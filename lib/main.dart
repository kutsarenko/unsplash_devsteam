import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(UnsplashGallery());
}

class UnsplashGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     theme: ThemeData(primarySwatch: Colors.lightBlue),

      home: GalleryPage(),
    );
  }
}
