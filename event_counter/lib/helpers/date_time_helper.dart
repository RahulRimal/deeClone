class DateTimeHelper {
  static String getRemainingTime(DateTime deadline) {
    var now = DateTime.now();
    var difference = deadline.difference(now);
    var days = difference.inDays;
    var hours = difference.inHours;
    var minutes = difference.inMinutes;
    var seconds = difference.inSeconds;

    if (days < 1) {
      if (hours < 1) {
        if (minutes < 1) {
          if (seconds < 1) {
            return 'Date Expired';
          }
          return "$seconds seconds left";
        } else {
          return "$minutes minutes left";
        }
      } else {
        return "$hours hours left";
      }
    } else {
      return "$days days left";
    }
  }

  static String getDate(DateTime time) {
    return time.year.toString() +
        "/" +
        time.month.toString() +
        "/" +
        time.day.toString();
  }

  static String getTime(DateTime time) {
    return time.hour.toString() +
        ":" +
        time.minute.toString() +
        ":" +
        time.second.toString();
  }

  static String getTimeCounter(DateTime time) {
    return time.day.toString() +
        " days : " +
        time.hour.toString() +
        " hours : " +
        time.minute.toString() +
        " minutes: " +
        time.second.toString() +
        " seconds";
  }

  static DateTime decreaseTime(DateTime time) {
    // return time.subtract(Duration(seconds: 1));
    return DateTime(time.year, time.month, time.day, time.hour, time.minute,
        time.second - 1);
  }
}
