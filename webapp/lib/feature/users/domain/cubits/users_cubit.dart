import 'package:bloc/bloc.dart';
import '../../data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:grpc/grpc.dart';
import '../../../../../generated/user.pb.dart';
import '../../../../../generated/auth.pb.dart';
import 'package:flutter/foundation.dart';
import '../../services/grpc_service.dart';
import 'package:localstorage/localstorage.dart';
part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final LocalStorage storage = new LocalStorage('token');

  Init() {
    late ClientChannel client;
    AuthResponse hasToken;
  }

  UsersCubit({required ServiceClient serviceClient})
      : _serviceClient = serviceClient,
        super(const UsersInitial());

  late AuthResponse hasToken;
  final ServiceClient _serviceClient;

  Future<void> postRegister(String name, String email, String password) async {
    UserResponse registerUser =
        UserResponse(name: name, email: email, password: password);
    emit(const UsersLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final token = storage.getItem('token');
      await _serviceClient.postRegister(registerUser, token);
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
      hasToken = await _serviceClient.postLogin(loginUser);
      storage.setItem('token', hasToken.token);
      // storage.setItem('role', hasToken.role);

      print(hasToken);
      emit(const UsersSuccess());
    } on Exception {
      emit(const UsersFailure());
    }
  }

  Future<void> getUsers() async {
    emit(const UsersLoading());
    try {
      final token = storage.getItem('token');
      final userResponse = await _serviceClient.getUsers(token);
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
    await Future.delayed(const Duration(seconds: 1));
    try {
      final token = storage.getItem('token');
      editUser = await _serviceClient.updateUser(editUser, token);
      emit(const UsersSuccess());
    } on Exception {
      emit(const UsersFailure());
    }
  }

  Future<void> deleteUser(id) async {
    emit(const UsersLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      final token = storage.getItem('token');
      await _serviceClient.deleteUser(id, token);
      getUsers();
    } on Exception {
      emit(const UsersFailure());
    }
  }
}
