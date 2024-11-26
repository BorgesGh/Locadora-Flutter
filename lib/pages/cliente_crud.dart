import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/model/Cliente.dart';
import 'package:locadora_dw2/pages/interation_control/cliente_interation_control.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluentui;
import 'package:locadora_dw2/widgets/MeuScaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locadora_dw2/widgets/toast.dart';

class ClienteCrud extends StatefulWidget {
  const ClienteCrud({super.key});

  @override
  State<ClienteCrud> createState() => _ClienteCrudState();
}

class _ClienteCrudState extends State<ClienteCrud> {
  late ClienteInterationControl _control;

  @override
  void initState() {
    super.initState();
    _control = ClienteInterationControl();
    _control.getClientes();
  }

  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: "Cliente",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40, top: 20, right: 40),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: fluentui.Colors.grey[110]),
                borderRadius: BorderRadius.circular(25)),
            child: Form(
              key: _control.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  fluentui.InfoLabel(
                    label: 'Nome:',
                    child: fluentui.TextBox(
                      controller: _control.nomeControl,
                      keyboardType: TextInputType.text,
                      placeholder: 'João Ricardo...',
                    ),
                  ),
                  const SizedBox(height: 10),
                  fluentui.InfoLabel(
                    label: 'Número de Inscrição:',
                    isHeader: true,
                    child: fluentui.TextBox(
                      controller: _control.numIscricaoControl,
                      keyboardType: TextInputType.number,
                      placeholder: '123456...',
                    ),
                  ),
                  const SizedBox(height: 10),
                  fluentui.InfoLabel(
                    label: "Sexo:",
                    child: fluentui.ComboBox<String>(
                      value: _control.sexoControl.text.isEmpty
                          ? null
                          : _control.sexoControl.text,
                      placeholder: _control.sexoControl.text.isEmpty
                          ? const Text('Sexo')
                          : Text(_control.sexoControl.text),
                      onChanged: (String? value) {
                        setState(() {
                          _control.sexoControl.text = value!;
                        });
                      },
                      items: _control
                          .getSexo()
                          .map((sexo) => fluentui.ComboBoxItem<String>(
                                value: sexo,
                                child: Text(sexo),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  fluentui.InfoLabel(
                    label: 'Data de Nascimento:',
                    isHeader: true,
                    child: fluentui.DatePicker(
                      selected: _control.dataNascimentoControl,
                      onChanged: (value) {
                        setState(() {
                          _control.dataNascimentoControl = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  fluentui.InfoLabel(
                    label: "Status do Cliente",
                    child: fluentui.ToggleSwitch(
                      checked: _control.estahAtivoControl,
                      onChanged: (value) {
                        setState(() {
                          _control.estahAtivoControl = value;
                        });
                      },
                      content: _control.estahAtivoControl
                          ? const Text('Ativo')
                          : const Text('Inativo'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          fluentui.Button(
            onPressed: () async {
              final response;

              if (_control.idController != -1) {
                response = await _control.atualizar();
              } else {
                response = await _control.inserir();
              }

              if (response.sucesso) {
                Toast.mensagemSucesso(
                    context: context, titulo: "Cliente inserido com sucesso!");
              } else {
                Toast.mensagemErro(
                    context: context,
                    titulo: "Erro ao inserir cliente!",
                    description: response.mensagemErro.toString());
              }
              setState(() {
                _control.idController = -1;
              });
            },
            child: _control.idController == -1
                ? const Text('Inserir')
                : const Text('Editar'),
          ),
          SizedBox(height: 20),
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: StreamBuilder<List<Cliente>>(
                  stream: _control.fluxo,
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

                    _control.clientes = snapshot.data!;

                    return DataTable(
                      columnSpacing: 2,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            overflow: TextOverflow.ellipsis,
                            "Nome",
                            style: TextStyle(fontSize: 18),
                          ),
                          headingRowAlignment: MainAxisAlignment.center,
                        ),
                        DataColumn(
                          label: Text(
                            "Numero de Inscrição",
                            style: TextStyle(fontSize: 18),
                          ),
                          headingRowAlignment: MainAxisAlignment.center,
                        ),
                        DataColumn(
                          label: Text(
                            overflow: TextOverflow.ellipsis,
                            "Data de Nascimento",
                            style: TextStyle(fontSize: 18),
                          ),
                          headingRowAlignment: MainAxisAlignment.center,
                        ),
                        DataColumn(
                          label: Text(
                            overflow: TextOverflow.ellipsis,
                            "Sexo",
                            style: TextStyle(fontSize: 18),
                          ),
                          headingRowAlignment: MainAxisAlignment.center,
                        ),
                        DataColumn(
                          label: Text(
                            overflow: TextOverflow.ellipsis,
                            "Status",
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
                      rows: _control.clientes.map((Cliente elemento) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Row(
                                children: [
                                  Text(elemento.nome),
                                ],
                              ),
                            ),
                            DataCell(Row(
                              children: [
                                Text(elemento.numInscricao.toString()),
                              ],
                            )),
                            DataCell(Row(
                              children: [
                                Text(elemento.dataNascimento.toString()),
                              ],
                            )),
                            DataCell(Row(
                              children: [
                                Text(elemento.sexo.toString()),
                              ],
                            )),
                            DataCell(Row(
                              children: [
                                Text(elemento.estahAtivo ? "Ativo" : "Inativo"),
                              ],
                            )),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _control.editarCliente(elemento);
                                      setState(() {
                                        _control.idController =
                                            elemento.idCliente!;
                                      });
                                    },
                                    color: Colors.blue,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      final response = await _control
                                          .deletarCliente(elemento);
                                      if (response.sucesso) {
                                        Toast.mensagemSucesso(
                                            titulo: "Excluido com sucesso!",
                                            context: context);

                                        setState(() {
                                          if (_control.idController ==
                                              elemento.idCliente) {
                                            _control.limparCampos();
                                          }
                                          _control.clientes.remove(elemento);
                                        });
                                      } else {
                                        Toast.mensagemErro(
                                            titulo: "Erro ao apagar o Ator",
                                            description:
                                                "Esse elemento já está relacionado com outro...",
                                            context: context);
                                      }
                                    },
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}
