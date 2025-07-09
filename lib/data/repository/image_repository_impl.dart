import 'package:dog_gallery_app/data/datasource/image_remote_data_source.dart';
import 'package:dog_gallery_app/domain/entities/response_model.dart';
import 'package:dog_gallery_app/domain/repositories/image_repository.dart';

class ImageRepositoryImpl implements ImageRepository {
  ImageRepositoryImpl(this.imageRemoteDataSource);

  final ImageRemoteDataSource imageRemoteDataSource;

  @override
  Future<ResponseModel> getRandomImage() {
    return imageRemoteDataSource.getRandomImage();
  }
}