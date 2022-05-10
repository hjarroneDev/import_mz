import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculosPage extends StatefulWidget {
  final String tipo;
  final String fob;
  final String cif;
  final String motorCc;
  final String combustivel;
  final String assentos;
  final String portas;
  final String ano;
  final String peso;
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

  void calInicial() {
    //*Formatador
    final formatarMoeda = NumberFormat("#,##0.00", "en_US");

    //*CIF
    valCIF = formatarMoeda
        .format(double.parse(widget.cif) * double.parse(widget.cambio));

    //*Kudumba
    valKudumba = formatarMoeda.format(double.parse(widget.cambio) * 35 * 1.17);

    //*MCnet
    if (double.parse(widget.fob) < 500) {
      valMCnet = formatarMoeda.format(double.parse(widget.cambio) * 5);
    } else if (double.parse(widget.fob) >= 500 && double.parse(widget.fob) <= 10000) {
      valMCnet = formatarMoeda.format(double.parse(widget.cambio) * 24);
    } else if (double.parse(widget.fob) > 10000 &&
        double.parse(widget.fob) <= 50000) {
      valMCnet = formatarMoeda.format(double.parse(widget.cambio) * 64);
    } else {
      valMCnet = formatarMoeda.format(
          double.parse(widget.cambio) * double.parse(widget.fob) * 0.0085);
    }

    //*Maputo Car
    if (double.parse(widget.peso) <= 3500) {
      valMptCar = formatarMoeda.format(14385 * 1.17);
    }else if (double.parse(widget.peso) > 3500 && double.parse(widget.peso) <= 8500) {
      valMptCar = formatarMoeda.format(32060 * 1.17);
    }else if (double.parse(widget.peso) > 8500 && double.parse(widget.peso) <= 20000) {
      valMptCar = formatarMoeda.format(44470 * 1.17);
    }
    else if (double.parse(widget.peso) > 20000 && double.parse(widget.peso) <= 33000) {
      valMptCar = formatarMoeda.format(48701 * 1.17);
    }else {
      valMptCar = formatarMoeda.format(((((double.parse(widget.peso) - 33000)/1000)*1410)+ 48701)*1.17);
    }

    //*Ordem de Entrega

    valOrdemEntrega = formatarMoeda.format(69*117);
    
  }

  @override
  void initState() {
    calInicial();
    super.initState();
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
                    widget.cif,
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
                    widget.tipo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    '-',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const Text(
                    '750 Mt',
                    style: TextStyle(
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
                    widget.assentos,
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
                    '${valMptCar!} Mt',
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
                    widget.peso,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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
