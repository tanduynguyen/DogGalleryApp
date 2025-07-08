import 'package:dog_gallery_app/domain/entities/response_model.dart';

abstract class ImageRepository {
  Future<ResponseModel> getRandomImage();
}