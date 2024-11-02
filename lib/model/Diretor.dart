
class Diretor{

  int? idDiretor;
  late String nome;

  Diretor({this.idDiretor,required this.nome});

  factory Diretor.fromMap(Map<String,dynamic> map){
    return Diretor(nome: map['nome'], idDiretor: map['idDiretor'] );
  }

  Map<String,dynamic> toMap(){
    final Map<String,dynamic> map = Map<String, dynamic>();
    map['nome'] = this.nome;

    if(idDiretor != null) map['idDiretor'] = this.idDiretor;

    return map;
  }

  @override
  String toString() {
    return nome;
  }
}