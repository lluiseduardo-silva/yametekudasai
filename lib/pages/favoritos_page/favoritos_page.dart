import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/bloc/favoritos_bloc/index.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'package:yamete_kudasai/pages/favoritos_page/widgets/card.widgets.dart';

import '../index.dart';

class FavoritosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favoritos'), actions: [
        Align(
          alignment: Alignment.center,
          child: BlocBuilder<FavoritosBloc, FavoritosState>(
            builder: (context, state) {
              if (state is FavoritosInitial) {
                return Text('Oh NO!');
              } else if (state is FavoritosLoaded) {
                return Text(state.favoritos.length.toString());
              }
              return Text('');
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.star),
          onPressed: () {},
        ),
      ]),
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .05,
              child: Align(
                  alignment: Alignment.center,
                  child: Text('Segure o seu anime pare remover dos favoritos')),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .84,
              child: BlocBuilder<FavoritosBloc, FavoritosState>(
                builder: (context, state) {
                  if (state is FavoritosLoaded) {
                    if (state.favoritos.length > 0) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 9 / 16,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: 3),
                        children: state.favoritos.values.map((e) {
                          return FavoritosGridTile(
                            imgUrl: e.capa,
                            title: e.titulo,
                            onLongPress: () {
                              BlocProvider.of<FavoritosBloc>(context)
                                  .add(AdicionarFavorito(dados: e));
                            },
                            onTap: () {
                              BlocProvider.of<DetalhesBloc>(context)
                                  .add(CarregarDetalhes(id: e.id));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetalhesPage(url: e.id)));
                            },
                          );
                        }).toList(),
                      );
                    }
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
