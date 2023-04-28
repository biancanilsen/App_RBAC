import 'dart:io';
import 'package:protobuf/protobuf.dart';
import 'package:grpc/grpc.dart';
import '../../../generated/auth.pbgrpc.dart';
import '../../../generated/auth.pbenum.dart';
import '../../../generated/auth.pb.dart';
import '../../../generated/user.pb.dart';
import '../../../generated/user.pbgrpc.dart';
import '../../../generated/user.pbenum.dart';
import '../data/models/user_model.dart';
import 'package:http2/http2.dart' as http2;

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

  Future<UsersResponse> getUsers(String token) async {
    try {
      if (stub == null) {
        Init();
        if (stub == null) {
          throw Exception('Failed to initialize authStub');
        }
      }
      final headers = {'Authorization': '$token'};
      // final metadata = Metadata.fromMap(headers);
      final request = Empty();
      final response =
          await stub?.showAll(request, options: CallOptions(metadata: headers));

      // final response = await stub?.showAll(request);
      return response!;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting guests: $e');
    }
  }

  // Future getConfig() async {
  //   final uri = Uri.parse('https://172.16.8.73:3000');
  //   final socket = await SecureSocket.connect(uri.host, uri.port);
  //   final transport = await http2.ClientTransportConnection.viaSocket(
  //     socket,
  //     settings: http2.ClientSettings(),
  //   );
  //   final headers = <String, Object>{
  //     HttpHeaders.authorizationHeader: 'Bearer $accessToken',
  //   };
  //   final stream = transport.makeRequest(
  //     headers as List<http2.Header>,
  //     endStream: true,
  //   );
  // }

  // Future<UsersResponse> getUsers() async {
  //   try {
  //     final uri = Uri.parse('https://example.com/path');
  //     final socket = await SecureSocket.connect(uri.host, uri.port);
  //     final transport = await http2.ClientTransportConnection.viaSocket(
  //       socket,
  //       settings: http2.ClientSettings(),
  //     );
  //     final headers = <String, Object>{
  //       HttpHeaders.authorizationHeader: 'Bearer $accessToken',
  //     };
  //     final stream = transport.makeRequest(
  //       headers as List<http2.Header>,
  //       endStream: true,
  //     );
  //     await stream.outgoingMessages.close();
  //     final response = await stream.incomingMessages.first;
  //     final responseHeaders = response.headers;
  //     final responseStream = response.expand((m) => m);
  //     final responseBody = await utf8.decodeStream(responseStream);
  //     print(
  //         'Response status: ${responseHeaders.value(HttpHeaders.statusHeader)}');
  //     print('Response body: $responseBody');
  //     return UsersResponse.fromJson(json.decode(responseBody));
  //   } catch (e) {
  //     print('Caught error: $e');
  //     throw Exception('Error getting guests: $e');
  //   }
  // }

  Future<UserResponse> updateUser(UserResponse model) async {
    try {
      if (stub == null) {
        Init();
        if (stub == null) {
          throw Exception('Failed to initialize authStub');
        }
      }
      final request;

      request = UpdateUserResponse(
        id: model.id,
        name: model.name,
        email: model.email,
        password: model.password,
      );
      final response = await stub?.update(request);
      return response!;
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting guests: $e');
    }
  }

  Future<Empty> deleteUser(String id) async {
    try {
      if (stub == null) {
        throw Exception('Stub has not been initialized');
      }
      final request = IdRequest(
        id: id,
      );
      final response = await stub?.delete(request);
      return Empty();
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Error getting guests: $e');
    }
  }
}

class MyRequest {}

class MyResponse {}
