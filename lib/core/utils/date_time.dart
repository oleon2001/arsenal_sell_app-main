import 'package:intl/intl.dart';

class DateTimeUtils {
  // Common date formats
  static const String defaultDateFormat = 'dd/MM/yyyy';
  static const String defaultTimeFormat = 'HH:mm';
  static const String defaultDateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String apiDateTimeFormat = 'yyyy-MM-ddTHH:mm:ss.SSSZ';
  static const String displayDateFormat = 'EEEE, dd MMMM yyyy';
  static const String shortDateFormat = 'dd/MM';
  static const String monthYearFormat = 'MMMM yyyy';

  // Spanish locale formatters
  static final DateFormat _dateFormatter =
      DateFormat(defaultDateFormat, 'es_ES');
  static final DateFormat _timeFormatter =
      DateFormat(defaultTimeFormat, 'es_ES');
  static final DateFormat _dateTimeFormatter =
      DateFormat(defaultDateTimeFormat, 'es_ES');
  static final DateFormat _displayDateFormatter =
      DateFormat(displayDateFormat, 'es_ES');
  static final DateFormat _shortDateFormatter =
      DateFormat(shortDateFormat, 'es_ES');
  static final DateFormat _monthYearFormatter =
      DateFormat(monthYearFormat, 'es_ES');

  /// Format date to default format (dd/MM/yyyy)
  static String formatDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return _dateFormatter.format(dateTime);
  }

  /// Format time to default format (HH:mm)
  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return _timeFormatter.format(dateTime);
  }

  /// Format date and time to default format (dd/MM/yyyy HH:mm)
  static String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return _dateTimeFormatter.format(dateTime);
  }

  /// Format date for display (Lunes, 15 enero 2024)
  static String formatDisplayDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return _displayDateFormatter.format(dateTime);
  }

  /// Format short date (15/01)
  static String formatShortDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return _shortDateFormatter.format(dateTime);
  }

  /// Format month and year (enero 2024)
  static String formatMonthYear(DateTime? dateTime) {
    if (dateTime == null) return '';
    return _monthYearFormatter.format(dateTime);
  }

  /// Format custom date pattern
  static String formatCustom(DateTime? dateTime, String pattern) {
    if (dateTime == null) return '';
    return DateFormat(pattern, 'es_ES').format(dateTime);
  }

  /// Get relative time (hace 2 horas, ayer, etc.)
  static String getRelativeTime(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return 'Ayer';
      } else if (difference.inDays < 7) {
        return 'Hace ${difference.inDays} días';
      } else if (difference.inDays < 30) {
        final weeks = (difference.inDays / 7).floor();
        return weeks == 1 ? 'Hace 1 semana' : 'Hace $weeks semanas';
      } else if (difference.inDays < 365) {
        final months = (difference.inDays / 30).floor();
        return months == 1 ? 'Hace 1 mes' : 'Hace $months meses';
      } else {
        final years = (difference.inDays / 365).floor();
        return years == 1 ? 'Hace 1 año' : 'Hace $years años';
      }
    } else if (difference.inHours > 0) {
      return difference.inHours == 1
          ? 'Hace 1 hora'
          : 'Hace ${difference.inHours} horas';
    } else if (difference.inMinutes > 0) {
      return difference.inMinutes == 1
          ? 'Hace 1 minuto'
          : 'Hace ${difference.inMinutes} minutos';
    } else {
      return 'Ahora mismo';
    }
  }

  /// Get time of day greeting
  static String getTimeGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buenos días';
    } else if (hour < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  /// Check if date is today
  static bool isToday(DateTime? dateTime) {
    if (dateTime == null) return false;
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Check if date is yesterday
  static bool isYesterday(DateTime? dateTime) {
    if (dateTime == null) return false;
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return dateTime.year == yesterday.year &&
        dateTime.month == yesterday.month &&
        dateTime.day == yesterday.day;
  }

  /// Check if date is this week
  static bool isThisWeek(DateTime? dateTime) {
    if (dateTime == null) return false;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));

    return dateTime.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        dateTime.isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Get start of day (00:00:00)
  static DateTime startOfDay(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day);

  /// Get end of day (23:59:59)
  static DateTime endOfDay(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);

  /// Get start of week (Monday)
  static DateTime startOfWeek(DateTime dateTime) {
    final daysToSubtract = dateTime.weekday - 1;
    return startOfDay(dateTime.subtract(Duration(days: daysToSubtract)));
  }

  /// Get end of week (Sunday)
  static DateTime endOfWeek(DateTime dateTime) {
    final daysToAdd = 7 - dateTime.weekday;
    return endOfDay(dateTime.add(Duration(days: daysToAdd)));
  }

  /// Get start of month
  static DateTime startOfMonth(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month, 1);

  /// Get end of month
  static DateTime endOfMonth(DateTime dateTime) =>
      DateTime(dateTime.year, dateTime.month + 1, 0, 23, 59, 59);

  /// Parse date string with multiple formats
  static DateTime? parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;

    final formats = [
      defaultDateTimeFormat,
      defaultDateFormat,
      apiDateTimeFormat,
      'yyyy-MM-dd',
      'dd-MM-yyyy',
      'yyyy/MM/dd',
      'MM/dd/yyyy',
    ];

    for (final format in formats) {
      try {
        return DateFormat(format).parse(dateString);
      } catch (e) {
        continue;
      }
    }

    return null;
  }

  /// Calculate age from birth date
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  /// Calculate duration between two dates
  static String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays}d ${duration.inHours % 24}h';
    } else if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  /// Get business days between two dates
  static int getBusinessDays(DateTime startDate, DateTime endDate) {
    int businessDays = 0;
    DateTime current = startDate;

    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      if (current.weekday != DateTime.saturday &&
          current.weekday != DateTime.sunday) {
        businessDays++;
      }
      current = current.add(const Duration(days: 1));
    }

    return businessDays;
  }

  /// Check if it's business hours
  static bool isBusinessHours({
    DateTime? dateTime,
    int startHour = 8,
    int endHour = 18,
  }) {
    final checkTime = dateTime ?? DateTime.now();

    // Check if it's weekend
    if (checkTime.weekday == DateTime.saturday ||
        checkTime.weekday == DateTime.sunday) {
      return false;
    }

    // Check if it's within business hours
    return checkTime.hour >= startHour && checkTime.hour < endHour;
  }

  /// Get next business day
  static DateTime getNextBusinessDay([DateTime? from]) {
    DateTime nextDay = (from ?? DateTime.now()).add(const Duration(days: 1));

    while (nextDay.weekday == DateTime.saturday ||
        nextDay.weekday == DateTime.sunday) {
      nextDay = nextDay.add(const Duration(days: 1));
    }

    return nextDay;
  }

  /// Format time spent (for visit duration, etc.)
  static String formatTimeSpent(DateTime? startTime, DateTime? endTime) {
    if (startTime == null) return 'No iniciado';
    if (endTime == null) return 'En progreso';

    final duration = endTime.difference(startTime);
    return formatDuration(duration);
  }

  /// Get week number of year
  static int getWeekOfYear(DateTime dateTime) {
    final startOfYear = DateTime(dateTime.year, 1);
    final days = dateTime.difference(startOfYear).inDays;
    return ((days + startOfYear.weekday) / 7).ceil();
  }

  /// Check if date is in the future
  static bool isFuture(DateTime? dateTime) {
    if (dateTime == null) return false;
    return dateTime.isAfter(DateTime.now());
  }

  /// Check if date is in the past
  static bool isPast(DateTime? dateTime) {
    if (dateTime == null) return false;
    return dateTime.isBefore(DateTime.now());
  }

  /// Get local timezone offset
  static String getTimezoneOffset() {
    final offset = DateTime.now().timeZoneOffset;
    final hours = offset.inHours;
    final minutes = offset.inMinutes % 60;
    final sign = hours >= 0 ? '+' : '-';
    return '$sign${hours.abs().toString().padLeft(2, '0')}:${minutes.abs().toString().padLeft(2, '0')}';
  }
}
