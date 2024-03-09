import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  final String imagePath;
  final String title;
  const FullScreenImage(
      {super.key, required this.imagePath, required this.title});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: widget.imagePath,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
