import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_validation_state.dart';

class UserValidationCubit extends Cubit<UserValidationState> {
  UserValidationCubit() : super(const UserValidating());

  void validaForm(String titulo, String conteudo) {
    String cubitTituloMessage = '';
    String cubitConteudoMessage = '';
    bool formInvalid;

    formInvalid = false;
    if (titulo == '') {
      formInvalid = true;
      cubitTituloMessage = 'Preencha o título';
    } else {
      cubitTituloMessage = '';
    }
    if (conteudo == '') {
      formInvalid = true;
      cubitConteudoMessage = 'Preencha o conteúdo';
    } else {
      cubitConteudoMessage = '';
    }

    if (formInvalid == true) {
      emit(UserValidating(
        tituloMessage: cubitTituloMessage,
        conteudoMessage: cubitConteudoMessage,
      ));
    } else {
      emit(const UserValidated());
    }
  }
}
