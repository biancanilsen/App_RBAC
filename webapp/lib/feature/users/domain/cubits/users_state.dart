part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  const UsersInitial();

  @override
  List<Object?> get props => [];
}

class UsersLoading extends UsersState {
  const UsersLoading();

  @override
  List<Object?> get props => [];
}

class UsersLoaded extends UsersState {
  const UsersLoaded({
    this.users,
  });

  final List<User>? users;

  UsersLoaded copyWith({
    List<User>? users,
  }) {
    return UsersLoaded(
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [users];
}

class UsersFailure extends UsersState {
  const UsersFailure();

  @override
  List<Object?> get props => [];
}

class UsersSuccess extends UsersState {
  const UsersSuccess();

  @override
  List<Object?> get props => [];
}
