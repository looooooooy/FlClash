import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fl_clash/plugins/app.dart';

Future<String> accountDeviceName() async {
  if (Platform.isAndroid) {
    try {
      final name = await app?.deviceName().timeout(const Duration(seconds: 2));
      if (name != null && name.trim().isNotEmpty) return name;
    } catch (_) {}
    try {
      return (await DeviceInfoPlugin().androidInfo).model;
    } catch (_) {
      return 'Android';
    }
  }
  if (Platform.isMacOS) {
    try {
      final name = (await DeviceInfoPlugin().macOsInfo).computerName;
      if (name.trim().isNotEmpty) return name;
    } catch (_) {}
  }
  try {
    return Platform.localHostname;
  } catch (_) {
    return '';
  }
}

String normalizedAccountDeviceName(String name, String platform) {
  final cleaned = name.replaceAll(RegExp(r'[\x00-\x1F\x7F]'), ' ').trim();
  if (cleaned.isEmpty) return platform;

  // Keep within the Core's UTF-8 byte limit without splitting a character.
  var bytes = 0;
  final result = StringBuffer();
  for (final rune in cleaned.runes) {
    bytes += switch (rune) {
      <= 0x7f => 1,
      <= 0x7ff => 2,
      <= 0xffff => 3,
      _ => 4,
    };
    if (bytes > 256) break;
    result.writeCharCode(rune);
  }
  return result.toString();
}
