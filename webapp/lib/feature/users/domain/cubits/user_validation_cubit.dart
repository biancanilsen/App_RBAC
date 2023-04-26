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
      cubitEmailMessage = 'Preencha o email';
    } else {
      cubitEmailMessage = '';
    }
    if (password == '') {
      formInvalid = true;
      cubitPasswordMessage = 'Preencha a  senha';
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
