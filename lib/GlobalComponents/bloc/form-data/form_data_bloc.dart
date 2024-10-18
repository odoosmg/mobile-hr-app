import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Helper/k_enum.dart';
import 'package:hrm_employee/Models/api/api_result.dart';
import 'package:hrm_employee/Repository/form_data_repository.dart';
import 'package:hrm_employee/Services/app_services.dart';
import 'package:hrm_employee/Services/database_service.dart';

import '../../../Models/form/select_form_model.dart';

part 'form_data_event.dart';
part 'form_data_state.dart';

///***
/// For Select Form Data
/// */

class FormDataBloc extends Bloc<FormDataEvent, FormDataState> {
  final FormDataRepository formDataRepository;
  FormDataBloc(this.formDataRepository) : super(FormDataInitial()) {
    on<FormDataCompanyList>(_companyList);
    on<FormDataCompanySelected>(_companySelect);
  }
/*
  void _companyList(
      FormDataCompanyList event, Emitter<FormDataState> emit) async {
    final dbService = AppServices.instance<DatabaseService>();
    SelectFormModel box = dbService.getFormData!;
    state.stateType = FormDataStateType.companyList;

    /// selected id
    List<int> ids = box.companySelected!.map((e) => e.id!).toList();

    /// Not refresh
    if (!event.isRefresh) {
    

      /// update isSelected by id
      box.companyList!.map((e) {
        if (ids.contains(e.id)) {
          e.isSelected = true;
        }
      }).toList();

      ///
      dbService.putFormData(box);
      state.companyList!.data = box.companyList;
      state.companyList!.status = ApiStatus.success;

      emit(state.copyWith(state));

      return;
    }

    /// Refresh
    await formDataRepository.companyList().then((value) {
      if (value.isSuccess) {
        ///
        ids = _remainIds(ids, value.data!.map((e) => e.id!).toList());

        /// check if ids have value
        if (ids.isNotEmpty) {
          /// update isSelected by id
          value.data!.map((e) {
            if (ids.contains(e.id)) {
              e.isSelected = true;
            }
          }).toList();
        } else {
          /// else set first index as checked
          if (value.data!.isNotEmpty) {
            value.data![0].isSelected = true;
            box.companySelected = [value.data![0]];
            dbService.putFormData(box);
          }
        }

        // if (value.data!.isNotEmpty) {
        //   value.data![0].isSelected = true;
        // }

        box.companyList = value.data;
        dbService.putFormData(box);
      }
      state.companyList = value;
      emit(state.copyWith(state));
    });
  }

  */

  void _companyList(
      FormDataCompanyList event, Emitter<FormDataState> emit) async {
    state.stateType = FormDataStateType.companyList;

    final dbService = AppServices.instance<DatabaseService>();
    SelectFormModel box = dbService.getFormData!;
    List<int> ids = box.companySelected!.map((e) => e.id!).toList();

    if (!event.isRefresh) {
      /// update isSelected by id
      box.companyList!.map((e) {
        if (ids.contains(e.id)) {
          e.isSelected = true;
        }
      }).toList();

      ///
      dbService.putFormData(box);

      ///
      state.companyList!.data = box.companyList;
      state.companyList!.status = ApiStatus.success;
      emit(state.copyWith(state));
    }

    ///
    await formDataRepository.companyList().then((value) {
      if (value.isSuccess) {
        if (value.data!.isNotEmpty) {
          /// first index
          value.data![0].isSelected = true;
          box.companySelected = [value.data![0]];
        }
      }
      state.companyList = value;

      box.companyList = value.data;
      dbService.putFormData(box);

      emit(state.copyWith(state));
    });
  }

  void _companySelect(
      FormDataCompanySelected event, Emitter<FormDataState> emit) async {
    SelectFormModel box = AppServices.instance<DatabaseService>().getFormData ??
        SelectFormModel();
    box.companySelected = event.list;
    AppServices.instance<DatabaseService>().putFormData(box);
    state.stateType = FormDataStateType.companySelect;
    state.companySelected = box.companySelected;

    ///
    emit(state.copyWith(state));
  }

  /// Compare 2 lists.
  /// find ids that have in old list.
  List<int> _remainIds(List<int> list1, List<int> list2) {
    List<int> d = [];

    for (int i = 0; i < list2.length; i++) {
      /// have,added
      if (list1.contains(list2[i])) {
        d.add(list2[i]);
      }
    }
    return d;
  }
}
