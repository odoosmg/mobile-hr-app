import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Repository/form_data_repository.dart';

import '../../../Models/form/select_form_model.dart';

part 'form_data_event.dart';
part 'form_data_state.dart';

class FormDataBloc extends Bloc<FormDataEvent, FormDataState> {
  final FormDataRepository formDataRepository;
  FormDataBloc(this.formDataRepository) : super(FormDataInitial()) {
    on<FormDataCompanyList>(_companyList);
  }

  void _companyList(
      FormDataCompanyList event, Emitter<FormDataState> emit) async {
    await formDataRepository.companyList().then((value) {
      // value.data!.map((e) {}).toList();
    });
  }
}
