import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.busca.bloc.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.favorite.bloc.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.home.bloc.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.lista.bloc.dart';
import 'package:yamete_kudasai/screens/home.animes.page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: HomeBloc(),
        child: BlocProvider(
          bloc: ListaBloc(),
          child: BlocProvider(
            bloc: BuscaBloc(),
            child: BlocProvider(
              bloc: FavoriteBloc(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                debugShowMaterialGrid: false,
                theme: ThemeData(
                  brightness: Brightness.dark,
                ),
                home: HomeAnimesPage(),
              ),
            ),
          ),
        ));
  }
}
