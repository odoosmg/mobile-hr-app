import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    // on<DateLabel>(_dateLabel);
  }

  // void _dateLabel(DateLabel event, Emitter<HomeState> emit) {}
}
