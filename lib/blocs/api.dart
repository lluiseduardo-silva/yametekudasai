import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yamete_kudasai/blocs/entityes/index.dart' as models;

const _baseUrl = 'https://nextjs-puppeteer-api.vercel.app/api/tensei/';
String _busca;
String _next;

class Anitube {
  Future<models.Busca> busca(String s) async {
    _busca = s;

    http.Response response = await http
        .get("${_baseUrl}nezuko?busca=${Uri.encodeQueryComponent(_busca)}&url");

    return decodeBusca(response);
  }

  Future<models.Busca> nextBusca() async {
    if (_next != '' && _next != null) {
      http.Response response =
          await http.get("${_baseUrl}nezuko?busca=${_busca}&url=${_next}");
      return decodeBusca(response);
    } else {
      throw Exception('Não é possivel carregar a proxima pagina sem URL');
    }
  }

  Future<models.Lista> carregarLista(String url) async {
    if (url == '') {
      http.Response response = await http.get("${_baseUrl}hinata?url");
      return decodeLista(response);
    } else {
      http.Response response =
          await http.get("${_baseUrl}hinata?&url=${_next}");
      return decodeLista(response);
    }
  }

  Future<models.Home> carregarHome() async {
    http.Response response = await http.get("${_baseUrl}rimuru");
    return decodeHome(response);
  }

  Future<models.DetalheAnime> carregarDetalhes(String s) async {
    print(s);
    http.Response response =
        await http.get("${_baseUrl}kakuzu?url=${Uri.encodeQueryComponent(s)}");
    return decodeDetalhes(response);
  }

  Future<models.AnimeStream> carregarStream(String s) async {
    print(s);
    http.Response response =
        await http.get("${_baseUrl}hakurou?url=${Uri.encodeQueryComponent(s)}");
    return decodeStream(response);
  }
}

models.Busca decodeBusca(http.Response response) {
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    models.Busca ds = new models.Busca.fromJson(decoded);
    if (ds.animesbusca.nextpage == _next || ds.animesbusca.nextpage == '') {
      _next = '';
      return ds;
    } else {
      if (ds.animesbusca.nextpage != '' && ds.animesbusca.nextpage != null) {
        _next = ds.animesbusca.nextpage;
      }
      return ds;
    }
  } else {
    throw Exception('Falha ao carregas videos');
  }
}

models.Lista decodeLista(http.Response response) {
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    models.Lista ds = new models.Lista.fromJson(decoded);
    if (ds.animeslista.nextpage != '' && _next != ds.animeslista.nextpage) {
      print(ds.animeslista.nextpage);
      print(_next);
      _next = ds.animeslista.nextpage;
      print(_next);
    }
    return ds;
  } else {
    throw Exception('Falha ao carregas videos');
  }
}

models.Home decodeHome(http.Response response) {
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);

    models.Home ds = new models.Home.fromJson(decoded);
    return ds;
  }
}

models.DetalheAnime decodeDetalhes(http.Response response) {
  print(response.statusCode);
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);

    models.DetalheAnime ds = new models.DetalheAnime.fromJson(decoded);

    return ds;
  }
}

models.AnimeStream decodeStream(http.Response response) {
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);

    models.AnimeStream ds = new models.AnimeStream.fromJson(decoded);

    return ds;
  }
}
