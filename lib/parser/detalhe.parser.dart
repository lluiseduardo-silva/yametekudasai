import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:yamete_kudasai/consts/selectors.dart';
import 'package:yamete_kudasai/models/detalhe.model.dart';

class DetalheParser {
  Detalhe praseDetalhe(http.Response response) {
    var html = parse(response.body);
    var episodios = <Episodio>[];
    html
        .querySelectorAll(Constantes.ANITUBE_DETALHES_EPISODES_LIST)
        .forEach((element) {
      episodios.add(Episodio(
          titulo: element.attributes['title'],
          id: Constantes.parseId(element.attributes['href'])));
    });
    return Detalhe(
        titulo: html.querySelector('.pagAniTitulo > .mwidth > h1').innerHtml,
        capa: html.querySelector('#capaAnime > img').attributes['src'],
        episodios: episodios,
        // ignore: prefer_if_null_operators
        sinopse: html.querySelector('#sinopse2') != null
            ? html.querySelector('#sinopse2').innerHtml
            : '');
  }
}
