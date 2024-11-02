import 'package:flutter/material.dart';
import 'package:locadora_dw2/model/Diretor.dart';
import 'package:locadora_dw2/widgets/FormAreaNumeros.dart';
import 'package:locadora_dw2/widgets/toast.dart';
import '../controle/ControladorTitulo.dart';
import '../model/Ator.dart';
import '../model/Titulo.dart';
import '../widgets/Botao.dart';
import '../widgets/FormArea.dart';
import '../widgets/MeuScaffold.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class TituloCRUD extends StatefulWidget{

  const TituloCRUD({super.key});

  @override
  State<StatefulWidget> createState() => _TituloCRUDState();
}

class _TituloCRUDState extends State<TituloCRUD>{
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
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1)
        ),
        margin: const EdgeInsets.only(top: 20,left: 15,right: 15),
        child: Column(

          children: [
            Flexible(
              child: Form(
                key: _controladorTitulo.formKey,

                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1)
                  ),
                  height: 300,
                  margin: const EdgeInsets.only(top: 10,left: 15,right: 15),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Expanded(

                        child: Container(
                          margin: const EdgeInsets.only(top: 30, left: 10,right: 10),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                                  children: [
                                    FormArea("Nome do Titulo",
                                      tipo: TextInputType.text,
                                      controlador: _controladorTitulo.nameTituloController,
                                    ),
                                    FormAreaNumeros("Ano",
                                      tipo: TextInputType.number,
                                      controlador: _controladorTitulo.yearController,
                                    ),
                                    FormArea("Sinopse",
                                      tipo: TextInputType.text,
                                      controlador: _controladorTitulo.sinopseController,
                                    ),
                                  ],
                                ),
                              ),

                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    Flexible(
                                      child: ComboBox(
                                        items: _controladorTitulo.diretores.map((Diretor elemento) {
                                          return ComboBoxItem<Diretor>(
                                            value: elemento,
                                            child: Text(elemento.nome),
                                          );
                                        }).toList(),
                                      ),
                                    ),

                                    Flexible(
                                      child: ComboBox(
                                        items: _controladorTitulo.titulos.map((Titulo elemento) {
                                          return ComboBoxItem<Titulo>(
                                            value: elemento,
                                            child: Text(elemento.nome),
                                          );
                                        }).toList(),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: MultiSelectDialogField(
                                    searchable: true,
                                    items: _controladorTitulo.atores.map((Ator ator) {
                                      return MultiSelectItem(
                                          ator,
                                          ator.nome
                                      );
                                    }).toList(),
                                    onConfirm: ( confirmeds ) {
                                      _controladorTitulo.selectedAtors = confirmeds as List<Ator>;
                                    },
                                    initialValue: [], 
                                    buttonText: const Text("Selecione os Atores"),
                                    title: const Text("Atores"),
                                  ),
                                )
                              ),

                              SizedBox(height: space),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Botao(
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
            ),
          ],
        ),
      ),
  );

  }

  void limparNomeEResetarBotao(){
    _controladorTitulo.nameTituloController.text = "";
    _controladorTitulo.operationController = Operacoes.Enviar.name;
  }
}



