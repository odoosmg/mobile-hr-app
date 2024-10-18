part of 'form_data_bloc.dart';

class FormDataEvent {}

class FormDataCompanyList extends FormDataEvent {
  final bool isRefresh;
  FormDataCompanyList(this.isRefresh);
}
