import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/bloc/detalhes_bloc/detalhes_bloc.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'package:yamete_kudasai/models/home.model.dart';
import 'package:yamete_kudasai/pages/index.dart';
import 'package:yamete_kudasai/pages/player.widget.dart';
import 'home.card.widgets.dart';

class EpisodiosRecentesWidget extends StatelessWidget {
  final Home state;
  const EpisodiosRecentesWidget({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * .50
          : MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 10),
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        addSemanticIndexes: true,
        addRepaintBoundaries: true,
        cacheExtent: 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 9 / 16,
          crossAxisCount: 3,
        ),
        itemCount: state.episodios.length,
        itemBuilder: (context, index) {
          var animes = state.episodios;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
            child: VerticalGridTilee(
                imgUrl: animes[index].capa,
                textContainerHeight: 40,
                title: animes[index].titulo,
                onTap: () async {
                  BlocProvider.of<StreamBloc>(context)
                      .add(LoadFromUrl(id: animes[index].id));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScaffold(),
                      ));
                  // await new Anitube()
                  //     .carregarStream(animes[index].linkVisualizaAoEP)
                  //     .then((value) {
                  //   if (value[0].file.isNotEmpty) {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               new MountPlayer().mountWithUrl(value[0].file)),
                  //     );
                  //   } else {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               new MountPlayer().mountWithUrl(value[1].file)),
                  //     );
                  //   }
                  // });
                }),
          );
        },
      ),
    );
  }
}

class AnimesAdicionadosWidget extends StatelessWidget {
  final Home state;
  const AnimesAdicionadosWidget({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).orientation == Orientation.portrait
          ? MediaQuery.of(context).size.height * .25
          : MediaQuery.of(context).size.height * .50,
      margin: EdgeInsets.only(top: 10),
      child: GridView.builder(
        addRepaintBoundaries: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 16 / 9,
            crossAxisSpacing: 2,
            maxCrossAxisExtent: MediaQuery.of(context).size.width),
        itemCount: state.animesRecentes.length,
        itemBuilder: (context, index) {
          var animes = state.animesRecentes;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: VerticalGridTile(
              imgUrl: animes[index].capa,
              title: animes[index].titulo,
              textContainerHeight: 0,
              onTap: () {
                BlocProvider.of<DetalhesBloc>(context)
                    .add(CarregarDetalhes(id: animes[index].id));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetalhesPage(url: animes[index].id)));
              },
            ),
          );
        },
      ),
    );
  }
}

class AnimesMaisAssistidosWidget extends StatelessWidget {
  final Home state;
  const AnimesMaisAssistidosWidget({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height * .25
            : MediaQuery.of(context).size.height * .50,
        margin: EdgeInsets.only(top: 10),
        child: GridView.builder(
          addRepaintBoundaries: true,
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 16 / 9,
              crossAxisSpacing: 2,
              maxCrossAxisExtent: MediaQuery.of(context).size.width),
          itemCount: state.populares.length,
          itemBuilder: (context, index) {
            var animes = state.populares;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: VerticalGridTile(
                imgUrl: animes[index].capa,
                title: animes[index].titulo,
                textContainerHeight: 0,
                onTap: () {
                  BlocProvider.of<DetalhesBloc>(context)
                      .add(CarregarDetalhes(id: animes[index].id));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetalhesPage(url: animes[index].id)));
                },
              ),
            );
          },
        ));
  }
}
