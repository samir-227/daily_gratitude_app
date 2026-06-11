String _removeDiacritics(String text) {
  const diacritics = [
    '\u{064B}', '\u{064C}', '\u{064D}', '\u{064E}', '\u{064F}',
    '\u{0650}', '\u{0651}', '\u{0652}',
  ];
  for (final d in diacritics) {
    text = text.replaceAll(d, '');
  }
  return text;
}

String _removePunctuation(String text) {
  return text.replaceAll(RegExp(r'[^\p{L}\p{N}\s]', unicode: true), '');
}

const _arabicStopwords = {
  'أنا', 'أنت', 'هو', 'هي', 'نحن', 'هم', 'أن', 'في', 'من', 'على',
  'إلى', 'عن', 'مع', 'لا', 'ما', 'كان', 'كانت', 'يكون', 'هذا', 'هذه',
  'ذلك', 'التي', 'الذي', 'وقد', 'قد', 'لقد', 'لكن', 'إذا', 'كل',
  'بعد', 'قبل', 'عند', 'حتى', 'أو', 'إلا', 'غير', 'أين',
  'كيف', 'متى', 'أي', 'أيها', 'أيتها', 'هؤلاء', 'اللذان', 'اللتان',
  'الذين', 'اللاتي', 'اللائي', 'هناك', 'هنا', 'ثم', 'بل',
  'ليس', 'ليست', 'إن', 'إنما', 'كما', 'لأن', 'لذلك', 'بين',
  'تحت', 'فوق', 'دون', 'خلف', 'أمام', 'لدى', 'عندما', 'بعدما',
  'قبلما', 'حين', 'حيث', 'أما', 'إما', 'سواء', 'سوف', 'الآن',
};

List<String> extractTopics(String arabicText) {
  String cleaned = arabicText.toLowerCase();
  cleaned = _removeDiacritics(cleaned);
  cleaned = _removePunctuation(cleaned);

  final words = cleaned.split(RegExp(r'\s+'));
  final topics = <String>{};

  for (final word in words) {
    if (word.length < 3) continue;
    if (_arabicStopwords.contains(word)) continue;
    topics.add(word);
    if (topics.length >= 10) break;
  }

  return topics.toList();
}
