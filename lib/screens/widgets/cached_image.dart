import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;

  const CachedImage({Key? key, required this.imageUrl}) : super(key: key);

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      margin: const EdgeInsets.only(left: 5, top: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => _imageWidget(imageProvider),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
    );
    // errorWidget: (context, url, error) =>
    //     _imageWidget(const AssetImage('assets/images/placeholder.png')));
  }
}
