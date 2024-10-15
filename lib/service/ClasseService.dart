
import 'package:locadora_dw2/model/Classe.dart';
import 'package:locadora_dw2/service/GenericService.dart';

class ClasseService extends GenericService<Classe>{

  ClasseService() : super(rota: "/classe", fromMap: Classe.fromMap);

}