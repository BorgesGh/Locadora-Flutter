import 'package:flutter/material.dart';
import 'package:locadora_dw2/utils/CONSTANTES.dart';

class FormAreaNumeros extends StatelessWidget {
  String? label;
  String? dica;
  bool password = false;
  bool editavel = true;

  TextEditingController? controlador;
  FormFieldValidator<String>? validator;
  TextInputType? tipo;

  String? validarSomenteNumeros(String? texto) {
    if (texto == null || texto.isEmpty) {
      return "O campo está vazio";
    }
    // Verifica se o texto contém algo que não seja número ou ponto
    if (!RegExp(r'^[0-9.]+$').hasMatch(texto)) {
      return "O campo deve conter apenas números";
    }
    return null;
  }

  FormAreaNumeros(
    this.label, {super.key,
    this.dica,
    this.password = false,
    this.controlador,
    this.validator,
    this.tipo = TextInputType.number,
    this.editavel = true,
  }) {
    validator ??= validarSomenteNumeros;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      validator: validator,
      keyboardType: tipo,
      obscureText: password,
      enabled: editavel,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: CONSTANTES.BEGE)),
        hintText: dica,
      ),
    );
  }
}
