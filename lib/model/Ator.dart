
class Ator{
  int? id;
  late String nome;

  Ator({required this.nome, this.id});

  Ator.fromMap(Map<String,dynamic> map){
    id = map['id'];
    nome = map['nome'];
  }

  Map<String,dynamic> toMap(){
    final Map<String,dynamic> map = Map<String, dynamic>();
    map['nome'] = this.nome;

    if(id != null) map['id'] = this.id;

    return map;
  }

}