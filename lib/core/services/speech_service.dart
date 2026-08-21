import 'package:speech_to_text/speech_to_text.dart';
import '../constants/app_constants.dart';
import '../constants/app_strings.dart';

class SpeechService {
  final SpeechToText _speech = SpeechToText();

  bool get isListening => _speech.isListening;
  bool get isAvailable => _speech.isAvailable;

  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  Future<void> startListening({
    required Function(String text) onResult,
    required Function(String error) onError,
  }) async {
    final locale = await getBestArabicLocale();
    if (locale == null) {
      onError(AppStrings.errorNoArabicPack);
      return;
    }

    await _speech.listen(
      onResult: (result) => onResult(result.recognizedWords),
      listenOptions: SpeechListenOptions(
        partialResults: true,
        cancelOnError: false,
        localeId: locale,
        listenFor: kMaxRecordingDuration,
        pauseFor: kPauseDuration,
      ),
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  Future<String?> getBestArabicLocale() async {
    final locales = await _speech.locales();
    final arabicLocales = locales.where((l) => l.localeId.startsWith('ar')).toList();
    if (arabicLocales.any((l) => l.localeId == kArabicLocaleEG)) return kArabicLocaleEG;
    if (arabicLocales.any((l) => l.localeId == kArabicLocaleSA)) return kArabicLocaleSA;
    if (arabicLocales.isNotEmpty) return arabicLocales.first.localeId;
    return null;
  }

  Future<List<LocaleName>> getArabicLocales() async {
    final locales = await _speech.locales();
    return locales.where((l) => l.localeId.startsWith('ar')).toList();
  }
}
