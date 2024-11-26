import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:locadora_dw2/controle/ControleDominio.dart';
import 'package:locadora_dw2/model/Cliente.dart';
import 'package:locadora_dw2/utils/ResponseEntity.dart';

class ClienteInterationControl {
  final numIscricaoControl = TextEditingController();
  final nomeControl = TextEditingController();
  var dataNascimentoControl = DateTime.now();
  final sexoControl = TextEditingController();
  var estahAtivoControl = true;
  int idController = -1;

  List<Cliente> clientes = [];

  StreamController<List<Cliente>> stream = StreamController<List<Cliente>>();

  Stream<List<Cliente>> get fluxo => stream.stream;

  final formKey = GlobalKey<FormState>();

  List<String> getSexo() {
    return ['Masculino', 'Feminino'];
  }

  void getClientes() async {
    final response =
        await ControleDominio.getControladorCliente().listarClientes();
    stream.add(response.resultado!);
  }

  Future<ResponseEntity> inserir() async {
    if (_validarInputs()) {
      final response =
          await ControleDominio.getControladorCliente().createCliente(Cliente(
        numInscricao: numIscricaoControl.text,
        nome: nomeControl.text,
        dataNascimento: dataNascimentoControl,
        sexo: sexoControl.text,
        estahAtivo: estahAtivoControl,
      ));

      return response;
    }
    return ResponseEntity.erro('Preencha todos os campos corretamente');
  }

  void editarCliente(Cliente cliente) {
    numIscricaoControl.text = cliente.numInscricao;
    nomeControl.text = cliente.nome;
    dataNascimentoControl = cliente.dataNascimento;
    sexoControl.text = cliente.sexo;
    estahAtivoControl = cliente.estahAtivo;
  }

  Future<ResponseEntity> atualizar() async {
    if (_validarInputs()) {
      final response =
          await ControleDominio.getControladorCliente().updateCliente(Cliente(
        idCliente: idController,
        numInscricao: numIscricaoControl.text,
        nome: nomeControl.text,
        dataNascimento: dataNascimentoControl,
        sexo: sexoControl.text,
        estahAtivo: estahAtivoControl,
      ));
      getClientes();
      stream.add(clientes);
      return response;
    }
    return ResponseEntity.erro('Preencha todos os campos corretamente');
  }

  Future<ResponseEntity> deletarCliente(Cliente cliente) {
    return ControleDominio.getControladorCliente().deleteCliente(cliente);
  }

  bool _validarInputs() {
    if (numIscricaoControl.text.isEmpty ||
        nomeControl.text.isEmpty ||
        sexoControl.text.isEmpty ||
        (dataNascimentoControl == DateTime.now() ||
            dataNascimentoControl.isAfter(DateTime.now()))) {
      return false;
    }
    return true;
  }

  void limparCampos() {
    numIscricaoControl.clear();
    nomeControl.clear();
    sexoControl.clear();
    dataNascimentoControl = DateTime.now();
    estahAtivoControl = true;
  }
}
