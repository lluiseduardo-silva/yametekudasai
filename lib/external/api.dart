import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:yamete_kudasai/models/busca.g.dart';

import 'package:yamete_kudasai/models/cheeriostream.g.dart';

import 'package:yamete_kudasai/models/detalhes.g.dart';

import 'package:yamete_kudasai/models/generos.g.dart';

import 'package:yamete_kudasai/models/home.g.dart';

const _baseHost = 'nextjs-puppeteer-api.vercel.app';
const _baseScheme = 'https';
const _endpoint = 'api/';
String _busca;
String _nextBusca;
String _nextLista;

class Anitube {
  Future<Busca> busca(String s) async {
    _busca = s;
    http.Response response = await http.get(new Uri(
        host: _baseHost,
        scheme: _baseScheme,
        path: '${_endpoint}cheerio/busca',
        queryParameters: {"busca": _busca, "url": ''}));
    if (response.statusCode == 404) {
      throw NotFoundException('Sem resultados');
    }
    if (response.statusCode == 403) {
      throw BannedExcpetion('Ta foda');
    }
    return decodeBusca(response);
  }

  Future<Busca> nextBusca() async {
    if (_nextBusca != '' && _nextBusca != null) {
      http.Response response = await http.get(new Uri(
          host: _baseHost,
          scheme: _baseScheme,
          path: '${_endpoint}cheerio/busca',
          queryParameters: {"busca": _busca, "url": _nextBusca}));
      if (response.statusCode == 403) {
        throw BannedExcpetion('Ta foda');
      }
      return decodeBusca(response);
    } else {
      throw EmptyParameterException('Não existe proxima pagina');
    }
  }

  Future<Busca> carregarListaDublada(String url) async {
    http.Response response = await http.get(new Uri(
        host: _baseHost,
        scheme: _baseScheme,
        path: '${_endpoint}cheerio/dublados',
        queryParameters: {"url": ''}));
    if (response.statusCode == 403) {
      throw BannedExcpetion('Ta foda');
    }
    return decodeLista(response);
  }

  Future<Busca> carregarListaDubladaNext(String url) async {
    if (_nextLista == '') {
      throw EmptyParameterException('Não existe proxima pagina');
    }
    http.Response response = await http.get(new Uri(
        host: _baseHost,
        scheme: _baseScheme,
        path: '${_endpoint}cheerio/dublados',
        queryParameters: {"url": _nextLista}));
    if (response.statusCode == 403) {
      throw BannedExcpetion('Ta foda');
    }
    return decodeLista(response);
  }

  Future<Busca> carregarListaLegendada(String url) async {
    http.Response response = await http.get(new Uri(
        host: _baseHost,
        scheme: _baseScheme,
        path: '${_endpoint}cheerio/legendados',
        queryParameters: {"url": ''}));
    if (response.statusCode == 403) {
      throw BannedExcpetion('Ta foda');
    }
    return decodeLista(response);
  }

  Future<Busca> carregarListaLegendadaNext(String url) async {
    if (_nextLista == '') {
      throw EmptyParameterException('Não existe proxima pagina');
    }
    http.Response response = await http.get(new Uri(
        host: _baseHost,
        scheme: _baseScheme,
        path: '${_endpoint}cheerio/legendados',
        queryParameters: {"url": _nextLista}));
    if (response.statusCode == 403) {
      throw BannedExcpetion('Ta foda');
    }
    return decodeLista(response);
  }

  Future<Home> carregarHome() async {
    http.Response response = await http.get(new Uri(
      host: _baseHost,
      scheme: _baseScheme,
      path: '${_endpoint}cheerio/home',
    ));
    if (response.statusCode == 403) {
      throw BannedExcpetion('Ta foda');
    }
    return decodeHome(response);
  }

  Future<Detalhes> carregarDetalhes(String s) async {
    http.Response response = await http.get(new Uri(
        host: _baseHost,
        scheme: _baseScheme,
        path: '${_endpoint}cheerio/detalhes',
        queryParameters: {"url": s}));
    if (response.statusCode == 403) {
      throw BannedExcpetion('Ta foda');
    }
    return decodeDetalhes(response);
  }

  Future<CheerioStream> carregarStream(String s) async {
    print(s);
    http.Response response = await http.get(new Uri(
        host: _baseHost,
        scheme: _baseScheme,
        path: '${_endpoint}cheerio/stream',
        queryParameters: {"url": s}));
    if (response.statusCode == 403) {
      throw BannedExcpetion('Ta foda');
    }
    return decodeStream(response);
  }

  Future<List<Generos>> carregarGeneros() async {
    http.Response response = await http.get(new Uri(
        host: _baseHost,
        scheme: _baseScheme,
        path: '${_endpoint}cheerio/generos'));
    if (response.statusCode == 403) {
      throw BannedExcpetion('Ta foda');
    }
    return decodedGenres(response);
  }
}

Busca decodeBusca(http.Response response) {
  if (response.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(response.body);
    Busca ds = new Busca.fromJson(decoded);
    if (ds.nextPage != null) {
      if (_nextBusca != ds.nextPage) {
        _nextBusca = ds.nextPage;
      }
    } else {
      _nextBusca = '';
    }
    return ds;
  } else {
    throw Exception('erro desconhecido');
  }
}

Busca decodeLista(http.Response response) {
  if (response.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(response.body);
    Busca ds = Busca.fromJson(decoded);
    if (ds.nextPage != null) {
      if (_nextLista != ds.nextPage) {
        _nextLista = ds.nextPage;
      }
    } else {
      _nextLista = '';
    }
    return ds;
  } else {
    throw Exception('Falha ao carregas videos');
  }
}

Home decodeHome(http.Response response) {
  if (response.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(response.body);
    return Home.fromJson(decoded);
  }
  throw new Exception('Falha ao carregar home page');
}

Detalhes decodeDetalhes(http.Response response) {
  print(response.statusCode);
  if (response.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(response.body);
    return Detalhes.fromJson(decoded);
  }
  throw new Exception('Falha ao carregar os detalhes');
}

CheerioStream decodeStream(http.Response response) {
  print(response.statusCode);
  if (response.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(response.body);
    Map<String, dynamic> json = decoded;
    // CheerioStream ds = new CheerioStream.fromJson(decoded);
    return CheerioStream.fromJson(json);
  }
  return new CheerioStream();
}

List<Generos> decodedGenres(http.Response response) {
  if (response.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(response.body);
    Map<String, dynamic> json = decoded;
    List<Generos> ds = [];
    json.values.map((e) => ds.add(new Generos.fromJson(e)));
    return ds;
  }
  return [];
}

class NotFoundException implements Exception {
  String cause;
  NotFoundException(this.cause);
}

class EmptyParameterException implements Exception {
  String cause;
  EmptyParameterException(this.cause);
}

class BannedExcpetion implements Exception {
  String cause;
  BannedExcpetion(this.cause);
}

// Map<String, dynamic> json = decoded;
//     json['data'].forEach((v) {
//       ds.add(new CheerioStream.fromJson(v));
//     });