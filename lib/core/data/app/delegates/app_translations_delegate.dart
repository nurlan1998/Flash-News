import 'package:news_app_flutter/generated/l10n.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:intl/number_symbols.dart';

class AppTranslationsDelegate extends AppLocalizationDelegate {
  @override
  bool shouldReload(AppLocalizationDelegate old) => true;

  static void addAppCategory() {
    numberFormatSymbols['app'] = const NumberSymbols(
      NAME: 'app',
      DECIMAL_SEP: '.',
      GROUP_SEP: '\u00A0',
      PERCENT: '%',
      ZERO_DIGIT: '0',
      PLUS_SIGN: '+',
      MINUS_SIGN: '-',
      EXP_SYMBOL: 'e',
      PERMILL: '\u2030',
      INFINITY: '\u221E',
      NAN: 'NaN',
      DECIMAL_PATTERN: '#,##0.###',
      SCIENTIFIC_PATTERN: '#E0',
      PERCENT_PATTERN: '#,##0%',
      CURRENCY_PATTERN: '\u00A4#,##0.00',
      DEF_CURRENCY_CODE: 'UZS',
    );
  }
}
