import 'package:flutter/material.dart';

class GetData extends StatefulWidget {
  final String carname;

  final String tipo;
  final String fob;
  final String cif;


  final String referencia;
  final String motorCc;
  final String combustivel;
  final String assentos;
  final String portas;
  final String ano;
  final String peso;

  const GetData({
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
    required this.carname,
    required this.referencia,
    
  }) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'CIF USD..................',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Tipo de Veículo....',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Ano de Fabrico.....',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Cc do Motor..........',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Combustivel..........',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Assentos................',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Portas......................',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Peso........................',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Referência.............',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 25,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.cif}.00",
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
            Text(
              widget.ano,
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
              widget.motorCc,
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
              widget.combustivel,
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
              widget.portas,
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
              widget.peso,
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
              widget.referencia,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
