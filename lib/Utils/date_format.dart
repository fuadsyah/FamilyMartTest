// 📦 Package imports:
import 'package:intl/intl.dart';

String formatDate(String date){
  var format = DateFormat('dd MMMM yyyy').format(DateTime.parse(date));

  return format;
}
