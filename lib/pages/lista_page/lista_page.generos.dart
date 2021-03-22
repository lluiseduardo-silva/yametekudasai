import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'package:yamete_kudasai/consts/mock.data.dart';
import 'package:yamete_kudasai/pages/detalhes_page/detalhes_page.dart';

import 'widgets/lista.card.widgets.dart';

class ListaPageGeneros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController scroll = new ScrollController();
    scroll.addListener(() {
      if (scroll.offset == scroll.position.maxScrollExtent) {
        BlocProvider.of<BuscaBloc>(context).add(ProximaBusca());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Generos'),
      ),
      body: Container(
        child: BlocBuilder<BuscaBloc, BuscaState>(
          builder: (context, state) {
            if (state is BuscaOffline) {
              return Container(
                child: Center(
                  child: Text('Parece que está sem internet'),
                ),
              );
            }
            if (state is BuscaInitial) {
              return Container(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Escolha um genero'),
                      DropdownButton(
                          items: Genres.generos,
                          itemHeight: 60,
                          hint: Text('Selecione um Gênero'),
                          onChanged: (value) {
                            BlocProvider.of<BuscaBloc>(context)
                                .add(BuscarAnime(value));
                          }),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text('Escolha um genero para começar'),
                    ),
                  )
                ],
              ));
            }
            if (state is BuscaLoading) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is BuscaLoaded) {
              return Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Escolha um genero'),
                      DropdownButton(
                          items: Genres.generos,
                          itemHeight: 60,
                          hint: Text('Selecione uma letra'),
                          onChanged: (value) {
                            BlocProvider.of<BuscaBloc>(context)
                                .add(BuscarAnime(value));
                          }),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 9 / 16,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 3),
                      itemCount: state.busca.length,
                      controller: scroll,
                      itemBuilder: (context, index) {
                        var animes = state.busca;
                        if (index < state.busca.length) {
                          return ListaCardWidget(
                            title: animes[index].titulo,
                            imgUrl: animes[index].capa ??
                                'https://www.anitube.site/wp-content/themes/newanitubevelho/img/thumb-default.png',
                            onTap: () {
                              BlocProvider.of<DetalhesBloc>(context)
                                  .add(CarregarDetalhes(id: animes[index].id));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetalhesPage()));
                            },
                          );
                        } else {
                          // BlocProvider.of<ListaBloc>(context)
                          //     .add(ListaEvent.loadNextDub);
                          return SizedBox();
                        }
                      },
                    ),
                  )
                ]),
              );
            } else if (state is BuscaNextPage) {
              return Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Escolha um genero'),
                      DropdownButton(
                          items: Genres.generos,
                          itemHeight: 60,
                          hint: Text('Selecione uma letra'),
                          onChanged: (value) {
                            BlocProvider.of<BuscaBloc>(context)
                                .add(BuscarAnime(value));
                          }),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 9 / 16,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 3),
                      controller: scroll,
                      itemCount: state.busca.length,
                      itemBuilder: (context, index) {
                        var animes = state.busca;
                        return ListaCardWidget(
                          title: animes[index].titulo,
                          imgUrl: animes[index].capa ??
                              'https://www.anitube.site/wp-content/themes/newanitubevelho/img/thumb-default.png',
                          onTap: () {
                            BlocProvider.of<DetalhesBloc>(context)
                                .add(CarregarDetalhes(id: animes[index].id));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetalhesPage()));
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
