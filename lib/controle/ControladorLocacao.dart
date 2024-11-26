import 'package:locadora_dw2/model/Locacao.dart';
import 'package:locadora_dw2/service/LocacaoService.dart';
import 'package:locadora_dw2/utils/ResponseEntity.dart';

class ControladorLocacao{

  late LocacaoService locacaoService;

  ControladorLocacao(){
    locacaoService = LocacaoService();
  }

  Future<ResponseEntity<List<Locacao>>> getLocacoes(){
    return locacaoService.getAll();
  }

  Future<ResponseEntity<Locacao>> updateLocacao(Locacao locacao){
    return locacaoService.update(locacao);
  }

  Future<ResponseEntity<Locacao>> createLocacao(Locacao locacao){
    return locacaoService.inserir(locacao);
  }

  void deleteLocacao(Locacao locacao){
    locacaoService.delete(locacao);
  }
}