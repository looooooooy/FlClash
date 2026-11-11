import 'package:fl_clash/accounts/health.dart';
import 'package:fl_clash/accounts/proxy_labels.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('country labels remove only trailing server counts', () {
    for (final name in [
      'Australia - 2 Servers',
      'Australia -2 Server',
      'Australia – 12 SERVERS',
      'Australia — 2 server ',
    ]) {
      expect(heySocksCountryLabel(name), 'Australia');
    }
    expect(heySocksCountryLabel('Timor-Leste'), 'Timor-Leste');
    expect(heySocksCountryLabel('Server Islands'), 'Server Islands');
  });

  test(
    'old and new profiles use global numbers without changing Core keys',
    () {
      final profile = Profile.normal().copyWith(
        type: ProfileType.heysocks,
        managed: const ManagedProfileInfo(
          countryNames: {
            'AU': 'Australia - 2 Servers',
            'BR': 'Brazil - 2 Server',
          },
          lineNames: {
            'a': 'Australia - 2 Servers · Sydney · Standard',
            'b': '02 · Australia - 2 Servers - Melbourne',
            'c': 'Brazil - 2 Server · São Paulo · Standard',
          },
        ),
      );
      final labels = heySocksProxyLabels(profile);
      expect(labels['Australia - 2 Servers'], 'Australia');
      expect(labels['Brazil - 2 Server'], 'Brazil');
      expect(
        labels['Australia - 2 Servers · Sydney · Standard'],
        '01 · Sydney',
      );
      expect(
        labels['02 · Australia - 2 Servers - Melbourne'],
        '02 · Melbourne',
      );
      expect(
        labels['Brazil - 2 Server · São Paulo · Standard'],
        '03 · São Paulo',
      );
      expect(profile.managed!.countryNames['AU'], 'Australia - 2 Servers');
      expect(
        heySocksProxyLabels(profile.copyWith(type: ProfileType.file)),
        isEmpty,
      );
    },
  );

  test('node details survive removal of legacy category wrappers', () {
    final profile = Profile.normal().copyWith(
      type: ProfileType.heysocks,
      managed: const ManagedProfileInfo(
        countryNames: {'AU': 'Australia - 2 Servers'},
        lineNames: {
          'a': 'Australia - 2 Servers · Sydney · Residential · Standard',
          'b': '02 · Australia - 2 Servers · Melbourne · Residential',
        },
      ),
    );
    expect(
      heySocksProxyLabels(profile).values,
      containsAll([
        '01 · Sydney · Residential',
        '02 · Melbourne · Residential',
      ]),
    );
  });

  test(
    'health requires consecutive failures and suppresses repeated alerts',
    () {
      final health = HeySocksHealth();
      expect(health.record('a', -1), false);
      expect(health.record('a', 50), false);
      expect(health.record('a', -1), false);
      expect(health.record('a', -2), true);
      expect(health.record('a', -1), false);
      expect(health.record('b', -1), false);
      expect(health.record('b', -1), true);
      health.reset();
      expect(health.record('b', -1), false);
      expect(health.record('b', -1, manual: true), true);
    },
  );
}
