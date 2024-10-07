
class Ator{
  late int id;
  late String nome;

  Ator({required this.nome, required this.id});

  Ator.fromMap(Map<String,dynamic> map){
    id = map["id"];
    nome = map["nome"];
  }

}