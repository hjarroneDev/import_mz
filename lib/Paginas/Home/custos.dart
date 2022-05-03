import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class Custos extends StatefulWidget {
  const Custos({Key? key}) : super(key: key);

  @override
  State<Custos> createState() => _CustosState();
}

class _CustosState extends State<Custos> {

  String referencia = 'vazio';
  @override
  void initState() {
    super.initState();

    

    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse(
        'https://www.beforward.jp/pt/honda/n-box/bm112777/id/3575656/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    final ref = html
        .querySelector(
            '#spec > table > tbody > tr:nth-child(1) > td:nth-child(2)')
        .toString();

        setState(() {
          
          referencia =  ref;
        });

  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
         Text(
          referencia,
          style:  const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        Text(
          'Tipo'.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        Text(
          'Motor Cc:'.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        Text(
          'Combustível:'.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
