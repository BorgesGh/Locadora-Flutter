
import 'package:flutter/cupertino.dart';

import '../model/Classe.dart';

class ControladorClasse{

  static TextEditingController nomeClasseController = TextEditingController();

  static TextEditingController valorClasseController = TextEditingController();

  static TextEditingController dataClasseController = TextEditingController();

  //poderia fazer um stream....

  static int idController = -1;


  static const nomenclatura = "Classe";

  static List<Classe> classes = [Classe(nome: "Normal", id: 1, valor: 12.25,dataDevolucao: DateTime.utc(2024)),
    Classe(nome: "Urgente", id: 2, valor: 8.15,dataDevolucao: DateTime.utc(2024))];

  static void inserirClasse({required String nome, required int id, required DateTime data, required double valor}){
    Classe novoClasse = Classe(nome: nome, id: id, dataDevolucao: data,valor: valor);
    classes.add(novoClasse);

    // Chama um serviço de criação na API

  }

  static void editarClasse({required String novoNome, required int id, required DateTime data, required double valor}){

    Classe? alvo;
    for(Classe classe in classes){
      if(classe.id == id) {
        alvo = classe;
      }
    }

    alvo!.nome = novoNome;
    alvo.dataDevolucao = data;
    alvo.valor = valor;

    //Chama um serviço de Editar da API
  }

  static String formatarDateTime(DateTime diaHora){
    return "${diaHora.day}-${diaHora.month}-${diaHora.year}";
  }
}