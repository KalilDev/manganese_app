import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './enums.dart';

@immutable
abstract class SettingsManagerEvent extends Equatable {
  SettingsManagerEvent({ThemeMode themeOptions})
      : themeOptions = themeOptions,
        super([themeOptions ?? ThemeMode.light]);
  final ThemeMode themeOptions;
}

class LoadedSettingsEvent extends SettingsManagerEvent {
  LoadedSettingsEvent({ThemeMode themeOptions})
      : super(themeOptions: themeOptions);
}

class UpdateSettingsEvent extends SettingsManagerEvent {
  UpdateSettingsEvent({ThemeMode themeOptions})
      : super(themeOptions: themeOptions);
}
