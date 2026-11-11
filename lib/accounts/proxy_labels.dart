import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/profile.dart';

final _serverCount = RegExp(
  r'\s*[-–—]\s*\d+\s*servers?\s*$',
  caseSensitive: false,
);
final _ordinal = RegExp(r'^\d+\s*·\s*');

String heySocksCountryLabel(String name) =>
    name.replaceFirst(_serverCount, '').trim();

Map<String, String> heySocksProxyLabels(Profile? profile) {
  final info = profile?.managed;
  if (profile?.type != ProfileType.heysocks || info == null) return const {};
  final labels = <String, String>{
    for (final country in info.countryNames.values)
      country: heySocksCountryLabel(country),
  };
  for (final (index, line) in info.lineNames.values.indexed) {
    final numbered = _ordinal.hasMatch(line);
    var name = line.replaceFirst(_ordinal, '').trim();
    for (final country in info.countryNames.values) {
      // Early builds wrapped the node name between country and category.
      if (name.startsWith('$country · ')) {
        name = name.substring(country.length + 3);
        if (!numbered) {
          final parts = name.split(' · ');
          if (parts.length > 1) name = parts.take(parts.length - 1).join(' · ');
        }
      }
      for (final prefix in {country, heySocksCountryLabel(country)}) {
        for (final separator in [' · ', ' - ', ' – ', ' — ', ' | ']) {
          if (name.toLowerCase().startsWith(
            '$prefix$separator'.toLowerCase(),
          )) {
            name = name.substring(prefix.length + separator.length).trim();
          }
        }
        if (name.toLowerCase() == prefix.toLowerCase()) name = '';
      }
    }
    final number = '${index + 1}'.padLeft(2, '0');
    labels[line] = name.isEmpty ? number : '$number · $name';
  }
  return labels;
}
