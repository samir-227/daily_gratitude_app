String formatEntryDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final entryDate = DateTime(date.year, date.month, date.day);

  final diff = today.difference(entryDate).inDays;

  if (diff == 0) return 'اليوم';
  if (diff == 1) return 'أمس';
  if (diff < 7) {
    const weekdays = ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
    return weekdays[date.weekday - 1];
  }
  return '${date.day}/${date.month}/${date.year}';
}

String formatTimeOfDay(DateTime date) {
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}
