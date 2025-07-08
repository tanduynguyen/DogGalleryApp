import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dog_gallery_app/presentation/bloc/image_bloc.dart';
import 'package:dog_gallery_app/presentation/bloc/image_event.dart';
import 'package:dog_gallery_app/presentation/bloc/image_state.dart';
import 'package:flutter/material.dart';
import 'package:dog_gallery_app/presentation/pages/image_fullscreen_page.dart';

class ImageGalleryPage extends StatefulWidget {
  const ImageGalleryPage({super.key, required this.title});

  final String title;

  @override
  State<ImageGalleryPage> createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageGalleryPage> {
  final String placeholder = 'assets/images/imagePlaceholder16x9.png';
  final scrollController = ScrollController();
  static const double spacing = 4;
  static const int crossAxisCount = 4;

  void reloadRandomImage(BuildContext context) {
    context.read<ImageBloc>().add(ReloadImageEvent());
    Timer(Duration(milliseconds: 500), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocBuilder<ImageBloc, ImageState>(
          builder: (context, state) {
            if (state is ImageLoading && state is! ImageLoaded) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is ImageLoaded) {
              return imageListView(state.imageUrls);
            }
            if (state is ImageError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('Press the adding button to start!', style: Theme.of(context).textTheme.headlineSmall));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => reloadRandomImage(context),
        tooltip: 'Reload Random Image',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget imageListView(List<String> imageUrls) {
    return SafeArea(
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(spacing),
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        controller: scrollController,
        children: imageUrls.map(imageWidget).toList(),
      ),
    );
  }

  Widget imageWidget(String url) {
    return ImageFullScreenWrapperWidget(
      child: FadeInImage.assetNetwork(
        placeholder: placeholder,
        image: url,
        fit: BoxFit.cover,
      ),
    );
  }
}
