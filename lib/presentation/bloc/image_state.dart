abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  ImageLoaded(this.imageUrls);

  final List<String> imageUrls;
}

class ImageError extends ImageState {
  ImageError(this.message);

  final String message;
}