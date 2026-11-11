import 'package:fl_clash/accounts/managed.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaml/yaml.dart';

void main() {
  test(
    'cached all-proxy profiles receive domestic rules before the fallback',
    () {
      final original = <String, dynamic>{
        'proxies': [
          {'name': '01 · Sydney'},
        ],
        'proxy-groups': [
          {
            'name': 'HeySocks',
            'proxies': ['Australia'],
          },
        ],
        'rules': ['MATCH,HeySocks'],
      };
      final updated = withManagedRouting(original);
      expect(updated['rules'], [
        'DOMAIN-SUFFIX,local,DIRECT',
        'DOMAIN-SUFFIX,lan,DIRECT',
        'GEOIP,LAN,DIRECT,no-resolve',
        'GEOSITE,cn,DIRECT',
        'GEOIP,CN,DIRECT',
        'MATCH,HeySocks',
      ]);
      expect(original['rules'], ['MATCH,HeySocks']);
      expect(updated['proxies'], same(original['proxies']));
      expect(updated['proxy-groups'], same(original['proxy-groups']));
      expect(withManagedRouting(updated), updated);
    },
  );

  test('final runtime YAML keeps domestic routing and rule mode', () async {
    final result = await makeRealProfileTask(
      MakeRealProfileState(
        profilesPath: '/profiles',
        profileId: 1,
        rawConfig: withManagedRouting({
          'rules': ['MATCH,HeySocks'],
        }),
        realPatchConfig: const PatchClashConfig(),
        overrides: const ProfileOverrides(),
        appendSystemDns: false,
        proxyGroups: const [],
        rules: const [],
        addedRules: const [],
        defaultUA: 'FlClash-Test',
      ),
    );
    final yaml = loadYaml(result.yaml) as YamlMap;
    expect(yaml['mode'], Mode.rule.name);
    expect(yaml['rules'], managedRoutingRules);
  });
}
