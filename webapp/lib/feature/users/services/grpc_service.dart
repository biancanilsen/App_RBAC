import 'package:grpc/grpc.dart';

import '../../../generated/user.pb.dart';
import '../../../generated/user.pbgrpc.dart';
import '../../../generated/user.pbenum.dart';
import '../data/models/user_model.dart';

class ServiceClient {
  late ClientChannel client;
  static final ServiceClient _singleton = new ServiceClient._internal();
  factory ServiceClient() => _singleton;
  ServiceClient._internal();
  static final instance = ServiceClient._init();

  ServiceClient._init() {
    Init();
  }

  Init() {
    client = ClientChannel(
      '172.16.8.73',
      port: 3000,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    stub = UserServiceClient(client);
  }

  UserServiceClient? stub;

  Future<UsersResponse> getUsers() async {
    try {
      if (stub == null) {
        throw Exception('Stub has not been initialized');
      }
      final request = Empty();
      final response = await stub?.index(request);
      return response!;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting users: $e');
    }
  }

  Future<void> dispose() async {
    await client.shutdown();
  }

  Future<UserResponse> postRegister(UserResponse model) async {
    try {
      if (stub == null) {
        Init();
        if (stub == null) {
          throw Exception('Failed to initialize stub');
        }
      }
      final request;

      request = CreateUserResquest(
        name: model.name,
        email: model.email,
        password: model.password,
      );

      final response = await stub?.create(request);

      return response!;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting users: $e');
    }
  }
}

class MyRequest {}

class MyResponse {}
