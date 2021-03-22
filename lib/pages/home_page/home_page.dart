import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/bloc/home_bloc/index.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'package:yamete_kudasai/pages/home_page/widgets/animes.widgets.dart';
import 'package:yamete_kudasai/pages/lista_page/lista_page.dub.dart';
import 'package:yamete_kudasai/pages/lista_page/lista_page.generos.dart';
import 'package:yamete_kudasai/pages/lista_page/lista_page.sub.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeOffline) {
        return Container(
          child: Center(
            child: Text('Parece que está sem internet'),
          ),
        );
      }
      if (state is HomeLoading) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is HomeLoaded) {
        print(state.animes.episodios[0].titulo);
        return SingleChildScrollView(
            child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text('DUBLADO'),
                  onPressed: () {
                    BlocProvider.of<ListaBloc>(context).add(LoadDub(letra: ''));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaPageDublados()));
                  },
                ),
                TextButton(
                  child: Text('LEGENDADO'),
                  onPressed: () {
                    BlocProvider.of<ListaBloc>(context).add(LoadSub(letra: ''));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaPageLegendado()));
                  },
                ),
                TextButton(
                  child: Text('GÊNEROS'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaPageGeneros()));
                  },
                )
              ],
            ),
            TitleWidget(
              title: "Mais Assistidos",
            ),
            AnimesMaisAssistidosWidget(state: state.animes),
            TitleWidget(
              title: 'Adicionados Recentemente',
            ),
            AnimesAdicionadosWidget(state: state.animes),
            TitleWidget(
              title: "Episodios Recentes",
            ),
            EpisodiosRecentesWidget(state: state.animes)
          ],
        ));
      } else if (state is HomeError) {
        return Container(
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Oops'),
              Text('Parece que algo deu errado :('),
              Text('Gostia de tentar de novo?'),
              IconButton(
                icon: Icon(Icons.refresh_rounded),
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(HomeEvent.fetchHome);
                },
              )
            ],
          )),
        );
      }
      return Container();
    });
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 15),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 2,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
