import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AppPhotoViewer extends StatelessWidget {
  const AppPhotoViewer({
    super.key,
    required this.photos,
    this.initialIndex = 0,
  });
  final List<File> photos;
  final int initialIndex;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text('${initialIndex + 1} de ${photos.length}'),
        ),
        body: Container(
          color: Colors.black,
          child: PhotoViewGallery.builder(
            itemCount: photos.length,
            builder: (context, index) => PhotoViewGalleryPageOptions(
              imageProvider: FileImage(photos[index]),
              heroAttributes: PhotoViewHeroAttributes(tag: photos[index].path),
            ),
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            pageController: PageController(initialPage: initialIndex),
          ),
        ),
      );
}
