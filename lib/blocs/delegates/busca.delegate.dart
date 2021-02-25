import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yamete_kudasai/blocs/bloc/animes.busca.bloc.dart';
import 'package:yamete_kudasai/blocs/entityes/index.dart';
import 'package:yamete_kudasai/screens/detalhes.anime.page.dart';
import 'package:yamete_kudasai/screens/widgets/home.widgets.dart';

import '../api.dart';

class BuscaDelegate extends SearchDelegate<String> {
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
    // TODO: implement buildLeading
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
    // TODO: implement buildResults
    // Future.delayed(Duration.zero).then((value) => close(context,query));
    // return Container();
    BlocProvider.of<BuscaBloc>(context).inBusca.add(query);

    return Column(
      children: [
        StreamBuilder(
          stream: BlocProvider.of<BuscaBloc>(context).outWork,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data)
                return Center(
                  child: LinearProgressIndicator(),
                );
            }
            return SizedBox();
          },
        ),
        Expanded(
          flex: 1,
          child: StreamBuilder<List<Dadosbusca>>(
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
                        imgUrl: snapshot.data[index].cover,
                        title: snapshot.data[index].title,
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
                      );
                    } else {
                      BlocProvider.of<BuscaBloc>(context).inBusca.add(null);
                      return SizedBox();
                    }
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return ListTile(
      leading: Icon(Icons.tv),
      title: Text('Digite o nome do seu anime ex: Black Clover'),
    );
  }

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => 'Busca';

}

class CustomLocalizationDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'en';

  @override
  Future<MaterialLocalizations> load(Locale locale) => SynchronousFuture<MaterialLocalizations>(const CustomLocalization());

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
