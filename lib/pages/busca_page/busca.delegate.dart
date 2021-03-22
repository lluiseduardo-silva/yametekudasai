import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'package:yamete_kudasai/pages/index.dart';

import 'widgets/busca.card.widget.dart';

class BuscaBlocDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    ScrollController scroll = ScrollController();
    if (query.isNotEmpty) {
      BlocProvider.of<BuscaBloc>(context).add(BuscarAnime(query));
    }
    scroll.addListener(() {
      if (scroll.offset == scroll.position.maxScrollExtent) {
        BlocProvider.of<BuscaBloc>(context).add(ProximaBusca());
      }
    });
    return BlocBuilder<BuscaBloc, BuscaState>(
      builder: (context, state) {
        if (state is BuscaOffline) {
          return Container(
            child: Center(
              child: Text('Parece que está sem internet'),
            ),
          );
        }
        if (state is BuscaNotFound) {
          return Container(
            child: Center(
              child: Text('Parece que não encontramos nada'),
            ),
          );
        }
        if (state is BuscaLoading) {
          return Container(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        } else if (state is BuscaLoaded) {
          return Column(
            children: [
              Expanded(
                flex: 1,
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
                    if (index < state.busca.length) {
                      return VerticalBuscaTile(
                        imgUrl: animes[index].capa,
                        title: animes[index].titulo,
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
            ],
          );
        } else if (state is BuscaNextPage) {
          return Column(
            children: [
              Expanded(
                flex: 1,
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
                    return VerticalBuscaTile(
                      imgUrl: animes[index].capa,
                      title: animes[index].titulo,
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
            ],
          );
        } else if (state is BuscaError) {
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
                  'Parece que não encontramos nada :(',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Por que não tenta pesquisar outra coisa?',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
    // return Column(
    //   children: [
    //     StreamBuilder(
    //       stream: BlocProvider.of<BuscaBloc>(context).outWork,
    //       builder: (context, snapshot) {
    //         if (snapshot.hasData) {
    //           if (snapshot.data)
    //             return Center(
    //               child: LinearProgressIndicator(),
    //             );
    //         }
    //         return SizedBox();
    //       },
    //     ),
    //     Expanded(
    //       flex: 1,
    //       child: StreamBuilder<List<Dadosbusca>>(
    //         initialData: [],
    //         stream: BlocProvider.of<BuscaBloc>(context).outAnimes,
    //         builder: (context, snapshot) {
    //           if (snapshot.hasData) {
    //             return GridView.builder(
    //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //                   childAspectRatio: 9 / 16,
    //                   crossAxisSpacing: 5,
    //                   mainAxisSpacing: 5,
    //                   crossAxisCount: 3),
    //               itemCount: snapshot.data.length + 1,
    //               itemBuilder: (context, index) {
    //                 if (index < snapshot.data.length) {
    //                   return VerticalGridTile(
    //                     imgUrl: snapshot.data[index].cover,
    //                     title: snapshot.data[index].title,
    //                     onTap: () {
    //                       // BlocProvider.of<DetalheBloc>(context)
    //                       //     .inDetails
    //                       //     .add(snapshot.data[index].pageLink);
    //                       // Navigator.push(
    //                       //     context,
    //                       //     MaterialPageRoute(
    //                       //       builder: (context) => Details(),
    //                       //     ));
    //                     },
    //                   );
    //                 } else {
    //                   BlocProvider.of<BuscaBloc>(context).inBusca.add(null);
    //                   return SizedBox();
    //                 }
    //               },
    //             );
    //           } else {
    //             return CircularProgressIndicator();
    //           }
    //         },
    //       ),
    //     )
    //   ],
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.tv),
      title: Text('Digite o nome do seu anime ex: Black Clover'),
    );
  }

  @override
  String get searchFieldLabel => 'Busca';
}

class CustomLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(const CustomLocalization());

  @override
  bool shouldReload(CustomLocalizationDelegate old) => false;

  @override
  String toString() => 'CustomLocalization.delegate(en_US)';
}

class CustomLocalization extends DefaultMaterialLocalizations {
  const CustomLocalization();

  @override
  String get searchFieldLabel => "My hint text";
}
