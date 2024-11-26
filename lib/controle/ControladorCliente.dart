import 'package:locadora_dw2/model/Cliente.dart';
import 'package:locadora_dw2/service/ClienteService.dart';
import 'package:locadora_dw2/utils/ResponseEntity.dart';

class ControladorCliente {
  late ClienteService clienteService;

  ControladorCliente() {
    clienteService = ClienteService();
  }

  Future<ResponseEntity<List<Cliente>>> listarClientes() {
    return clienteService.getAll();
  }

  Future<ResponseEntity<Cliente>> updateCliente(Cliente cliente) {
    return clienteService.update(cliente);
  }

  Future<ResponseEntity<Cliente>> createCliente(Cliente cliente) async {
    try {
      return await clienteService.inserir(cliente);
    } on Exception catch (e) {
      // Colocar todas as exceptions tratadas aqui...
      return ResponseEntity.erro(e.toString());
    }
  }

  Future<ResponseEntity> deleteCliente(Cliente cliente) async {
    try {
      return await clienteService.delete(cliente);
    } on Exception catch (e) {
      return ResponseEntity.erro(e.toString());
    }
  }
}
