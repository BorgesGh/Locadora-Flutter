import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import '../widgets/MeuScaffold.dart';

class HomePage extends StatelessWidget{

  List<String> imagens = ["Locadora.png","Locadora2.jpg","Locadora3.jpeg"];

  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: "Locadora",
      body: Container()
    );
  }
}