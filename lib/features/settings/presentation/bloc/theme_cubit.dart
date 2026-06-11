import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';

class ThemeCubit extends Cubit<Brightness> {
  ThemeCubit() : super(Brightness.dark);

  Future<void> loadTheme() async {
    final settingsBox = await Hive.openBox(kSettingsBox);
    final isDark = settingsBox.get(kDarkModeEnabled, defaultValue: true) as bool;
    emit(isDark ? Brightness.dark : Brightness.light);
  }

  Future<void> toggleDarkMode(bool enabled) async {
    final settingsBox = await Hive.openBox(kSettingsBox);
    await settingsBox.put(kDarkModeEnabled, enabled);
    emit(enabled ? Brightness.dark : Brightness.light);
  }
}
