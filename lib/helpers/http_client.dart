import 'package:dio/dio.dart';
import 'package:shell/constants/http_client_request_types.dart';

class AppHttpClient {
  String baseUrl = "https://64e73b47b0fd9648b78f95d7.mockapi.io";
  static final AppHttpClient _AppHttpClient = AppHttpClient._internal();
  final dio = Dio();

  factory AppHttpClient() {
    return _AppHttpClient;
  }

  AppHttpClient._internal();

  Future<Response<dynamic>?> call({required AppHttpClientRequestType type, dynamic data, required String url}) async {
    if (type == AppHttpClientRequestType.get) return await dio.get(baseUrl + url, queryParameters: data);
    if (type == AppHttpClientRequestType.post) return await dio.post(baseUrl + url, data: data);
    return null;
  }
}
