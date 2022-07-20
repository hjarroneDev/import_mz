import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

import 'widget/calculos/calculos.dart';
import 'widget/getdata.dart';
import 'widget/image.dart';

class Resumo extends StatefulWidget {
  const Resumo({Key? key}) : super(key: key);

  @override
  State<Resumo> createState() => _ResumoState();
}

class _ResumoState extends State<Resumo> {
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
                    visible: (islodin) ? true : false,
                    child: const SizedBox(
                      height: 50,
                    ),
                  ),
                  if (islodin == true && linkController.text != '')
                    Visibility(
                      visible: (screamSizeWidth > 600) ? true : false,
                      child: const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  else
                    Center(
                      child: (screamSizeWidth > 1251)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Expanded(
                                        child: ImageView(
                                          imageLink:
                                              '//image-cdn.beforward.jp/large/202207/3791369/BM324210_7c0076.jpg',
                                          height: 300,
                                          width: 460,
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
                                              screamSizeWidth.toString(),
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
                                          child: const GetData(
                                            ano: "2010",
                                            assentos: 5,
                                            cif: '4709',
                                            combustivel: 'Petrol',
                                            fob: '3160',
                                            motorCc: "1300",
                                            peso: '600',
                                            maxcap: '600',
                                            portas: '5',
                                            referencia: 'BM324210',
                                            tipo: 'Hatchback',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Visibility(
                                      visible: visivel,
                                      child: const CalculosPage(
                                        ano: "2013",
                                        assentos: 6,
                                        cif: '4709',
                                        combustivel: 'Petrol',
                                        fob: '3160',
                                        motorCc: "1300",
                                        peso: '1200',
                                        maxcap: '1200',
                                        portas: '5',
                                        tipo: 'Hatchback',
                                        cambio: '63',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : (screamSizeWidth < 1250 && screamSizeWidth >= 342)
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    top: 50,
                                  ),
                                  child: (screamSizeWidth < 460 &&
                                          screamSizeWidth > 342)
                                      ? Visibility(
                                          visible: visivel,
                                          child: SizedBox(
                                            height: 535,
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: [
                                                Wrap(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          child: Wrap(
                                                            alignment:
                                                                WrapAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                screamSizeWidth
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black54,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        const SizedBox(
                                                          child: ImageView(
                                                            imageLink:
                                                                '//image-cdn.beforward.jp/large/202207/3791369/BM324210_7c0076.jpg',
                                                            height: 210,
                                                            width: 400,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10,
                                                          left: 20,
                                                          right: 20),
                                                      child: GetData(
                                                        ano: "2010",
                                                        assentos: 5,
                                                        cif: '4709',
                                                        combustivel: 'Petrol',
                                                        fob: '3160',
                                                        motorCc: "1300",
                                                        peso: '600',
                                                        maxcap: '600',
                                                        portas: '5',
                                                        referencia: 'BM324210',
                                                        tipo: 'Hatchback',
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 20,
                                                        //left: 10,
                                                        //right: 10
                                                      ),
                                                      child: CalculosPage(
                                                        ano: "2013",
                                                        assentos: 6,
                                                        cif: '4709',
                                                        combustivel: 'Petrol',
                                                        fob: '3160',
                                                        motorCc: "1300",
                                                        peso: '1200',
                                                        maxcap: '1200',
                                                        portas: '5',
                                                        tipo: 'Hatchback',
                                                        cambio: '63',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : (screamSizeWidth <= 800 &&
                                              screamSizeWidth > 461)
                                          ? Visibility(
                                              visible: visivel,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 25),
                                                    child: Wrap(
                                                      children: [
                                                        Text(
                                                          screamSizeWidth
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 800,
                                                    child: SingleChildScrollView(
                                                        scrollDirection:
                                                      Axis.horizontal,
                                                        child: Row(
                                                    children: const [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(
                                                                8.0),
                                                        child: ImageView(
                                                          imageLink:
                                                              '//image-cdn.beforward.jp/large/202207/3791369/BM324210_7c0076.jpg',
                                                          height: 250,
                                                          width: 350,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width: 300,
                                                        child: GetData(
                                                          ano: "2010",
                                                          assentos: 5,
                                                          cif: '4709',
                                                          combustivel:
                                                              'Petrol',
                                                          fob: '3160',
                                                          motorCc: "1300",
                                                          peso: '600',
                                                          maxcap: '600',
                                                          portas: '5',
                                                          referencia:
                                                              'BM324210',
                                                          tipo: 'Hatchback',
                                                        ),
                                                      ),
                                                    ],
                                                        ),
                                                      ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  (screamSizeWidth >= 555)
                                                      ? const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 120,
                                                                  right: 120),
                                                          child: CalculosPage(
                                                            ano: "2013",
                                                            assentos: 6,
                                                            cif: '4709',
                                                            combustivel:
                                                                'Petrol',
                                                            fob: '3160',
                                                            motorCc: "1300",
                                                            peso: '1200',
                                                            maxcap: '1200',
                                                            portas: '5',
                                                            tipo: 'Hatchback',
                                                            cambio: '63',
                                                          ),
                                                        )
                                                      : const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 60,
                                                                  right: 60),
                                                          child: CalculosPage(
                                                            ano: "2013",
                                                            assentos: 6,
                                                            cif: '4709',
                                                            combustivel:
                                                                'Petrol',
                                                            fob: '3160',
                                                            motorCc: "1300",
                                                            peso: '1200',
                                                            maxcap: '1200',
                                                            portas: '5',
                                                            tipo: 'Hatchback',
                                                            cambio: '63',
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              child: SizedBox(
                                                height: 1300,
                                                width: 900,
                                                child: GridView(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                  ),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    const ImageView(
                                                      imageLink:
                                                          '//image-cdn.beforward.jp/large/202207/3791369/BM324210_7c0076.jpg',
                                                      height: 250,
                                                      width: 350,
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        screamSizeWidth
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: visivel,
                                                      child: const GetData(
                                                        ano: "2010",
                                                        assentos: 5,
                                                        cif: '4709',
                                                        combustivel: 'Petrol',
                                                        fob: '3160',
                                                        motorCc: "1300",
                                                        peso: '600',
                                                        maxcap: '600',
                                                        portas: '5',
                                                        referencia: 'BM324210',
                                                        tipo: 'Hatchback',
                                                      ),
                                                    ),
                                                    Visibility(
                                                      visible: visivel,
                                                      child: const CalculosPage(
                                                        ano: "2013",
                                                        assentos: 6,
                                                        cif: '4709',
                                                        combustivel: 'Petrol',
                                                        fob: '3160',
                                                        motorCc: "1300",
                                                        peso: '1200',
                                                        maxcap: '1200',
                                                        portas: '5',
                                                        tipo: 'Hatchback',
                                                        cambio: '63',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                )
                              : Visibility(
                                  visible: visivel,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus &&
                                            currentFocus.focusedChild != null) {
                                          currentFocus.focusedChild?.unfocus();
                                        }
                                      },
                                      child: SizedBox(
                                        height: 535,
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                            Center(
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                      screamSizeWidth
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.black54,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Center(
                                              child: ImageView(
                                                imageLink:
                                                    '//image-cdn.beforward.jp/large/202207/3791369/BM324210_7c0076.jpg',
                                                height: 205,
                                                width: 310,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const GetData(
                                              ano: "2010",
                                              assentos: 5,
                                              cif: '4709',
                                              combustivel: 'Petrol',
                                              fob: '3160',
                                              motorCc: "1300",
                                              peso: '600',
                                              maxcap: '600',
                                              portas: '5',
                                              referencia: 'BM324210',
                                              tipo: 'Hatchback',
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            const CalculosPage(
                                              ano: "2013",
                                              assentos: 6,
                                              cif: '4709',
                                              combustivel: 'Petrol',
                                              fob: '3160',
                                              motorCc: "1300",
                                              peso: '1200',
                                              maxcap: '1200',
                                              portas: '5',
                                              tipo: 'Hatchback',
                                              cambio: '63',
                                            ),
                                          ],
                                        ),
                                      ),
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
                    : (screamSizeWidth < 890 && screamSizeWidth > 408)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 40,
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
                                              icon: (islodin == true)
                                                  ? Center(
                                                      child: SizedBox(
                                                        width: 25,
                                                        height: 25,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Colors
                                                              .teal.shade300,
                                                        ),
                                                      ),
                                                    )
                                                  : Icon(
                                                      Icons.search_sharp,
                                                      size: 25,
                                                      color:
                                                          Colors.teal.shade300,
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
                                                  FocusScopeNode currentFocus =
                                                      FocusScope.of(context);
                                                  if (!currentFocus
                                                          .hasPrimaryFocus &&
                                                      currentFocus
                                                              .focusedChild !=
                                                          null) {
                                                    currentFocus.focusedChild
                                                        ?.unfocus();
                                                  }
                                                  setState(() {
                                                    visivel = false;
                                                    islodin = true;
                                                  });
                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 5), () {
                                                    setState(() {
                                                      visivel = true;
                                                      islodin = false;

                                                      linkController.clear();
                                                    });
                                                  });
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
