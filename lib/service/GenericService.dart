import 'dart:convert';

import '../utils/CONSTANTES.dart';
import '../utils/ResponseEntity.dart';
import 'package:http/http.dart' as http;

class GenericService<T> {
  String url = CONSTANTES.urlServer;
  late String _urlOperation;

  final T Function(Map<String, dynamic> map)
      fromMap; // Adiciona uma função padrão para criar novos atores

  GenericService({required String rota, required this.fromMap}) {
    url += rota; // Padrão -> /nomeRota
  }

  // -------------------- METODO GET --------------------------------
  Future<ResponseEntity<List<T>>> getAll() async {
    _urlOperation = "${url}/getAll";

    final _uri = Uri.parse(_urlOperation);

    var client = http.Client();

    try {
      var _response = await client.get(_uri);

      client.close();

      if (_response.statusCode == 200) {
        List listMapResponse = json.decode(_response.body);
        final listAtores =
            listMapResponse.map<T>((atorJson) => fromMap(atorJson)).toList();
        return ResponseEntity(listAtores);
      } else {
        return ResponseEntity.erro(
            "Ocorreu um erro ao buscar! -> ${_response.statusCode}");
      }
    } on Exception catch (erro) {
      return ResponseEntity.erro("Erro! -> ${erro.toString()}");
    }
  }

  // -------------------------- METODO POST ---------------------------------
  Future<ResponseEntity<T>> inserir(T elemento) async {
    _urlOperation = "${url}/add";

    final _uri = Uri.parse(_urlOperation);

    var client = http.Client();

    try {
      print(jsonEncode((elemento as dynamic).toMap()));

      var _response = await client.post(
        _uri,
        body: jsonEncode((elemento as dynamic)
            .toMap()), // Esse cast dá acesso ao metodo toMap
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 5));

      client.close();

      if (_response.statusCode == 200) {
        final mapResponse = json.decode(_response.body);
        final elementoRes = fromMap(mapResponse);
        return ResponseEntity(elementoRes);
      } else {
        return ResponseEntity.erro(
            "Ocorreu um erro ao buscar! -> ${_response.statusCode}");
      }
    } on Exception catch (erro) {
      return ResponseEntity.erro("Erro! -> ${erro.toString()}");
    }
  }

  // ---------------------------- METODO PUT ----------------------------
  Future<ResponseEntity<T>> update(T elemento) async {
    _urlOperation = "${url}/update";

    final _uri = Uri.parse(_urlOperation);
    var client = http.Client();

    try {
      var _response = await client.put(_uri,
          body: jsonEncode((elemento as dynamic).toMap()),
          headers: {"Content-Type": "application/json"});

      client.close();

      if (_response.statusCode == 200) {
        final mapResponse = json.decode(_response.body);
        final elementoRes = fromMap(mapResponse);
        return ResponseEntity(elementoRes);
      } else {
        return ResponseEntity.erro(_response.body);
      }
    } on Exception catch (erro) {
      return ResponseEntity.erro("Erro! -> ${erro.toString()}");
    }
  }

  //------------------------------- METODO DELETE -----------------------------

  Future<ResponseEntity> delete(T elemento) async {
    _urlOperation = "${url}/delete";

    final _uri = Uri.parse(_urlOperation);
    var client = http.Client();

    try {
      var _response = await client.delete(_uri,
          body: jsonEncode((elemento as dynamic).toMap()),
          headers: {"Content-Type": "application/json"});

      client.close();

      if (_response.statusCode == 200) {
        return ResponseEntity<String>("Excluído com sucesso!");
      } else {
        return ResponseEntity.erro(_response.body);
      }
    } on Exception catch (erro) {
      return ResponseEntity.erro("Erro! -> ${erro.toString()}");
    }
  }
}
