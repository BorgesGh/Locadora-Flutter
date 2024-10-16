
import 'package:locadora_dw2/model/Diretor.dart';
import 'package:locadora_dw2/service/GenericService.dart';

class DiretorService extends GenericService<Diretor>{

  DiretorService() : super(rota: "/diretor",fromMap: Diretor.fromMap);
}