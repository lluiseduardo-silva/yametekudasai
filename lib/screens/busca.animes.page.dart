import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/api.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.busca.bloc.dart';
import 'package:yamete_kudasai/blocs/delegates/busca.delegate.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import 'package:yamete_kudasai/screens/widgets/home.widgets.dart';

import 'detalhes.anime.page.dart';

class BuscaAnimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Busca'),
          elevation: 0,
          actions: [
        StreamBuilder(
        stream: BlocProvider.of<BuscaBloc>(context).outWork,
        builder: (context, snapshot) {
          if(snapshot.hasData){if(snapshot.data) return Center(

            child: CircularProgressIndicator(),);}
          return Icon(Icons.check);
        }
    ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String q = await showSearch(
                    context: context, delegate: BuscaDelegate());
                print('Enviou a request com o dado ${q}');
                if (q != null)
                  BlocProvider.of<BuscaBloc>(context).inBusca.add(q);
              },
            ),
          ],
        ),
        body: StreamBuilder<List<Dadosbusca>>(
          initialData: [],
          stream: BlocProvider.of<BuscaBloc>(context).outAnimes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 9 / 16,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 3),
                itemCount: snapshot.data.length + 1,
                itemBuilder: (context, index) {
                  if (index < snapshot.data.length) {
                    return VerticalGridTile(
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
                      imgUrl: snapshot.data[index].cover,
                      title: snapshot.data[index].title,
                    );
                  } else if (index > 1) {
                    BlocProvider.of<BuscaBloc>(context).inBusca.add(null);
                    return Container();
                  }
                  return Container();
                },
              );
            } else {
              return Center(
                child: Text('Faça uma pesquisa'),
              );
            }
          },
        ));
  }
}
