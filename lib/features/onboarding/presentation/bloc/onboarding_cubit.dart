import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/notification_service.dart';

abstract class OnboardingState {}

class OnboardingPageState extends OnboardingState {
  final int page;
  final int reminderHour;
  final int reminderMinute;
  OnboardingPageState({
    this.page = 0,
    this.reminderHour = 20,
    this.reminderMinute = 0,
  });
}

class OnboardingCompleteState extends OnboardingState {}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingPageState());

  void nextPage() {
    if (state is OnboardingPageState) {
      final s = state as OnboardingPageState;
      if (s.page < 2) {
        emit(OnboardingPageState(
          page: s.page + 1,
          reminderHour: s.reminderHour,
          reminderMinute: s.reminderMinute,
        ));
      }
    }
  }

  void setReminderTime(int hour, int minute) {
    if (state is OnboardingPageState) {
      final s = state as OnboardingPageState;
      emit(OnboardingPageState(page: s.page, reminderHour: hour, reminderMinute: minute));
    }
  }

  Future<void> completeOnboarding() async {
    final s = state as OnboardingPageState;
    final settingsBox = await Hive.openBox(kSettingsBox);
    await settingsBox.put(kOnboardingComplete, true);
    await settingsBox.put(kReminderTime, '${s.reminderHour}:${s.reminderMinute}');
    final notifService = NotificationService();
    await notifService.initialize();
    await notifService.scheduleDaily(s.reminderHour, s.reminderMinute);
    emit(OnboardingCompleteState());
  }
}
