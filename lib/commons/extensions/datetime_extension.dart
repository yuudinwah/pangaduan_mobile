import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toLog() {
    DateTime now = DateTime.now();
    Duration duration = now.difference(this);

    if (duration.inDays > 354) {
      return dateFormat(format: 'dd MM yyyy');
    } else if (duration.inDays > 7) {
      return dateFormat(format: 'dd MMM');
    } else if (duration.inDays > 0) {
      return dateFormat(format: 'EEE dd');
    } else if (duration.inHours > 0) {
      return '${dateFormat(format: 'hh')} jam lalu';
    } else if (duration.inMinutes > 0) {
      return '${dateFormat(format: 'mm')} mnit lalu';
    } else {
      return '${dateFormat(format: 'ss')} dtik lalu';
    }
  }

  String dateFormat({String format = 'dd MMMM yyyy', String locale = 'id'}) {
    return DateFormat(format, locale).format(this).toString();
  }
}
