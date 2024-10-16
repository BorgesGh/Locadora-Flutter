

import 'package:flutter/material.dart';
import 'package:locadora_dw2/utils/CONSTANTES.dart';

class Botao extends StatelessWidget{

  late VoidCallback ao_clicar;
  Widget? texto;
  Color? cor;

  Botao({super.key,
    required this.ao_clicar,
    this.texto,
    this.cor
  })
  {
    cor ??= CONSTANTES.LARANJA;
  }
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ao_clicar,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(cor),
        foregroundColor: const WidgetStatePropertyAll(Colors.black)
      ),

      child: texto,
    );
  }

}