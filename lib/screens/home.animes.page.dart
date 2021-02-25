import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.favorite.bloc.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.home.bloc.dart';
import 'package:yamete_kudasai/blocs/delegates/busca.delegate.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import 'package:yamete_kudasai/screens/favoritos.page.dart';
import 'package:yamete_kudasai/screens/todos.animes.page.dart';
import 'package:yamete_kudasai/screens/widgets/home.widgets.dart';

class HomeAnimesPage extends StatelessWidget {
  const HomeAnimesPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        Align(
          alignment: Alignment.center,
          child: StreamBuilder<Map<String, DetalheAnime>>(
            initialData: {},
            stream: BlocProvider.of<FavoriteBloc>(context).outFav,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.length.toString());
              } else
                return Container();
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.star),
          onPressed: () {
            print('Navegando para os animes favoritos');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnimesFavoritosPage(),
              ),
            );
          },
        ),
        IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              print('Navegando para todos animes');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodosAnimesPage(),
                ),
              );
            }),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            await showSearch(
                context: context, delegate: BuscaDelegate());
          },
        ),
      ], title: Text('Home')),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _renderTitleSection('Mais Assistidos'),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .30,
                  margin: EdgeInsets.only(top: 10),
                  child: StreamBuilder<List<MaisAssistidos>>(
                    initialData: [],
                    stream: BlocProvider.of<HomeBloc>(context).outMore,
                    builder: (context, snapshot) {
                      if (snapshot.data.isNotEmpty) {
                        return MaisVisualizadosListWidget();
                      }
                      return Stack(
                        children: [LinearProgressIndicator()],
                      );
                    },
                  )),
              _renderTitleSection('Adicionados Recentemente'),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .30,
                  margin: EdgeInsets.only(top: 10),
                  child: StreamBuilder<List<Adicionados>>(
                    initialData: [],
                    stream: BlocProvider.of<HomeBloc>(context).outLan,
                    builder: (context, snapshot) {
                      if (snapshot.data.isNotEmpty) {
                        return AnimesRecenteListWidget();
                      }
                      return Stack(
                        children: [LinearProgressIndicator()],
                      );
                    },
                  )),
              _renderTitleSection('Episodios Recentes'),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .70,
                margin: EdgeInsets.only(top: 10),
                child: StreamBuilder<List<EpisodiosRecentes>>(
                  initialData: [],
                  stream: BlocProvider.of<HomeBloc>(context).outEps,
                  builder: (context, snapshot) {
                    if (snapshot.data.isNotEmpty) {
                      return EpisodiosRecentesListWidget();
                    }
                    return Stack(
                      children: [LinearProgressIndicator()],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_renderTitleSection(String t) {
  return Container(
    padding: EdgeInsets.only(left: 20, top: 15),
    child: Text(
      t,
      style: TextStyle(
        fontSize: 20,
        letterSpacing: 2,
        color: Colors.white,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}
