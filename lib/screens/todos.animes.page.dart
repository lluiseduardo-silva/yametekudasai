import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/api.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.lista.bloc.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import 'package:yamete_kudasai/screens/detalhes.anime.page.dart';
import 'package:yamete_kudasai/screens/widgets/list.view.items.widget.dart';

class TodosAnimesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Todos os animes'),
        ),actions: [
        StreamBuilder(
            stream: BlocProvider.of<ListaBloc>(context).outWork,
            builder: (context, snapshot) {
              if(snapshot.hasData){if(snapshot.data) return Center(

                child: CircularProgressIndicator(),);}
              return Icon(Icons.check);
            }
        ),
      ],

      ),
      body: StreamBuilder<List<Dadoslista>>(
        stream: BlocProvider.of<ListaBloc>(context).outAnimes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data.length + 1,
              separatorBuilder: (context, index) => Divider(
                color: Colors.black,
              ),
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return ListViewAllAnimesItem(
                      dados: snapshot.data[index],
                      onTap: () async {
                        await new Anitube()
                            .carregarDetalhes(snapshot.data[index].pageLink).then((value){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Details(anime: value),
                            ),
                          );
                        });
                      });
                } else if (index > 1) {
                  return StreamBuilder(
                    stream: BlocProvider.of<ListaBloc>(context).outWork,
                    initialData: false,
                    builder: (context, boleano) {
                      if(boleano.data){
                        return LinearProgressIndicator();

                      }
                      BlocProvider.of<ListaBloc>(context).inLoad.add(null);
                      return Container();
                    },
                  );


                }
                return LinearProgressIndicator();
              },
            );
          } else {
            return Center(
              child: Text('NÃO TEM NADA NA PORRA DO ARQUIVO'),
            );
          }
        },
        initialData: [],
      ),
    );
  }
}
