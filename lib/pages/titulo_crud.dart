import 'package:flutter/material.dart';
import 'package:locadora_dw2/model/Diretor.dart';
import 'package:locadora_dw2/widgets/FormAreaNumeros.dart';
import 'package:locadora_dw2/widgets/local/ComboBoxAsync.dart';
import 'package:locadora_dw2/widgets/toast.dart';
import '../controle/ControladorTitulo.dart';
import '../model/Ator.dart';
import '../model/Classe.dart';
import '../model/Titulo.dart';
import '../widgets/Botao.dart';
import '../widgets/FormArea.dart';
import '../widgets/MeuScaffold.dart';
import "package:fluent_ui/fluent_ui.dart";
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/cupertino.dart';

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
            Form(
              key: _controladorTitulo.formKey,

              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(15)

                ),
                height: 300,
                margin: const EdgeInsets.only(top: 10,left: 65,right: 65),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Expanded(

                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10,right: 10),

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
                                    child: ComboBoxAsync<Diretor>(
                                        stream: _controladorTitulo.streamDiretor.stream,
                                        items: _controladorTitulo.diretorController.diretores,
                                        selected: _controladorTitulo.selectedDiretor,
                                        onChange: (selecionado) {
                                          setState(() {
                                            _controladorTitulo.selectedDiretor = selecionado;
                                          });
                                        },
                                        placeHolder: "Selecione um diretor...",
                                        label: "Diretor"
                                    )
                                  ),

                                  Flexible(
                                    child: ComboBoxAsync<Classe>(
                                      stream: _controladorTitulo.streamClasse.stream,
                                      items: _controladorTitulo.classeController.classes,
                                      selected: _controladorTitulo.selectedClasse,
                                      onChange: (selecionado) {
                                        setState(() {
                                          _controladorTitulo.selectedClasse = selecionado;
                                        });
                                      },
                                      placeHolder: "Selecione uma Classe...",
                                      label: "Classe"
                                    )
                                  ),

                                  Flexible(
                                    child: ComboBoxAsync<String>(
                                      stream: _controladorTitulo.streamCategoria.stream,
                                      items: _controladorTitulo.categorias,
                                      selected: _controladorTitulo.selectedCategoria,
                                      onChange: (selecionado) {
                                        setState(() {
                                          _controladorTitulo.selectedCategoria = selecionado;
                                        });
                                      },
                                      placeHolder: "Selecione uma Categoria...",
                                      label: "Categoria"
                                    )
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(

                                        child: StreamBuilder<List<Ator>>(
                                          stream: _controladorTitulo.streamAtores.stream,
                                          builder: (context, snapshot) {
                                            final elementos = snapshot.data;

                                            if(elementos == null){
                                              return const Text("Erro carregar atores...");
                                            }

                                            return MultiSelectDialogField<Ator>(
                                              validator: (selecionados) {
                                                if(selecionados == null){
                                                  return "Selecione ao menos 1 ator!";
                                                }
                                              },


                                              searchable: true,
                                              items: elementos.map((Ator ator) {
                                                return MultiSelectItem(
                                                    ator,
                                                    ator.nome,
                                                );
                                              }).toList(),
                                              onConfirm: ( confirmeds ) {
                                                _controladorTitulo.selectedAtors = confirmeds;
                                              },
                                              initialValue: [],
                                              buttonText: const Text("Selecione os Atores",overflow: TextOverflow.ellipsis,),
                                              title: const Text("Atores"),
                                            );
                                          }
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: space),
            Botao(
                ao_clicar: (){
                  if(_controladorTitulo.formKey.currentState!.validate() && validarCampos(context)){
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
                        limparNomeEResetarBotao();
                      });
                    }
                    else{
                      setState(() {
                        try {
                          _controladorTitulo.editarTitulo(
                              titulo:Titulo(
                                  idTitulo: _controladorTitulo.idController,
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
                        limparNomeEResetarBotao();
                      });
                      _controladorTitulo.idController = -1;
                    }
                  }
                },
                texto: Text(_controladorTitulo.operationController.toString())
            ),


          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(

                children: [
                  Expanded(

                    child: StreamBuilder<List<Titulo>>(
                        stream: _controladorTitulo.fluxo,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Mostra um indicador de carregamento
                          }

                          if (snapshot.hasError) {
                            return const Text('Erro ao carregar Titulos'); // Tratamento de erro
                          }

                          if (!snapshot.hasData) {
                            return const Center(child: Text("Erro ao acessar o Backend!"));
                          }

                          _controladorTitulo.titulos = snapshot.data!;

                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                dataRowMaxHeight: 100,
                                columns: _controladorTitulo.getColluns().map((col) {
                                  return DataColumn(
                                      label: Text(col,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      headingRowAlignment: MainAxisAlignment.center
                                  );
                                }).toList(),

                                rows:_controladorTitulo.titulos.map((titulo) {
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Row(children: [Text(titulo.nome)]),
                                              showEditIcon: true,
                                              onTap: (){
                                                setState(() {
                                                  _controladorTitulo.idController = titulo.idTitulo;
                                                  _controladorTitulo.nameTituloController.text = titulo.nome;
                                                  _controladorTitulo.yearController.text = titulo.ano.toString();
                                                  _controladorTitulo.sinopseController.text = titulo.sinopse;

                                                  _controladorTitulo.selectedCategoria = titulo.categoria;
                                                  _controladorTitulo.selectedClasse = titulo.classe;
                                                  _controladorTitulo.selectedDiretor = titulo.diretor;
                                                  _controladorTitulo.selectedAtors = titulo.atores;

                                                  _controladorTitulo.operationController = Operacoes.Editar.name;
                                                });
                                              }
                                            ),
                                            DataCell(
                                              Text(titulo.ano.toString())
                                            ),
                                            DataCell(
                                              Container(

                                                child: Text(titulo.sinopse),
                                                width: 100,
                                              )
                                            ),
                                            DataCell(
                                              Text(titulo.diretor.nome),
                                            ),
                                            DataCell(
                                              Text(titulo.classe.nome),
                                            ),
                                            DataCell(
                                              Text(titulo.categoria),
                                            ),
                                            DataCell(
                                              Wrap(
                                                children: titulo.atores.map((ator) => Text("${ator.nome}, ")).toList(),
                                              )
                                            ),
                                            DataCell(
                                              Botao(
                                                ao_clicar: () async {
                                                  final response = await _controladorTitulo.excluirTitulo(titulo);

                                                  if(response.sucesso){
                                                    setState(() {
                                                      if (_controladorTitulo.idController == titulo.idTitulo) {
                                                        limparNomeEResetarBotao();
                                                      }
                                                      _controladorTitulo.titulos.remove(titulo);
                                                      Toast.mensagemSucesso(titulo: "Excluido com sucesso!", context: context);
                                                    });
                                                  }
                                                  else{
                                                    Toast.mensagemErro(context: context, titulo: "Erro ao deletar titulo", description: "O titulo atual já faz parte de um item");
                                                  }
                                                },
                                                texto: const Text("Excluir"),
                                                cor: const Color(12233333),
                                              ),
                                            ),
                                          ]
                                        );
                                      }).toList(),
                              ),
                            ),
                          );
                      }
                    )
                  )
                ],
              ),
            ),
          ]
        )
      )
    );
  }

  void limparNomeEResetarBotao(){
    _controladorTitulo.nameTituloController.text = "";
    _controladorTitulo.operationController = Operacoes.Enviar.name;

    _controladorTitulo.selectedAtors == [];
    _controladorTitulo.selectedDiretor == null;
    _controladorTitulo.selectedCategoria == null;
    _controladorTitulo.selectedClasse == null;
  }

  bool validarCampos(BuildContext context){
    if(_controladorTitulo.selectedAtors == [] ||
        _controladorTitulo.selectedDiretor == null ||
        _controladorTitulo.selectedCategoria == null ||
        _controladorTitulo.selectedClasse == null
    ){
      Toast.mensagemErro(context: context,titulo: "Algum campo não foi selecionado!!",description: "Verifique se todos os campos no formulário foram preenchidos");
      return false;
    }
    return true;
  }
}



