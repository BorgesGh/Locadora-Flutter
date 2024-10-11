

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorDiretor.dart';
import 'package:locadora_dw2/model/Diretor.dart';

import '../widgets/Botao.dart';
import '../widgets/FormArea.dart';
import '../widgets/MeuScaffold.dart';

class DiretorCRUD extends StatefulWidget{
  const DiretorCRUD({super.key});

  @override
  State<StatefulWidget> createState() => _DireitorCRUDState();
}

class _DireitorCRUDState extends State<DiretorCRUD>{

  List<Diretor> diretores = ControladorDiretor.diretores;

  double space = 10.0;

  String operacao = "Enviar";

  int gambiarra = 3;

  int idController = -1;

  final formKey = GlobalKey<FormState>();

  final nomeDiretorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: "Cadastro de ${ControladorDiretor.nomenclatura}",
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
                      FormArea("Nome do ${ControladorDiretor.nomenclatura}",
                        tipo: TextInputType.text,
                        controlador: nomeDiretorController,
                      ),
                      SizedBox(height: space),
                      Botao(
                          ao_clicar: (){
                            if(formKey.currentState!.validate()){

                              if(operacao == "Enviar"){
                                setState(() {
                                  ControladorDiretor.inserirDiretor(nome: nomeDiretorController.text, id: gambiarra++);
                                });
                                nomeDiretorController.text = "";
                              }
                              else{
                                setState(() {
                                  ControladorDiretor.editarDiretor(novoNome: nomeDiretorController.text, id: idController);
                                  limparNomeEResetarBotao();
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
            child: DataTable(
              border: TableBorder.all(
                  width: 1,
                  color: Colors.black),

              columns: const <DataColumn>[
                DataColumn(
                    label: Text("Nome ${ControladorDiretor.nomenclatura}",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    headingRowAlignment: MainAxisAlignment.center
                ),
                DataColumn(
                    label: Text("Opções",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    headingRowAlignment: MainAxisAlignment.center
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
                        showEditIcon: true,
                        onTap: (){
                          nomeDiretorController.text = elemento.nome;
                          idController = elemento.id!;
                          setState(() {
                            operacao = "Editar";

                          });
                        }
                    ),
                    DataCell(Botao(
                      ao_clicar: (){
                        setState(() {
                          if(idController == elemento.id){
                            limparNomeEResetarBotao();
                          }
                          diretores.remove(elemento);
                        });
                      },
                      texto: const Text("Excluir"),
                      cor: Colors.red,
                    ),)
                  ],
                );
              }).toList(),
            ),
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