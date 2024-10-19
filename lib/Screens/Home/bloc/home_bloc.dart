import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Models/home/in_out_model.dart';
import 'package:hrm_employee/Repository/form_data_repository.dart';
import 'package:hrm_employee/Repository/home_repository.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  final FormDataRepository formDataRepository;
  HomeBloc(this.homeRepository, this.formDataRepository)
      : super(HomeInitial()) {
    on<HomeCheckIn>(_checkIn);
    on<HomeCheckOut>(_checkOut);
    on<HomeGetData>(_getData);
  }

  ///
  void _checkIn(HomeCheckIn event, Emitter<HomeState> emit) async {
    /// loading
    state.checkInResult!.status = ApiStatus.loading;
    state.stateType = HomeStateType.checkin;
    emit(state.copyWith(state));

    ///
    await homeRepository.checkin().then((value) {
      state.checkInResult = value;
      emit(state.copyWith(state));
    });
  }

  ///
  void _checkOut(HomeCheckOut event, Emitter<HomeState> emit) async {
    /// loading
    state.checkOutResult!.status = ApiStatus.loading;
    state.stateType = HomeStateType.checkout;
    emit(state.copyWith(state));

    ///
    await homeRepository.checkout(event.checkInId).then((value) {
      state.checkOutResult = value;
      emit(state.copyWith(state));
    });
  }

  ///
  void _getData(HomeGetData event, Emitter<HomeState> emit) async {
    final dbService = AppServices.instance<DatabaseService>();
    final box = dbService.getFormData;

    state.stateType = HomeStateType.getData;

    /// loading
    if (event.isLoading) {
      state.getDataResult!.status = ApiStatus.loading;
    }

    emit(state.copyWith(state));

    if ((box?.companySelected ?? []).isEmpty) {
      await formDataRepository.companyList().then((value) {
        if (value.isSuccess) {
          ///
          if (value.data!.isNotEmpty) {
            /// first index
            value.data![0].isSelected = true;
            box!.companyList = value.data;
            box.companySelected = [value.data![0]];
            dbService.putFormData(box);
          }
        } else {
          /// return state failed.
          /// no need to conitue if cannot retrive company list
          state.getDataResult!.status = ApiStatus.failed;
          emit(state.copyWith(state));
          return;
        }
      });
    }

    await homeRepository.getInOutData().then((value) {
      state.getDataResult = value;

      emit(state.copyWith(state));
    });
  }
}
