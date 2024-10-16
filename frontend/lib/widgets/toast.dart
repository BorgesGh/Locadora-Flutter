library minha_biblioteca_flutter;

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toast {

  static void mensagemSucesso({
    String titulo = "Tudo certo!",
    String description = "A Operação foi concluída com sucesso!",
    BuildContext? context
  })
  {

    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,

      borderSide: const BorderSide(
          color:  Colors.green
      ),

      icon: const Icon(Icons.check),

      autoCloseDuration: const Duration(seconds: 3),
      title: Text(titulo),
      description: Text(description),

      alignment: Alignment.topRight,
      direction: TextDirection.ltr,

      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
            color: Color(0x07000000),
            blurRadius: 14,
            spreadRadius: 0
        )
      ],
    );
  }

  static void mensagemErro({
    String titulo = "Ocorreu um erro...",
    String description = "Algo deu errado",
    BuildContext? context
  })
  {

    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.minimal,

      borderSide: const BorderSide(
          color:  Colors.red
      ),

      icon: const Icon(Icons.report_gmailerrorred),

      autoCloseDuration: const Duration(seconds: 3),
      title: Text(titulo),
      description: Text(description),

      alignment: Alignment.topRight,
      direction: TextDirection.ltr,

      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
            color: Color(0x07000000),
            blurRadius: 14,
            spreadRadius: 0
        )
      ],
    );
  }

  static void mensagemInfo({
    String titulo = "Ocorreu um erro...",
    String description = "Algo deu errado",
    BuildContext? context
    }){

    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.minimal,

      borderSide: const BorderSide(
          color:  Colors.white
      ),

      icon: const Icon(Icons.info_outline),

      autoCloseDuration: const Duration(seconds: 3),
      title: Text(titulo),
      description: Text(description),

      alignment: Alignment.topRight,
      direction: TextDirection.ltr,

      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
            color: Color(0x07000000),
            blurRadius: 14,
            spreadRadius: 0
        )
      ],
    );
  }




}