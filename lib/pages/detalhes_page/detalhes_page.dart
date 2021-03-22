import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'package:yamete_kudasai/cubit/themecubit_cubit.dart';
import 'package:yamete_kudasai/pages/detalhes_page/widgets/episodes.widget.dart';

import '../player.widget.dart';

class DetalhesPage extends StatelessWidget {
  final String url;

  const DetalhesPage({Key key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<DetalhesBloc, DetalhesState>(
          builder: (context, state) {
            if (state is DetalhesLoaded) {
              return Text(state.anime.titulo);
            }
            return Text('');
          },
        ),
        actions: [
          BlocBuilder<FavoritosBloc, FavoritosState>(
            builder: (context, favState) {
              if (favState is FavoritosLoaded) {
                return BlocBuilder<DetalhesBloc, DetalhesState>(
                  builder: (context, state) {
                    if (state is DetalhesLoaded) {
                      return IconButton(
                        onPressed: () {
                          BlocProvider.of<FavoritosBloc>(context)
                              .add(AdicionarFavorito(dados: state.anime));
                        },
                        icon: favState.favoritos.containsKey(state.anime.id)
                            ? Icon(Icons.star,
                                color: context.select(
                                    (ThemecubitCubit element) =>
                                        element.state.themeMode ==
                                                ThemeMode.dark
                                            ? Colors.red
                                            : Colors.white))
                            : Icon(Icons.star_outline),
                      );
                    }
                    return Container();
                  },
                );
              }
              return Container();
            },
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<DetalhesBloc, DetalhesState>(
          builder: (context, state) {
            if (state is DetalhesOffline) {
              return Container(
                child: Center(
                  child: Text('Parece que está sem internet'),
                ),
              );
            }
            if (state is DetalhesLoaded) {
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .40,
                        width: MediaQuery.of(context).size.width,
                        color: context.select((ThemecubitCubit element) =>
                            element.state.themeMode == ThemeMode.dark
                                ? Colors.red
                                : Color(0xFAFAFA)),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: CachedNetworkImage(
                                  imageUrl: state.anime.capa,
                                  placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: Icon(Icons.error),
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Column(
                                    children: [
                                      Text('SINOPSE'),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Expanded(
                                          child: SingleChildScrollView(
                                        child: Text(state.anime.sinopse),
                                      ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text(
                          'Episódios Disponíveis',
                          maxLines: 1,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * .60,
                          child: BlocBuilder<EphBloc, EphState>(
                            builder: (context, hState) {
                              if (hState is EphLoaded) {
                                return ListView.builder(
                                  itemCount: state.anime.episodios.length,
                                  itemBuilder: (context, index) {
                                    return EpisodesTile(
                                        title:
                                            state.anime.episodios[index].titulo,
                                        watched: hState.historico.containsKey(
                                                state.anime.episodios[index].id)
                                            ? false
                                            : true,
                                        onTap: () async {
                                          BlocProvider.of<StreamBloc>(context)
                                              .add(LoadFromUrl(
                                                  id: state.anime
                                                      .episodios[index].id));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PlayerScaffold()));
                                        });
                                  },
                                );
                              }
                              return Container();
                            },
                          )),
                    ],
                  ),
                ),
              );
            } else if (state is DetalhesLoading) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is DetalhesError) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Oops!',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'Parece que algo deu errado :(',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Gostaria de tentar novamente?',
                      style: TextStyle(fontSize: 18),
                    ),
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        BlocProvider.of<DetalhesBloc>(context)
                            .add(CarregarDetalhes(id: url));
                      },
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
