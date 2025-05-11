import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_bar_event.dart';
part 'tab_bar_state.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  TabBarBloc() : super(TabBarInitial()) {
    on<TabBarItemTappedEvent>((event, emit) {
      currentIndex = event.index;
      emit(TabBarItemSelectedState(index: currentIndex));
    });
  }

  int currentIndex = 0;
  bool isSelected = false;
}
