import 'package:flutter/material.dart';
import 'package:locadora_dw2/pages/ator_crud.dart';
import 'package:locadora_dw2/pages/home_page.dart';
import 'package:locadora_dw2/widgets/MenuLateral.dart';
import 'package:locadora_dw2/utils/CONSTANTES.dart';
import 'package:locadora_dw2/widgets/MeuScaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/ator" : (context) => AtorCRUD(),
        },
        initialRoute: "/ator",
        debugShowCheckedModeBanner: false,
      home: HomePage(),
      );
  }
}

