import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yamete_kudasai/blocs/entityes/index.dart' as models;

const _baseUrl = 'https://nextjs-puppeteer-api.vercel.app/api/tensei/';
String _busca;
String _nextBusca;
String _nextLista;

class Anitube {
  Future<models.Busca> busca(String s) async {
    _busca = s;

    http.Response response = await http
        .get("${_baseUrl}nezuko?busca=${Uri.encodeQueryComponent(_busca)}&url");

    return decodeBusca(response);
  }

  Future<models.Busca> nextBusca() async {
    print(_nextBusca);
    if (_nextBusca != '' && _nextBusca != null) {
      http.Response response =
          await http.get("${_baseUrl}nezuko?busca=$_busca&url=$_nextBusca");
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
      print(_nextLista);
      http.Response response =
          await http.get("${_baseUrl}hinata?&url=$_nextLista");
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
    if (ds.animesbusca.nextpage == _nextBusca ||
        ds.animesbusca.nextpage == '') {
      _nextBusca = '';
      return ds;
    } else {
      if (ds.animesbusca.nextpage != '' && ds.animesbusca.nextpage != null) {
        _nextBusca = ds.animesbusca.nextpage;
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
    if (ds.animeslista.nextpage != '' &&
        _nextLista != ds.animeslista.nextpage) {
      _nextLista = ds.animeslista.nextpage;
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
  return new models.Home();
}

models.DetalheAnime decodeDetalhes(http.Response response) {
  print(response.statusCode);
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);

    models.DetalheAnime ds = new models.DetalheAnime.fromJson(decoded);

    return ds;
  }
  return new models.DetalheAnime();
}

models.AnimeStream decodeStream(http.Response response) {
  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);

    models.AnimeStream ds = new models.AnimeStream.fromJson(decoded);

    return ds;
  }
  return new models.AnimeStream();
}
