
import '../model/Ator.dart';

class ControladorAtor{

  static List<Ator> atores = [Ator(nome: "Ricardo", id: 1),Ator(nome: "Ghabriel", id: 2)];

  static void inserirAtor({required String nome, required int id}){
    Ator novoAtor = Ator(nome: nome, id: id);
    atores.add(novoAtor);

    // Chama um serviço de criação na API

  }

  static void editarAtor({required String novoNome, required int id}){

    Ator? alvo;
    for(Ator ator in atores){
      if(ator.id == id) {
        alvo = ator;
      }
    }

    alvo!.nome = novoNome;

    //Chama um serviço de Editar da API
  }
}