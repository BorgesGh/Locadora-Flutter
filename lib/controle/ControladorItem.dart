

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:locadora_dw2/controle/ControladorTitulo.dart';
import 'package:locadora_dw2/model/Item.dart';
import 'package:locadora_dw2/model/Titulo.dart';
import 'package:locadora_dw2/service/ItemService.dart';

import '../utils/ResponseEntity.dart';

enum Operacoes{
  Enviar,
  Editar
}

class ControladorItem{

  final formKey = GlobalKey<FormState>();

  List<Item> items = [];
  List<String> tipos = ["DVD","Fita","BlueRay"];

  //controllers
  final numSerieController = TextEditingController();
  final tituloController = ControladorTitulo();
  String operationController = Operacoes.Enviar.name;
  int idController = -1;

  final streamTitulo = StreamController<List<Titulo>>();
  final streamTipo = StreamController<List<String>>();
  final streamDate = StreamController<DateTime>();

  final streamItem = StreamController<List<Item>>();

  Titulo? selectedTitulo;
  String? selectedTipo;
  DateTime selectedDate = DateTime.now();

  late ItemService itemService;

  ControladorItem(){
    itemService = ItemService();

    tituloController.getTitulos().then((titulos) => streamTitulo.add(titulos));
    streamTipo.add(tipos);

  }


  Future<List<Item>> getItems() async{

    ResponseEntity<List<Item>> responseEntity = await itemService.getAll();
    items = responseEntity.resultado ?? []; // Caso o resultado venha vazio...

    streamItem.add(items);

    return responseEntity.resultado!;

  }

  Future<void> inserirItem({required Item itemNew}) async {

    ResponseEntity<Item> response = await itemService.inserir(itemNew);
    Item? item = response.resultado;

    items.add(item!);
    streamItem.add(items);

  }

  Future<void> editarItem({required Item item}) async {


    Item? alvo;

    // alvo = diretores.map((Diretor) => Diretor.id == id) as Diretor?;

    for (Item it in items) {
      if (it.idItem == item.idItem) {
        alvo = it;
      }
    }

    if (alvo != null) {
      alvo.titulo = item.titulo;
      alvo.tipoItem = item.tipoItem;
      alvo.dataAquisicao = item.dataAquisicao;
      alvo.numSerie = item.numSerie;

      ResponseEntity<Item> response = await itemService.update(alvo);

      if (response.sucesso) {
        // Atualizar a lista local com o Diretor modificado
        streamItem.add(items);
      }
    }
  }

  Future<ResponseEntity> excluirItem(Item item) async{
    return itemService.delete(item);

  }

  List<String> getColluns(){
    return ["NumSerie","Data Aquisição", "Tipo", "Titulo","Opções"];
  }
}