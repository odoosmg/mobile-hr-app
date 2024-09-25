import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/Repository/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository) : super(HomeInitial()) {
    on<HomeCheckIn>(checkIn);
  }

  void checkIn(HomeCheckIn event, Emitter<HomeState> emit) async {
    state.checkInResult!.status = ApiStatus.loading;
    emit(state.copyWith(state));
    await homeRepository.checkin().then((value) {
      state.checkInResult = value;
      emit(state.copyWith(state));
    });
  }
}
