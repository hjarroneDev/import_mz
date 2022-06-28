import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custos.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({Key? key}) : super(key: key);

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/defult.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Row(
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
                      ],
                    ),
                  ],
                ),
              ),
              
              const Custos(),
            ],
          ),
        ),
      ),
    );
  }
}
