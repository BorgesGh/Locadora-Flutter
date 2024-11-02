
class Classe{

  int? idClasse;
  late String nome;
  late double valor;
  late DateTime dataDevolucao;

  Classe({ required this.idClasse,required this.nome,required this.valor,required this.dataDevolucao});

  Classe.fromMap(Map<String,dynamic> map){

    idClasse = map["idClasse"];
    nome = map["nome"];
    valor = map["valor"];
    dataDevolucao = DateTime.parse(map["dataDevolucao"]);
  }

  Map<String, dynamic> toMap(){
    final Map<String,dynamic> map = Map<String,dynamic>();

    map['nome'] = this.nome;
    map['valor'] = this.valor;
    map['dataDevolucao'] = this.dataDevolucao.toIso8601String();

    if(idClasse != null){
      map['idClasse'] = this.idClasse;
    }

    return map;
  }

  @override
  String toString() {
    return nome;
  }
}