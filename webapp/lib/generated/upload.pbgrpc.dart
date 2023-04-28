///
//  Generated code. Do not modify.
//  source: upload.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'upload.pb.dart' as $1;
export 'upload.pb.dart';

class UploadServiceClient extends $grpc.Client {
  static final _$upload =
      $grpc.ClientMethod<$1.UploadRequest, $1.UploadResponse>(
          '/upload.UploadService/Upload',
          ($1.UploadRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.UploadResponse.fromBuffer(value));

  UploadServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.UploadResponse> upload($1.UploadRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$upload, request, options: options);
  }
}

abstract class UploadServiceBase extends $grpc.Service {
  $core.String get $name => 'upload.UploadService';

  UploadServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.UploadRequest, $1.UploadResponse>(
        'Upload',
        upload_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UploadRequest.fromBuffer(value),
        ($1.UploadResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.UploadResponse> upload_Pre(
      $grpc.ServiceCall call, $async.Future<$1.UploadRequest> request) async {
    return upload(call, await request);
  }

  $async.Future<$1.UploadResponse> upload(
      $grpc.ServiceCall call, $1.UploadRequest request);
}
