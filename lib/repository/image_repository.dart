import 'package:dio/dio.dart';
import 'package:dog_gallery_app/models/response_model.dart';
import 'package:dog_gallery_app/repository/app_repository.dart';

class ImageRepository extends AppRepository {

  Future<ResponseModel> getRandomImage() async {
    try {
      Response response = await dio.get(
          ApiPath.randomImage.getUrl(),
          options: Options(headers: await headers()));
      return ResponseModel.fromJson(response.data);
    } catch (error, stacktrace) {
      displayError(error, stacktrace);
      return ResponseModel.withError("$error");
    }
  }
}