import 'package:flutter/material.dart';
import 'package:locadora_dw2/pages/home_page.dart';
import 'package:locadora_dw2/routes.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/cupertino.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = goRouter();

    return FluentApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData(),
      );
  }
}

