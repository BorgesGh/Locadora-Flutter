

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:locadora_dw2/controle/ControladorClasse.dart';

import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class BotaoData extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _BotaoDataSate(controladorDate);

  BotaoData(this.controladorDate, {super.key});

  TextEditingController controladorDate;

}
class _BotaoDataSate extends State<BotaoData>{

  DateTime? diaHora;
  TextEditingController controladorDate;

  _BotaoDataSate(this.controladorDate){
    diaHora = DateTime.now();
    controladorDate.text = diaHora.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {

          diaHora = (await showOmniDateTimePicker(
            context: context,
            initialDate: DateTime.now(),
            type: OmniDateTimePickerType.date,

          ));

          diaHora ??= DateTime.now();

          setState((){
            controladorDate.text = diaHora.toString();

          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Text(ControladorClasse.formatarDateTime(diaHora!)),
            ),
            const Flexible(
              flex: 1,
              child: Icon(Icons.calendar_month_outlined))
          ],
        ),
    );
  }

}