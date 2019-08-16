import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'enums.dart';

@immutable
abstract class SettingsManagerState extends Equatable {
  SettingsManagerState({ThemeOptions themeOptions})
      : themeOptions = themeOptions ?? ThemeOptions.auto,
        super([
          themeOptions ?? ThemeOptions.auto,
        ]);
  final ThemeOptions themeOptions;
}

class PlaceholderSettingsManagerState extends SettingsManagerState {}

class LoadedSettingsManagerState extends SettingsManagerState {
  LoadedSettingsManagerState({ThemeOptions themeOptions})
      : super(themeOptions: themeOptions);
}
