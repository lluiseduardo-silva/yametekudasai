import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:yamete_kudasai/models/stream.model.dart';
import 'package:yamete_kudasai/consts/selectors.dart';

class StreamParser {
  AnimeStream parseStream(http.Response response) {
    var html = parse(response.body);
    var script = html.querySelectorAll('#video > script')[5].innerHtml;
    script = script
        .replaceAll('file', '"file"')
        .replaceAll('label', '"label:"')
        .replaceAll('type', '"type"')
        .replaceAll('default', '"default"')
        .replaceAll("'", '"')
        .replaceAll('fullscreen', '"fullscreen"')
        .toString();
    var result = RegExp((r'(\{(?:\[??[^\[]*?\}))')).allMatches(script);
    var fontes = <Fontes>[];
    try {
      fontes = <Fontes>[
        Fontes.fromJson(result.elementAt(0).group(0)),
        Fontes.fromJson(result.elementAt(1).group(0))
      ];
    } on FormatException {
      fontes = <Fontes>[
        Fontes.fromJson(result.elementAt(0).group(0)),
      ];
    }

    return AnimeStream(
        titulo: html.querySelector('.pagEpiTitulo > .mwidth > h1').innerHtml,
        backEpLink: html
                    .querySelectorAll('.pagEpiGroupControles > a')[0]
                    .attributes['href'] !=
                null
            ? Constantes.parseId(html
                .querySelectorAll('.pagEpiGroupControles > a')[0]
                .attributes['href'])
            : '',
        backEpName: html
            .querySelectorAll('.pagEpiGroupControles > a')[0]
            .attributes['title'],
        nextEpLink: html
                    .querySelectorAll('.pagEpiGroupControles > a')[2]
                    .attributes['href'] !=
                null
            ? Constantes.parseId(html
                .querySelectorAll('.pagEpiGroupControles > a')[2]
                .attributes['href'])
            : '',
        nextEpName: html
            .querySelectorAll('.pagEpiGroupControles > a')[2]
            .attributes['title'],
        detalhes: Constantes.parseId(
            html.querySelectorAll('.pagEpiGroupControles > a')[1].attributes['href']),
        fontes: fontes);
  }
}
