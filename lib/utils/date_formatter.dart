import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
///
///
String formatDateFromTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  final formatter = DateFormat('M-d-yyyy');
  final formattedDate = formatter.format(dateTime);
  return formattedDate;
}

///
///
///
DateTime convertTimeOfDayToDateTime({
  required TimeOfDay timeOfDay,
  required DateTime selectedDate,
}) {
  return DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    timeOfDay.hour,
    timeOfDay.minute,
  );
}

///
///
///
TimeOfDay dateTimeToTimeOfDay(DateTime dateTime) {
  return TimeOfDay(
    hour: dateTime.hour,
    minute: dateTime.minute,
  );
}

///
///
///

final monthShortCommaDayFormat = DateFormat('MMM,dd');
final monthNameDateYearFormat = DateFormat.yMMMd();
// final timeWithoutAMPMFormat = DateFormat("H:i:s");
final timeWithoutAMPMFormat = DateFormat.Hm();
final timeWithAMPMFormat = DateFormat.jm();
final monthDateYearFormat = DateFormat.yMd();
final dayNameMonthNameDateYearFormat = DateFormat.yMMMMEEEEd();
final monthNameDayDateYearFormat = DateFormat.yMMMMd();
final weekDayNameFormat = DateFormat('EEEE');
final monthNameFormat = DateFormat.MMM();
final monthDateFormat = DateFormat('dd');
final dayNameMonthYear = DateFormat('EEEE MM/yy');
final dayDateMonth = DateFormat('EEE, d MMM');
final dateMonthYearFormat = DateFormat('dd/MM/yyyy');
final monthDayYearFormat = DateFormat('MM-dd-yyyy');
final yearMonthDayFormat = DateFormat('yyyy-MM-dd');
var yMDHMSFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
var yMDFromat = DateFormat("yyyy-MM-dd");
final dayNameMonthYearDate = DateFormat('EEEE, MMM, dd');
final dayName = DateFormat('EEEE'); // “Monday”
final monthDate = DateFormat('MMM, dd');
