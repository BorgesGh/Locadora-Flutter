
class Diretor{

  int? id;
  late String nome;

  Diretor({this.id,required this.nome});

  Diretor.fromMap(Map<String,dynamic> map){
    id = map["id"];
    nome = map["nome"];
  }
}