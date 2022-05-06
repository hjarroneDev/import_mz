import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class Custos extends StatefulWidget {
  const Custos({Key? key}) : super(key: key);

  @override
  State<Custos> createState() => _CustosState();
}

class _CustosState extends State<Custos> {
  final linkController = TextEditingController();

  bool islodin = false;
  bool visivel = false;

  late String carname;

  late String tipo;
  late String fob;
  late String cif;

  late String referencia;
  late String motorCc;
  late String combustivel;
  late String assentos;
  late String ano;
  late String peso;

  late String imageLink;

  @override
  void initState() {
    carname = '';
    tipo = '';
    fob = '';
    cif = '';
    referencia = '';
    motorCc = '';
    combustivel = '';
    assentos = '';
    ano = '';
    peso = '';
    imageLink = '';

    linkController.clear();

    super.initState();
  }

  void getWebsiteData() async {
    if (linkController.text == '') {
      return;
    } else {
      final url = Uri.parse(linkController.text);
      final response = await http.get(url);
      dom.Document document = parser.parse(response.body);

      // Image
      final valimag = document.getElementById('mainImage')?.attributes['src'];

      // Fob
      final valfobs = document.getElementsByClassName('price ip-usd-price');
      final valfob = valfobs.map((item) => item.text);

      // Cif
      final valcif =
          document.getElementById('fn-vehicle-price-total-price')?.innerHtml;

      // Tipo
      final valtipo =
          document.querySelector('#bread > li:nth-child(5) > a')?.text;

      ///Notas
      final names = document.getElementsByClassName('car-info-flex-box');

      //Referencia
      final nameh1 = names
          .map((element) => element.getElementsByTagName('h1')[0].innerHtml);

      ///Notas
      final elements = document.getElementsByClassName('specification');

      //Referencia
      final reftr =
          elements.map((element) => element.getElementsByTagName('tr')[0]);
      final reftd = reftr
          .map((element) => element.getElementsByTagName('td')[0].innerHtml);

      //Motor
      final mottr =
          elements.map((element) => element.getElementsByTagName('tr')[3]);
      final mottd = mottr
          .map((element) => element.getElementsByTagName('td')[0].innerHtml);

      //Ano
      final anotr =
          elements.map((element) => element.getElementsByTagName('tr')[8]);
      final anotd = anotr
          .map((element) => element.getElementsByTagName('td')[0].innerHtml);

      //Peso
      final pesotr =
          elements.map((element) => element.getElementsByTagName('tr')[9]);
      final pesotd = pesotr
          .map((element) => element.getElementsByTagName('td')[1].innerHtml);

      //Combustivel
      final combtr =
          elements.map((element) => element.getElementsByTagName('tr')[4]);
      final combtd = combtr
          .map((element) => element.getElementsByTagName('td')[1].innerHtml);

      //Assentos
      final asstr =
          elements.map((element) => element.getElementsByTagName('tr')[6]);
      final asstd = asstr
          .map((element) => element.getElementsByTagName('td')[1].innerHtml);

      setState(
        () {
          carname = nameh1
              .toString()
              .replaceAll('(', '')
              .replaceAll(')', '')
              .substring(5);
          referencia = reftd.toString().replaceAll('(', '').replaceAll(')', '');
          motorCc = mottd.toString().replaceAll('(', '').replaceAll(')', '');

          peso = pesotd.toString().replaceAll('(', '').replaceAll(')', '');
          combustivel =
              combtd.toString().replaceAll('(', '').replaceAll(')', '');
          ano = anotd
              .toString()
              .replaceAll('(', '')
              .replaceAll(')', '')
              .substring(0, 4);

          assentos = asstd.toString().replaceAll('(', '').replaceAll(')', '');
          fob = valfob
              .toString()
              .replaceAll('(', '')
              .replaceAll(')', '')
              .replaceAll(RegExp('[^A-Za-z0-9]'), '');

          var cifs = int.parse(valcif
                  .toString()
                  .replaceAll('(', '')
                  .replaceAll(')', '')
                  .replaceAll(RegExp('[^A-Za-z0-9]'), '')) +
              160;

          cif = cifs.toString();
          tipo = valtipo.toString();
          imageLink = valimag.toString();

          islodin = false;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 5, bottom: 20),
            child: SizedBox(
              child: TextField(
                controller: linkController,
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
                  suffixIcon: IconButton(
                    // Icon to
                    icon: const Icon(
                      Icons.clear,
                      size: 25,
                    ), // clear text
                    onPressed: () {
                      linkController.clear();
                    },
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
              onPressed: () {
                setState(() {
                  islodin = true;
                  visivel = true;
                });
                getWebsiteData();
              },
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
          const SizedBox(
            height: 50,
          ),
          if (islodin == true && linkController.text != '')
            const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 460.0,
                      height: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https:$imageLink',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Text(
                        carname,
                        style: const TextStyle(
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
                        Visibility(
                          visible: visivel,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'FOB USD................',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
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
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fob,
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
                              cif,
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
                              tipo,
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
                              ano,
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
                              motorCc,
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
                              combustivel,
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
                              assentos,
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
                              peso,
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
                              referencia,
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
                Visibility(
                  visible: visivel,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fob,
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
                                  cif,
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
                                  tipo,
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
                                  ano,
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
                                  motorCc,
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
                                  combustivel,
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
                                  assentos,
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
                                  peso,
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
                                  referencia,
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
                                  referencia,
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
                                  referencia,
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
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
