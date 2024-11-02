import 'package:flutter/cupertino.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class ComboBoxAsync<T> extends StatefulWidget {

  Stream<List<T>> stream;
  List items;
  T? selected;
  void Function(dynamic)? onChange;
  String placeHolder;
  String label;


  ComboBoxAsync({
  super.key,
  required this.stream,
  required this.items,
  required this.selected,
  required this.onChange,
  required this.placeHolder,
  required this.label
  });

  @override
  State<ComboBoxAsync<T>> createState() => _ComboBoxAsyncState<T>();
}

class _ComboBoxAsyncState<T> extends State<ComboBoxAsync<T>> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<List<dynamic>>(
              stream:  widget.stream,
              builder: (context, snapshot) {
                final elementos = snapshot.data;

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Container(
                    padding: const EdgeInsets.all(5),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.label,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Expanded(
                          child:ComboBox(
                            value: widget.selected ,
                            items: const [],
                            placeholder: const CircularProgressIndicator(),
                            )
                        )
                      ]
                    )
                  );
                }

                if(snapshot.hasError){
                  return const ComboBox(
                    items: [],
                    placeholder: Text("ERRRO AO CARREGAR!"),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(5),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.label,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20),
                      ),
                      Expanded(
                        child: ComboBox<T>(
                          isExpanded: true,
                          placeholder: Text(widget.placeHolder),
                          value: widget.selected,
                          items: elementos?.map((elemento) {
                            return ComboBoxItem<T>(
                              value: elemento,
                              child: Text(elemento.toString()),
                            );
                          }).toList(),
                          onChanged: widget.onChange
                        )
                      )
                    ]
                  )
                );
              }
          );
  }
}
