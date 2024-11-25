part of 'form_data_bloc.dart';

class FormDataState {
  FormDataStateType? stateType;
  ApiResult<List<SelectFormModel>>? companyList;
  List<SelectFormModel>? companySelected;
  DateTime? selectDateTime;

  FormDataState({
    this.stateType,
    this.companyList,
    this.companySelected,
    this.selectDateTime,
  });

  FormDataState copyWith(FormDataState d) {
    return FormDataState(
      stateType: d.stateType,
      companyList: d.companyList,
      companySelected: d.companySelected,
      selectDateTime: d.selectDateTime,
    );
  }
}

final class FormDataInitial extends FormDataState {
  @override
  ApiResult<List<SelectFormModel>> get companyList => ApiResult()
    ..status = ApiStatus.loading
    ..data = [];

  @override
  DateTime? get selectDateTime => DateTime.now();
}

enum FormDataStateType {
  companyList,
  companySelect,
  selectDateTime,
}
