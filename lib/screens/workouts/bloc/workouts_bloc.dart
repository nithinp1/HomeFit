import 'package:bloc/bloc.dart';
import 'package:homefit/data/workout_data.dart';
import 'package:meta/meta.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  WorkoutsBloc() : super(WorkoutsInitial());

  WorkoutsBloc.withCardTappedHandler() : super(WorkoutsInitial()) {
    on<CardTappedEvent>((event, emit) {
      emit(CardTappedState(workout: event.workout));
    });
  }
}
