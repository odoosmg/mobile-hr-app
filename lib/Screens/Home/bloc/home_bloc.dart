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
    on<HomeCheckIn>(_checkIn);
    on<HomeGetData>(_getData);
  }

  ///
  void _checkIn(HomeCheckIn event, Emitter<HomeState> emit) async {
    /// loading
    state.checkInResult!.status = ApiStatus.loading;
    state.stateType = HomeStateType.checkin;
    emit(state.copyWith(state));
    await homeRepository.checkin().then((value) {
      state.checkInResult = value;
      emit(state.copyWith(state));
    });
  }

  ///
  void _getData(HomeGetData event, Emitter<HomeState> emit) async {
    /// loading
    state.getDataResult!.status = ApiStatus.loading;
    state.stateType = HomeStateType.getData;
    emit(state.copyWith(state));

    await homeRepository.getInOutData().then((value) {
      state.getDataResult = value;
      emit(state.copyWith(state));
    });
  }
}
