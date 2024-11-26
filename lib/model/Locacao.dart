import 'Cliente.dart';

class Locacao {

  int? idLocacao;

  late DateTime dataLocacao;
  late DateTime dataDevolucaoPrevista;
  late DateTime dataDevolucaoEfetiva;
  late double valorCobrado;
  late double multaCobrada;

  late Cliente cliente;

  Locacao({this.idLocacao, required this.dataLocacao, required this.dataDevolucaoPrevista,
      required this.dataDevolucaoEfetiva, required this.valorCobrado, required this.multaCobrada});


  Locacao.fromMap(Map<String,dynamic> map){
    try{

      idLocacao = map["idLocacao"];
      dataLocacao = DateTime.parse(map["dataLocacao"]);
      dataDevolucaoPrevista = DateTime.parse(map["dataDevolucaoPrevista"]);
      dataDevolucaoEfetiva = DateTime.parse(map["dataDevolucaoEfetiva"]);
      valorCobrado = map["valorCobrado"];
      multaCobrada = map["multaCobrada"];

      cliente = Cliente.fromMap(map["cliente"]);

    }catch(Exception){
      print(Exception.toString());
    }
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = {};

    if(idLocacao != null){
      map["idLocacao"] = idLocacao;
    }

    map["dataLocacao"] = dataLocacao.toIso8601String();
    map["dataDevolucaoPrevista"] = dataDevolucaoPrevista.toIso8601String();
    map["dataDevolucaoEfetiva"] = dataDevolucaoEfetiva.toIso8601String();
    map["valorCobrado"] = valorCobrado;
    map["multaCobrada"] = multaCobrada;

    map["cliente"] = cliente.toMap();

    return map;

  }
}