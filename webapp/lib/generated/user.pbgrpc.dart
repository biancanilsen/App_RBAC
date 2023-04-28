///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $2;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$create =
      $grpc.ClientMethod<$2.CreateUserResquest, $2.UserResponse>(
          '/user.UserService/Create',
          ($2.CreateUserResquest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UserResponse.fromBuffer(value));
  static final _$update =
      $grpc.ClientMethod<$2.UpdateUserResponse, $2.UserResponse>(
          '/user.UserService/Update',
          ($2.UpdateUserResponse value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $2.UserResponse.fromBuffer(value));
  static final _$showAll = $grpc.ClientMethod<$2.Empty, $2.UsersResponse>(
      '/user.UserService/ShowAll',
      ($2.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UsersResponse.fromBuffer(value));
  static final _$showOne = $grpc.ClientMethod<$2.IdRequest, $2.UserResponse>(
      '/user.UserService/ShowOne',
      ($2.IdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.UserResponse.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$2.IdRequest, $2.Empty>(
      '/user.UserService/Delete',
      ($2.IdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.Empty.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$2.UserResponse> create($2.CreateUserResquest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$2.UserResponse> update($2.UpdateUserResponse request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$2.UsersResponse> showAll($2.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$showAll, request, options: options);
  }

  $grpc.ResponseFuture<$2.UserResponse> showOne($2.IdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$showOne, request, options: options);
  }

  $grpc.ResponseFuture<$2.Empty> delete($2.IdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'user.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.CreateUserResquest, $2.UserResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.CreateUserResquest.fromBuffer(value),
        ($2.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.UpdateUserResponse, $2.UserResponse>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $2.UpdateUserResponse.fromBuffer(value),
        ($2.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Empty, $2.UsersResponse>(
        'ShowAll',
        showAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Empty.fromBuffer(value),
        ($2.UsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IdRequest, $2.UserResponse>(
        'ShowOne',
        showOne_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.IdRequest.fromBuffer(value),
        ($2.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.IdRequest, $2.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.IdRequest.fromBuffer(value),
        ($2.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$2.UserResponse> create_Pre($grpc.ServiceCall call,
      $async.Future<$2.CreateUserResquest> request) async {
    return create(call, await request);
  }

  $async.Future<$2.UserResponse> update_Pre($grpc.ServiceCall call,
      $async.Future<$2.UpdateUserResponse> request) async {
    return update(call, await request);
  }

  $async.Future<$2.UsersResponse> showAll_Pre(
      $grpc.ServiceCall call, $async.Future<$2.Empty> request) async {
    return showAll(call, await request);
  }

  $async.Future<$2.UserResponse> showOne_Pre(
      $grpc.ServiceCall call, $async.Future<$2.IdRequest> request) async {
    return showOne(call, await request);
  }

  $async.Future<$2.Empty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$2.IdRequest> request) async {
    return delete(call, await request);
  }

  $async.Future<$2.UserResponse> create(
      $grpc.ServiceCall call, $2.CreateUserResquest request);
  $async.Future<$2.UserResponse> update(
      $grpc.ServiceCall call, $2.UpdateUserResponse request);
  $async.Future<$2.UsersResponse> showAll(
      $grpc.ServiceCall call, $2.Empty request);
  $async.Future<$2.UserResponse> showOne(
      $grpc.ServiceCall call, $2.IdRequest request);
  $async.Future<$2.Empty> delete($grpc.ServiceCall call, $2.IdRequest request);
}
