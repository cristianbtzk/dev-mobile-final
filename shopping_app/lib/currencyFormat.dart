import 'package:intl/intl.dart';

String currencyFormat(num number) {
  final oCcy = NumberFormat.currency(locale: "pt_BR");
  return oCcy.format(number);
}
