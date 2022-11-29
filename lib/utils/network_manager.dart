import 'package:dio/dio.dart';

class NetworkManager {
  late Dio _dio;

  String baseUrl = "https://getjadwal.api.devcode.gethired.id";

  NetworkManager() {
    _dio = Dio();
  }

  Future<Map<String, dynamic>> chekin(String email) async {
    var response = await _dio.post(
      "$baseUrl/checkin",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      data: {
        "email": email,
      },
    );
    Map? obj;
    if (response.statusCode == 200) {
      obj = response.data;
    } else if (response.statusCode == 400) {
      obj = response.data;
    }
    return obj as Map<String, dynamic>;
  }

  Future<void> getJadwal(String email) async {
    var response = await _dio.get(
      "$baseUrl/schedule?email=$email",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    Map obj = response.data;
    return obj['data'];
  }

  Future<void> getDetailJadwal(
      {required String email, required String day}) async {
    var response = await _dio.get(
      "$baseUrl/schedule?email=$email&day=$day",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    Map obj = response.data;
    return obj['data'];
  }

  Future<void> addSchedule(
      String email, String title, String daySelected) async {
    var response = await _dio.post(
      "$baseUrl/schedule?email=$email",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      data: {"title": title, "day": daySelected},
    );
    Map? obj = response.data;
  }

  Future<void> updateSchedule(
      {required String email, required String title, required int id}) async {
    var response = await _dio.patch(
      "$baseUrl/schedule?email=$email&id=$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      data: {
        "title": title,
      },
    );
    Map obj = response.data;
    print(obj);
  }

  Future<void> deleteSchedule(String email, String id) async {
    var response = await Dio().delete(
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      "$baseUrl/schedule?email=$email&id=$id",
    );
    // print(response.statusCode);
  }
}
