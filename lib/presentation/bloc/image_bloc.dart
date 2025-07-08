import 'dart:async';
import 'package:dog_gallery_app/domain/usecases/get_random_image.dart';
import 'package:dog_gallery_app/presentation/bloc/image_event.dart';
import 'package:dog_gallery_app/presentation/bloc/image_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final GetRandomImage getRandomImage;

  final eventController = StreamController<ImageEvent>();
  final stateController = StreamController<ImageState>();

  ImageBloc(this.getRandomImage) : super(ImageInitial()) {
    on<ReloadImageEvent>((event, emit) async {
      try {
        final currentImages = state is ImageLoaded ? (state as ImageLoaded).imageUrls : [];
        if (currentImages.isEmpty) {
          emit(ImageLoading());
        }
        final imageResponse = await getRandomImage();
        if (imageResponse.status == 'success' && imageResponse.message != null) {
          emit(ImageLoaded([...currentImages, imageResponse.message!]));
        } else {
          emit(ImageError('Failed to fetch dog image'));
        }
      } catch (ex) {
        emit(ImageError(ex.toString()));
      }
    });
  }
}
