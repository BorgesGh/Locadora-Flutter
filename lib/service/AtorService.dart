import 'package:locadora_dw2/model/Ator.dart';
import 'package:locadora_dw2/service/GenericService.dart';

import '../utils/ResponseEntity.dart';

class AtorService extends GenericService<Ator>{

  AtorService() : super( rota: "/ator", fromMap: Ator.fromMap);

}