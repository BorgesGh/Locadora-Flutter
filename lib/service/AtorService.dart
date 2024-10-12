
import 'dart:convert';

import 'package:locadora_dw2/model/Ator.dart';
import 'package:locadora_dw2/utils/CONSTANTES.dart';
import 'package:locadora_dw2/utils/ResponseEntity.dart';
import 'package:http/http.dart' as http;

class AtorService{

  String urlAtor = "${CONSTANTES.url}/ator/";
  late String _urlOperation;



  Future<ResponseEntity<List<Ator>>> getAll() async{

    _urlOperation = "${urlAtor}getAll";

    final _uri = Uri.parse(_urlOperation);

    try {
      var _response = await http.get(_uri);

      if (_response.statusCode == 200) {
        List listMapResponse = json.decode(_response.body);
        final listAtores = listMapResponse.map<Ator>((atorJson) =>
            Ator.fromMap(atorJson)).toList();
        return ResponseEntity(listAtores);
      } else {
        return ResponseEntity.erro(
            "Ocorreu um erro ao buscar os atores! -> ${_response.statusCode}");
      }
    }on Exception catch (erro){
      return ResponseEntity.erro("Erro! -> ${erro.toString()}");
    }

  }

  Future<ResponseEntity<Ator>> inserir(Ator ator) async {

    _urlOperation = "${urlAtor}add";

    final _uri = Uri.parse(_urlOperation);

    var client = http.Client();

    try {

      print(jsonEncode(ator.toMap()));

      var _response = await client.post(
          _uri,
           body: jsonEncode(ator.toMap()),
          headers:
          {"Content-Type": "application/json", "Transfer-Encoding" : "chunked", "Accept-Encoding" : "gzip,deflate,br"},

      ).timeout(Duration(seconds: 5));

      if (_response.statusCode == 200) {
        final mapResponse = json.decode(_response.body);
        final ator = Ator.fromMap(mapResponse);
        return ResponseEntity(ator);

      } else {
        return ResponseEntity.erro(
            "Ocorreu um erro ao buscar os atores! -> ${_response.statusCode}");
      }
    }on Exception catch (erro){
      return ResponseEntity.erro("Erro! -> ${erro.toString()}");
    }

  }

  Future<ResponseEntity<Ator>> update(Ator ator) async {

    _urlOperation = "${urlAtor}update";

    final _uri = Uri.parse(_urlOperation);
    var client = http.Client();

    try {
      var _response = await client.put(
          _uri,
          body: jsonEncode(ator.toMap()),
          headers: {"Content-Type" : "application/json"}
      );

      if (_response.statusCode == 200) {
        final mapResponse = json.decode(_response.body);
        final ator = Ator.fromMap(mapResponse);
        return ResponseEntity(ator);

      } else {
        return ResponseEntity.erro(
            "Ocorreu um erro ao buscar os atores! -> ${_response.statusCode}");
      }
    }on Exception catch (erro){
      return ResponseEntity.erro("Erro! -> ${erro.toString()}");
    }

  }

  Future<ResponseEntity> delete(Ator ator) async {

    _urlOperation = "${urlAtor}delete";

    final _uri = Uri.parse(_urlOperation);
    var client = http.Client();

    try {
      var _response = await client.delete(
          _uri,
          body: jsonEncode(ator.toMap()),
          headers: {"Content-Type" : "application/json"}
      );

      if (_response.statusCode == 200) {
        return ResponseEntity<String>("Excluído com sucesso!");

      } else {
        return ResponseEntity.erro(
            "Ocorreu um erro ao buscar os atores! -> ${_response.statusCode}");
      }
    }on Exception catch (erro){
      return ResponseEntity.erro("Erro! -> ${erro.toString()}");
    }

  }





}