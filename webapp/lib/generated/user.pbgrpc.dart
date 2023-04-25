///
//  Generated code. Do not modify.
//  source: user.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user.pb.dart' as $1;
export 'user.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$create =
      $grpc.ClientMethod<$1.CreateUserResquest, $1.UserResponse>(
          '/user.UserService/Create',
          ($1.CreateUserResquest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.UserResponse.fromBuffer(value));
  static final _$update =
      $grpc.ClientMethod<$1.UpdateUserResponse, $1.UserResponse>(
          '/user.UserService/Update',
          ($1.UpdateUserResponse value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.UserResponse.fromBuffer(value));
  static final _$showAll = $grpc.ClientMethod<$1.Empty, $1.UsersResponse>(
      '/user.UserService/ShowAll',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.UsersResponse.fromBuffer(value));
  static final _$showOne = $grpc.ClientMethod<$1.IdRequest, $1.UserResponse>(
      '/user.UserService/ShowOne',
      ($1.IdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.UserResponse.fromBuffer(value));
  static final _$delete = $grpc.ClientMethod<$1.IdRequest, $1.Empty>(
      '/user.UserService/Delete',
      ($1.IdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.UserResponse> create($1.CreateUserResquest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$create, request, options: options);
  }

  $grpc.ResponseFuture<$1.UserResponse> update($1.UpdateUserResponse request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$update, request, options: options);
  }

  $grpc.ResponseFuture<$1.UsersResponse> showAll($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$showAll, request, options: options);
  }

  $grpc.ResponseFuture<$1.UserResponse> showOne($1.IdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$showOne, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> delete($1.IdRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$delete, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'user.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.CreateUserResquest, $1.UserResponse>(
        'Create',
        create_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.CreateUserResquest.fromBuffer(value),
        ($1.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateUserResponse, $1.UserResponse>(
        'Update',
        update_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateUserResponse.fromBuffer(value),
        ($1.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $1.UsersResponse>(
        'ShowAll',
        showAll_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($1.UsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.IdRequest, $1.UserResponse>(
        'ShowOne',
        showOne_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.IdRequest.fromBuffer(value),
        ($1.UserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.IdRequest, $1.Empty>(
        'Delete',
        delete_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.IdRequest.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.UserResponse> create_Pre($grpc.ServiceCall call,
      $async.Future<$1.CreateUserResquest> request) async {
    return create(call, await request);
  }

  $async.Future<$1.UserResponse> update_Pre($grpc.ServiceCall call,
      $async.Future<$1.UpdateUserResponse> request) async {
    return update(call, await request);
  }

  $async.Future<$1.UsersResponse> showAll_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return showAll(call, await request);
  }

  $async.Future<$1.UserResponse> showOne_Pre(
      $grpc.ServiceCall call, $async.Future<$1.IdRequest> request) async {
    return showOne(call, await request);
  }

  $async.Future<$1.Empty> delete_Pre(
      $grpc.ServiceCall call, $async.Future<$1.IdRequest> request) async {
    return delete(call, await request);
  }

  $async.Future<$1.UserResponse> create(
      $grpc.ServiceCall call, $1.CreateUserResquest request);
  $async.Future<$1.UserResponse> update(
      $grpc.ServiceCall call, $1.UpdateUserResponse request);
  $async.Future<$1.UsersResponse> showAll(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Future<$1.UserResponse> showOne(
      $grpc.ServiceCall call, $1.IdRequest request);
  $async.Future<$1.Empty> delete($grpc.ServiceCall call, $1.IdRequest request);
}
