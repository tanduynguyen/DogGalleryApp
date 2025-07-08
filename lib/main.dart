import 'package:dog_gallery_app/presentation/bloc/image_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dog_gallery_app/presentation/pages/image_gallery_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasource/image_remote_data_source.dart';
import 'domain/entities/response_model.dart';
import 'domain/repositories/image_repository.dart';
import 'domain/usecases/get_random_image.dart';

void main() {
  runApp(const MyApp());
}

class ImageRepositoryImpl implements ImageRepository {
  ImageRepositoryImpl(this.imageRemoteDataSource);

  final ImageRemoteDataSource imageRemoteDataSource;

  @override
  Future<ResponseModel> getRandomImage() {
    return imageRemoteDataSource.getRandomImage();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dataSource = ImageRemoteDataSource();
    final repository = ImageRepositoryImpl(dataSource);
    final useCase = GetRandomImage(repository);

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: BlocProvider(
        create: (_) => ImageBloc(useCase),
        child: ImageGalleryPage(title: 'Dog Gallery App')
      )
    );
  }
}
