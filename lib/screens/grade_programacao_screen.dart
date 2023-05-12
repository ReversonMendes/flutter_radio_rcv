import 'package:flutter/material.dart';

import '../widget/new_card.dart';

class ProgramacaoScreen extends StatefulWidget {
  const ProgramacaoScreen({super.key});

  @override
  State<ProgramacaoScreen> createState() => _ProgramacaoScreenState();
}

class _ProgramacaoScreenState extends State<ProgramacaoScreen> {
  List<Programa> list = [];

  @override
  void initState() {
    super.initState();
    list.add(Programa('Programa Alvorada Sertaneja com Valdemir Matte',
        'De segunda a sexta as 6:00', 'assets/image/programacao1.png'));
    list.add(Programa('Programa Manhã 87 com Adair Silva',
        'De segunda a sexta as 8:30', 'assets/image/manha87.png'));
    list.add(Programa('Clube dos Bairros com Islan Roque',
        'De segunda a sexta as 10:00', 'assets/image/clubeDosBairros.png'));
    list.add(Programa('Sotoca Top com Ledy Dai', 'De segunda a sexta as 14:00',
        'assets/image/sotocatop.png'));
    list.add(Programa('Show da Tarde com José de Freitas',
        'De segunda a sexta as 16:00 ', 'assets/image/showdatarde.png'));
    list.add(Programa('Clube do Modão com Luiz Jung',
        'De segunda a sexta as 17:00', 'assets/image/clubedomodao.png'));
    list.add(Programa('Show da Noite com Neres', 'De segunda a sexta as 20:00',
        'assets/image/showdanoite.png'));
    list.add(Programa('Programa do Tiu Baza com Marcos Bazanella',
        'De segunda a sexta as 22:00', 'assets/image/tiu.png'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 20, bottom: 80),
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: ((ctx, index) {
          return NewsCard(
                  key: UniqueKey(),
                  title: list[index].title,
                  subtitle: list[index].subtitle,
                  imagem: list[index].imagem,
                );
        }),
      ),
    );
  }
}

class Programa {
  final String title;
  final String subtitle;
  final String imagem;

  Programa(this.title, this.subtitle, this.imagem);
}


// index == 0
//               ? Positioned(
//                   // Encabezado
//                   child: Container(
//                     height: 120.0,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: const BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(75.0),
//                         bottomRight: Radius.circular(75.0),
//                       ),
//                     ),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: const <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(left: 18.0, bottom: 20.0),
//                             child: Text(
//                               'Confira a nossa programação!',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ]),
//                   ),
//                 )
//               : 