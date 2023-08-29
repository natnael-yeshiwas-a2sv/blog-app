class InputConverter {
  static String toDateFormat(DateTime? dateTime) {
    dateTime = dateTime ?? DateTime.now();
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }
  static String calculatePostDate(DateTime createdAt) {
    Duration difference = DateTime.now().difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays > 1 ? "days" : "day"} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours > 1 ? "hours" : "hour"} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes > 1 ? "minutes" : "minute"} ago';
    } else {
      return 'Just now';
    }
  }
}
