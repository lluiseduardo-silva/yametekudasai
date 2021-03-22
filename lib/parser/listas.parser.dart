import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:yamete_kudasai/consts/selectors.dart';
import 'package:yamete_kudasai/errors/data.errors.dart';
import 'package:yamete_kudasai/parser/parse.aniitem.dart';
import '../models/lista.model.dart';

class ListasParser {
  List<Lista> parseDubAndSub(http.Response response) {
    var html = parse(response.body);
    var lista = <Lista>[];
    if (html.querySelector('.listaPagNotfound') != null) {
      throw DataParseException('Não encontramos nada');
    }
    if (html
        .querySelectorAll(Constantes.ANITUBE_LISTA_PAGINADA_COM_FOTO)
        .isNotEmpty) {
      html
          .querySelectorAll(Constantes.ANITUBE_LISTA_PAGINADA_COM_FOTO)
          .forEach((element) {
        lista.add(ParseAniItem().fromHtmlElementWithImage(element));
      });
      return lista;
    } else if (html
        .querySelectorAll(Constantes.ANITUBE_LISTA_PAGINADA_SEM_FOTO)
        .isNotEmpty) {
      html
          .querySelectorAll(Constantes.ANITUBE_LISTA_PAGINADA_SEM_FOTO)
          .forEach((element) {
        lista.add(ParseAniItem().fromHtmlElementWithoutImage(element));
      });
      return lista;
    } else {
      throw DataParseException(
          'Não encontramos o elemento HTML necessario para continuar');
    }
  }

  String parseNextPage(http.Response response) {
    var html = parse(response.body);
    if (html.querySelectorAll('.next').isNotEmpty) {
      return html.querySelector('.next').attributes['href'];
    } else {
      return '';
    }
  }

  List<Lista> parseSearchAndCategory(http.Response response) {
    var html = parse(response.body);
    var lista = <Lista>[];
    if (html
        .querySelectorAll(Constantes.ANITUBE_BUSCA_PAGINADA_COM_FOTO)
        .isNotEmpty) {
      html
          .querySelectorAll(Constantes.ANITUBE_BUSCA_PAGINADA_COM_FOTO)
          .forEach((element) {
        lista.add(ParseAniItem().fromHtmlElementWithImage(element));
      });
      return lista;
    } else if (html
        .querySelectorAll(Constantes.ANITUBE_BUSCA_PAGINADA_SEM_FOTO)
        .isNotEmpty) {
      html
          .querySelectorAll(Constantes.ANITUBE_BUSCA_PAGINADA_SEM_FOTO)
          .forEach((element) {
        lista.add(ParseAniItem().fromHtmlElementWithoutImage(element));
      });
      return lista;
    } else {
      throw DataParseException('Não encontramos o elemento HTML');
    }
  }
}
