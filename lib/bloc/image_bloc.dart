import 'dart:async';
import 'package:dog_gallery_app/bloc/image_event.dart';
import 'package:dog_gallery_app/bloc/image_state.dart';
import 'package:dog_gallery_app/repository/image_repository.dart';

class ImageBloc {
  final _imageRepository = ImageRepository();
  var state = ImageState([]);

  final eventController = StreamController<ImageEvent>();
  final stateController = StreamController<ImageState>();

  ImageBloc() {
    eventController.stream.listen((ImageEvent event) {
      if (event is ReloadImageEvent) {
        getRandomImage();
      }
    });

    stateController.sink.add(state);
  }

  void dispose() {
    stateController.close();
    eventController.close();
  }

  void getRandomImage()  {
    stateController.sink.add(state);

    _imageRepository.getRandomImage()
    .then((imageResponse) {
      if (imageResponse.status == 'success' && imageResponse.message != null) {
        state = ImageState([...state.imageUrls, imageResponse.message!]);
        stateController.sink.add(state);
      }
    });
  }
}
