import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  final String titulo;
  final VoidCallback onPress;
  const MenuItems({Key? key, required this.titulo, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: TextButton.styleFrom(
        primary: Colors.black38,
        textStyle: const TextStyle(
          fontSize: 16,
          //fontWeight: FontWeight.bold
        ),
      ),
      child: Text(
        titulo.toUpperCase(),
      ),
    );
  }
}