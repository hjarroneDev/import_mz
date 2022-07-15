import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:import_mz/Paginas/Home/resumo.dart';
import 'widget/menu/menu.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({Key? key}) : super(key: key);

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    setRotation(90);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void setRotation(int degrees) {
    final angle = degrees * pi / 180;
    animation = Tween<double>(begin: 0, end: angle).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final screamSizeWidth = MediaQuery.of(context).size.width;

    bool visivel = false;
    bool visivelLogo = true;
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
            child: StatefulBuilder(builder: (context, setState) {
              return Column(
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
                      : GestureDetector(
                          onTap: () {
                            if (visivel == false) {
                              return;
                            } else {
                              setState(() {
                                visivel = false;
                              });
                              controller.reverse(from: 90);
                            }
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus &&
                                currentFocus.focusedChild != null) {
                              currentFocus.focusedChild?.unfocus();
                            }
                          },
                          child: Row(
                            children: [
                              Visibility(
                                visible: visivelLogo,
                                child: Padding(
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
                                            decoration:
                                                TextDecoration.underline,
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
                                        padding:
                                            const EdgeInsets.only(right: 1),
                                        child: Icon(
                                          Icons.directions_car,
                                          size: 30,
                                          color: Colors.teal.shade200,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Visibility(
                                visible: visivel,
                                child: const SizedBox(
                                  height: 50,
                                  child: Menu(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      color: const Color.fromARGB(
                                              255, 176, 209, 206)
                                          .withOpacity(0.3),
                                    ),
                                    child: AnimatedBuilder(
                                      animation: animation,
                                      child: Icon(
                                        Icons.menu_open_rounded,
                                        color: Colors.teal.shade300,
                                        size: 40,
                                      ),
                                      builder: (context, child) =>
                                          Transform.rotate(
                                        angle: animation.value,
                                        child: child,
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    setState(() {
                                      visivel = !visivel;
                                      if (screamSizeWidth < 410 &&
                                          visivelLogo == true) {
                                        visivelLogo = false;
                                      } else if (screamSizeWidth < 410 &&
                                          visivelLogo == false) {
                                        visivelLogo = true;
                                      }
                                    });

                                    if (visivel == false) {
                                      controller.reverse(from: 90);
                                    } else {
                                      controller.forward(from: 0);
                                    }
                                    await Future.delayed(
                                        const Duration(seconds: 5), () {
                                      if (visivel == false) {
                                        return;
                                      } else {
                                        setState(() {
                                          visivel = false;
                                        });
                                        controller.reverse(from: 90);
                                        visivelLogo = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                  GestureDetector(
                    onTap: () {
                      if (visivel == false) {
                        return;
                      } else {
                        setState(() {
                          visivel = false;
                        });
                        controller.reverse(from: 90);
                      }
                    },
                    child: const SizedBox(
                      height: 10,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (visivel == false) {
                        return;
                      } else {
                        setState(() {
                          visivel = false;
                        });
                        controller.reverse(from: 90);
                      }
                    },
                    child: const Resumo(),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
