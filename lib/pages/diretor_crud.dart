

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorDiretor.dart';
import 'package:locadora_dw2/model/Diretor.dart';
import 'package:locadora_dw2/widgets/toast.dart';

import '../utils/ResponseEntity.dart';
import '../widgets/Botao.dart';
import '../widgets/FormArea.dart';
import '../widgets/MeuScaffold.dart';

class DiretorCRUD extends StatefulWidget{
  const DiretorCRUD({super.key});

  @override
  State<StatefulWidget> createState() => _DireitorCRUDState();
}

class _DireitorCRUDState extends State<DiretorCRUD>{

  final _controladorDiretor = ControladorDiretor();

  List<Diretor> diretores = [];
  double space = 10.0;

  String operacao = "Enviar";

  final formKey = GlobalKey<FormState>();

  final nomeDiretorController = TextEditingController();
  int idController = -1;

  @override
  void initState(){
    super.initState();
    _controladorDiretor.getDiretores();
  }


  @override
  void dispose() {
  }

  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: "Cadastro de Diretor",
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormArea("Nome do Diretor",
                        tipo: TextInputType.text,
                        controlador: nomeDiretorController,
                      ),
                      SizedBox(height: space),
                      Botao(
                          ao_clicar: (){
                            if(formKey.currentState!.validate()){

                              if(operacao == "Enviar"){
                                setState(() {
                                  _controladorDiretor.inserirDiretor(nome: nomeDiretorController.text);
                                });
                                nomeDiretorController.text = "";
                              }
                              else{
                                setState(() {
                                  try {
                                    _controladorDiretor.editarDiretor(
                                        novoNome: nomeDiretorController.text,
                                        id: idController);
                                    limparNomeEResetarBotao();
                                    Toast.mensagemSucesso(titulo: "Editado com sucesso!", context: context);
                                  } on Exception catch (erro){
                                    Toast.mensagemErro(titulo: "Ocorreu um erro ao editar: ${erro.toString()}", context: context);
                                  }
                                });
                                idController = -1;
                              }
                            }
                          },
                          texto: Text(operacao)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: space),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: StreamBuilder<ResponseEntity>(
                stream: _controladorDiretor.fluxo,
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Mostra um indicador de carregamento
                  }

                  if(snapshot.data?.resultado == null){
                    return const Center(child: Text("Erro ao acessar o Backend!"));

                  }

                  if (snapshot.hasError) {
                    return Text('Erro ao carregar Diretores'); // Tratamento de erro

                  }
                  if (snapshot.hasData && operacao != "Editar") {
                    ResponseEntity response = snapshot.data!;
                    if(response.resultado is List){
                      // print("StreamBuilder: Era uma lista!");
                      diretores = response.resultado;

                    } else {
                      // print("StreamBuilder: Era um elemento!");

                      // Verifique se o Diretor já existe na lista antes de adicionar
                      Diretor novoDiretor = response.resultado;
                      bool DiretorJaExiste = diretores.any((Diretor) => Diretor.id == novoDiretor.id);

                      if (idController != -1) {
                        // Substituir o Diretor editado na lista
                        diretores[idController] = novoDiretor;

                      } else if(!DiretorJaExiste) {
                        // Adicionar um novo Diretor se não estiver na lista
                        diretores.add(novoDiretor);
                      }
                    }

                    // response.resultado is List ? Diretores = response.resultado : Diretores.add(response.resultado) ;
                    // Atualiza a lista de Diretores
                  }
                  // print("StreamBuilder: ${snapshot.data!.resultado}");

                  return DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          "Nome Diretor",
                          style: TextStyle(fontSize: 18),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                      DataColumn(
                        label: Text(
                          "Opções",
                          style: TextStyle(fontSize: 18),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                    ],
                    rows: diretores.map((Diretor elemento) {
                      return DataRow(
                        cells: [
                          DataCell(
                            Row(
                              children: [
                                Text(elemento.nome),
                              ],
                            ),
                            onTap: () {
                              nomeDiretorController.text = elemento.nome;
                              idController = elemento.id!;
                              setState(() {
                                operacao = "Editar";
                              });
                            },
                            showEditIcon: true,
                          ),
                          DataCell(
                            Botao(
                              ao_clicar: () {
                                setState(() {
                                  if (idController == elemento.id) {
                                    limparNomeEResetarBotao();
                                  }
                                  diretores.remove(elemento);
                                  _controladorDiretor.excluirDiretor(elemento);
                                  Toast.mensagemSucesso(titulo: "Excluido com sucesso!", context: context);
                                });
                              },
                              texto: const Text("Excluir"),
                              cor: Colors.red,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  );
                },
              )
          )
        ],
      ),
    );

  }

  void limparNomeEResetarBotao(){
    nomeDiretorController.text = "";
    operacao = "Enviar";
  }
}