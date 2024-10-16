class ResponseEntity<R>{
  bool get sucesso => mensagemErro == null;
  String? mensagemErro = null;
  R? resultado = null;

  ResponseEntity(this.resultado);
  ResponseEntity.erro(String this.mensagemErro);
}