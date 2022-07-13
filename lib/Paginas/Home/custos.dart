import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'widget/calculos/calculos.dart';
import 'widget/getdata.dart';
import 'widget/image.dart';

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
  late String cambio;

  late String referencia;
  late String motorCc;
  late String combustivel;
  late int assentos;
  late String portas;
  late String ano;
  late String peso;
  late String maxcap;

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
    assentos = 0;
    ano = '';
    peso = '';
    maxcap = '';
    imageLink = '';
    portas = '';
    cambio = '';
    linkController.clear();
    super.initState();
  }

  Future getDesktopWebsiteData() async {
    setState(() {
      islodin = true;
    });
    final url = Uri.parse(linkController.text);
    final response = await http.get(url);
    dom.Document document = parser.parse(response.body);

    // Image
    final valimag = document.getElementById('mainImage')?.attributes['src'];

    // Fob
    final valfobs = document.getElementsByClassName('price ip-usd-price');
    final valfob = valfobs.map((item) => item.text);

    //Cambio
    final contraVal = document.getElementById('fn-ip-sh-price')?.innerHtml;

    // Cif
    final valcif =
        document.getElementById('fn-vehicle-price-total-price')?.innerHtml;

    // Tipo
    final valtipo =
        document.querySelector('#bread > li:nth-child(5) > a')?.text;

    ///Notas
    final names = document.getElementsByClassName('car-info-flex-box');

    //Referencia
    final nameh1 =
        names.map((element) => element.getElementsByTagName('h1')[0].innerHtml);

    ///Notas
    final elements = document.getElementsByClassName('specification');

    //Referencia
    final reftr =
        elements.map((element) => element.getElementsByTagName('tr')[0]);
    final reftd =
        reftr.map((element) => element.getElementsByTagName('td')[0].innerHtml);

    //Motor
    final mottr =
        elements.map((element) => element.getElementsByTagName('tr')[3]);
    final mottd =
        mottr.map((element) => element.getElementsByTagName('td')[0].innerHtml);

    //Ano
    final anotr =
        elements.map((element) => element.getElementsByTagName('tr')[8]);
    final anotd =
        anotr.map((element) => element.getElementsByTagName('td')[0].innerHtml);

    //Peso
    final pesotr =
        elements.map((element) => element.getElementsByTagName('tr')[9]);
    final pesotd = pesotr
        .map((element) => element.getElementsByTagName('td')[1].innerHtml);

    //MaxCapacite
    final capacittr =
        elements.map((element) => element.getElementsByTagName('tr')[10]);
    final capacittd = capacittr
        .map((element) => element.getElementsByTagName('td')[0].innerHtml);

    //Combustivel
    final combtr =
        elements.map((element) => element.getElementsByTagName('tr')[4]);
    final combtd = combtr
        .map((element) => element.getElementsByTagName('td')[1].innerHtml);

    //Assentos
    final asstr =
        elements.map((element) => element.getElementsByTagName('tr')[5]);
    final asstd =
        asstr.map((element) => element.getElementsByTagName('td')[1].innerHtml);

    final porttr =
        elements.map((element) => element.getElementsByTagName('tr')[6]);
    final portd = porttr
        .map((element) => element.getElementsByTagName('td')[1].innerHtml);

    setState(
      () {
        carname = nameh1
            .toString()
            .replaceAll('(', '')
            .replaceAll(')', '')
            .substring(5);
        referencia = reftd.toString().replaceAll('(', '').replaceAll(')', '');

        motorCc = mottd
            .toString()
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('cc', '');

        peso = pesotd
            .toString()
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll(',', '')
            .replaceAll('kg', '');

        maxcap = capacittd
            .toString()
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('ton', '')
            .trim();

        combustivel = combtd.toString().replaceAll('(', '').replaceAll(')', '');
        ano = anotd
            .toString()
            .replaceAll('(', '')
            .replaceAll(')', '')
            .substring(0, 4);

        assentos = int.parse(asstd
            .toString()
            .replaceAll('(', '')
            .replaceAll(')', ' ')
            .substring(0, 2));

        portas = portd.toString().replaceAll('(', '').replaceAll(')', '');

        fob = valfob
            .toString()
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll(RegExp('[^A-Za-z0-9]'), '');

        var cambioForm = int.parse(contraVal.toString().replaceAll(',', '')) /
            int.parse(fob);

        cambio = cambioForm.toString().substring(0, 5);

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
        visivel = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screamSizeWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                   Visibility(
                    visible: (islodin)? true: false,
                    child: const SizedBox(
                      height: 50,
                    ),
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
                    Center(
                      child: (screamSizeWidth > 1250)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Expanded(
                                        child: ImageView(
                                          imageLink: imageLink,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 25),
                                          child: SizedBox(
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
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Visibility(
                                          visible: visivel,
                                          child: GetData(
                                            ano: ano,
                                            assentos: assentos,
                                            carname: carname,
                                            cif: cif,
                                            combustivel: combustivel,
                                            fob: fob,
                                            motorCc: motorCc,
                                            peso: peso,
                                            maxcap: maxcap,
                                            portas: portas,
                                            referencia: referencia,
                                            tipo: tipo,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Visibility(
                                      visible: visivel,
                                      child: CalculosPage(
                                        ano: ano,
                                        assentos: assentos,
                                        cif: cif,
                                        combustivel: combustivel,
                                        fob: fob,
                                        motorCc: motorCc,
                                        peso: peso,
                                        maxcap: maxcap,
                                        portas: portas,
                                        tipo: tipo,
                                        cambio: cambio,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : (screamSizeWidth < 1310 && screamSizeWidth > 890)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 50,
                                  ),
                                  child: SizedBox(
                                    height: 457,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              child: ImageView(
                                                imageLink: imageLink,
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 375,
                                                  child: Text(
                                                    carname,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Visibility(
                                                  visible: visivel,
                                                  child: GetData(
                                                    ano: ano,
                                                    assentos: assentos,
                                                    carname: carname,
                                                    cif: cif,
                                                    combustivel: combustivel,
                                                    fob: fob,
                                                    motorCc: motorCc,
                                                    peso: peso,
                                                    maxcap: maxcap,
                                                    portas: portas,
                                                    referencia: referencia,
                                                    tipo: tipo,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Visibility(
                                          visible: visivel,
                                          child: CalculosPage(
                                            ano: ano,
                                            assentos: assentos,
                                            cif: cif,
                                            combustivel: combustivel,
                                            fob: fob,
                                            motorCc: motorCc,
                                            peso: peso,
                                            maxcap: maxcap,
                                            portas: portas,
                                            tipo: tipo,
                                            cambio: cambio,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(top: 90),
                                  child: SizedBox(
                                    height: 480,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        
                                        Center(
                                          child: ImageView(
                                            imageLink: imageLink,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Center(
                                          child: Container(
                                            width: 650,
                                            alignment: Alignment.center,
                                            child: Text(
                                              carname,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Visibility(
                                          visible: visivel,
                                          child: GetData(
                                            ano: ano,
                                            assentos: assentos,
                                            carname: carname,
                                            cif: cif,
                                            combustivel: combustivel,
                                            fob: fob,
                                            motorCc: motorCc,
                                            peso: peso,
                                            maxcap: maxcap,
                                            portas: portas,
                                            referencia: referencia,
                                            tipo: tipo,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        Visibility(
                                          visible: visivel,
                                          child: CalculosPage(
                                            ano: ano,
                                            assentos: assentos,
                                            cif: cif,
                                            combustivel: combustivel,
                                            fob: fob,
                                            motorCc: motorCc,
                                            peso: peso,
                                            maxcap: maxcap,
                                            portas: portas,
                                            tipo: tipo,
                                            cambio: cambio,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (screamSizeWidth > 890)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 650,
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
                                hintText: 'Colar Link ou Referencia',
                                hintStyle:
                                    GoogleFonts.roboto(color: Colors.black26),
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
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            height: 53,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.teal.shade300,
                              ),
                              onPressed: () async {
                                if (linkController.text == '' ||
                                    linkController.text ==
                                        'Necessario link da viatura') {
                                  linkController.text =
                                      'Necessario link da viatura';
                                } else if (linkController.text.length >= 24 &&
                                    linkController.text.substring(0, 24) ==
                                        'https://www.beforward.jp') {
                                  getDesktopWebsiteData();
                                } else if (linkController.text.length >= 23 &&
                                    linkController.text.substring(0, 23) ==
                                        'https://sp.beforward.jp') {
                                  setState(() {
                                    linkController.text =
                                        'Site ${linkController.text.substring(0, 23)} não Suportado';
                                  });
                                } else if (linkController.text.length >= 24 &&
                                    linkController.text.substring(0, 24) ==
                                        'https://www.sbtjapan.com') {
                                  setState(() {
                                    linkController.text =
                                        'Site ${linkController.text.substring(0, 24)} não Suportado';
                                  });
                                } else if (linkController.text ==
                                    'Site "${linkController.text}" não Suportado') {
                                  linkController.text =
                                      'Site "${linkController.text}" não Suportado';
                                } else {
                                  linkController.clear();
                                  linkController.text =
                                      'Necessario link da viatura';
                                }
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
                        ],
                      )
                    : (screamSizeWidth < 890 && screamSizeWidth > 600)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
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
                                    hintText: 'Colar Link ou Referencia',
                                    hintStyle: GoogleFonts.roboto(
                                        color: Colors.black26),
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
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 53,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.teal.shade300,
                                  ),
                                  onPressed: () async {
                                    if (linkController.text == '' ||
                                        linkController.text ==
                                            'Necessario link da viatura') {
                                      linkController.text =
                                          'Necessario link da viatura';
                                    } else if (linkController.text.length >=
                                            24 &&
                                        linkController.text.substring(0, 24) ==
                                            'https://www.beforward.jp') {
                                      getDesktopWebsiteData();
                                    } else if (linkController.text.length >=
                                            23 &&
                                        linkController.text.substring(0, 23) ==
                                            'https://sp.beforward.jp') {
                                      setState(() {
                                        linkController.text =
                                            'Site ${linkController.text.substring(0, 23)} não Suportado';
                                      });
                                    } else if (linkController.text.length >=
                                            24 &&
                                        linkController.text.substring(0, 24) ==
                                            'https://www.sbtjapan.com') {
                                      setState(() {
                                        linkController.text =
                                            'Site ${linkController.text.substring(0, 24)} não Suportado';
                                      });
                                    } else if (linkController.text ==
                                        'Site "${linkController.text}" não Suportado') {
                                      linkController.text =
                                          'Site "${linkController.text}" não Suportado';
                                    } else {
                                      linkController.clear();
                                      linkController.text =
                                          'Necessario link da viatura';
                                    }
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
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 40,
                                      child: TextField(
                                        controller: linkController,
                                        minLines: 1,
                                        maxLines: 3,
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 16,
                                            color: Colors.redAccent.shade100,
                                          ),
                                        ),
                                        textAlign: TextAlign.start,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.all(6),
                                          hintText: 'Colar Link ou Referencia',
                                          hintStyle: GoogleFonts.roboto(
                                              color: Colors.black26),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          enabledBorder:
                                              const OutlineInputBorder(
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
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          suffixIcon: Container(
                                            height: 58,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              color: const Color.fromARGB(
                                                      255, 129, 212, 205)
                                                  .withOpacity(0.2),
                                            ),
                                            child: IconButton(
                                              // Icon to
                                              icon: Icon(
                                                Icons.search_sharp,
                                                size: 25,
                                                color: Colors.teal.shade300,
                                              ), // clear text
                                              onPressed: () async {
                                                if (linkController.text == '' ||
                                                    linkController.text ==
                                                        'Necessario link da viatura') {
                                                  linkController.text =
                                                      'Necessario link da viatura';
                                                } else if (linkController
                                                            .text.length >=
                                                        24 &&
                                                    linkController.text
                                                            .substring(0, 24) ==
                                                        'https://www.beforward.jp') {
                                                  getDesktopWebsiteData();
                                                } else if (linkController
                                                            .text.length >=
                                                        23 &&
                                                    linkController.text
                                                            .substring(0, 23) ==
                                                        'https://sp.beforward.jp') {
                                                  setState(() {
                                                    linkController.text =
                                                        'Site ${linkController.text.substring(0, 23)} não Suportado';
                                                  });
                                                } else if (linkController
                                                            .text.length >=
                                                        24 &&
                                                    linkController.text
                                                            .substring(0, 24) ==
                                                        'https://www.sbtjapan.com') {
                                                  setState(() {
                                                    linkController.text =
                                                        'Site ${linkController.text.substring(0, 24)} não Suportado';
                                                  });
                                                } else if (linkController
                                                        .text ==
                                                    'Site "${linkController.text}" não Suportado') {
                                                  linkController.text =
                                                      'Site "${linkController.text}" não Suportado';
                                                } else {
                                                  linkController.clear();
                                                  linkController.text =
                                                      'Necessario link da viatura';
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
              ],
            ),
          ],
        ));
  }
}
