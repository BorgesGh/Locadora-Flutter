
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorClasse.dart';
import 'package:locadora_dw2/model/Classe.dart';
import 'package:locadora_dw2/widgets/BotaoDate.dart';
import 'package:locadora_dw2/widgets/MeuScaffold.dart';
import 'package:locadora_dw2/widgets/Botao.dart';
import 'package:locadora_dw2/widgets/FormArea.dart';



class ClasseCRUD extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _StateClasseCRUD();


}

class _StateClasseCRUD extends State<ClasseCRUD>{

  List<Classe> Classees = ControladorClasse.classes;

  double space = 10.0;

  int gambiarra = 3;

  String operacao = "Enviar";

  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    //Carregar a lista de Classees...
  }

  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: "Cadastro de Classe",
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


                      FormArea("Nome do Classe",
                        tipo: TextInputType.text,
                        controlador: ControladorClasse.nomeClasseController,
                      ),
                      SizedBox(height: space),

                      FormArea("Valor",
                        tipo: TextInputType.number,
                        controlador: ControladorClasse.valorClasseController,
                      ),
                      SizedBox(height: space),

                      BotaoData(ControladorClasse.dataClasseController),
                      SizedBox(height: space),


                      Botao(
                          ao_clicar: (){
                            if(formKey.currentState!.validate()){

                              if(operacao == "Enviar"){
                                setState(() {
                                  ControladorClasse.inserirClasse(
                                    id: gambiarra++,
                                    nome: ControladorClasse.nomeClasseController.text,
                                    valor: double.parse(ControladorClasse.valorClasseController.text),
                                    data: DateTime.parse(ControladorClasse.dataClasseController.text),
                                  );
                                });
                                ControladorClasse.nomeClasseController.text = "";
                              }

                              else{
                                setState(() {
                                  ControladorClasse.editarClasse(
                                    novoNome: ControladorClasse.nomeClasseController.text,
                                    id: ControladorClasse.idController,
                                    data: DateTime.parse(ControladorClasse.dataClasseController.text),
                                    valor: double.parse(ControladorClasse.valorClasseController.text)

                                  );
                                  limparNomeEResetarBotao();

                                });
                                ControladorClasse.idController = -1;
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
                    label: Text("Nome Classe",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    headingRowAlignment: MainAxisAlignment.center
                ),
                DataColumn(
                    label: Text("Valor",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    headingRowAlignment: MainAxisAlignment.center
                ),
                DataColumn(
                    label: Text("Data",
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

              rows: Classees.map((Classe elemento) {
                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        children: [
                          Text(elemento.nome),
                        ],
                      ),

                      onTap: (){
                        ControladorClasse.nomeClasseController.text= elemento.nome;
                        ControladorClasse.idController = elemento.id;
                        ControladorClasse.dataClasseController.text = elemento.dataDevolucao.toString();
                        ControladorClasse.valorClasseController.text = elemento.valor.toString() ;

                        setState(() {
                          operacao = "Editar";

                        });
                      },
                      showEditIcon: true,
                      // Fazer um Ontap que ao clicar sobre o elemento.
                    ),

                    DataCell(
                      Row(
                        children: [
                          Text("${elemento.valor}"),
                        ],
                      )
                    ),

                    DataCell(
                        Row(
                          children: [
                            Text(ControladorClasse.formatarDateTime(elemento.dataDevolucao)),
                          ],
                        )
                    ),// Supondo que 'nome' seja um atributo de 'Classe'
                    DataCell(
                      Botao(
                        ao_clicar: (){
                          setState(() {
                            if(ControladorClasse.idController == elemento.id){
                              limparNomeEResetarBotao();
                            }
                            Classees.remove(elemento);
                          });
                        },
                        texto: const Text("Excluir"),
                        cor: Colors.red,
                      ),
                    )
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
    ControladorClasse.nomeClasseController.text = "";
    ControladorClasse.valorClasseController.text = "";
    operacao = "Enviar";
  }


}