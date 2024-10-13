import 'package:locadora_dw2/model/Ator.dart';
import 'package:locadora_dw2/service/GenericService.dart';

import '../utils/ResponseEntity.dart';

class AtorService extends GenericService<Ator>{

  AtorService() : super( rota: "/ator", fromMap: Ator.fromMap);

  // Future<ResponseEntity<List<Ator>>> getAtores() async => super.getAll();
  //
  // Future<ResponseEntity<Ator>> insertAtor(Ator ator) async => super.inserir(ator);
  //
  // Future<ResponseEntity<Ator>> updateAtor(Ator ator) async => super.update(ator);
  //
  // Future<ResponseEntity> delete(Ator ator) async => super.delete(ator);

}