part of 'start_workout_bloc.dart';

@immutable
abstract class StartWorkoutState {}

class StartWorkoutInitial extends StartWorkoutState {}

class BackTappedState extends StartWorkoutState {}

class PlayTimerState extends StartWorkoutState {
  final int time;

  PlayTimerState({required this.time});
}

class PauseTimerState extends StartWorkoutState {
  final int currentTime;

  PauseTimerState({required this.currentTime});
}

class NextExerciseState extends StartWorkoutState {
  final int currentIndex;

  NextExerciseState({required this.currentIndex});
}

class WorkoutCompletedState extends StartWorkoutState {}
