// ignore_for_file: empty_catches

import 'package:dio/dio.dart';

class API {
  final Dio dio = Dio();
  final String baseUrl = "https://key1.tech/api";

  login({required String username, required String password}) async {
    try {
      final String endpoint = "$baseUrl/login";

      final params = {"email": username, "password": password};
      final response = await dio.post(endpoint, data: FormData.fromMap(params));

      return response.data;
    } catch (e) {
      return e;
    }
  }

  register(
      {required String email,
      required String password,
      required String name,
      required int programid}) async {
    try {
      final String endpoint = "$baseUrl/register";

      final params = {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
        "programid": programid
      };
      final response = await dio.post(endpoint, data: FormData.fromMap(params));

      return response.data;
    } catch (e) {}
  }
}
