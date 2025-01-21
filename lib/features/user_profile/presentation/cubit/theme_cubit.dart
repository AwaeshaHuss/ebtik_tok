import 'package:ebtik_tok/config/cache/cahce_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const _themeKey = 'themeMode';

  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.dark)) {
    _loadTheme();
  }
  static ThemeCubit get(context) => BlocProvider.of(context);

  void toggleTheme() async {
    final newThemeMode =
        state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

    emit(ThemeState(themeMode: newThemeMode));

    await CacheHelper.saveData(key: _themeKey, value: newThemeMode.name);
  }

  Future<void> _loadTheme() async {
    final themeName = CacheHelper.getData(key: _themeKey);

    final themeMode = themeName == ThemeMode.dark.name
        ? ThemeMode.dark
        : ThemeMode.light;

    emit(ThemeState(themeMode: themeMode));
  }
}
