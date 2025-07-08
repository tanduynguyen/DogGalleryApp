import 'dart:async';

import 'package:dog_gallery_app/bloc/image_bloc.dart';
import 'package:dog_gallery_app/bloc/image_event.dart';
import 'package:dog_gallery_app/bloc/image_state.dart';
import 'package:dog_gallery_app/modules/image_fullscreen.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: const MyHomePage(title: 'Dog Gallery App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = ImageBloc();
  final String placeholder = 'assets/images/imagePlaceholder16x9.png';
  final scrollController = ScrollController();
  static const double spacing = 4;
  static const int crossAxisCount = 4;

  @override
  initState() {
    super.initState();

    reloadRandomImage();
  }

  void reloadRandomImage() {
    bloc.eventController.sink.add(ReloadImageEvent());
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
        child: StreamBuilder<ImageState>(
          stream: bloc.stateController.stream,
          initialData: bloc.state,
          builder: (BuildContext context, AsyncSnapshot<ImageState> snapshot) {
            final data = snapshot.data;
            if (snapshot.hasError || data == null) {
              return SizedBox();
            }
            return imageListView(data.imageUrls);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reloadRandomImage,
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
        )
    );
  }
}
