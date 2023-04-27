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
    UserResponse registerUser =
        UserResponse(name: name, email: email, password: password);
    emit(const UsersLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _serviceClient.postRegister(registerUser);
      emit(const UsersSuccess());
    } on Exception {
      emit(const UsersFailure());
    }
  }

  Future<void> postLogin(String email, String password) async {
    AuthRequest loginUser = AuthRequest(email: email, password: password);
    emit(const UsersLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _serviceClient.postLogin(loginUser);
      emit(const UsersSuccess());
    } on Exception {
      emit(const UsersFailure());
    }
  }

  Future<void> getUsers() async {
    emit(const UsersLoading());
    try {
      final userResponse = await _serviceClient.getUsers();
      final users = userResponse.users
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

  Future<void> updateUser(
      String? id, String name, String email, String password) async {
    UserResponse editUser =
        UserResponse(id: id, name: name, email: email, password: password);
    emit(const UsersLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      editUser = await _serviceClient.updateUser(editUser);
      emit(const UsersSuccess());
    } on Exception {
      emit(const UsersFailure());
    }
  }

  Future<void> deleteUser(id) async {
    emit(const UsersLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      await _serviceClient.deleteUser(id);
      getUsers();
    } on Exception {
      emit(const UsersFailure());
    }
  }
}
