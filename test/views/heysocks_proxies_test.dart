import 'dart:io';
import 'dart:ui' as ui;

import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/ui/ui.dart';
import 'package:fl_clash/views/proxies/card.dart';
import 'package:fl_clash/views/views.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_app.dart';
import '../helpers/test_profiles.dart';

void main() {
  const font = String.fromEnvironment('HEYSOCKS_PREVIEW_FONT');
  setUpAll(() async {
    if (font.isNotEmpty) {
      await (FontLoader('Preview')..addFont(
            Future.value(ByteData.sublistView(await File(font).readAsBytes())),
          ))
          .load();
    }
  });
  for (final type in ProxiesType.values) {
    for (final width in [320.0, 412.0]) {
      testWidgets(
        'HeySocks $type at $width cleans legacy labels and fits selected cards',
        (tester) async {
          tester.view.physicalSize = Size(width, 892);
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          const country = 'Australia - 2 Servers';
          const line =
              'Australia - 2 Servers · Sydney International · Standard';
          final profile = Profile.normal().copyWith(
            type: ProfileType.heysocks,
            currentGroupName: 'HeySocks',
            selectedMap: {'HeySocks': country, country: line},
            unfoldSet: {'HeySocks', country},
            managed: const ManagedProfileInfo(
              countryNames: {'AU': country, 'AE': 'United Arab Emirates'},
              lineNames: {'id': line},
            ),
          );
          final groups = [
            const Group(
              name: 'HeySocks',
              type: GroupType.Selector,
              hidden: false,
              now: country,
              all: [
                Proxy(name: country, type: 'Selector'),
                Proxy(name: 'United Arab Emirates', type: 'Selector'),
              ],
            ),
            const Group(
              name: country,
              type: GroupType.Selector,
              hidden: false,
              now: line,
              all: [Proxy(name: line, type: 'HeySocks')],
            ),
          ];
          final container = ProviderContainer(
            overrides: [
              profilesProvider.overrideWith(() => TestProfiles([profile])),
              currentProfileIdProvider.overrideWithBuild((_, _) => profile.id),
              currentGroupsStateProvider.overrideWithValue(
                GroupsState(value: groups),
              ),
              groupsProvider.overrideWithValue(groups),
            ],
          );
          addTearDown(container.dispose);
          globalState.container = container;
          container.read(viewSizeProvider.notifier).value = Size(width, 892);
          container
              .read(proxiesStyleSettingProvider.notifier)
              .update((state) => state.copyWith(type: type));
          final boundary = GlobalKey();
          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: TestApp(
                locale: const Locale('en'),
                theme: ThemeData(fontFamily: font.isEmpty ? null : 'Preview'),
                child: RepaintBoundary(
                  key: boundary,
                  child: const ProxiesView(),
                ),
              ),
            ),
          );
          await tester.pump(const Duration(milliseconds: 500));
          expect(find.text(country), findsNothing);
          expect(find.text('Australia'), findsWidgets);
          expect(
            tester.getSize(find.byType(ProxyCard).first).height,
            lessThan(90),
          );
          expect(tester.takeException(), isNull);
          const output = String.fromEnvironment('HEYSOCKS_PREVIEW_DIR');
          if (output.isNotEmpty && width == 412) {
            await tester.runAsync(() async {
              final image =
                  await (boundary.currentContext!.findRenderObject()!
                          as RenderRepaintBoundary)
                      .toImage(pixelRatio: 2);
              final data = await image.toByteData(
                format: ui.ImageByteFormat.png,
              );
              await Directory(output).create(recursive: true);
              await File(
                '$output/proxies-${type.name}.png',
              ).writeAsBytes(data!.buffer.asUint8List());
              image.dispose();
            });
          }
          await tester.pumpWidget(const SizedBox());
        },
      );
    }
  }
}
