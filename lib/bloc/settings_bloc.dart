import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './bloc.dart';

class SettingsManagerBloc
    extends Bloc<SettingsManagerEvent, SettingsManagerState> {
  _getPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int themeOptions = prefs.getInt('themeOptions');
    final ThemeOptions options = themeOptions == null
        ? null
        : ThemeOptions.values.elementAt(themeOptions);
    dispatch(LoadedSettingsEvent(themeOptions: options));
  }

  _updateSettings(UpdateSettingsEvent event) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeOptions options = event.themeOptions;
    if (options == null) {
      final int themeOptions = prefs.getInt('themeOptions');
      options = themeOptions == null
          ? null
          : ThemeOptions.values.elementAt(themeOptions);
    } else {
      prefs.setInt('themeOptions', ThemeOptions.values.indexOf(options));
    }
    dispatch(LoadedSettingsEvent(themeOptions: options));
  }

  @override
  SettingsManagerState get initialState {
    _getPreferences();
    return PlaceholderSettingsManagerState();
  }

  @override
  Stream<SettingsManagerState> mapEventToState(
    SettingsManagerEvent event,
  ) async* {
    if (event is LoadedSettingsEvent) {
      yield LoadedSettingsManagerState(themeOptions: event.themeOptions);
    }
    if (event is UpdateSettingsEvent) {
      _updateSettings(event);
    }
  }
}
