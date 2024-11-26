import 'package:go_router/go_router.dart';
import 'package:locadora_dw2/pages/ator_crud.dart';
import 'package:locadora_dw2/pages/classe_crud.dart';
import 'package:locadora_dw2/pages/cliente_crud.dart';
import 'package:locadora_dw2/pages/diretor_crud.dart';
import 'package:locadora_dw2/pages/home_page.dart';
import 'package:locadora_dw2/pages/item_crud.dart';
import 'package:locadora_dw2/pages/locacao_listar.dart';
import 'package:locadora_dw2/pages/titulo_crud.dart';

enum Routes{
  Classe,
  Home,
  Ator,
  Diretor,
  Titulo,
  Item,
  LocacaoListar,
  Cliente
}

GoRouter goRouter(){
  return GoRouter(
    initialLocation:"/cliente",

      routes: <RouteBase>[
        GoRoute(
          path: "/",
          name: Routes.Home.name,
          builder: (context, state) => HomePage(),
        ),
        GoRoute(
          path: "/ator",
          name: Routes.Ator.name,
          builder: (context, state) => AtorCRUD(),
        ),
        GoRoute(
          path: "/diretor",
          name: Routes.Diretor.name,
          builder: (context, state) => const DiretorCRUD(),
        ),
        GoRoute(
          path: "/classe",
          name: Routes.Classe.name,
          builder: (context, state) => ClasseCRUD(),
        ),
        GoRoute(
          path: "/titulo",
          name: Routes.Titulo.name,
          builder: (context, state) => const TituloCRUD(),
        ),
        GoRoute(
          path: "/item",
          name:Routes.Item.name,
          builder: (context, state) => const ItemCrud(),
        ),
        GoRoute(
          path: "/locacaoListar",
          name:Routes.LocacaoListar.name,
          builder: (context, state) => const LocacaoListar(),
        ),
        GoRoute(
            path: "/cliente",
            name:Routes.Cliente.name,
            builder: (context, state) =>  const ClienteCrud(),
        )
      ]
  );
}