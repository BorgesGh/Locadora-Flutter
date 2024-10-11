
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
    dataDevolucao = map["dataDevolucao"];
  }

}