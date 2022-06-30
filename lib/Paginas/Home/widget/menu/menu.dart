import 'package:flutter/material.dart';

import 'widgets/menu_itins.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
              decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              color: Colors.teal.shade200.withOpacity(0.5),
            ),
              child: Row(
                children: [
                  
                  MenuItems(
                    onPress: () {},
                    titulo: 'Comparar',
                  ),
                 const Divider(),
                  
                  MenuItems(
                    onPress: () {},
                    titulo: 'Sobre',
                  ),
                ],
              ),
            ),
    );
  }
}