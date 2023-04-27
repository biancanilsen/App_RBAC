import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_validation_state.dart';

class UserValidationCubit extends Cubit<UserValidationState> {
  UserValidationCubit() : super(const UserValidating());

  void validaForm(String email, String password) {
    String cubitEmailMessage = '';
    String cubitPasswordMessage = '';
    bool formInvalid;

    formInvalid = false;
    if (email == '') {
      formInvalid = true;
      cubitEmailMessage = 'Campo obrigatório';
    } else {
      cubitEmailMessage = '';
    }
    if (password == '') {
      formInvalid = true;
      cubitPasswordMessage = 'Campo obrigatório';
    } else {
      cubitPasswordMessage = '';
    }

    if (formInvalid == true) {
      emit(UserValidating(
        emailMessage: cubitEmailMessage,
        passwordMessage: cubitPasswordMessage,
      ));
    } else {
      emit(const UserValidated());
    }
  }
}
