import 'package:flutter_test/flutter_test.dart';
import 'package:daily_gratitude_app/core/utils/arabic_text_utils.dart';

void main() {
  group('ArabicTextUtils', () {
    test('extracts topics from Arabic text', () {
      final topics = extractTopics('أنا ممتن لعيلتي وصحتي');
      expect(topics, containsAll(['ممتن', 'لعيلتي', 'وصحتي']));
    });

    test('removes stopwords from topics', () {
      final topics = extractTopics('أنا في المنزل مع عيلتي');
      expect(topics, isNot(contains('أنا')));
      expect(topics, isNot(contains('في')));
      expect(topics, isNot(contains('مع')));
    });

    test('removes short words', () {
      final topics = extractTopics('لا ما هو هي');
      expect(topics.every((t) => t.length >= 3), isTrue);
    });

    test('returns at most 10 topics', () {
      final topics = extractTopics('واحد اثنان ثلاثة أربعة خمسة ستة سبعة ثمانية تسعة عشرة أحد عشر اثنا عشر');
      expect(topics.length, lessThanOrEqualTo(10));
    });

    test('removes diacritics', () {
      final topics = extractTopics('شَكَرَ جَمِيل');
      expect(topics, containsAll(['شكر', 'جميل']));
    });
  });
}
