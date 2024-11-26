import '../model/Locacao.dart';
import 'GenericService.dart';

class LocacaoService extends GenericService<Locacao> {
  LocacaoService() : super(fromMap: Locacao.fromMap, rota: "/locacao");
}