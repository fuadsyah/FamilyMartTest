// 📦 Package imports:
import 'package:intl/intl.dart';

class TimeAgo{
  static String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime notificationDate = DateFormat("yyyy-MM-dd").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);
    if (difference.inDays > 32) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 4) {
      return (numericDates) ? '1w' : 'a month';
    } else if ((difference.inDays / 7).floor() >= 3) {
      return (numericDates) ? '3w' : '3 weeks ago';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return (numericDates) ? '2w' : '2 weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1w' : '1 weeks ago';
    } else if (difference.inDays >= 2) {
      return (numericDates) ? '${difference.inDays}d' : '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1d' : '1 day ago';
    } else if (difference.inHours >= 2) {
      return (numericDates) ? '${difference.inHours}h' : '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1h' : 'an hour ago';
    } else if (difference.inMinutes >= 2) {
      return (numericDates) ? '${difference.inMinutes}m' : "${difference.inMinutes} minutes ago";
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1m' : 'a minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}s';
    } else {
      return 'now';
    }
  }

}
