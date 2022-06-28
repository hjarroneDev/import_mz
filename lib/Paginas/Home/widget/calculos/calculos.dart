import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculosPage extends StatefulWidget {
  final String tipo;
  final String fob;
  final String cif;
  final String motorCc;
  final String combustivel;
  final int assentos;
  final String portas;
  final String ano;
  final String peso;
  final String maxcap;
  final String cambio;

  const CalculosPage({
    Key? key,
    required this.tipo,
    required this.fob,
    required this.cif,
    required this.motorCc,
    required this.combustivel,
    required this.assentos,
    required this.portas,
    required this.ano,
    required this.peso,
    required this.cambio,
    required this.maxcap,
  }) : super(key: key);

  @override
  State<CalculosPage> createState() => _CalculosPageState();
}

class _CalculosPageState extends State<CalculosPage> {
  //*Variaveis
  String? valCIF;
  String? valKudumba;
  String? valMCnet;
  String? valMptCar;
  String? valOrdemEntrega;
  String? valInatter;
  String? valDireitos;
  String? valIce;
  String? valIva;
  String? valTotal;
  String? valTsa;

  @override
  void initState() {
    calInicial();
    super.initState();
  }

  void calInicial() {
    double? calDireito;
    double? calIce;
    double? calIva;
    DateTime dateToday = DateTime.now();
    int currentYear = dateToday.year;
    double? pesoBruto;

    String cap1 = ((widget.maxcap == '-') ? 0 : widget.maxcap).toString();
    String peso1 = ((widget.peso == '-') ? 0 : widget.peso).toString();

    pesoBruto = double.parse(cap1) * 1000 + double.parse(peso1);

    //*Formatador
    final formatarMoeda = NumberFormat("#,##0.00", "en_US");

    //*CIF
    double calCifMetical =
        double.parse(widget.cif) * double.parse(widget.cambio);
    valCIF = formatarMoeda.format(calCifMetical);

    //*Anos
    double calAnoDif = currentYear - double.parse(widget.ano);

//! Condicao 2 (Assentos => 10)
//! <===========================================================================================================================

//*Assentos Maior ou Igaual a 10
    void isIgualeMaior10() {
      if (widget.combustivel == 'Diesel') {

        if (widget.assentos <= 39) {
          calDireito = calCifMetical * 0.05;
          valDireitos = formatarMoeda.format(calDireito);

          //*ICE
          calIce = (calCifMetical + calDireito!) * 0;
          valIce = formatarMoeda.format(calIce);

          //*IVA
          calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
          valIva = formatarMoeda.format(calIva);
        } else {
          
          calDireito = calCifMetical * 0.05;
          valDireitos = formatarMoeda.format(calDireito);

          //*ICE
          calIce = (calCifMetical + calDireito!) * 0;
          valIce = formatarMoeda.format(calIce);

          //*IVA
          calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
          valIva = formatarMoeda.format(calIva);
        }
      } else if (widget.combustivel == 'Gasolina' ||
          widget.combustivel == 'Petrol') {
        calDireito = calCifMetical * 0.05;
        valDireitos = formatarMoeda.format(calDireito);

        //*ICE
        calIce = (calCifMetical + calDireito!) * 0;
        valIce = formatarMoeda.format(calIce);

        //*IVA
        calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
        valIva = formatarMoeda.format(calIva);
      } else if (widget.combustivel == 'Eléctrico') {
        calDireito = calCifMetical * 0.20;
        valDireitos = formatarMoeda.format(calDireito);

        //*ICE
        calIce = (calCifMetical + calDireito!) * 0;
        valIce = formatarMoeda.format(calIce);

        //*IVA
        calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
        valIva = formatarMoeda.format(calIva);
      } else {
        calDireito = calCifMetical * 0.20;
        valDireitos = formatarMoeda.format(calDireito);

        //*ICE
        calIce = (calCifMetical + calDireito!) * 0.30;
        valIce = formatarMoeda.format(calIce);

        //*IVA
        calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
        valIva = formatarMoeda.format(calIva);
      }
    }

//! Condicao 2 (Assentos < 10)
//! <===========================================================================================================================

//*Assentos Menor que 10
    void isMenorque10() {
      //*Transporte de Pessoa
      //*>===========================================================================================================================

      if (widget.tipo == 'Sedan' ||
          widget.tipo == 'Hatchback' ||
          widget.tipo == 'SUV' ||
          widget.tipo == 'Mini Van' ||
          widget.tipo == 'Van' ||
          widget.tipo == 'Wagon' ||
          widget.tipo == 'Coupe' ||
          widget.tipo == 'Convertible' ||
          widget.tipo == 'Mini Bus' ||
          widget.tipo == 'Bus') {
        if (widget.combustivel == 'Gasolina' ||
            widget.combustivel == 'Petrol') {
          if (double.parse(widget.motorCc.replaceAll(',', '')) <= 1000) {
            if (calAnoDif <= 7) {
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0;
              valIce = formatarMoeda.format(calIce);

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            } else {
              //*Direitos
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.05;
              if (calIce! >= 10000) {
                valIce = formatarMoeda.format(calIce);
              } else {
                calIce = 10000;
                valIce = formatarMoeda.format(calIce);
              }

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            }
          } else if (double.parse(widget.motorCc.replaceAll(',', '')) > 1000 ||
              double.parse(widget.motorCc.replaceAll(',', '')) <= 1500) {
            if (calAnoDif <= 7) {
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.05;
              valIce = formatarMoeda.format(calIce);

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            } else {
              //*Direitos
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.10;
              if (calIce! >= 13000) {
                valIce = formatarMoeda.format(calIce);
              } else {
                calIce = 13000;
                valIce = formatarMoeda.format(calIce);
              }

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            }
          } else if (double.parse(widget.motorCc.replaceAll(',', '')) > 1500 ||
              double.parse(widget.motorCc.replaceAll(',', '')) <= 3000) {
            if (calAnoDif <= 7) {
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.25;
              valIce = formatarMoeda.format(calIce);

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            } else {
              //*Direitos
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.30;
              if (calIce! >= 70000) {
                valIce = formatarMoeda.format(calIce);
              } else {
                calIce = 70000;
                valIce = formatarMoeda.format(calIce);
              }

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            }
          } else {
            if (calAnoDif <= 7) {
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.25;
              valIce = formatarMoeda.format(calIce);

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            } else {
              //*Direitos
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.30;
              if (calIce! >= 140000) {
                valIce = formatarMoeda.format(calIce);
              } else {
                calIce = 140000;
                valIce = formatarMoeda.format(calIce);
              }

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            }
          }
        } else if (widget.combustivel == 'Diesel') {
          if (double.parse(widget.motorCc.replaceAll(',', '')) <= 1500) {
            //*Direitos
            calDireito = calCifMetical * 0.20;
            valDireitos = formatarMoeda.format(calDireito);

            //*ICE
            calIce = (calCifMetical + calDireito!) * 0.05;
            valIce = formatarMoeda.format(calIce);

            //*IVA
            calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
            valIva = formatarMoeda.format(calIva);
          } else if (double.parse(widget.motorCc.replaceAll(',', '')) > 1500 &&
              double.parse(widget.motorCc.replaceAll(',', '')) <= 2500) {
            if (calAnoDif <= 7) {
              //*Direitos
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.25;
              valIce = formatarMoeda.format(calIce);

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            } else {
              //*Direitos
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.3;
              if (calIce! >= 105000) {
                valIce = formatarMoeda.format(calIce);
              } else {
                calIce = 105000;
                valIce = formatarMoeda.format(calIce);
              }

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            }
          } else {
            if (calAnoDif <= 7) {
              //*Direitos
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.25;
              valIce = formatarMoeda.format(calIce);

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            } else {
              //*Direitos
              calDireito = calCifMetical * 0.20;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0.3;
              if (calIce! >= 105000) {
                valIce = formatarMoeda.format(calIce);
              } else {
                calIce = 105000;
                valIce = formatarMoeda.format(calIce);
              }

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            }
          }
        } else if (widget.combustivel == 'Eléctrico') {
          calDireito = calCifMetical * 0.20;
          valDireitos = formatarMoeda.format(calDireito);

          //*ICE
          calIce = (calCifMetical + calDireito!) * 0;
          valIce = formatarMoeda.format(calIce);

          //*IVA
          calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
          valIva = formatarMoeda.format(calIva);
        } else {
          calDireito = calCifMetical * 0.20;
          valDireitos = formatarMoeda.format(calDireito);

          //*ICE
          calIce = (calCifMetical + calDireito!) * 0.30;
          valIce = formatarMoeda.format(calIce);

          //*IVA
          calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
          valIva = formatarMoeda.format(calIva);
        }
      }

      //* Transporte de Mercadoria e outros
      //* >===========================================================================================================================
      if (widget.tipo == 'Truck' || widget.tipo == 'Pick up') {
        if (widget.combustivel == 'Diesel') {
          if (widget.tipo == 'Truck' && widget.maxcap == '-') {
            //*Direitos
            calDireito = calCifMetical * 0.05;
            valDireitos = formatarMoeda.format(calDireito);

            //*ICE
            calIce = (calCifMetical + calDireito!) * 0;
            valIce = formatarMoeda.format(calIce);

            //*IVA
            calIva = (calCifMetical + calDireito! + calIce!) * 0;
            valIva = formatarMoeda.format(calIva);
          } else {
            if (pesoBruto! <= 5000) {
              if (double.parse(widget.portas) == 2) {
                //*Direitos
                calDireito = calCifMetical * 0.05;
                valDireitos = formatarMoeda.format(calDireito);

                //*ICE
                calIce = (calCifMetical + calDireito!) * 0;
                valIce = formatarMoeda.format(calIce);

                //*IVA
                calIva = (calCifMetical + calDireito! + calIce!) * 0;
                valIva = formatarMoeda.format(calIva);
              } else if (double.parse(widget.portas) != 2 &&
                  double.parse(widget.portas) != 4) {
                if (double.parse(widget.motorCc.replaceAll(',', '')) <= 1500) {
                  //*Direitos
                  calDireito = calCifMetical * 0.20;
                  valDireitos = formatarMoeda.format(calDireito);

                  //*ICE
                  calIce = (calCifMetical + calDireito!) * 0.05;
                  valIce = formatarMoeda.format(calIce);

                  //*IVA
                  calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                  valIva = formatarMoeda.format(calIva);
                } else if (double.parse(widget.motorCc.replaceAll(',', '')) >
                        1500 &&
                    double.parse(widget.motorCc.replaceAll(',', '')) <= 2500) {
                  if (calAnoDif <= 7) {
                    //*Direitos
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.25;
                    valIce = formatarMoeda.format(calIce);

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  } else {
                    //*Direitos
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.3;
                    if (calIce! >= 105000) {
                      valIce = formatarMoeda.format(calIce);
                    } else {
                      calIce = 105000;
                      valIce = formatarMoeda.format(calIce);
                    }

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  }
                } else {
                  if (calAnoDif <= 7) {
                    //*Direitos
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.25;
                    valIce = formatarMoeda.format(calIce);

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  } else {
                    //*Direitos
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.3;
                    if (calIce! >= 105000) {
                      valIce = formatarMoeda.format(calIce);
                    } else {
                      calIce = 105000;
                      valIce = formatarMoeda.format(calIce);
                    }

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  }
                }
              }

              if (widget.tipo == 'Pick up') {
                if (double.parse(widget.motorCc.replaceAll(',', '')) <= 3200) {
                  if (calAnoDif <= 7) {
                    if (double.parse(widget.portas) == 4) {
                      //*Direitos
                      calDireito = calCifMetical * 0.05;
                      valDireitos = formatarMoeda.format(calDireito);

                      //*ICE
                      calIce = (calCifMetical + calDireito!) * 0.25;
                      valIce = formatarMoeda.format(calIce);

                      //*IVA
                      calIva = (calCifMetical + calDireito! + calIce!) * 0;
                      valIva = formatarMoeda.format(calIva);
                    }
                  } else {
                    if (double.parse(widget.portas) == 4) {
                      //*Direitos
                      calDireito = calCifMetical * 0.05;
                      valDireitos = formatarMoeda.format(calDireito);

                      //*ICE
                      calIce = (calCifMetical + calDireito!) * 0.3;
                      if (calIce! >= 170000) {
                        valIce = formatarMoeda.format(calIce);
                      } else {
                        calIce = 170000;
                        valIce = formatarMoeda.format(calIce);
                      }

                      //*IVA
                      calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                      valIva = formatarMoeda.format(calIva);
                    }
                  }
                } else if (double.parse(widget.motorCc.replaceAll(',', '')) >
                    3200) {
                  if (calAnoDif <= 7) {
                    if (double.parse(widget.portas) == 4) {
                      //*Direitos
                      calDireito = calCifMetical * 0.05;
                      valDireitos = formatarMoeda.format(calDireito);

                      //*ICE
                      calIce = (calCifMetical + calDireito!) * 0.25;
                      valIce = formatarMoeda.format(calIce);

                      //*IVA
                      calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                      valIva = formatarMoeda.format(calIva);
                    }
                  } else {
                    if (double.parse(widget.portas) == 4) {
                      //*Direitos
                      calDireito = calCifMetical * 0.05;
                      valDireitos = formatarMoeda.format(calDireito);

                      //*ICE
                      calIce = (calCifMetical + calDireito!) * 0.3;
                      if (calIce! >= 120000) {
                        valIce = formatarMoeda.format(calIce);
                      } else {
                        calIce = 120000;
                        valIce = formatarMoeda.format(calIce);
                      }

                      //*IVA
                      calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                      valIva = formatarMoeda.format(calIva);
                    }
                  }
                }
              }
            } else if (pesoBruto > 5000 && pesoBruto <= 20000) {
              //*Direitos
              calDireito = calCifMetical * 0.05;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0;
              valIce = formatarMoeda.format(calIce);

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            } else if (pesoBruto > 20000) {
              //*Direitos
              calDireito = calCifMetical * 0.05;
              valDireitos = formatarMoeda.format(calDireito);

              //*ICE
              calIce = (calCifMetical + calDireito!) * 0;
              valIce = formatarMoeda.format(calIce);

              //*IVA
              calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
              valIva = formatarMoeda.format(calIva);
            }
          }
        } else if (widget.combustivel == 'Gasolina' ||
            widget.combustivel == 'Petrol') {
          if (widget.tipo == 'Truck' && widget.maxcap == '-') {
            //*Direitos
            calDireito = calCifMetical * 0.05;
            valDireitos = formatarMoeda.format(calDireito);

            //*ICE
            calIce = (calCifMetical + calDireito!) * 0;
            valIce = formatarMoeda.format(calIce);

            //*IVA
            calIva = (calCifMetical + calDireito! + calIce!) * 0;
            valIva = formatarMoeda.format(calIva);
          } else {
            if (pesoBruto! <= 5000) {
              if (widget.tipo == 'Pick up') {
                if (calAnoDif <= 7) {
                  if (double.parse(widget.portas) == 4) {
                    //*Direitos
                    calDireito = calCifMetical * 0.05;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.25;
                    valIce = formatarMoeda.format(calIce);

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  }
                } else {
                  if (double.parse(widget.portas) == 4) {
                    //*Direitos
                    calDireito = calCifMetical * 0.05;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.3;
                    if (calIce! >= 85000) {
                      valIce = formatarMoeda.format(calIce);
                    } else {
                      calIce = 85000;
                      valIce = formatarMoeda.format(calIce);
                    }

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  }
                }
              }

              if (double.parse(widget.portas) == 2) {
                //*Direitos
                calDireito = calCifMetical * 0.05;
                valDireitos = formatarMoeda.format(calDireito);

                //*ICE
                calIce = (calCifMetical + calDireito!) * 0;
                valIce = formatarMoeda.format(calIce);

                //*IVA
                calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                valIva = formatarMoeda.format(calIva);
              } else if (double.parse(widget.portas) != 2 &&
                  double.parse(widget.portas) != 4) {
                if (double.parse(widget.motorCc.replaceAll(',', '')) <= 1000) {
                  if (calAnoDif <= 7) {
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0;
                    valIce = formatarMoeda.format(calIce);

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  } else {
                    //*Direitos
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.05;
                    if (calIce! >= 10000) {
                      valIce = formatarMoeda.format(calIce);
                    } else {
                      calIce = 10000;
                      valIce = formatarMoeda.format(calIce);
                    }

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  }
                } else if (double.parse(widget.motorCc.replaceAll(',', '')) >
                        1000 ||
                    double.parse(widget.motorCc.replaceAll(',', '')) <= 1500) {
                  if (calAnoDif <= 7) {
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.05;
                    valIce = formatarMoeda.format(calIce);

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  } else {
                    //*Direitos
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.10;
                    if (calIce! >= 13000) {
                      valIce = formatarMoeda.format(calIce);
                    } else {
                      calIce = 13000;
                      valIce = formatarMoeda.format(calIce);
                    }

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  }
                } else if (double.parse(widget.motorCc.replaceAll(',', '')) >
                        1500 ||
                    double.parse(widget.motorCc.replaceAll(',', '')) <= 3000) {
                  if (calAnoDif <= 7) {
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.25;
                    valIce = formatarMoeda.format(calIce);

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  } else {
                    //*Direitos
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.30;
                    if (calIce! >= 70000) {
                      valIce = formatarMoeda.format(calIce);
                    } else {
                      calIce = 70000;
                      valIce = formatarMoeda.format(calIce);
                    }

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  }
                } else {
                  if (calAnoDif <= 7) {
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.25;
                    valIce = formatarMoeda.format(calIce);

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  } else {
                    //*Direitos
                    calDireito = calCifMetical * 0.20;
                    valDireitos = formatarMoeda.format(calDireito);

                    //*ICE
                    calIce = (calCifMetical + calDireito!) * 0.30;
                    if (calIce! >= 140000) {
                      valIce = formatarMoeda.format(calIce);
                    } else {
                      calIce = 140000;
                      valIce = formatarMoeda.format(calIce);
                    }

                    //*IVA
                    calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
                    valIva = formatarMoeda.format(calIva);
                  }
                }
              }
            }
          }
        } else if (widget.combustivel != 'Gasolina' ||
            widget.combustivel != 'Petrol' ||
            (widget.combustivel != 'Diesel')) {
          //*Direitos
          calDireito = calCifMetical * 0.05;
          valDireitos = formatarMoeda.format(calDireito);

          //*ICE
          calIce = (calCifMetical + calDireito!) * 0;
          valIce = formatarMoeda.format(calIce);

          //*IVA
          calIva = (calCifMetical + calDireito! + calIce!) * 0.17;
          valIva = formatarMoeda.format(calIva);
        }
      }
    }

//! >===========================================================================================================================

//? Condicao 1
//? <===========================================================================================================================

    if (widget.assentos < 10) {
      isMenorque10();
    } else {
      isIgualeMaior10();
    }

//? >===========================================================================================================================

    //*Kudumba
    double calKudumba = double.parse(widget.cambio) * 35 * 1.17;
    valKudumba = formatarMoeda.format(calKudumba);

    //*MCnet
    double? calMCnet;
    if (double.parse(widget.fob) < 500) {
      calMCnet = double.parse(widget.cambio) * 5;
    } else if (double.parse(widget.fob) >= 500 &&
        double.parse(widget.fob) <= 10000) {
      calMCnet = double.parse(widget.cambio) * 24;
    } else if (double.parse(widget.fob) > 10000 &&
        double.parse(widget.fob) <= 50000) {
      calMCnet = double.parse(widget.cambio) * 64;
    } else {
      calMCnet =
          double.parse(widget.cambio) * double.parse(widget.fob) * 0.0085;
    }
    valMCnet = formatarMoeda.format(calMCnet);

    //*Maputo Car
    double? calMptCar;
    if (widget.peso == '-') {
      if (widget.tipo == 'SUV' ||
          widget.tipo == 'Pick up' ||
          widget.tipo == 'Van' ||
          widget.tipo == 'Sedan' ||
          widget.tipo == 'Mini Van' ||
          widget.tipo == 'Hatchback' ||
          widget.tipo == 'Coupe' ||
          widget.tipo == 'Convertible' ||
          widget.tipo == 'Wagon' ||
          widget.tipo == 'Mini Bus') {
        calMptCar = 14385 * 1.17;
      } else if (widget.tipo == 'Truck' || widget.tipo == 'Bus') {
        calMptCar = 32060 * 1.17;
      } else {
        calMptCar = null;
      }
    } else {
      if (pesoBruto <= 3500) {
        calMptCar = 14385 * 1.17;
      } else if (pesoBruto > 3500 && double.parse(widget.peso) <= 8500) {
        calMptCar = 32060 * 1.17;
      } else if (pesoBruto > 8500 && pesoBruto <= 20000) {
        calMptCar = 44470 * 1.17;
      } else if (pesoBruto > 20000 && pesoBruto <= 33000) {
        calMptCar = 48701 * 1.17;
      } else {
        calMptCar = ((((pesoBruto - 33000) / 1000) * 1410) + 48701) * 1.17;
      }
    }
    valMptCar = formatarMoeda.format((calMptCar == null) ? '-' : calMptCar);

    //*INATTER
    //~ Variaveis
    double isPesado = 6680 + 3900 + 1850;
    double isLigeiro = 6680 + 2980 + 1850;
    double? calInatter;
    if (widget.peso == '-') {
      if (widget.tipo == 'Truck' ||
          widget.tipo == 'Machinery' ||
          widget.tipo == 'Tractor') {
        calInatter = isPesado;
      } else {
        if (widget.assentos <= 7) {
          calInatter = isLigeiro;
        } else {
          calInatter = isPesado;
        }
      }
    } else {
      if (pesoBruto <= 3500 && widget.assentos <= 7) {
        calInatter = isLigeiro;
      } else {
        calInatter = isPesado;
      }
    }
    valInatter = formatarMoeda.format(calInatter);

    //*Ordem de Entrega
    double calOrdemEntrega = 70 * 117;
    valOrdemEntrega = formatarMoeda.format(calOrdemEntrega);

    //*TSA
    double calTsa = 750;
    valTsa = formatarMoeda.format(calTsa);

    //*Total
    double calTotal = calCifMetical +
        calDireito! +
        calIce! +
        calIva! +
        calKudumba +
        calMCnet +
        calOrdemEntrega +
        calInatter +
        calTsa;

    valTotal = formatarMoeda
        .format((calMptCar == null) ? 0 + calTotal : calMptCar + calTotal);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 300,
            child: Text(
              'Custos de Importacao',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Compra e Transporte........................',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Direitos Aduaneiros..........................',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Imposto de Consumo Especifico....',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Imposto de valor Acrescentado.....',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Taxa de Serviço Aduaneiro..............',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Serviço Mcnet....................................',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'INATTER..............................................',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Maputo Car.........................................',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Kudumba.............................................',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    'Ordem de Entrega.............................',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Divider(
                    color: Colors.black54,
                    height: 5,
                  ),
                  Text(
                    'Total.............................',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${valCIF!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${valDireitos!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${valIce!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${valIva!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${valTsa!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${valMCnet!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    (valInatter == '-') ? valInatter! : '${valInatter!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    (valMptCar == '-') ? valMptCar! : '${valMptCar!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${valKudumba!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${valOrdemEntrega!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Divider(
                    color: Colors.black54,
                    height: 5,
                  ),
                  Text(
                    '${valTotal!} Mt',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
