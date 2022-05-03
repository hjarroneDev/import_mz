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
                                  fontSize: 20,
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
                                  fontSize: 25,
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
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 5, bottom: 20),
                child: SizedBox(
                  child: TextField(
                    minLines: 1,
                    maxLines: 3,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent.shade100,
                      ),
                    ),
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Cole o Link ou Referencia',
                      hintStyle: GoogleFonts.roboto(color: Colors.black26),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal.shade200,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade300,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Calcular'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
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
