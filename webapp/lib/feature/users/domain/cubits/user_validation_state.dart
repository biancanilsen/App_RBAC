part of 'user_validation_cubit.dart';

abstract class UserValidationState extends Equatable {
  const UserValidationState();
}

class UserValidating extends UserValidationState {
  const UserValidating({
    this.tituloMessage,
    this.conteudoMessage,
  });

  final String? tituloMessage;
  final String? conteudoMessage;

  UserValidating copyWith({
    String? tituloMessage,
    String? conteudoMessage,
  }) {
    return UserValidating(
      tituloMessage: tituloMessage ?? this.tituloMessage,
      conteudoMessage: conteudoMessage ?? this.conteudoMessage,
    );
  }

  @override
  List<Object?> get props => [tituloMessage, conteudoMessage];
}

class UserValidated extends UserValidationState {
  const UserValidated();

  @override
  List<Object> get props => [];
}
