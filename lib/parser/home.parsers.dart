import 'package:html/parser.dart' show parse;
import 'package:http/http.dart';
import 'package:yamete_kudasai/consts/selectors.dart';
import 'package:yamete_kudasai/models/home.model.dart';

class HomeParser {
  Home parseHome(Response response) {
    var html = parse(response.body);
    var index = 0;
    final home =
        Home(animesNovos: [], animesRecentes: [], episodios: [], populares: []);
    html.querySelectorAll(Constantes.ANITUBE_EPISODES_LIST).forEach((element) {
      /**
           * Ep Link - OK
           * Ep Name - OK
           * Ep Cover - OK
           */
      // Constantes.parseId(element.children[0].attributes['href'])
      // element.children[0].attributes['title']
      // element.children[0].children[0].children[0].attributes['src']
      home.episodios.add(Episodios(
          titulo: element.children[0].attributes['title'],
          id: Constantes.parseId(element.children[0].attributes['href']),
          capa: element.children[0].children[0].children[0].attributes['src']));
    });
    html
        .querySelectorAll(Constantes.ANITUBE_ANIMES_CONTAINER)
        .forEach((element) {
      element.querySelectorAll(Constantes.ANITUBE_ANIME_ITEM).forEach((el) {
        if (index == 0) {
          home.populares.add(MaisAssistidos(
              titulo: el.children[0].attributes['title'],
              id: Constantes.parseId(el.children[0].attributes['href']),
              capa: el.children[0].querySelector('img').attributes['src']));
        }
        if (index == 1) {
          home.animesRecentes.add(AnimesRecentes(
              titulo: el.children[0].attributes['title'],
              id: Constantes.parseId(el.children[0].attributes['href']),
              capa: el.children[0].querySelector('img').attributes['src']));
        }
        if (index == 2) {
          home.animesNovos.add(Novos(
              titulo: el.children[0].attributes['title'],
              id: Constantes.parseId(el.children[0].attributes['href']),
              capa: el.children[0].querySelector('img').attributes['src']));
        }
      });
      index++;
    });
    return home;
  }
}
