
class Diretor{

  int? id;
  late String nome;

  Diretor({this.id,required this.nome});

  factory Diretor.fromMap(Map<String,dynamic> map){
    return Diretor(nome: map['nome'], id: map['id'] );
  }

  Map<String,dynamic> toMap(){
    final Map<String,dynamic> map = Map<String, dynamic>();
    map['nome'] = this.nome;

    if(id != null) map['id'] = this.id;

    return map;
  }
}