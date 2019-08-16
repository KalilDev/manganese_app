import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './enums.dart';

@immutable
abstract class SettingsManagerEvent extends Equatable {
  SettingsManagerEvent({ThemeOptions themeOptions})
      : themeOptions = themeOptions,
        super([themeOptions ?? ThemeOptions.auto]);
  final ThemeOptions themeOptions;
}

class LoadedSettingsEvent extends SettingsManagerEvent {
  LoadedSettingsEvent({ThemeOptions themeOptions})
      : super(themeOptions: themeOptions);
}

class UpdateSettingsEvent extends SettingsManagerEvent {
  UpdateSettingsEvent({ThemeOptions themeOptions})
      : super(themeOptions: themeOptions);
}
