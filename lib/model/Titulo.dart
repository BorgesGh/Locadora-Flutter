
import 'dart:math';

import 'package:locadora_dw2/model/Ator.dart';
import 'package:locadora_dw2/model/Diretor.dart';

import 'Classe.dart';

class Titulo {


  int? idTitulo;
  late String nome;
  late int ano;
  late String sinopse;
  late String categoria;

  late List<Ator> atores = [];
  late Diretor diretor;
  late Classe classe;

  Titulo({
    this.idTitulo,
    required this.nome,
    required this.ano,
    required this.sinopse,
    required this.categoria,
    required this.atores,
    required this.diretor,
    required this.classe
  });

  Titulo.fromMap(Map<String,dynamic> map){
    idTitulo = map['idTitulo'];
    nome = map['nome'];
    ano = map['ano'];
    sinopse = map['sinopse'];
    categoria = map['categoria'];

    atores = (map['atores'] as List).map((item) => Ator.fromMap(item)).toList();
    diretor =   Diretor.fromMap(map['diretor']);
    classe = Classe.fromMap(map['classe']);

  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = <String,dynamic>{};

    map['nome'] = nome;
    map['ano'] = ano;
    map['sinopse'] = sinopse;
    map['categoria'] = categoria;

    map['atores'] = atores.map((ator) => ator.toMap()).toList();
    map['diretor'] = diretor.toMap();
    map['classe'] = classe.toMap();

    if(idTitulo != null){
      map['idTitulo'] = idTitulo;
    }
    return map;
  }

  @override
  String toString() {
    return nome;
  }
}