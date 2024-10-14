part of 'form_data_bloc.dart';

class FormDataState {
  FormDataStateType? stateType;
  List<SelectFormModel>? companyList;
  FormDataState({
    this.stateType,
    this.companyList,
  });

  FormDataState copyWith(FormDataState d) {
    return FormDataState(
      stateType: d.stateType,
      companyList: d.companyList,
    );
  }
}

final class FormDataInitial extends FormDataState {
  @override
  List<SelectFormModel> get companyList => [];
}

enum FormDataStateType {
  companyList,
}
