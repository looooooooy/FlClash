import 'package:fl_clash/l10n/l10n.dart';

String accountFailureLabel(AppLocalizations l10n, String? kind) =>
    switch (kind) {
      'unauthenticated' ||
      'authentication_required' => l10n.heysocksLoginRequired,
      'input' ||
      'invalid_input' ||
      'invalid_credentials' ||
      'request_rejected' => l10n.heysocksInvalidLogin,
      'expired' || 'canceled' || 'superseded' => l10n.heysocksExpired,
      'selection_required' => l10n.heysocksSelectionRequired,
      'network' ||
      'network_unavailable' ||
      'timeout' ||
      'rate_limited' => l10n.heysocksNetworkError,
      'storage_failure' || 'corrupt_storage' => l10n.heysocksStorageError,
      'captcha_required' => l10n.heysocksVerification,
      _ => l10n.heysocksError,
    };
