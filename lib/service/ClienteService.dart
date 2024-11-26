import 'package:locadora_dw2/service/GenericService.dart';

import '../model/Cliente.dart';

class ClienteService extends GenericService<Cliente>{

  ClienteService() : super(fromMap: Cliente.fromMap, rota: "/Cliente");
}