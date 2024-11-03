
import 'package:locadora_dw2/service/GenericService.dart';

import '../model/Item.dart';

class ItemService extends GenericService<Item>{

  ItemService() : super(rota: "/item",fromMap: Item.fromMap);
}