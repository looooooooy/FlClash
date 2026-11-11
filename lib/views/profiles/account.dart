import 'dart:async';

import 'package:fl_clash/accounts/labels.dart';
import 'package:fl_clash/accounts/managed.dart';
import 'package:fl_clash/accounts/models.dart';
import 'package:fl_clash/accounts/runtime.dart';
import 'package:fl_clash/accounts/service.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/features/form/form.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/ui/icons/icons.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'account_challenge.dart';

void showHeySocksAccount(BuildContext context) {
  unawaited(BaseNavigator.push(context, const HeySocksAccountView()));
}

class HeySocksAccountView extends ConsumerStatefulWidget {
  const HeySocksAccountView({super.key});

  @override
  ConsumerState<HeySocksAccountView> createState() =>
      _HeySocksAccountViewState();
}

class _HeySocksAccountViewState extends ConsumerState<HeySocksAccountView> {
  String? _error;
  bool _busy = false;
  int _operation = 0;

  @override
  void initState() {
    super.initState();
    ref.read(managedAccountProvider);
    unawaited(accountService.initialize());
  }

  Future<void> _run(
    Future<void> Function() action, {
    bool interrupt = false,
  }) async {
    if (_busy && !interrupt) return;
    final operation = ++_operation;
    final generation = accountService.status.value.state.generation;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await action();
    } on AccountChallengeRequired catch (challenge) {
      if (!mounted || operation != _operation) return;
      final token = await BaseNavigator.push<String>(
        context,
        AccountChallengeView(challenge: challenge.challenge),
      );
      if (token != null &&
          mounted &&
          operation == _operation &&
          generation == accountService.status.value.state.generation) {
        try {
          await accountService.validateCaptcha(token);
          await action();
        } catch (error) {
          if (mounted && operation == _operation) {
            setState(() => _error = accountFailureKind(error));
          }
        }
      }
    } catch (error) {
      if (mounted && operation == _operation) {
        setState(() => _error = accountFailureKind(error));
      }
    } finally {
      if (mounted && operation == _operation) setState(() => _busy = false);
    }
  }

  Future<void> _login() async {
    await showFormSheet<void>(
      context: context,
      builder: (_) => const HeySocksLoginForm(),
    );
    if (accountService.status.value.state.authenticated && mounted) {
      await _run(() => ref.read(managedAccountProvider).sync());
    }
  }

  @override
  Widget build(BuildContext context) {
    final manager = ref.watch(managedAccountProvider);
    final profile = ref
        .watch(profilesProvider)
        .where((p) => p.type == ProfileType.heysocks)
        .firstOrNull;
    return ValueListenableBuilder<AccountStatus>(
      valueListenable: accountService.status,
      builder: (context, account, _) =>
          ValueListenableBuilder<ManagedSyncStatus>(
            valueListenable: manager.status,
            builder: (context, sync, _) => HeySocksAccountBody(
              account: account,
              sync: sync,
              error: _error,
              busy: _busy,
              available: profile?.managed?.lineNames.length ?? 0,
              selectionRequired: profile?.managed?.selectionRequired ?? false,
              onLogin: _login,
              onRefresh: () => _run(() => manager.sync()),
              onLogout: () => _run(accountService.logout, interrupt: true),
              onChoose: () {
                if (profile != null) {
                  ref.read(currentProfileIdProvider.notifier).value =
                      profile.id;
                }
                ref.read(currentPageLabelProvider.notifier).value =
                    PageLabel.proxies;
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ),
    );
  }
}

class HeySocksAccountBody extends StatelessWidget {
  final AccountStatus account;
  final ManagedSyncStatus sync;
  final String? error;
  final bool busy;
  final int available;
  final bool selectionRequired;
  final VoidCallback onLogin;
  final VoidCallback onRefresh;
  final VoidCallback onLogout;
  final VoidCallback onChoose;
  const HeySocksAccountBody({
    super.key,
    required this.account,
    required this.sync,
    this.error,
    this.busy = false,
    this.available = 0,
    this.selectionRequired = false,
    required this.onLogin,
    required this.onRefresh,
    required this.onLogout,
    required this.onChoose,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    final signedIn = account.state.authenticated;
    final working = busy || sync.syncing || account.restoring;
    final failure = error ?? sync.failure ?? account.failure;
    return Scaffold(
      title: l10n.heysocksAccount,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
          top: context.contentTopPadding,
          bottom: 20 + context.bottomInset,
        ),
        children: [
          ErrorBanner(
            message: failure == null
                ? null
                : accountFailureLabel(l10n, failure),
          ),
          Card(
            padding: const EdgeInsets.all(20),
            radius: AppCorner.xl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    GlyphIcon(
                      AppGlyphs.key,
                      color: context.colorScheme.primary,
                    ),
                    Expanded(
                      child: Text(
                        signedIn
                            ? l10n.heysocksSignedIn
                            : l10n.heysocksSignedOut,
                        style: AppTextStyle.callout.of(
                          context,
                          emphasized: true,
                        ),
                      ),
                    ),
                    if (account.restoring) const ActivityIndicator(),
                  ],
                ),
                if (signedIn) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      Text(
                        '$available',
                        style: AppTextStyle.largeTitle.of(
                          context,
                          emphasized: true,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          l10n.heysocksReady,
                          style: AppTextStyle.callout.of(context).toLighter,
                        ),
                      ),
                    ],
                  ),
                  if (sync.syncing)
                    Row(
                      spacing: 12,
                      children: [
                        const ActivityIndicator(size: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                l10n.heysocksSyncing,
                                style: AppTextStyle.subheadline.of(context),
                              ),
                              Text(
                                l10n.heysocksProgress(
                                  sync.completed,
                                  sync.total,
                                ),
                                style: AppTextStyle.footnote
                                    .of(context)
                                    .toLighter,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (sync.unsupported > 0 || sync.failed > 0)
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      children: [
                        if (sync.unsupported > 0)
                          Text(
                            '${l10n.heysocksUnsupported} · ${sync.unsupported}',
                            style: AppTextStyle.footnote.of(context).toLighter,
                          ),
                        if (sync.failed > 0)
                          Text(
                            '${l10n.heysocksFailed} · ${sync.failed}',
                            style: AppTextStyle.footnote.of(context).toLighter,
                          ),
                      ],
                    ),
                ] else
                  Text(
                    l10n.heysocksLoginHint,
                    style: AppTextStyle.subheadline.of(context).toLighter,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: signedIn
                ? (available > 0 ? onChoose : null)
                : (working ? null : onLogin),
            child: Text(
              signedIn ? l10n.heysocksChoose : l10n.heysocksLogin,
              textAlign: TextAlign.center,
            ),
          ),
          if (signedIn) ...[
            if (sync.failed > 0 || selectionRequired)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  selectionRequired
                      ? l10n.heysocksSelectionRequired
                      : l10n.heysocksPartial,
                  style: AppTextStyle.footnote.of(context).toLighter,
                ),
              ),
            const SizedBox(height: 8),
            generateSection(
              items: [
                FormRow(
                  title: l10n.sync,
                  leading: const GlyphIcon(AppGlyphs.sync),
                  onPressed: working ? null : onRefresh,
                  trailing: working ? const ActivityIndicator(size: 18) : null,
                ),
                FormRow(
                  title: l10n.heysocksRelogin,
                  leading: const GlyphIcon(AppGlyphs.key),
                  onPressed: working ? null : onLogin,
                ),
                FormRow(
                  title: l10n.heysocksLogout,
                  leading: GlyphIcon(
                    AppGlyphs.close,
                    color: context.colorScheme.error,
                  ),
                  titleStyle: AppTextStyle.body
                      .of(context)
                      .copyWith(color: context.colorScheme.error),
                  onPressed: onLogout,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                l10n.heysocksHealthHint,
                style: AppTextStyle.footnote.of(context).toLighter,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class HeySocksLoginForm extends StatefulWidget {
  final AccountService? service;
  const HeySocksLoginForm({super.key, this.service});
  @override
  State<HeySocksLoginForm> createState() => _HeySocksLoginFormState();
}

class _HeySocksLoginFormState extends State<HeySocksLoginForm> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordFocus = FocusNode();
  AccountService get _service => widget.service ?? accountService;
  bool _busy = false;
  bool _pending = false;
  String? _failure;
  String? _deviceId;
  String? _code;
  int _flow = 0;

  Future<void> _submit() async {
    if (_busy) return;
    FocusScope.of(context).unfocus();
    if (!_email.text.contains('@') || _password.text.isEmpty) {
      setState(() => _failure = 'input');
      return;
    }
    final flow = ++_flow;
    setState(() {
      _busy = true;
      _pending = true;
      _failure = null;
    });
    FocusScope.of(context).unfocus();
    final password = _password.text;
    _password.clear();
    try {
      var result = await _service.login(_email.text.trim(), password);
      if (!mounted || flow != _flow) return;
      if (result.challenge case final challenge?) {
        final token = await BaseNavigator.push<String>(
          context,
          AccountChallengeView(challenge: challenge),
        );
        if (!mounted || flow != _flow) return;
        if (token == null) throw const AccountFailure('canceled');
        result = await _service.captcha(challenge.id, token);
      }
      if (!mounted || flow != _flow) return;
      if (!result.state.authenticated) {
        throw const AccountFailure('unauthenticated');
      }
      _pending = false;
      Navigator.of(context).pop();
    } catch (error) {
      if (mounted && flow == _flow) {
        setState(() => _failure = accountFailureKind(error));
      }
    } finally {
      if (mounted && flow == _flow) setState(() => _busy = false);
    }
  }

  Future<void> _device() async {
    if (_busy) return;
    final flow = ++_flow;
    _password.clear();
    setState(() {
      _busy = true;
      _pending = true;
      _failure = null;
    });
    try {
      final device = await _service.startDevice();
      if (!mounted || flow != _flow) {
        await _service.cancelDevice(device.id);
        return;
      }
      setState(() => _deviceId = device.id);
      while (mounted && flow == _flow) {
        final event = await _service.pollDevice(device.id);
        if (!mounted || flow != _flow) return;
        if (event.type == 'code') setState(() => _code = event.code);
        if (event.type == 'authorized') {
          _pending = false;
          _deviceId = null;
          Navigator.of(context).pop();
          return;
        }
      }
    } catch (error) {
      if (mounted && flow == _flow) {
        setState(() => _failure = accountFailureKind(error));
      }
    } finally {
      if (mounted && flow == _flow) {
        setState(() {
          _busy = false;
          _deviceId = null;
          _code = null;
        });
      }
    }
  }

  Future<void> _cancelDevice() async {
    _flow++;
    final device = _deviceId;
    setState(() {
      _busy = false;
      _pending = false;
      _deviceId = null;
      _code = null;
      _failure = null;
    });
    if (device != null) {
      await _service.cancelDevice(device).catchError((Object _) {});
    }
  }

  @override
  void dispose() {
    _flow++;
    final device = _deviceId;
    if (device != null) {
      unawaited(_service.cancelDevice(device).catchError((Object _) {}));
    }
    if (_pending && !_service.status.value.state.authenticated) {
      unawaited(_service.logout().catchError((Object _) {}));
    }
    _email.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.appLocalizations;
    return FormPage(
      title: l10n.heysocksLogin,
      onSave: _submit,
      saving: _busy,
      showSaveAction: false,
      error: _failure == null ? null : accountFailureLabel(l10n, _failure),
      children: [
        if (_deviceId == null)
          generateSection(
            items: [
              FormRow(
                title: l10n.heysocksEmail,
                stacked: true,
                trailing: FormRowTextField(
                  controller: _email,
                  textAlign: TextAlign.start,

                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
                ),
              ),
              FormRow(
                title: l10n.password,
                stacked: true,
                trailing: FormRowSecretTextField(
                  controller: _password,
                  textAlign: TextAlign.start,

                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                ),
              ),
            ],
          ),
        if (_deviceId != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Card(
              radius: AppCorner.lg,
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 14,
                children: [
                  if (_code case final code?)
                    Semantics(
                      label: l10n.heysocksDevice,
                      child: Text(
                        code,
                        style: AppTextStyle.title1.of(
                          context,
                          emphasized: true,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    const ActivityIndicator(),
                  Text(
                    l10n.heysocksDeviceHint,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.footnote.of(context).toLighter,
                  ),
                  Text(
                    l10n.heysocksWaiting,
                    style: AppTextStyle.footnote
                        .of(context, emphasized: true)
                        .toLight,
                  ),
                ],
              ),
            ),
          ),
        if (_deviceId == null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FilledButton(
              onPressed: _busy ? null : _submit,
              child: _busy
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 10,
                      children: [
                        const ActivityIndicator(size: 18),
                        Text(l10n.heysocksWaiting),
                      ],
                    )
                  : Text(l10n.heysocksLogin),
            ),
          ),
        if (_deviceId == null && !_busy)
          generateSection(
            items: [
              FormRow(
                title: l10n.heysocksDevice,
                leading: const GlyphIcon(AppGlyphs.devices),
                onPressed: _device,
              ),
            ],
          ),
        if (_deviceId != null)
          generateSection(
            items: [
              FormRow(
                title: l10n.cancel,
                leading: const GlyphIcon(AppGlyphs.close),
                onPressed: _cancelDevice,
              ),
            ],
          ),
      ],
    );
  }
}
