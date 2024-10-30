import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/widgets/ComboBox.dart';
import 'package:locadora_dw2/widgets/toast.dart';
import '../controle/ControladorTitulo.dart';
import '../model/Titulo.dart';
import '../widgets/Botao.dart';
import '../widgets/FormArea.dart';
import '../widgets/MeuScaffold.dart';

class TituloCRUD extends StatefulWidget{
  const TituloCRUD({super.key});

  @override
  State<StatefulWidget> createState() => _DireitorCRUDState();
}

class _DireitorCRUDState extends State<TituloCRUD>{

  final _controladorTitulo = ControladorTitulo();

  double space = 10.0;

  @override
  void initState(){
    super.initState();
    _controladorTitulo.getTitulos();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: "Cadastro de Titulo",
      body: SingleChildScrollView(
        child: Column(

        children: [
          Form(
            key: _controladorTitulo.formKey,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 50,right: 50),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Column(

                        children: [
                          FormArea("Nome do Titulo",
                            tipo: TextInputType.text,
                            controlador: _controladorTitulo.nameTituloController,
                          ),
                          FormArea("Ano",
                            tipo: TextInputType.number,
                            controlador: _controladorTitulo.yearController,
                          ),
                          FormArea("Sinopse",
                            tipo: TextInputType.text,
                            controlador: _controladorTitulo.sinopseController,
                          ),
                        ],
                      ),

                      Column(

                        children: [
                          ComboBox( // Não vai ser uma comboBox... Vai ser lista!
                            textoDica: "Escolha um Ator",
                            selected: _controladorTitulo.selectedAtors,
                            items: _controladorTitulo.atores
                          ),
                          ComboBox(
                              textoDica: "Escolha um Diretor",
                              selected: _controladorTitulo.selectedDiretor,
                              items: _controladorTitulo.diretores
                          ),

                          ComboBox(
                              textoDica: "Escolha uma Classe",
                              selected: _controladorTitulo.selectedClasse,
                              items: _controladorTitulo.classes
                          ),
                        ],
                      ),

                      SizedBox(height: space),
                      Botao(
                          ao_clicar: (){
                            if(_controladorTitulo.formKey.currentState!.validate()){

                              if(Operacoes.Enviar.name == _controladorTitulo.operationController){
                                setState(() {
                                  _controladorTitulo.inserirTitulo(
                                      tituloNew: Titulo(
                                          nome: _controladorTitulo.nameTituloController.text,
                                          ano: int.parse(_controladorTitulo.yearController.text),
                                          sinopse: _controladorTitulo.sinopseController.text,

                                          categoria: _controladorTitulo.selectedCategoria!,
                                          diretor: _controladorTitulo.selectedDiretor!,
                                          classe: _controladorTitulo.selectedClasse!,
                                          atores: _controladorTitulo.selectedAtors!
                                      )
                                  );
                                });
                              }
                              else{
                                setState(() {
                                  try {
                                    _controladorTitulo.editarTitulo(
                                        titulo:Titulo(
                                          id: _controladorTitulo.idController,
                                          nome: _controladorTitulo.nameTituloController.text,
                                          ano: int.parse(_controladorTitulo.yearController.text),
                                          sinopse: _controladorTitulo.sinopseController.text,

                                          categoria: _controladorTitulo.selectedCategoria!,
                                          diretor: _controladorTitulo.selectedDiretor!,
                                          classe: _controladorTitulo.selectedClasse!,
                                          atores: _controladorTitulo.selectedAtors!
                                      )
                                    );
                                    limparNomeEResetarBotao();
                                    Toast.mensagemSucesso(titulo: "Editado com sucesso!", context: context);
                                  } on Exception catch (erro){
                                    Toast.mensagemErro(titulo: "Ocorreu um erro ao editar: ${erro.toString()}", context: context);
                                  }
                                });
                                _controladorTitulo.idController = -1;
                              }
                            }
                          },
                          texto: Text(_controladorTitulo.operationController.toString())
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: space),


          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: StreamBuilder<List<Titulo>>(
              stream: _controladorTitulo.fluxo,
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Mostra um indicador de carregamento
                }

                if (snapshot.hasError) {
                  return Text('Erro ao carregar Diretores'); // Tratamento de erro
                }

                if(!snapshot.hasData){
                  return const Center(child: Text("Erro ao acessar o Backend!"));
                }

                _controladorTitulo.titulos = snapshot.data!;

                return DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        "Nome Titulo",
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
                  rows: _controladorTitulo.titulos.map((Titulo elemento) {
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
    ),
    );

  }

  void limparNomeEResetarBotao(){
    nomeDiretorController.text = "";
    operacao = "Enviar";
  }
}



