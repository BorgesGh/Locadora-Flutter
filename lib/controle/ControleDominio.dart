import 'package:locadora_dw2/controle/ControladorCliente.dart';

class ControleDominio{

  ControladorCliente controladorCliente = ControladorCliente();

  static ControladorCliente getControladorCliente(){
    return ControladorCliente();
  }
}