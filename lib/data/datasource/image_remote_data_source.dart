import 'package:dio/dio.dart';
import 'package:dog_gallery_app/domain/entities/response_model.dart';
import 'package:dog_gallery_app/domain/repositories/api_path.dart';

class ImageRemoteDataSource {
  var dio = Dio();

  Future<ResponseModel> getRandomImage() async {
    try {
      Response response = await dio.get(
          ApiPath.randomImage.getUrl(),
          options: Options(headers: { 'Content-Type': 'application/json' }));
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load dog image');
      }
    } catch (error, _) {
      return ResponseModel.withError("$error");
    }
  }
}