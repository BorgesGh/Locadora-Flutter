
import '../model/Diretor.dart';

class ControladorDiretor{


  static const nomenclatura = "Diretor";

  static List<Diretor> diretores = [Diretor(nome: "Ricardo", id: 1),Diretor(nome: "Ghabriel", id: 2)];

  static void inserirDiretor({required String nome, required int id}){
    Diretor novoDiretor = Diretor(nome: nome, id: id);
    diretores.add(novoDiretor);

    // Chama um serviço de criação na API

  }

  static void editarDiretor({required String novoNome, required int id}){

    Diretor? alvo;
    for(Diretor diretor in diretores){
      if(diretor.id == id) {
        alvo = diretor;
      }
    }

    alvo!.nome = novoNome;

    //Chama um serviço de Editar da API
  }
}