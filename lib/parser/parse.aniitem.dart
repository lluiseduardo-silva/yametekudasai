import 'package:html/dom.dart';
import 'package:yamete_kudasai/consts/selectors.dart';
import 'package:yamete_kudasai/models/lista.model.dart';

class ParseAniItem {
  Lista fromHtmlElementWithImage(Element element) {
    return Lista(
        titulo: element.children[0].attributes['title'],
        id: Constantes.parseId(element.children[0].attributes['href']),
        capa: element.querySelector('.aniItemImg > img').attributes['src']);
  }

  Lista fromHtmlElementWithoutImage(Element element) {
    return Lista(
        titulo: element.attributes['title'],
        id: Constantes.parseId(element.attributes['href']),
        capa: null);
  }
}
