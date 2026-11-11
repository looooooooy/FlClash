import 'package:fl_clash/core/controller.dart';

import 'rpc.dart';
import 'service.dart';
import 'store.dart';

final accountStore = ProtectedAccountStore();
final accountService = AccountService(
  gateway: CoreAccountGateway(coreController),
  store: accountStore,
);
