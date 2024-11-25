part of 'form_data_bloc.dart';

class FormDataEvent {}

class FormDataCompanyList extends FormDataEvent {
  final bool isRefresh;
  FormDataCompanyList(this.isRefresh);
}

class FormDataCompanySelected extends FormDataEvent {
  final List<SelectFormModel> list;
  FormDataCompanySelected(this.list);
}

class FormDataSelectDateTime extends FormDataEvent {
  final DateTime datetime;
  FormDataSelectDateTime(this.datetime);
}
