import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({Key? key}) : super(key: key);

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white54,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
                width: 200,
                child: Card(
                  color: Colors.greenAccent,
                  child: Center(
                    child: Text(
                      'Import MZ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(45),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      focusColor: Colors.red.shade200,
                      hintText: 'Link:',
                      hintStyle: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 30),
                        fontSize: 20,
                        color: Colors.black26,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        
                      ),
                      
                    ),
                  ),
                ),
              ),
               SizedBox(
                height: 50,
                width: 130,
                child: InkWell(
                  
                  child: const Card(
                    color: Colors.greenAccent,
                    child: Center(
                      child: Text(
                        'Calcular',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  onTap: (){},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
