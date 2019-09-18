import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'enums.dart';

@immutable
abstract class SettingsManagerState extends Equatable {
  SettingsManagerState({ThemeMode themeOptions})
      : themeOptions = themeOptions ?? ThemeMode.light,
        super([
          themeOptions ?? ThemeMode.light,
        ]);
  final ThemeMode themeOptions;
}

class PlaceholderSettingsManagerState extends SettingsManagerState {}

class LoadedSettingsManagerState extends SettingsManagerState {
  LoadedSettingsManagerState({ThemeMode themeOptions})
      : super(themeOptions: themeOptions);
}
