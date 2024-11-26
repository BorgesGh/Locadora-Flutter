import 'Locacao.dart';

class Cliente {
  int? idCliente;

  late String numInscricao;
  late String nome;
  late DateTime dataNascimento;
  late String sexo;
  late bool estahAtivo;

  Cliente(
      {this.idCliente,
      required this.numInscricao,
      required this.nome,
      required this.dataNascimento,
      required this.sexo,
      required this.estahAtivo});

  Cliente.fromMap(Map<String, dynamic> map) {
    try {
      idCliente = map["idCliente"];
      numInscricao = map["numInscricao"];
      nome = map["nome"];
      dataNascimento = DateTime.parse(map["dataNascimento"]);
      sexo = map["sexo"];
      estahAtivo = map["estahAtivo"];
    } catch (Exception) {
      print(Exception.toString());
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    if (idCliente != null) {
      map["idCliente"] = idCliente;
    }

    map["numInscricao"] = numInscricao;
    map["nome"] = nome;
    map["dataNascimento"] = dataNascimento.toIso8601String();
    map["sexo"] = sexo;
    map["estahAtivo"] = estahAtivo;
    return map;
  }
}
