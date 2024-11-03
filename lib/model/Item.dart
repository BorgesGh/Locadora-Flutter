
import 'package:locadora_dw2/model/Titulo.dart';

class Item{

  int? idItem;

  late int numSerie;
  late DateTime dataAquisicao;
  late String tipoItem;
  late Titulo titulo;

  Item({this.idItem, required this.numSerie, required this.dataAquisicao, required this.tipoItem, required this.titulo});

  Item.fromMap(Map<String,dynamic> map){
    try {
      idItem = map["idItem"];
      numSerie = map["numSerie"];
      dataAquisicao = DateTime.parse(map["dataAquisicao"]);
      tipoItem = map["tipoItem"];

      titulo = Titulo.fromMap(map["titulo"]);
    }catch (Exception) {
      print(Exception.toString());


    }

  }

  Map<String,dynamic> toMap(){

    Map<String,dynamic> map = {};

    map["numSerie"] = numSerie;
    map["dataAquisicao"] = dataAquisicao.toIso8601String();
    map["tipoItem"] = tipoItem;

    map["titulo"] = titulo.toMap();

    if(idItem != null){
      map["idItem"] = idItem;
    }

    return map;
  }

  @override
  String toString() {
    return "Serie: $numSerie,\n Titulo: ${titulo.toString()}";
  }
}