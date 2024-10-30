import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComboBox<T> extends StatefulWidget {
  T selected;
  List<T> items = [];
  String textoDica;

  ComboBox({super.key, required this.selected, required this.items, required this.textoDica});

  @override
  State<ComboBox> createState() => _ComboBoxState();
}

class _ComboBoxState extends State<ComboBox> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        hint: Text(widget.textoDica),
        value: widget.items.first,

        onChanged: (Object? selected) {
          setState(() {
            widget.selected = selected;
          });
        },

        items: widget.items.map<DropdownMenuItem<Object>>((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value.toString()),
          );

       }).toList(),

    );
  }
}
