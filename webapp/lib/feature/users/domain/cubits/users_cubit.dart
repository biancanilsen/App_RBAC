import 'package:bloc/bloc.dart';
import '../../data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:grpc/grpc.dart';
import '../../../../../generated/user.pb.dart';
import '../../../../../generated/auth.pb.dart';
import 'package:flutter/foundation.dart';
import '../../services/grpc_service.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  Init() {
    late ClientChannel client;
  }

  UsersCubit({required ServiceClient serviceClient})
      : _serviceClient = serviceClient,
        super(const UsersInitial());

  final ServiceClient _serviceClient;

  Future<void> postRegister(String name, String email, String password) async {
    UserResponse loginUser =
        UserResponse(name: name, email: email, password: password);
    emit(const UsersLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _serviceClient.postRegister(loginUser);
      emit(const UsersSuccess());
    } on Exception {
      emit(const UsersFailure());
    }
  }

  Future<void> getUsers() async {
    emit(const UsersLoading());
    try {
      final usersResponse = await _serviceClient.getUsers();
      final users = usersResponse.users
          .map((user) => User(
                id: user.id,
                name: user.name,
                email: user.email,
                password: user.password,
              ))
          .toList();
      print(users);
      emit(UsersLoaded(
        users: users,
      ));
    } on Exception {
      emit(const UsersFailure());
    }
  }

  Future<void> deleteUser(id) async {
    emit(const UsersLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      // await _serviceClient.deleteUsers(id);
      getUsers();
    } on Exception {
      emit(const UsersFailure());
    }
  }

  Future<void> saveUser(
      String? id, String name, String email, String password) async {
    UserResponse editUser =
        UserResponse(id: id, name: name, email: email, password: password);
    emit(const UsersLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      debugPrint('id: $id');
      if (id == null) {
        // editUser = await _serviceClient.updateUsers(editUser);
      } else {
        // editUser = await _serviceClient.updateUsers(editUser);
      }
      emit(const UsersSuccess());
    } on Exception {
      emit(const UsersFailure());
    }
  }
}
