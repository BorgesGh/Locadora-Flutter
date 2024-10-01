
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorAtor.dart';
import 'package:locadora_dw2/model/Ator.dart';
import 'package:locadora_dw2/widgets/MeuScaffold.dart';
import 'package:locadora_dw2/widgets/Botao.dart';
import 'package:locadora_dw2/widgets/FormArea.dart';

class AtorCRUD extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _StateAtorCRUD();


}

class _StateAtorCRUD extends State<AtorCRUD>{

  List<Ator> atores = ControladorAtor.atores;

  double space = 10.0;

  String operacao = "Enviar";

  final formKey = GlobalKey<FormState>();

  final nomeAtorController = TextEditingController();
  int idController = 0;

  @override
  void initState(){
    super.initState();
    //Carregar a lista de Atores...
  }

  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
       texto: "Cadastro de Ator",
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
                      FormArea("Nome do ator",
                        tipo: TextInputType.text,
                        controlador: nomeAtorController,
                      ),
                      SizedBox(height: space),
                      Botao(
                       ao_clicar: (){
                          if(formKey.currentState!.validate()){

                            if(operacao == "Enviar"){
                              setState(() {
                                ControladorAtor.inserirAtor(nome: nomeAtorController.text, id: 5);
                              });
                              nomeAtorController.text = "";
                            }
                            else{
                              setState(() {
                                ControladorAtor.editarAtor(novoNome: nomeAtorController.text, id: idController);
                                operacao = "Enviar";
                              });
                              nomeAtorController.text = "";
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
             width: 300,
             child: DataTable(
               border: TableBorder.all(
                   width: 1,
                   color: Colors.black),

               columns: const <DataColumn>[
                 DataColumn(
                   label: Text("Nome Ator",
                     style: TextStyle(
                       fontSize: 18,
                     ),
                   ),
                   headingRowAlignment: MainAxisAlignment.center
                 ),
               ],

               rows: atores.map((Ator elemento) {
                 return DataRow(
                   cells: [
                     DataCell(
                       Text(elemento.nome),
                       showEditIcon: true,
                       onTap: (){
                         nomeAtorController.text = elemento.nome;
                         idController = elemento.id;
                         setState(() {
                           operacao = "Editar";

                         });
                       }

                       // Fazer um Ontap que ao clicar sobre o elemento.
                     ),  // Supondo que 'nome' seja um atributo de 'Ator'
                   ],
                 );
               }).toList(),
             ),
           )
         ],
       ),
    );

  }

}