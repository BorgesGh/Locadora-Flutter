
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/CONSTANTES.dart';
import 'MenuLateral.dart';

class MeuScaffold extends StatelessWidget {

  //Fazer o construtor que recebe o body e o titulo

  String texto = "";
  Widget? body;

  MeuScaffold({required this.texto, this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: InkWell(
              child: Text(texto),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "/");
              },
            )
        ),
        backgroundColor: CONSTANTES.LARANJA,
      ),
      drawer: const MenuLateral(),
      body: body,
    );
  }

}