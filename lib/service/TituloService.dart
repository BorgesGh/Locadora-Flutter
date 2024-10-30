
import 'package:locadora_dw2/model/Titulo.dart';
import 'package:locadora_dw2/service/GenericService.dart';

class TituloService extends GenericService<Titulo>{

  TituloService() : super(rota: "/titulo",fromMap: Titulo.fromMap);

}