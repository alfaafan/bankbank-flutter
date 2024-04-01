import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatToIdr(int value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ',
        decimalDigits: 2);
    return formatter.format(value);
  }
}