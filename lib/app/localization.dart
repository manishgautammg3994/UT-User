import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Event
abstract class LocalizationEvent {}

class LocalizationInitialEvent extends LocalizationEvent {
  final Locale locale;

  LocalizationInitialEvent({required this.locale});
}

// State
abstract class LocalizationState {}

class LocalizationInitialState extends LocalizationState {
  final Locale locale;

  LocalizationInitialState({required this.locale});
}

// Bloc
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc()
      : super(LocalizationInitialState(locale: const Locale('en'))) {
    // Register the event handler
    on<LocalizationInitialEvent>((event, emit) {
      emit(LocalizationInitialState(locale: event.locale));
    });
  }
}
