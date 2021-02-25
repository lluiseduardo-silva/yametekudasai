import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/api.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.home.bloc.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import 'package:yamete_kudasai/constants/player.dart';
import 'package:yamete_kudasai/screens/detalhes.anime.page.dart';

class MaisVisualizadosListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MaisAssistidos>>(
      initialData: [],
      stream: BlocProvider.of<HomeBloc>(context).outMore,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GridView.builder(
                addRepaintBoundaries: true,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 16 / 9,
                    crossAxisSpacing: 2,
                    maxCrossAxisExtent: MediaQuery.of(context).size.width),
                itemCount: snapshot.data.length,
                cacheExtent: 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: VerticalGridTile(
                      title: snapshot.data[index].title,
                      imgUrl: snapshot.data[index].cover,
                      onTap: () async {
                        await new Anitube()
                            .carregarDetalhes(snapshot.data[index].pageLink)
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(anime: value),
                            ),
                          );
                        });
                      },
                    ),
                  );
                }),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class AnimesRecenteListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Adicionados>>(
      initialData: [],
      stream: BlocProvider.of<HomeBloc>(context).outLan,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GridView.builder(
                addRepaintBoundaries: true,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    childAspectRatio: 16 / 9,
                    crossAxisSpacing: 2,
                    maxCrossAxisExtent: MediaQuery.of(context).size.width),
                itemCount: snapshot.data.length,
                cacheExtent: 0,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: VerticalGridTile(
                      title: snapshot.data[index].title,
                      imgUrl: snapshot.data[index].cover,
                      onTap: () async {
                        await new Anitube()
                            .carregarDetalhes(snapshot.data[index].pageLink)
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(anime: value),
                            ),
                          );
                        });
                      },
                    ),
                  );
                }),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class EpisodiosRecentesListWidget extends StatelessWidget {
  const EpisodiosRecentesListWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EpisodiosRecentes>>(
      initialData: [],
      stream: BlocProvider.of<HomeBloc>(context).outEps,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
              addSemanticIndexes: true,
              addRepaintBoundaries: true,
              cacheExtent: 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16 / 9,
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                    child: VerticalGridTile(
                      title: snapshot.data[index].titulo,
                      imgUrl: snapshot.data[index].thumbnail,
                      textContainerHeight: 40,
                      onTap: () async {
                        await new Anitube()
                            .carregarStream(
                                snapshot.data[index].linkVisualizaAoEP)
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MountPlayer()
                                  .mountWithUrl(value.fontes[0].url),
                            ),
                          );
                        });
                      },
                    ));
              });
        }
        return Center(child: Text('Não encontramos nada'));
      },
    );
  }
}

class VerticalGridTile extends StatefulWidget {
  final Function onTap;
  final Function onLongPress;
  final String title;
  final String imgUrl;
  final double textContainerHeight;

  const VerticalGridTile(
      {Key key,
      this.onTap,
      this.title,
      this.imgUrl,
      this.onLongPress,
      this.textContainerHeight = 90})
      : super(key: key);
  @override
  _VerticalGridTileState createState() => _VerticalGridTileState();
}

class _VerticalGridTileState extends State<VerticalGridTile> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () async {
        await widget.onLongPress();
      },
      onTap: () async {
        setState(() {
          isLoading = !isLoading;
        });
        await widget.onTap();
        setState(() {
          isLoading = !isLoading;
        });
      },
      child: GridTile(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : CachedNetworkImage(
                imageUrl: widget.imgUrl,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.error),
                ),
                fit: BoxFit.fill,
              ),
        footer: Container(
          color: Colors.black54,
          height: widget.textContainerHeight,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              widget.title,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}

// await new Anitube()
//     .carregarDetalhes(snapshot.data[index].pageLink).then((value){
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Details(anime: value),
// ),
// );
// });
