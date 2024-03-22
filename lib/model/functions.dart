import 'package:intl/intl.dart';

convertDateToString(DateTime date) {
  return '${DateFormat('dd.MM.yyyy, HH:MM').format(date)} Uhr';
}
