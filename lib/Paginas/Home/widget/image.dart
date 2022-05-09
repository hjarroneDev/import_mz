import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  final String imageLink;
  const ImageView({Key? key, required this.imageLink}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        alignment: Alignment.center,
        child: Container(
          width: 460.0,
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            image: DecorationImage(
              image: NetworkImage(
                'https:${widget.imageLink}',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
