part of 'form_data_bloc.dart';

class FormDataState {
  FormDataStateType? stateType;
  ApiResult<List<SelectFormModel>>? companyList;
  List<SelectFormModel>? companySelected;

  FormDataState({
    this.stateType,
    this.companyList,
    this.companySelected,
  });

  FormDataState copyWith(FormDataState d) {
    return FormDataState(
      stateType: d.stateType,
      companyList: d.companyList,
      companySelected: d.companySelected,
    );
  }
}

final class FormDataInitial extends FormDataState {
  @override
  ApiResult<List<SelectFormModel>> get companyList => ApiResult()
    ..status = ApiStatus.loading
    ..data = [];
}

enum FormDataStateType {
  companyList,
  companySelect,
}
