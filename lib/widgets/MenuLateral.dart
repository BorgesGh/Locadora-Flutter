import 'package:flutter/material.dart';
import '../utils/CONSTANTES.dart';

class MenuLateral extends StatelessWidget{
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: CONSTANTES.BEGE,
            ),
            child: Text(
              'Menu de Opções',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const ImageIcon(
              AssetImage("icons/ator_128.png"),
            ),

            title: const Text('Ator'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/ator");
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Classe'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/classe");
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Diretor'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/diretor");
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Titulo'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.of(context).pushNamed("/titulo");
            },
          ),
        ],
      ),
    );
  }
}