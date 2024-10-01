

import 'package:flutter/material.dart';
import 'package:locadora_dw2/utils/CONSTANTES.dart';

class Botao extends StatelessWidget{

  late VoidCallback ao_clicar;
  Widget? texto;

  Botao({super.key, required this.ao_clicar, this.texto});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ao_clicar,
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(CONSTANTES.LARANJA),
        foregroundColor: WidgetStatePropertyAll(Colors.black)
      ),

      child: texto,
    );
  }

}