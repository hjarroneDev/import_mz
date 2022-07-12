import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custos.dart';
import 'widget/menu/menu.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({Key? key}) : super(key: key);

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screamSizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/defult.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (screamSizeWidth > 600)
                    ? Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Import",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 23,
                                      color: Colors.teal.shade200,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Moz",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                      fontSize: 28,
                                      color: Colors.yellow.shade800,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 1),
                                  child: Icon(
                                    Icons.directions_car,
                                    size: 30,
                                    color: Colors.teal.shade200,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const Menu(),
                        ],
                      )
                    : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Import",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      fontSize: 23,
                                      color: Colors.teal.shade200,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Moz",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                      fontSize: 28,
                                      color: Colors.yellow.shade800,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 1),
                                  child: Icon(
                                    Icons.directions_car,
                                    size: 30,
                                    color: Colors.teal.shade200,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                  color: const Color.fromARGB(255, 176, 209, 206).withOpacity(0.2),
                                ),
                                child:  Center(
                                  child: Icon(
                                    Icons.menu,
                                    size: 35,
                                    color: Colors.teal.shade300,
                                  ),
                                ),
                              ),
                              onTap: (){

                                
                              },
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),
                const Custos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
