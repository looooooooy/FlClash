import 'dart:convert';

class AccountState {
  final int revision;
  final int generation;
  final bool authenticated;
  const AccountState({
    this.revision = 0,
    this.generation = 0,
    this.authenticated = false,
  });
  factory AccountState.fromJson(Map<String, dynamic> value) => AccountState(
    revision: value['revision'] as int,
    generation: value['generation'] as int,
    authenticated: value['authenticated'] as bool,
  );
}

class AccountFailure implements Exception {
  final String kind;
  final int? httpStatus;
  final int? vendorCode;
  const AccountFailure(this.kind, {this.httpStatus, this.vendorCode});
  factory AccountFailure.fromJson(Map<String, dynamic> value) => AccountFailure(
    value['kind'] as String,
    httpStatus: value['httpStatus'] as int?,
    vendorCode: value['vendorCode'] as int?,
  );
  @override
  String toString() => 'AccountFailure($kind)';
}

class AccountChallenge {
  final String id;
  final Uri url;
  final String operation;
  const AccountChallenge({
    required this.id,
    required this.url,
    required this.operation,
  });
  factory AccountChallenge.fromJson(Map<String, dynamic> value) =>
      AccountChallenge(
        id: value['id'] as String,
        url: Uri.parse(value['url'] as String),
        operation: value['operation'] as String,
      );
  @override
  String toString() => 'AccountChallenge(redacted)';
}

class AccountChallengeRequired implements Exception {
  final AccountFailure failure;
  final AccountChallenge challenge;
  const AccountChallengeRequired(this.failure, this.challenge);
  @override
  String toString() => 'AccountChallengeRequired';
}

class AccountAuthResult {
  final AccountState state;
  final AccountChallenge? challenge;
  const AccountAuthResult(this.state, [this.challenge]);
  factory AccountAuthResult.fromJson(Map<String, dynamic> value) =>
      AccountAuthResult(
        AccountState.fromJson(accountMap(value['state'])),
        value['challenge'] == null
            ? null
            : AccountChallenge.fromJson(accountMap(value['challenge'])),
      );
  @override
  String toString() => 'AccountAuthResult(redacted)';
}

class AccountSnapshot {
  final Map<String, dynamic> _value;
  AccountSnapshot.fromPrivateJson(Map<String, dynamic> value) : _value = value {
    final session = accountMap(value['session']);
    final payload = accountMap(session['payload']);
    if (accountMap(payload['token'])['token'] is! String ||
        (accountMap(payload['token'])['token'] as String).isEmpty ||
        value['revision'] is! int ||
        value['generation'] is! int) {
      throw const AccountFailure('corrupt_storage');
    }
  }
  int get revision => _value['revision'] as int;
  int get generation => _value['generation'] as int;
  Map<String, dynamic> toPrivateJson() => _value;
  String encodePrivate() => jsonEncode(_value);
  @override
  String toString() => 'AccountSnapshot(redacted)';
}

class AccountDeviceFlow {
  final String id;
  final int timeoutSeconds;
  const AccountDeviceFlow(this.id, this.timeoutSeconds);
  factory AccountDeviceFlow.fromJson(Map<String, dynamic> value) =>
      AccountDeviceFlow(value['id'] as String, value['timeoutSeconds'] as int);
  @override
  String toString() => 'AccountDeviceFlow(redacted)';
}

class AccountDeviceEvent {
  final String type;
  final String? code;
  final AccountState state;
  const AccountDeviceEvent(this.type, this.code, this.state);
  factory AccountDeviceEvent.fromJson(Map<String, dynamic> value) =>
      AccountDeviceEvent(
        value['type'] as String,
        value['code'] as String?,
        AccountState.fromJson(accountMap(value['state'])),
      );
  @override
  String toString() => 'AccountDeviceEvent(redacted)';
}

class AccountNode {
  final Map<String, dynamic> _value;
  AccountNode.fromPrivateJson(this._value);
  String get stableId => _value['stableId'] as String;
  String get name => _value['name'] as String;
  String get countryCode => _value['country_code'] as String;
  String get countryName => _value['countryName'] as String;
  String get categoryName => _value['categoryName'] as String;
  Map<String, dynamic> toPrivateJson() => _value;
  @override
  String toString() => 'AccountNode(redacted)';
}

class AccountCatalog {
  final List<AccountNode> nodes;
  const AccountCatalog(this.nodes);
  factory AccountCatalog.fromPrivateJson(Map<String, dynamic> value) =>
      AccountCatalog([
        for (final node in value['nodes'] as List? ?? const [])
          AccountNode.fromPrivateJson(accountMap(node)),
      ]);
}

class AccountNodeConfig {
  final Map<String, dynamic> _value;
  AccountNodeConfig.fromPrivateJson(this._value);
  AccountNode get node =>
      AccountNode.fromPrivateJson(accountMap(_value['node']));
  bool get usable => (_value['connections'] as List? ?? const []).isNotEmpty;
  Map<String, dynamic> toPrivateJson() => _value;
  AccountNodeConfig withNode(AccountNode node) =>
      AccountNodeConfig.fromPrivateJson({
        ..._value,
        'node': node.toPrivateJson(),
      });
  @override
  String toString() => 'AccountNodeConfig(redacted)';
}

class AccountConfigOptions {
  final List<String> nameservers;
  final String strategy;
  final String isp;
  final bool energy;
  const AccountConfigOptions({
    this.nameservers = const [],
    this.strategy = '',
    this.isp = '',
    this.energy = false,
  });
  Map<String, Object?> toJson() => {
    'Nameservers': nameservers,
    'Strategy': strategy,
    'ISP': isp,
    'Energy': energy,
  };
}

class AccountProfile {
  final Map<String, dynamic> _value;
  AccountProfile.fromPrivateJson(this._value);
  Map<String, dynamic> toPrivateJson() => _value;
  @override
  String toString() => 'AccountProfile(redacted)';
}

Map<String, dynamic> accountMap(Object? value) {
  if (value is! Map) throw const AccountFailure('invalid_response');
  return Map<String, dynamic>.from(value);
}
