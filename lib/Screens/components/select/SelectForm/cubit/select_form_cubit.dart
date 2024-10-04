import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrm_employee/Models/form/select_form_model.dart';

class SelectFormCubit extends Cubit<SelectFormModel?> {
  SelectFormCubit() : super(null); // init value is null

  void select(SelectFormModel? selectedItem) {
    emit(selectedItem);
  }
}
