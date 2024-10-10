import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileImageCubit extends Cubit<bool> {
  ProfileImageCubit() : super(false);

  void isError(bool isError) {
    emit(isError);
  }
}
