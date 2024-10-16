

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorClasse.dart';

import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class BotaoData extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _BotaoDataSate(streamDate,controladorDate);


  BotaoData({required this.controladorDate, this.streamDate, super.key});

  TextEditingController controladorDate;
  final streamDate;

  static String formatarDateTime(DateTime diaHora){
    return "${diaHora.day}/${diaHora.month}/${diaHora.year}";
  }

}

class _BotaoDataSate extends State<BotaoData>{

  _BotaoDataSate(this._streamDate, this.controladorDate);

  StreamController<DateTime> _streamDate;
  TextEditingController controladorDate;

  DateTime? diaHora;
  DateTime? horaEscolhida;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<DateTime>(
      stream: _streamDate.stream,
      initialData: DateTime.now(),

      builder: (context, snapshot) {

        if(horaEscolhida == null) {
          diaHora = snapshot.data;
          controladorDate.text = diaHora.toString();
        }

        return ElevatedButton(
            onPressed: () async {

              diaHora = (await showOmniDateTimePicker(
                context: context,
                initialDate: DateTime.now(),
                type: OmniDateTimePickerType.date,
                firstDate: DateTime.now(),

              ));

              controladorDate.text = diaHora.toString();

              setState(() {
                horaEscolhida = diaHora;
              });


            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(BotaoData.formatarDateTime(diaHora!)),
                ),
                const Flexible(
                  flex: 1,
                  child: Icon(Icons.calendar_month_outlined))
              ],
            ),
        );
      }
    );
  }



}