
class Classe{

  int? id;
  late String nome;
  late double valor;
  late DateTime dataDevolucao;

  Classe({ required this.id,required this.nome,required this.valor,required this.dataDevolucao});

  Classe.fromMap(Map<String,dynamic> map){

    id = map["id"];
    nome = map["nome"];
    valor = map["valor"];
    dataDevolucao = DateTime.parse(map["dataDevolucao"]);
  }

  Map<String, dynamic> toMap(){
    final Map<String,dynamic> map = Map<String,dynamic>();

    map['nome'] = this.nome;
    map['valor'] = this.valor;
    map['dataDevolucao'] = this.dataDevolucao.toIso8601String();

    if(id != null){
      map['id'] = this.id;
    }

    return map;
  }

}