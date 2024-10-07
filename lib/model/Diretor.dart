
class Diretor{

  late int id;
  late String nome;

  Diretor({required this.id,required this.nome});

  Diretor.fromMap(Map<String,dynamic> map){
    id = map["id"];
    nome = map["nome"];
  }
}