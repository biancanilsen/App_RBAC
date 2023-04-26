import 'package:grpc/grpc.dart';
import '../../../generated/auth.pbgrpc.dart';
import '../../../generated/auth.pbenum.dart';
import '../../../generated/auth.pb.dart';
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
    authStub = AuthServiceClient(client);
  }

  UserServiceClient? stub;
  AuthServiceClient? authStub;

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

  Future<AuthResponse> postLogin(AuthRequest model) async {
    try {
      if (authStub == null) {
        Init();
        if (authStub == null) {
          throw Exception('Failed to initialize authStub');
        }
      }
      final request;

      request = AuthRequest(
        email: model.email,
        password: model.password,
      );

      final response = await authStub?.login(request);

      print(response);
      return response!;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting users: $e');
    }
  }
}

class MyRequest {}

class MyResponse {}
