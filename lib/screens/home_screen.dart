import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

final List<String> imgList = [
  'assets/image/19-anos.svg',
  'assets/image/19-anos.svg',
  'assets/image/19-anos.svg',
  'assets/image/19-anos.svg',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.green,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      SvgPicture.asset(item, fit: BoxFit.cover, width: 1000.0),
                      //Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: const Text(
                            'Divulgação rcv fm',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    color: Colors.lightBlue,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 80.0, top: 150.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const <Widget>[
                          // SvgPicture.asset(
                          //   'assets/image/19-anos.svg',
                          //   height: 250,
                          //   width: 250,
                          // ),
                           Text(
                            'CONTATO/ENDEREÇO',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontWeight: FontWeight.w800,
                              fontSize: 24.0,
                            ),
                          ),
                          Text(
                            'Travessa Domingos Batistton, 51 Dois Vizinhos, PR - CEP 85660-000',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            'Tel: 46 999799230',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 16.0, bottom: 50.0),
                          //   child: Wrap(
                          //     direction: Axis.horizontal,
                          //     spacing: 10.0,
                          //     runSpacing: 5.0,
                          //     children: const <Widget>[
                          //       // Center(
                          //       //   child: myChips("Estas Anotado..!"),
                          //       // )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 600.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(75.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 34.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          // const Text(
                          //   'Anuncie na RCV',
                          //   style: TextStyle(
                          //   color: Colors.green,
                          //   fontSize: 18.0,
                          //   fontWeight: FontWeight.bold),
                          // ),
                          AnimatedTextKit(
                            animatedTexts: [
                              RotateAnimatedText('Anuncie na RCV',
                                  textStyle: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                  duration: const Duration(milliseconds: 2000)),
                            ],
                            totalRepeatCount: 4,
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                            repeatForever: true,
                          ),
                          const Text(
                            'Fale conosco agora mesmo e tenha o seu negócio divulgado na rádio',
                            style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.green,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton.icon(
                            style: raisedButtonStyle,
                            onPressed: () {
                              openWhatsapp(
                                  context: context,
                                  text: 'Olá RCV FM',
                                  number: '+55 46999799230');
                            },
                            icon: const FaIcon(FontAwesomeIcons.whatsapp),
                            label: const Text('Anuncie aqui agora'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 430.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(75.0),
                      ),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 150.0),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                          ),
                          items: imageSliders
                        )
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: const <Widget>[
                        //     Text(
                        //       'RCV FM 87.9',
                        //       style: TextStyle(
                        //         color: Color.fromARGB(255, 255, 255, 255),
                        //         fontWeight: FontWeight.w800,
                        //         fontSize: 28.0,
                        //       ),
                        //     ),
                        //     Text(
                        //       '20 anos da queridinha',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 20.0,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        ),
                  ),
                ),
                Positioned(
                  child: Container(
                      height: 170.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 254, 255, 255),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(75.0),
                          bottomRight: Radius.circular(75.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          const Text(
                            'RCV FM 87.9',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w800,
                              fontSize: 28.0,
                            ),
                          ),
                          const Text(
                            '20 anos da queridinha',
                            style: TextStyle(
                              color: Color.fromARGB(255, 2, 2, 2),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 5)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                      width: 2.0,
                                      color: Colors.green,
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: 60.0,
                                    height: 60.0,
                                    child: IconButton(
                                        icon: const FaIcon(
                                          FontAwesomeIcons.whatsapp,
                                          color: Colors.green,
                                        ),
                                        highlightColor: Colors.green,
                                        onPressed: () {
                                          openWhatsapp(
                                              context: context,
                                              text: 'Olá RCV FM',
                                              number: '+55 46999799230');
                                        }),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                      width: 2.0,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  child: SizedBox(
                                      width: 60.0,
                                      height: 60.0,
                                      child: IconButton(
                                          icon: const FaIcon(
                                            FontAwesomeIcons.facebook,
                                            color: Colors.blue,
                                          ),
                                          highlightColor: Colors.green,
                                          onPressed: () {
                                            openFacebook(context: context);
                                          })),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    border: Border.all(
                                      width: 2.0,
                                      color: const Color(0xFFF49CC8),
                                    ),
                                  ),
                                  child: const SizedBox(
                                    width: 60.0,
                                    height: 60.0,
                                    child: Icon(
                                      FontAwesomeIcons.instagram,
                                      color: Color(0xFFC7166F),
                                    ),
                                  ),
                                ),
                              ]),
                        ],
                      )),
                ),
              ],
            )),
      ),
    );
  }
}

void openWhatsapp(
    {required BuildContext context,
    required String text,
    required String number}) async {
  var whatsapp = number; //+92xx enter like this
  var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=$text";
  var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
      await launchUrl(Uri.parse(
        whatsappURLIos,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Whatsapp não instalado")));
    }
  } else {
    // android , web
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Whatsapp not instalado")));
    }
  }
}

void openFacebook({required BuildContext context}) async {
  var facebookUrlAndroid = "fb://page/100063769260739";
  var facebookURLIos = "https://www.facebook.com/radiorcv";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrl(Uri.parse(facebookURLIos))) {
      await launchUrl(Uri.parse(
        facebookURLIos,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("facebook não instalado")));
    }
  } else {
    // android , web
    // if (await canLaunchUrl(Uri.parse(facebookUrlAndroid))) {
    await launchUrl(Uri.parse(facebookURLIos));
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("facebook não instalado")));
    // }
  }
}
