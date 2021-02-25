import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/api.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.favorite.bloc.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import 'package:yamete_kudasai/constants/player.dart';
import 'package:yamete_kudasai/screens/widgets/detalhes.widgets.dart';

class Details extends StatelessWidget {
  final DetalheAnime anime;
  const Details({Key key, this.anime}) : super(key: key);
  @override
  Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          title: Text(anime.detalhes.titulo),
          actions: [
            StreamBuilder(
              initialData: {},
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return IconButton(
                    icon: Icon(snapshot.data.containsKey(anime.detalhes.pageLink)? Icons.star:Icons.star_border),
                    onPressed: () {
                      BlocProvider.of<FavoriteBloc>(context).toggleFavorite(anime);
                    },
                  );
                }else{
                  return CircularProgressIndicator();
                }
              },)
          ],
        ),
        body: Container(
          color: Colors.black87,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .45,
                  child: Row(children: [
                    Expanded(
                      flex:1,
                      // height: MediaQuery.of(context).size.height * .50,
                      // width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: anime.detalhes.capa,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Icon(Icons.error),
                        ),
                        fit: BoxFit.cover,
                        httpHeaders: {'referer': 'https://anitube.site'},
                      ),
                    ),
                    Expanded(
                      flex:1,
                      // height: MediaQuery.of(context).size.height * .10,
                      // width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
                        child: Text(
                          anime.detalhes.sinopse,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'EPISODIOS',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .80,
                  child: ListView.builder(
                      itemCount: anime.detalhes.episodios.length,
                      itemBuilder: (context, index) {
                        return ListViewEpisodeTile(
                          title: anime.detalhes.episodios[index].titulo,
                          onTap: () async {
                            AnimeStream sources = await new Anitube().carregarStream(
                                anime.detalhes.episodios[index].link);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => new MountPlayer().mountWithUrl(sources.fontes[0].url)),
                            );
                          },
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
