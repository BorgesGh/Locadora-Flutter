import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorItem.dart';
import 'package:locadora_dw2/model/Item.dart';
import 'package:locadora_dw2/model/Titulo.dart';
import 'package:locadora_dw2/widgets/BotaoDate.dart';
import 'package:locadora_dw2/widgets/MeuScaffold.dart';
import "package:fluent_ui/fluent_ui.dart";
import 'package:locadora_dw2/widgets/local/ComboBoxAsync.dart';
import 'package:intl/intl.dart';
import '../widgets/Botao.dart';
import '../widgets/FormArea.dart';
import '../widgets/FormAreaNumeros.dart';
import '../widgets/toast.dart';

class ItemCrud extends StatefulWidget {
  const ItemCrud({super.key});

  @override
  State<ItemCrud> createState() => _ItemCrudState();
}

class _ItemCrudState extends State<ItemCrud> {
  final _controladorItem = ControladorItem();

  @override
  void initState() {
    super.initState();
    _controladorItem.getItems();
  }


  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: "Cadastro de Items",
      child: Container(
        margin: const EdgeInsets.only(top: 20,left: 15,right: 15),
        child: Column(
          children: [
            Form(
              key: _controladorItem.formKey,
              child: Container(
                height: 300,
                margin: const EdgeInsets.only(top: 10,left: 65,right: 65),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          FormAreaNumeros("Número de Serie",
                            tipo: TextInputType.number,
                            controlador: _controladorItem.numSerieController,
                          ),
                          DatePicker(
                            selected: _controladorItem.selectedDate,
                            header: "Data de Aquisição",
                            onChanged: (value) {
                              setState(() {
                                _controladorItem.selectedDate = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: ComboBoxAsync<Titulo>(
                              stream: _controladorItem.streamTitulo.stream,
                              items: _controladorItem.tituloController.titulos,
                              selected: _controladorItem.selectedTitulo,
                              onChange: (selected){
                                setState(() {
                                  _controladorItem.selectedTitulo = selected;
                                });
                              },
                              placeHolder: "Selecione um Título...",
                              label: "Titulo"
                            ),
                          ),
                          Flexible(
                            child: ComboBoxAsync<String>(
                              stream: _controladorItem.streamTipo.stream,
                              items: _controladorItem.tipos,
                              selected: _controladorItem.selectedTipo,
                              onChange: (selected) {
                                setState(() {
                                  _controladorItem.selectedTipo = selected;
                                });
                              },
                              placeHolder: "Selecione um Tipo...",
                              label: "Tipo",
                            ),
                          )
                        ],
                      )
                    )
                  ],
                ),
              )
            ),
            Botao(
                ao_clicar: (){
                  if(_controladorItem.formKey.currentState!.validate() && validarCampos(context)){
                    // validarCampos(context);
                    if(Operacoes.Enviar.name == _controladorItem.operationController){
                      setState(() {
                        _controladorItem.inserirItem(
                            itemNew: Item(
                              numSerie: int.parse(_controladorItem.numSerieController.text),
                              dataAquisicao: _controladorItem.selectedDate,
                              tipoItem: _controladorItem.selectedTipo!,
                              titulo: _controladorItem.selectedTitulo!
                            )
                        );
                        limparNomeEResetarBotao();
                      });
                    }
                    else{
                      setState(() {
                        try {
                          _controladorItem.editarItem(
                              item:Item(
                                idItem: _controladorItem.idController,
                                tipoItem: _controladorItem.selectedTipo!,
                                numSerie: int.parse(_controladorItem.numSerieController.text),
                                dataAquisicao: _controladorItem.selectedDate,
                                titulo: _controladorItem.selectedTitulo!
                              )
                          );
                          limparNomeEResetarBotao();
                          Toast.mensagemSucesso(titulo: "Editado com sucesso!", context: context);
                        } on Exception catch (erro){
                          Toast.mensagemErro(titulo: "Ocorreu um erro ao editar: ${erro.toString()}", context: context);
                        }
                        limparNomeEResetarBotao();
                      });
                      _controladorItem.idController = -1;
                    }
                  }
                },
                texto: Text(_controladorItem.operationController.toString())
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: StreamBuilder<List<Item>>(
                stream: _controladorItem.streamItem.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Mostra um indicador de carregamento
                  }

                  if (snapshot.hasError) {
                    return const Text(
                        'Erro ao carregar Classes'); // Tratamento de erro
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                        child: Text("Erro ao acessar o Backend!"));
                  }

                  _controladorItem.items = snapshot.data!;

                  return DataTable(
                    columns: _controladorItem.getColluns().map((coluna) {
                      return DataColumn(
                        label: Text(coluna,
                          style: const TextStyle(fontSize: 18),
                        ),
                          headingRowAlignment: MainAxisAlignment.center);
                    }).toList(),
                    rows:
                      _controladorItem.items.map((item) {
                        return DataRow(
                          cells: <DataCell>[
                            DataCell(
                              Text(item.numSerie.toString()),
                              onTap: (){
                                setState(() {
                                  _controladorItem.numSerieController.text = item.numSerie.toString();
                                  _controladorItem.selectedDate = item.dataAquisicao;
                                  _controladorItem.selectedTitulo = item.titulo;
                                  _controladorItem.selectedTipo = item.tipoItem;

                                  _controladorItem.idController = item.idItem!;
                                  _controladorItem.operationController = Operacoes.Editar.name;
                                });
                              },
                              showEditIcon: true

                            ),
                            DataCell(
                              Text(DateFormat('dd/MM/yyyy').format(item.dataAquisicao)) // Trocar formatação!!
                            ),
                            DataCell(
                              Text(item.tipoItem)
                            ),
                            DataCell(
                                Text(item.titulo.toString())
                            ),
                            DataCell(
                              Botao(
                                ao_clicar: () async {
                                  final response = await _controladorItem.excluirItem(item);

                                  if(response.sucesso) {
                                    setState(() {
                                      if (_controladorItem.idController == item.idItem) {
                                        limparNomeEResetarBotao();
                                      }
                                      Toast.mensagemSucesso(
                                          titulo: "Excluido com sucesso!",
                                          context: context);

                                      _controladorItem.items.remove(item);
                                    });
                                  }
                                  else{
                                    Toast.mensagemErro(context: context, titulo: "Erro ao deletar o item");
                                  }
                                },
                                texto: const Text("Excluir"),
                                cor: const Color(12233333),
                              ),
                            )
                          ]
                        );
                      }).toList()
                  );
                }
              )
            )
          ]
        )
      ),
    );
  }

  void limparNomeEResetarBotao(){
    _controladorItem.numSerieController.text = "";
    _controladorItem.operationController = Operacoes.Enviar.name;

    _controladorItem.selectedDate = DateTime.now();
    _controladorItem.selectedTipo = null;
    _controladorItem.selectedTitulo = null;
  }

  bool validarCampos(BuildContext context){
    if(_controladorItem.selectedTipo == null ||
        _controladorItem.selectedTitulo == null
    ){
      Toast.mensagemErro(context: context,titulo: "Algum campo não foi selecionado!!",description: "Verifique se todos os campos no formulário foram preenchidos");
      return false;
    }
    return true;
  }
}
