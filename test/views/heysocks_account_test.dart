import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'package:fl_clash/accounts/managed.dart';
import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/service.dart';
import 'package:fl_clash/features/form/form.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/ui/ui.dart';
import 'package:fl_clash/views/profiles/account.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../accounts/fakes.dart';
import '../helpers/test_app.dart';
import '../helpers/host_scaffold.dart';

class _DeviceGateway extends FakeGateway {
  final event = Completer<AccountDeviceEvent>();
  bool canceled = false;
  @override
  Future<AccountDeviceFlow> startDevice() async =>
      const AccountDeviceFlow('synthetic-flow', 300);
  @override
  Future<AccountDeviceEvent> pollDevice(String id) => event.future;
  @override
  Future<void> cancelDevice(String id) async {
    canceled = true;
    if (!event.isCompleted) {
      event.completeError(const AccountFailure('canceled'));
    }
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const previewFont = String.fromEnvironment('HEYSOCKS_PREVIEW_FONT');
  setUpAll(() async {
    if (previewFont.isNotEmpty) {
      final loader = FontLoader('HeySocksPreview')
        ..addFont(
          Future.value(
            ByteData.sublistView(await File(previewFont).readAsBytes()),
          ),
        );
      await loader.load();
    }
  });
  late ProviderContainer container;
  setUp(() {
    container = ProviderContainer();
    globalState.container = container;
    container.read(viewSizeProvider.notifier).value = const Size(412, 892);
  });
  tearDown(() => container.dispose());

  Future<void> pump(
    WidgetTester tester,
    Widget child,
    Brightness brightness,
  ) async {
    tester.view.physicalSize = const Size(412, 892);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: TestApp(
          locale: const Locale('en'),
          theme: ThemeData(
            fontFamily: previewFont.isEmpty ? null : 'HeySocksPreview',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff2196f3),
              brightness: brightness,
            ),
          ),
          child: child,
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  for (final brightness in Brightness.values) {
    testWidgets(
      'account states render without overflow in ${brightness.name}',
      (tester) async {
        final boundary = GlobalKey();
        var chosen = 0;
        final body = HeySocksAccountBody(
          account: const AccountStatus(
            state: AccountState(authenticated: true),
            persisted: true,
          ),
          sync: const ManagedSyncStatus(
            total: 3,
            completed: 3,
            ready: 2,
            unsupported: 1,
          ),
          available: 2,
          onLogin: () {},
          onRefresh: () {},
          onLogout: () {},
          onChoose: () => chosen++,
        );
        await pump(
          tester,
          RepaintBoundary(key: boundary, child: body),
          brightness,
        );
        expect(find.text('Signed in'), findsOneWidget);
        expect(tester.takeException(), isNull);
        await tester.tap(find.text('Choose a country and line'));
        expect(chosen, 1);
        const output = String.fromEnvironment('HEYSOCKS_PREVIEW_DIR');
        if (output.isNotEmpty) {
          final render =
              boundary.currentContext!.findRenderObject()!
                  as RenderRepaintBoundary;
          await tester.runAsync(() async {
            final image = await render.toImage(pixelRatio: 2);
            final bytes = await image.toByteData(
              format: ui.ImageByteFormat.png,
            );
            await Directory(output).create(recursive: true);
            await File(
              '$output/account-${brightness.name}.png',
            ).writeAsBytes(bytes!.buffer.asUint8List());
            image.dispose();
          });
        }
        await tester.pumpWidget(const SizedBox());
      },
    );
  }

  testWidgets('syncing account keeps counts together and actions reachable', (
    tester,
  ) async {
    var refreshed = 0;
    await pump(
      tester,
      HeySocksAccountBody(
        account: const AccountStatus(
          state: AccountState(authenticated: true),
          persisted: true,
        ),
        sync: const ManagedSyncStatus(
          syncing: true,
          total: 102,
          completed: 18,
          unsupported: 2,
        ),
        available: 98,
        onLogin: () {},
        onRefresh: () => refreshed++,
        onLogout: () {},
        onChoose: () {},
      ),
      Brightness.light,
    );
    expect(find.text('98'), findsOneWidget);
    expect(find.text('Syncing lines…'), findsOneWidget);
    await tester.tap(find.text('Sync'));
    expect(refreshed, 0);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
    'login keeps password obscured and handles failure with keyboard',
    (tester) async {
      final loginBoundary = GlobalKey();
      final service = AccountService(
        gateway: FakeGateway(),
        store: FakeStore(),
      );
      await pump(
        tester,
        Builder(
          builder: (context) => HostScaffold(
            body: TextButton(
              onPressed: () => showFormSheet<void>(
                context: context,
                builder: (_) => RepaintBoundary(
                  key: loginBoundary,
                  child: HeySocksLoginForm(service: service),
                ),
              ),
              child: const Text('Open login'),
            ),
          ),
        ),
        Brightness.light,
      );
      await tester.tap(find.text('Open login'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(FormRowSecretTextField), findsOneWidget);
      final secret = find.descendant(
        of: find.byType(FormRowSecretTextField),
        matching: find.byType(EditableText),
      );
      expect(tester.widget<EditableText>(secret).obscureText, isTrue);
      final fields = find.byType(EditableText);
      expect(tester.getSize(fields.first).width, greaterThan(250));
      expect(
        tester.getTopLeft(find.text('Email')).dy,
        lessThan(tester.getTopLeft(fields.first).dy),
      );
      const output = String.fromEnvironment('HEYSOCKS_PREVIEW_DIR');
      if (output.isNotEmpty) {
        await tester.runAsync(() async {
          final render =
              loginBoundary.currentContext!.findRenderObject()!
                  as RenderRepaintBoundary;
          final image = await render.toImage(pixelRatio: 2);
          final data = await image.toByteData(format: ui.ImageByteFormat.png);
          await Directory(output).create(recursive: true);
          await File(
            '$output/login.png',
          ).writeAsBytes(data!.buffer.asUint8List());
          image.dispose();
        });
      }
      await tester.enterText(fields.first, 'invalid');
      await tester.enterText(secret, 'synthetic-password');
      tester.view.viewInsets = const FakeViewPadding(bottom: 300);
      addTearDown(tester.view.resetViewInsets);
      await tester.pump();
      tester.widget<FormPage>(find.byType(FormPage)).onSave();
      await tester.pump();
      expect(
        tester.widget<FormPage>(find.byType(FormPage)).error,
        'Check your email and password, then try again.',
      );
      tester.view.viewInsets = const FakeViewPadding();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));
      expect(
        find.text('Check your email and password, then try again.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      final disposal = service.dispose();
      await tester.pump(const Duration(seconds: 1));
      await disposal;
    },
  );

  testWidgets('successful login closes the form after secure persistence', (
    tester,
  ) async {
    final service = AccountService(gateway: FakeGateway(), store: FakeStore());
    await pump(
      tester,
      Builder(
        builder: (context) => HostScaffold(
          body: TextButton(
            onPressed: () => showFormSheet<void>(
              context: context,
              builder: (_) => HeySocksLoginForm(service: service),
            ),
            child: const Text('Open login'),
          ),
        ),
      ),
      Brightness.light,
    );
    await tester.tap(find.text('Open login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    final fields = find.byType(EditableText);
    await tester.enterText(fields.first, 'synthetic@example.test');
    await tester.enterText(fields.last, 'synthetic-password');
    tester.widget<FormPage>(find.byType(FormPage)).onSave();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(service.status.value.persisted, isTrue);
    expect(find.byType(HeySocksLoginForm), findsNothing);
    await tester.pumpWidget(const SizedBox());
    final disposal = service.dispose();
    await tester.pump(const Duration(seconds: 1));
    await disposal;
  });

  testWidgets('closing authorization cancels the pending device flow', (
    tester,
  ) async {
    final gateway = _DeviceGateway();
    final service = AccountService(gateway: gateway, store: FakeStore());
    await pump(
      tester,
      Builder(
        builder: (context) => HostScaffold(
          body: TextButton(
            onPressed: () => showFormSheet<void>(
              context: context,
              builder: (_) => HeySocksLoginForm(service: service),
            ),
            child: const Text('Open login'),
          ),
        ),
      ),
      Brightness.light,
    );
    await tester.tap(find.text('Open login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Authorize with another device'));
    await tester.ensureVisible(find.text('Authorize with another device'));
    await tester.tap(find.text('Authorize with another device'));
    await tester.pump();
    Navigator.of(tester.element(find.byType(HeySocksLoginForm))).pop();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(gateway.canceled, isTrue);
    expect(service.status.value.state.authenticated, isFalse);
    await tester.pumpWidget(const SizedBox());
    final disposal = service.dispose();
    await tester.pump(const Duration(seconds: 1));
    await disposal;
  });

  testWidgets('expired authorization shows a retryable safe error', (
    tester,
  ) async {
    final gateway = _DeviceGateway();
    final service = AccountService(gateway: gateway, store: FakeStore());
    await pump(
      tester,
      Builder(
        builder: (context) => HostScaffold(
          body: TextButton(
            onPressed: () => showFormSheet<void>(
              context: context,
              builder: (_) => HeySocksLoginForm(service: service),
            ),
            child: const Text('Open login'),
          ),
        ),
      ),
      Brightness.light,
    );
    await tester.tap(find.text('Open login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Authorize with another device'));
    await tester.ensureVisible(find.text('Authorize with another device'));
    await tester.tap(find.text('Authorize with another device'));
    await tester.pump();
    gateway.event.completeError(const AccountFailure('expired'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(
      find.text('Authorization expired. Please try again.'),
      findsOneWidget,
    );
    expect(service.status.value.state.authenticated, isFalse);
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    final disposal = service.dispose();
    await tester.pump(const Duration(seconds: 1));
    await disposal;
  });

  testWidgets('safe failure and sync states show no raw transport data', (
    tester,
  ) async {
    await pump(
      tester,
      HeySocksAccountBody(
        account: const AccountStatus(state: AccountState(authenticated: true)),
        sync: const ManagedSyncStatus(
          syncing: true,
          total: 10,
          completed: 4,
          ready: 3,
          failed: 1,
        ),
        error: 'network_unavailable',
        available: 3,
        onLogin: () {},
        onRefresh: () {},
        onLogout: () {},
        onChoose: () {},
      ),
      Brightness.dark,
    );
    expect(find.text('4 of 10 checked'), findsOneWidget);
    expect(
      find.text('Unable to reach HeySocks. Check your connection and retry.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });
}
