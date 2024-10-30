
import 'dart:math';

import 'package:locadora_dw2/model/Ator.dart';
import 'package:locadora_dw2/model/Diretor.dart';

import 'Classe.dart';

class Titulo {


  int? id;
  late String nome;
  late int ano;
  late String sinopse;
  late String categoria;

  late List<Ator> atores = [];
  late Diretor diretor;
  late Classe classe;

  Titulo({
    this.id,
    required this.nome,
    required this.ano,
    required this.sinopse,
    required this.categoria,
    required this.atores,
    required this.diretor,
    required this.classe
  });

  Titulo.fromMap(Map<String,dynamic> map){
    id = map['id'];
    nome = map['nome'];
    ano = map['ano'];
    sinopse = map['sinopse'];
    categoria = map['categoria'];

    atores = map['atores'] as List<Ator>;
    diretor = map['diretor'] as Diretor;
    classe = map['classe'] as Classe;

  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = <String,dynamic>{};

    map['nome'] = nome;
    map['ano'] = ano;
    map['sinopse'] = sinopse;
    map['categoria'] = categoria;

    map['atores'] = atores;
    map['diretor'] = diretor;
    map['classe'] = classe;

    if(id != null){
      map['id'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return nome;
  }
}