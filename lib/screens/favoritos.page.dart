import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/api.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.favorite.bloc.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import 'package:yamete_kudasai/screens/widgets/home.widgets.dart';

import 'detalhes.anime.page.dart';

class AnimesFavoritosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        actions: [
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
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .05,
              child: Align(
                alignment: Alignment.center,
                  child: Text('Segure o seu anime pare remover dos favoritos')),),
            Container(
            height: MediaQuery.of(context).size.height * .80,
            child: StreamBuilder<Map<String, DetalheAnime>>(
              initialData: {},
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 9/ 16,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        crossAxisCount: 2),
                    children: snapshot.data.values.map((e){
                      return VerticalGridTile(
                        title: e.detalhes.titulo,
                        onLongPress: ()async{
                          BlocProvider.of<FavoriteBloc>(context).toggleFavorite(e);
                        },
                        onTap: () async {
                          await new Anitube()
                              .carregarDetalhes(e.detalhes.pageLink)
                              .then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(anime: value),
                              ),
                            );
                          });
                        },
                        imgUrl: e.detalhes.capa,
                      );}).toList(),
                  );
                }
                return Container(
                  child: Center(
                    child: Text('Parece que você ainda não tem favoritos'),
                  ),
                );
              },
            ),
          ),]
        ),
      ),
    );
  }
}
