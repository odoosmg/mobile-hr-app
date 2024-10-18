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
  }

  void _companyList(
      FormDataCompanyList event, Emitter<FormDataState> emit) async {
    SelectFormModel box = AppServices.instance<DatabaseService>().getFormData!;
    state.stateType = FormDataStateType.companyList;
    if (!event.isRefresh) {
      List<int> ids = box.companySelected!.map((e) => e.id!).toList();

      box.companyList!.map((e) {
        if (ids.contains(e.id)) {
          e.isSelected = true;
        }
      }).toList();

      AppServices.instance<DatabaseService>().putFormData(box);
      state.companyList!.data = box.companyList;
      state.companyList!.status = ApiStatus.success;
      print("state === ${state.companyList!.data}");
      print("box ======= ${box.companyList}");
      emit(state.copyWith(state));

      return;
    }

    await formDataRepository.companyList().then((value) {
      if (value.isSuccess) {
        /// update box
        SelectFormModel box =
            AppServices.instance<DatabaseService>().getFormData ??
                SelectFormModel();
        box.companyList = value.data;
        AppServices.instance<DatabaseService>().putFormData(box);
      }
      state.companyList = value;
      emit(state.copyWith(state));
    });
  }
}
