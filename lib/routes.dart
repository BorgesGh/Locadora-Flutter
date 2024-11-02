import 'package:go_router/go_router.dart';
import 'package:locadora_dw2/pages/ator_crud.dart';
import 'package:locadora_dw2/pages/classe_crud.dart';
import 'package:locadora_dw2/pages/diretor_crud.dart';
import 'package:locadora_dw2/pages/home_page.dart';
import 'package:locadora_dw2/pages/titulo_crud.dart';

enum Routes{
  Home,
  Ator,
  Diretor,
  Classe,
  Titulo
}

GoRouter goRouter(){
  return GoRouter(
    initialLocation: "/titulo",

      routes: <RouteBase>[
        GoRoute(
          path: "/home",
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
          builder: (context, state) => TituloCRUD(),
          // builder: (context, state) => const TituloCrud(),
        )
      ]
  );
}