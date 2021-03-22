import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'package:yamete_kudasai/pages/detalhes_page/detalhes_page.dart';

class PlayerScaffold extends StatefulWidget {
  const PlayerScaffold({Key key}) : super(key: key);
  @override
  _PlayerScaffoldState createState() => _PlayerScaffoldState();
}

class _PlayerScaffoldState extends State<PlayerScaffold> {
  BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    super.initState();
  }

  void _setupPlayer({String key, int startAt, String name}) {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
            autoDetectFullscreenDeviceOrientation: true,
            controlsConfiguration: BetterPlayerControlsConfiguration(
              enableProgressText: true,
            ),
            startAt: Duration(microseconds: startAt),
            aspectRatio: 16 / 9,
            handleLifecycle: true,
            fit: BoxFit.contain,
            autoPlay: true,
            allowedScreenSleep: false);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.addEventsListener((event) async {
      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        Duration data =
            await _betterPlayerController.videoPlayerController.position;
        BlocProvider.of<EphBloc>(context).add(AdicionarHistorico(
            key: key, duration: data.inMicroseconds, episodeName: name));
        // }
      }
    });
  }

  @override
  void dispose() {
    BlocProvider.of<EphBloc>(context).add(RefreshState());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Player"),
        ),
        body: BlocBuilder<StreamBloc, StreamState>(
          builder: (context, state) {
            if (state is StreamOffline) {
              return Container(
                child: Center(
                  child: Text('Parece que está sem internet'),
                ),
              );
            }
            if (state is StreamLoaded) {
              return BlocBuilder<EphBloc, EphState>(
                builder: (context, hState) {
                  if (hState is EphLoaded) {
                    if (state.stream.fontes[0].file.isNotEmpty) {
                      if (hState.historico.containsKey(state.stream.id)) {
                        print(state.stream.id);
                        _setupPlayer(
                            key: state.stream.id,
                            startAt: hState.historico[state.stream.id].duration,
                            name: state.stream.titulo);
                      } else {
                        print(state.stream.id);
                        _setupPlayer(
                            key: state.stream.id,
                            startAt: 01,
                            name: state.stream.titulo);
                      }
                      _betterPlayerController.setupDataSource(
                          BetterPlayerDataSource.network(
                              state.stream.fontes[0].file,
                              headers: {
                            'referer': 'https://www.anitube.site/'
                          }));
                    } else {
                      if (hState.historico.containsKey(state.stream.id)) {
                        _setupPlayer(
                            key: state.stream.id,
                            startAt: hState.historico[state.stream.id].duration,
                            name: state.stream.titulo);
                      } else {
                        print(state.stream.id);
                        _setupPlayer(
                            key: state.stream.id,
                            startAt: 01,
                            name: state.stream.titulo);
                      }
                      _betterPlayerController.setupDataSource(
                          BetterPlayerDataSource.network(
                              state.stream.fontes[1].file,
                              headers: {
                            'referer': 'https://www.anitube.site/'
                          }));
                    }
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: BetterPlayer(
                                controller: _betterPlayerController),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                child: Text('Anterior'),
                                onPressed: () async {
                                  if (state.stream.backEpLink.isNotEmpty) {
                                    _betterPlayerController.pause();
                                    BlocProvider.of<EphBloc>(context)
                                        .add(RefreshState());
                                    BlocProvider.of<StreamBloc>(context).add(
                                        LoadFromUrl(
                                            id: state.stream.backEpLink));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Este já é o primeiro episódio')));
                                  }
                                },
                              ),
                              TextButton(
                                child: Text('Avançar 1:30'),
                                onPressed: () async {
                                  Duration actual =
                                      await _betterPlayerController
                                          .videoPlayerController.position;
                                  int milliseconds = actual.inMilliseconds;
                                  _betterPlayerController.seekTo(Duration(
                                      milliseconds: milliseconds + 90000));
                                },
                              ),
                              TextButton(
                                child: Text('Proximo'),
                                onPressed: () async {
                                  if (state.stream.nextEpLink.isNotEmpty) {
                                    _betterPlayerController.pause();
                                    BlocProvider.of<EphBloc>(context)
                                        .add(RefreshState());
                                    BlocProvider.of<StreamBloc>(context).add(
                                        LoadFromUrl(
                                            id: state.stream.nextEpLink));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Este já é o ultimo episódio')));
                                  }
                                },
                              )
                            ],
                          ),
                          TextButton(
                            child: Text('Ir para anime'),
                            onPressed: () async {
                              _betterPlayerController.pause();
                              BlocProvider.of<EphBloc>(context)
                                  .add(RefreshState());
                              BlocProvider.of<DetalhesBloc>(context).add(
                                  CarregarDetalhes(id: state.stream.detalhes));
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetalhesPage(),
                                  ),
                                  (route) => true);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              );
            } else if (state is StreamLoading) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is StreamError) {
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
                        BlocProvider.of<StreamBloc>(context)
                            .add(LoadFromUrl(id: state.url));
                      },
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }
}
