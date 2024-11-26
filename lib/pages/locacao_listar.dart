import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/routes.dart';
import 'package:locadora_dw2/widgets/MeuScaffold.dart';

class LocacaoListar extends StatefulWidget {
  const LocacaoListar({super.key});

  @override
  State<LocacaoListar> createState() => _LocacaoListarState();
}

class _LocacaoListarState extends State<LocacaoListar> {

  List<String> columns = ["Cliente", "Item", "Data Locação", "Data Devolução", "Ações"];

  @override
  Widget build(BuildContext context) {
    return MeuScaffold(
      texto: 'Locações',
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          // context.pushNamed(Routes.Item.name);
        },
        child: const Icon(Icons.add),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(15),
                child: DataTable(
                  border: const TableBorder(bottom: BorderSide(width: 1)),
                    columns: columns.map((elemento) =>
                        DataColumn(label: Text(elemento),headingRowAlignment: MainAxisAlignment.center)).toList(),
                    rows: <DataRow>
                    [
                      DataRow(
                          cells: <DataCell>[
                            DataCell(Text("Cliente 1")),
                            DataCell(Text("Item 1")),
                            DataCell(Text("01/01/2021")),
                            DataCell(Text("01/02/2021")),
                            DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: (){
                                        // context.pushNamed(Routes.Item.name);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: (){
                                        // context.pushNamed(Routes.Item.name);
                                      },
                                    )
                                  ],
                                )
                            )
                          ]
                      )
                    ]
                )
            )
          ],
        ),
      ),
    );
  }
}
