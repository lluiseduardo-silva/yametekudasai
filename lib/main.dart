import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/cubit/themecubit_cubit.dart';
import 'package:yamete_kudasai/external/anitube.service.dart';
import 'package:yamete_kudasai/pages/historico_page/historico_page.dart';
import 'package:yamete_kudasai/themes/app-theme.dart';
import 'package:yamete_kudasai/pages/index.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'pages/favoritos_page/favoritos_page.dart';

void main() async {
  runApp(App());
}

//BlocBuilderCode
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemecubitCubit>(
          create: (context) => ThemecubitCubit(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(animeRepo: new AnitubeService()),
        ),
        BlocProvider<BuscaBloc>(
          create: (context) => BuscaBloc(animeRepo: new AnitubeService()),
        ),
        BlocProvider<FavoritosBloc>(
          create: (context) => FavoritosBloc(),
        ),
        BlocProvider<DetalhesBloc>(
          create: (context) => DetalhesBloc(animeRepo: new AnitubeService()),
        ),
        BlocProvider<ListaBloc>(
          create: (context) => ListaBloc(animeRepo: new AnitubeService()),
        ),
        BlocProvider<StreamBloc>(
          create: (context) => StreamBloc(animeRepo: new AnitubeService()),
        ),
        BlocProvider<EphBloc>(
          create: (context) => EphBloc(),
        )
      ],
      child: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({
    Key key,
  }) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    BlocProvider.of<HomeBloc>(context).add(HomeEvent.fetchHome);
    BlocProvider.of<FavoritosBloc>(context).add(InicializarFavoritos());
    BlocProvider.of<EphBloc>(context).add(InicializarHistorico());
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemecubitCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          context.select((ThemecubitCubit element) => element.state.themeMode),
      home: MyScaffold(),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yamete Kudasai'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoricoPage()));
            },
          ),
          Align(
            alignment: Alignment.center,
            child: BlocBuilder<FavoritosBloc, FavoritosState>(
              builder: (context, state) {
                if (state is FavoritosInitial) {
                  return Text('Oh NO!');
                } else if (state is FavoritosLoaded) {
                  if (state.favoritos == null) {
                    return Text('0');
                  }
                  return Text(state.favoritos.length.toString());
                }
                return Text('');
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoritosPage()));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              await showSearch(context: context, delegate: BuscaBlocDelegate());
            },
          ),
        ],
      ),
      body: HomePage(),
    );
  }
}
