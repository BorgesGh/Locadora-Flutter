
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorClasse.dart';
import 'package:locadora_dw2/model/Classe.dart';
import 'package:locadora_dw2/widgets/BotaoDate.dart';
import 'package:locadora_dw2/widgets/MeuScaffold.dart';
import 'package:locadora_dw2/widgets/Botao.dart';
import 'package:locadora_dw2/widgets/FormArea.dart';

import '../model/Diretor.dart';
import '../widgets/FormAreaNumeros.dart';
import '../widgets/toast.dart';



class ClasseCRUD extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _StateClasseCRUD();

}

class _StateClasseCRUD extends State<ClasseCRUD>{

  final _controladorClasse = ControladorClasse();

  List<Classe> classes = [];

  double space = 10.0;

  String operacao = "Enviar";

  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _controladorClasse.getClasses();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: "Cadastro de Classe",
      body: SingleChildScrollView(
        child: Column(
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


                        FormArea("Nome do Classe",
                          tipo: TextInputType.text,
                          controlador: _controladorClasse.nomeClasseController,
                        ),
                        SizedBox(height: space),

                        FormAreaNumeros("Valor",
                          tipo: TextInputType.number,
                          controlador: _controladorClasse.valorClasseController,
                        ),
                        SizedBox(height: space),

                        BotaoData(streamDate: _controladorClasse.streamDate, controladorDate: _controladorClasse.dataClasseController),
                        SizedBox(height: space),


                        Botao(
                            ao_clicar: (){
                              if(formKey.currentState!.validate()){

                                if(operacao == "Enviar"){
                                  setState(() {
                                    _controladorClasse.inserirClasse(
                                      nome: _controladorClasse.nomeClasseController.text,
                                      valor: double.parse(_controladorClasse.valorClasseController.text),
                                      dataDevolucao: DateTime.parse(_controladorClasse.dataClasseController.text),
                                    );
                                    limparNomeEResetarBotao();
                                  });
                                  _controladorClasse.nomeClasseController.text = "";
                                }

                                else{
                                  setState(() {
                                    _controladorClasse.editarClasse(
                                      novoNome: _controladorClasse.nomeClasseController.text,
                                      id: _controladorClasse.idController,
                                      data: DateTime.parse(_controladorClasse.dataClasseController.text),
                                      valor: double.parse(_controladorClasse.valorClasseController.text)

                                    );
                                    limparNomeEResetarBotao();
                                    _controladorClasse.dataClasseController.text = DateTime.now().toString();

                                  });
                                  _controladorClasse.idController = -1;
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
                child: StreamBuilder<List<Classe>>(
                  stream: _controladorClasse.fluxo,
                  builder: (context, snapshot) {
        
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // Mostra um indicador de carregamento
                    }
        
                    if (snapshot.hasError) {
                      return Text('Erro ao carregar Classes'); // Tratamento de erro
                    }
        
                    if(!snapshot.hasData){
                      return const Center(child: Text("Erro ao acessar o Backend!"));
                    }
        
                    classes = snapshot.data!;
        
                    return DataTable(
                      columnSpacing: 2,

                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            overflow: TextOverflow.ellipsis,
                            "Nome Classe",
                            style: TextStyle(fontSize: 18),
                          ),
                          headingRowAlignment: MainAxisAlignment.center,
                        ),
                        DataColumn(
                          label: Text(
                            "Valor",
                            style: TextStyle(fontSize: 18),
                          ),
                          headingRowAlignment: MainAxisAlignment.center,
                        ),
                        DataColumn(
                          label: Text(
                            overflow: TextOverflow.ellipsis,
                            "Data de Entrega",
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
                      rows: classes.map((Classe elemento) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  Text(elemento.nome),
                                ],
                              ),
                              onTap: () {
                                _controladorClasse.nomeClasseController.text = elemento.nome;
                                _controladorClasse.valorClasseController.text = "${elemento.valor}";
                                _controladorClasse.idController = elemento.idClasse!;
                                _controladorClasse.dataClasseController.text = elemento.dataDevolucao.toString();
        
                                _controladorClasse.streamDate.add(elemento.dataDevolucao);
        
                                setState(() {
                                  operacao = "Editar";
                                });
                              },
                              showEditIcon: true,
                            ),
                            DataCell(
                              Row(
                                children: [
                                  Text(elemento.valor.toString()),
                                ],
                              )
                            ),
                            DataCell(
                                Row(
                                  children: [
                                    Text(BotaoData.formatarDateTime(elemento.dataDevolucao))
                                  ],
                                )
                            ),
                            DataCell(
                              Botao(
                                ao_clicar: () async {
                                  final response = await _controladorClasse.excluirClasse(elemento);
                                  if(response.sucesso) {
                                    Toast.mensagemSucesso(
                                        titulo: "Excluido com sucesso!",
                                        context: context);

                                    setState(() {
                                      if (_controladorClasse.idController == elemento.idClasse) {
                                        limparNomeEResetarBotao();
                                      }
                                      classes.remove(elemento);
                                    });
                                  }
                                  else{
                                    Toast.mensagemErro(
                                        titulo: "Erro ao apagar o Ator",
                                        description: "Esse elemento já está relacionado com outro...",
                                        context: context);
                                  }
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
      ),
    );

  }

  void limparNomeEResetarBotao(){

    final valor = 0;
    _controladorClasse.nomeClasseController.text = "";
    _controladorClasse.valorClasseController.text = valor.toString();

    operacao = "Enviar";
  }
}