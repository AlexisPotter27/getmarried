import 'dart:async';

import 'package:dio/dio.dart';
import 'package:getmarried/helper/storage_helper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


import '../constants/storage_keys.dart';


class HttpHelper {
  static Dio? _client;


  static Future<Map<String, String>> _getHeaders({String? contentType}) async {
    final storageToken = await StorageHelper.getString(StorageKeys.user);
    Map<String, String> headers = {};
    headers['Access-Control-Allow-Origin'] = '*';
    headers['Accept'] = 'application/json';
    headers['Content-Type'] = contentType ?? 'application/json';
    if (storageToken != null) headers['Authorization'] = 'Bearer $storageToken';

    return headers;
  }

  static Future<Dio> _getInstance(
      {bool enabledDioLogger = false, String? contentType}) async {
    _client ??= Dio();
    _client!.options.headers = await _getHeaders(contentType: contentType);

    if (enabledDioLogger) {
      _client?.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 400,
        ),
      );
    }
    return _client!;
  }

  Future<Response> get(String url, {Options? options}) async {
    final instance = await (_getInstance(enabledDioLogger: false));
    return instance.get(url, options: options);
  }

  Future<Response> download(String url, String savePath,
      {ProgressCallback? progressCallback}) async {
    final instance = await _getInstance();
    return instance.download(url, savePath,
        onReceiveProgress: progressCallback);
  }

  Future<Response> post(String url,
      {dynamic body,
      Options? options,
      ProgressCallback? progressCallback,
      String? contentType}) async {
    final instance =
        await (_getInstance(contentType: contentType, enabledDioLogger: true));
    return instance.post(url,
        data: body, onSendProgress: progressCallback, options: options);
  }

  Future<Response> put(String url, {dynamic body}) async {
    final instance = await (_getInstance());
    return instance.put(url, data: body);
  }

  Future<Response> patch(String url, {dynamic body}) async {
    final instance = await (_getInstance());
    return instance.patch(url, data: body);
  }

  Future<Response> delete(String url, {dynamic body}) async {
    final instance = await (_getInstance());
    return instance.delete(url);
  }

// Future<String?> downloadWithIndicator(String url,
//     {required String savePath, required String fileName}) async {
//   print('SAVE PATH -------------------------$savePath');
//   print('DOWNLOAD URL -------------------------$url');
//   FlutterDownloader.registerCallback(DownloadUtil.downloadCallback);
//   return await FlutterDownloader.enqueue(
//     url: url,
//     savedDir: savePath,
//     fileName: fileName,
//     headers: await _getHeaders(),
//     showNotification: true,
//     openFileFromNotification: true,
//     //saveInPublicStorage: true
//   );
// }
}
