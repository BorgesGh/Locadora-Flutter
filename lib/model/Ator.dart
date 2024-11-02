class Ator{

  int? idAtor;
  late String nome;

  Ator({required this.nome, this.idAtor});

  factory Ator.fromMap(Map<String,dynamic> map){
    return Ator(nome: map['nome'], idAtor: map['idAtor'] );

  }

  Map<String,dynamic> toMap(){
    final Map<String,dynamic> map = <String, dynamic>{};
    map['nome'] = nome;

    if(idAtor != null) map['idAtor'] = idAtor;

    return map;
  }

}