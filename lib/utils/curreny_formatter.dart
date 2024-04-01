import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatToIdr(double value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ',
        decimalDigits: 0);
    return formatter.format(value);
  }
}