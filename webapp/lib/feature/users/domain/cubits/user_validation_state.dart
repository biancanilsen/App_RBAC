part of 'user_validation_cubit.dart';

abstract class UserValidationState extends Equatable {
  const UserValidationState();
}

class UserValidating extends UserValidationState {
  const UserValidating({
    this.emailMessage,
    this.passwordMessage,
  });

  final String? emailMessage;
  final String? passwordMessage;

  UserValidating copyWith({
    String? emailMessage,
    String? conteudoMessage,
  }) {
    return UserValidating(
      emailMessage: emailMessage ?? this.emailMessage,
      passwordMessage: passwordMessage ?? this.passwordMessage,
    );
  }

  @override
  List<Object?> get props => [emailMessage, passwordMessage];
}

class UserValidated extends UserValidationState {
  const UserValidated();

  @override
  List<Object> get props => [];
}
