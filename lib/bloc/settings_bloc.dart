import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:key_value_store/key_value_store.dart';
import 'package:preferences_abstraction/preferences_abstraction.dart';

import './bloc.dart';

abstract class SettingsManagerBloc
    extends Bloc<SettingsManagerEvent, SettingsManagerState> {}

class LocalSettingsManagerBloc extends SettingsManagerBloc {
  LocalSettingsManagerBloc([this.prefs]);
  KeyValueStore prefs;
  LoadedSettingsManagerState _updateSettings(UpdateSettingsEvent event) {
    try {
      ThemeMode options = event.themeOptions;
      if (options == null) {
        final int themeOptions = getInt('themeOptions');
        options = themeOptions == null
            ? null
            : ThemeMode.values.elementAt(themeOptions);
      } else {
        prefs.setInt('themeOptions', ThemeMode.values.indexOf(options));
      }
      return LoadedSettingsManagerState(themeOptions: options);
    } catch (e) {
      return LoadedSettingsManagerState();
    }
  }

  _initialize() async {
    prefs ??= await getKeyValueStore();
    final int themeOptions = getInt('themeOptions');
    final ThemeMode options =
        themeOptions == null ? null : ThemeMode.values.elementAt(themeOptions);
    dispatch(LoadedSettingsEvent(themeOptions: options));
  }

  @override
  SettingsManagerState get initialState {
    _initialize();
    return PlaceholderSettingsManagerState();
  }

  int getInt(String key) {
    int i;
    try {
      i = prefs?.getInt(key);
    } catch (e) {}
    return i;
  }

  @override
  Stream<SettingsManagerState> mapEventToState(
    SettingsManagerEvent event,
  ) async* {
    if (event is LoadedSettingsEvent) {
      yield LoadedSettingsManagerState(themeOptions: event.themeOptions);
    }
    if (event is UpdateSettingsEvent) {
      yield _updateSettings(event);
    }
  }
}
