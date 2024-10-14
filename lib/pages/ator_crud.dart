import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorAtor.dart';
import 'package:locadora_dw2/model/Ator.dart';
import 'package:locadora_dw2/utils/ResponseEntity.dart';
import 'package:locadora_dw2/widgets/MeuScaffold.dart';
import 'package:locadora_dw2/widgets/Botao.dart';
import 'package:locadora_dw2/widgets/FormArea.dart';
import 'package:locadora_dw2/widgets/toast.dart';

class AtorCRUD extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _StateAtorCRUD();


}

class _StateAtorCRUD extends State<AtorCRUD>{

  final _controladorAtor = ControladorAtor();

  late List<Ator> atores;
  double space = 10.0;

  String operacao = "Enviar";

  final formKey = GlobalKey<FormState>();

  final nomeAtorController = TextEditingController();
  int idController = -1;

  @override
  void initState(){
    super.initState();
    _controladorAtor.getAtores();
  }


  @override
  void dispose() {
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
                                _controladorAtor.inserirAtor(nome: nomeAtorController.text);
                              });
                              nomeAtorController.text = "";
                            }
                            else{
                              setState(() {
                                try {
                                  _controladorAtor.editarAtor(
                                      novoNome: nomeAtorController.text,
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
               stream: _controladorAtor.fluxo,
               builder: (context, snapshot) {

                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return CircularProgressIndicator(); // Mostra um indicador de carregamento
                 }
                 if(snapshot.data?.resultado == null){
                   return const Center(child: Text("Erro ao acessar o Backend!"));

                 }

                 if (snapshot.hasError) {
                   return Text('Erro ao carregar atores'); // Tratamento de erro
                 }
                 if(!snapshot.hasData){
                   atores = [];
                 }

                 if (snapshot.hasData && operacao != "Editar") {
                   ResponseEntity response = snapshot.data!;
                   if(response.resultado is List){
                     print("StreamBuilder: Era uma lista!");
                     atores = response.resultado;

                   } else {
                     print("StreamBuilder: Era um elemento!");

                     // Verifique se o ator já existe na lista antes de adicionar
                     Ator novoAtor = response.resultado;
                     bool atorJaExiste = atores.any((ator) => ator.id == novoAtor.id);

                     if (idController != -1) {
                       // Substituir o ator editado na lista
                       atores[idController] = novoAtor;

                     } else if(!atorJaExiste) {
                       // Adicionar um novo ator se não estiver na lista
                       atores.add(novoAtor);
                     }
                   }

                   // response.resultado is List ? atores = response.resultado : atores.add(response.resultado) ;
                   // Atualiza a lista de atores
                 }
                 print("StreamBuilder: ${snapshot.data!.resultado}");

                 return DataTable(
                   border: TableBorder(
                     borderRadius: BorderRadius.circular(10),
                   ),
                   headingRowColor: const WidgetStatePropertyAll(Colors.white),
                   decoration: const BoxDecoration(
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black,
                         blurRadius: 10,
                         offset: Offset(4, 6),
                       )
                     ]
                   ),
                   columns: const <DataColumn>[
                     DataColumn(
                       label: Text(
                         "Nome Ator",
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
                   rows: atores.map((Ator elemento) {
                     return DataRow(
                       color: const WidgetStatePropertyAll(Colors.white),
                       cells: [
                         DataCell(
                           Row(
                             children: [
                               Text(elemento.nome),
                             ],
                           ),
                           onTap: () {
                             nomeAtorController.text = elemento.nome;
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
                                 atores.remove(elemento);
                                 _controladorAtor.excluirAtor(elemento);
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
    nomeAtorController.text = "";
    operacao = "Enviar";
  }


}