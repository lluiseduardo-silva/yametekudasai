import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yamete_kudasai/themes/app-theme.dart';

part 'themecubit_state.dart';

class ThemecubitCubit extends Cubit<ThemeState> {
  ThemecubitCubit() : super(ThemeState(themeMode: ThemeMode.light)) {
    updateAppTheme();
  }

  void updateAppTheme() {
    final Brightness currentBrightness = AppTheme.currentSystemBrightness;
    currentBrightness == Brightness.light
        ? _setTheme(ThemeMode.light)
        : _setTheme(ThemeMode.dark);
  }

  void _setTheme(ThemeMode themeMode) {
    AppTheme.setStatusBarAndNavigationBarColors(themeMode);
    emit(ThemeState(themeMode: themeMode));
  }
}
