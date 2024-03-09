import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unsplash_image/widgets/image_overlay.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String fullImagePath;
  const ImageCard(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.fullImagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showImageOverlay(
          context,
          imagePath,
          title,
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Flexible(
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('$title'),
            ],
          ),
        ),
      ),
    );
  }
}
