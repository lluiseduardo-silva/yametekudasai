import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamete_kudasai/bloc/episode_history_bloc/eph_bloc.dart';
import 'package:yamete_kudasai/bloc/index.dart';
import 'package:yamete_kudasai/pages/player.widget.dart';

class HistoricoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historico'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .05,
              child: Align(
                  alignment: Alignment.center,
                  child: Text('Segure o episódio para apagar do histórico')),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .84,
              child: BlocBuilder<EphBloc, EphState>(
                builder: (context, state) {
                  if (state is EphLoaded) {
                    if (state.historico.length > 0) {
                      return ListView(
                        children: state.historico.values.map((e) {
                          return ListTile(
                            title: Text(e.name),
                            subtitle: Text(
                                'Voce parou em ${Duration(microseconds: e.duration)}'),
                            onTap: () async {
                              BlocProvider.of<StreamBloc>(context)
                                  .add(LoadFromUrl(id: e.key));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerScaffold(),
                                  ));
                            },
                            onLongPress: () async {
                              BlocProvider.of<EphBloc>(context)
                                  .add(Remover(key: e.key));
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
