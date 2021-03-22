import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'package:yamete_kudasai/consts/mock.data.dart';
import 'package:yamete_kudasai/pages/index.dart';
import 'package:yamete_kudasai/pages/lista_page/widgets/lista.card.widgets.dart';

class ListaPageLegendado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController scroll = new ScrollController();
    scroll.addListener(() {
      if (scroll.offset == scroll.position.maxScrollExtent) {
        BlocProvider.of<ListaBloc>(context).add(LoadSubNext());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Animes Legendados'),
      ),
      body: Container(
        child: BlocBuilder<ListaBloc, ListaState>(
          builder: (context, state) {
            if (state is ListaNoMatch) {
              return Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Agrupar por letra'),
                        DropdownButton(
                            items: Letras.letras,
                            itemHeight: 60,
                            hint: Text('Selecione uma letra'),
                            onChanged: (value) {
                              BlocProvider.of<ListaBloc>(context)
                                  .add(LoadDub(letra: value));
                            }),
                      ],
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text('Nada encontrado'),
                      ),
                    )
                  ],
                ),
              );
            }
            if (state is ListaOffline) {
              return Container(
                child: Center(
                  child: Text('Parece que está sem internet'),
                ),
              );
            }
            if (state is ListaLoading) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is ListaLoaded) {
              return Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Agrupar por letra'),
                      DropdownButton(
                          items: Letras.letras,
                          itemHeight: 60,
                          hint: Text('Selecione uma letra'),
                          onChanged: (value) {
                            BlocProvider.of<ListaBloc>(context)
                                .add(LoadSub(letra: value));
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
                      itemCount: state.lista.length,
                      itemBuilder: (context, index) {
                        var animes = state.lista;
                        if (index < state.lista.length) {
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
                          return SizedBox();
                        }
                      },
                    ),
                  )
                ]),
              );
            } else if (state is ListaNextPage) {
              return Container(
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Agrupar por letra'),
                      DropdownButton(
                          items: Letras.letras,
                          itemHeight: 60,
                          hint: Text('Selecione uma letra'),
                          onChanged: (value) {
                            BlocProvider.of<ListaBloc>(context)
                                .add(LoadDub(letra: value));
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
                      itemCount: state.lista.length,
                      itemBuilder: (context, index) {
                        var animes = state.lista;
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
