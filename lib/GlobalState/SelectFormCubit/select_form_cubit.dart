import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';

part 'select_form_state.dart';

class SelectFormCubit extends Cubit<SelectFormState> {
  SelectFormCubit() : super(SelectFormInitial());

  void select() {}
}
