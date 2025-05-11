import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_workout_event.dart';
part 'start_workout_state.dart';

class StartWorkoutBloc extends Bloc<StartWorkoutEvent, StartWorkoutState> {
  StartWorkoutBloc() : super(StartWorkoutInitial()) {
    on<BackTappedEvent>((event, emit) {
      emit(BackTappedState());
    });

    on<PlayTappedEvent>((event, emit) {
      time = event.time;
      emit(PlayTimerState(time: event.time));
    });

    on<PauseTappedEvent>((event, emit) {
      time = event.time;
      emit(PauseTimerState(currentTime: time));
    });

    on<NextTappedEvent>((event, emit) {
      // Update the current exercise index and emit the updated state
      if (event.currentIndex < event.totalExercises - 1) {
        emit(NextExerciseState(currentIndex: event.currentIndex + 1));
      } else {
        emit(WorkoutCompletedState());
      }
    });

    on<FinishTappedEvent>((event, emit) {
      // Mark the workout as completed and emit the final state
      emit(WorkoutCompletedState());
    });
  }

  int time = 0;
}
