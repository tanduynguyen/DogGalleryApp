import 'package:dog_gallery_app/domain/entities/response_model.dart';
import 'package:dog_gallery_app/domain/repositories/image_repository.dart';

class GetRandomImage {
  final ImageRepository repository;

  GetRandomImage(this.repository);

  Future<ResponseModel> call() {
    return repository.getRandomImage();
  }
}