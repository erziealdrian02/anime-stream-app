import 'package:intl/intl.dart';

class DateFormatter {
  static String formatReleaseDate(String releaseDate) {
    try {
      final date = DateTime.parse(releaseDate);
      return DateFormat('MMM d, yyyy').format(date);
    } catch (e) {
      return releaseDate;
    }
  }

  static String formatEpisodeReleaseDate(String releaseDate) {
    try {
      final date = DateTime.parse(releaseDate);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          return '${difference.inMinutes} minutes ago';
        }
        return '${difference.inHours} hours ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
      } else {
        return DateFormat('MMM d, yyyy').format(date);
      }
    } catch (e) {
      return releaseDate;
    }
  }

  static String getDayOfWeek(DateTime date) {
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[date.weekday - 1];
  }

  static String getCurrentDay() {
    return getDayOfWeek(DateTime.now());
  }
}
