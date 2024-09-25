import 'package:flutter_bloc/flutter_bloc.dart';

part 'date_label_state.dart';

class DateLabelCubit extends Cubit<DateTime> {
  DateLabelCubit() : super(DateTime.now());

  void dateLabel() {
    emit(DateTime.now());
  }
}
