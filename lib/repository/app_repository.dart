import 'package:dio/dio.dart';
import 'dart:developer' as developer;

enum ApiPath {
  randomImage;

  static String mainUrl = "https://dog.ceo";

  String getUrl() {
    var url = '$mainUrl/api/breeds';
    switch (this) {
      case ApiPath.randomImage:
        return '$url/image/random';
    }
  }
}

class AppRepository {
  var dio = Dio();

  Future<Map<String, dynamic>?> headers() async {
    return { 'Content-Type': 'application/json' };
  }

  void displayError(Object error, StackTrace stacktrace) {
    developer.log("Exception occurred: $error stackTrace: $stacktrace");
  }

}