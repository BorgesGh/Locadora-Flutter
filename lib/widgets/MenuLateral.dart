import 'package:flutter/material.dart';
import 'package:locadora_dw2/routes.dart';
import 'package:go_router/go_router.dart';
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
              AssetImage("assets/icons/ator_128.png"),
            ),

            title: const Text('Ator'),
            onTap: () {
              context.goNamed(Routes.Ator.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Classe'),
            onTap: () {
              context.goNamed(Routes.Classe.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Diretor'),
            onTap: () {
              context.goNamed(Routes.Diretor.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_card_outlined),
            title: const Text('Titulo'),
            onTap: () {
              context.goNamed(Routes.Titulo.name);
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text("Item"),
            onTap: () {
              context.goNamed(Routes.Item.name);
            },
          )
        ],
      ),
    );
  }
}