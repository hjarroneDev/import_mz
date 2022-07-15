import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String imageLink;
  final double width;
  final double height;
  const ImageView({Key? key, required this.imageLink, required this.width, required this.height}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              image: NetworkImage(
                'https:${widget.imageLink}',
              ),
              fit: BoxFit.cover,
              scale: 5),
        ),
      ),
    );
  }
}
