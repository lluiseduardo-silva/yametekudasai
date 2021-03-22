import 'dart:io';

import 'package:yamete_kudasai/errors/api.errors.dart';
import 'package:yamete_kudasai/parser/detalhe.parser.dart';
import 'package:yamete_kudasai/parser/home.parsers.dart';
import 'package:yamete_kudasai/parser/listas.parser.dart';
import 'package:yamete_kudasai/parser/stream.parser.dart';
import 'package:yamete_kudasai/models/detalhe.model.dart';
import 'package:yamete_kudasai/models/home.model.dart';
import 'package:yamete_kudasai/models/lista.model.dart';
import 'package:yamete_kudasai/models/stream.model.dart';
import '../consts/selectors.dart';
import 'package:http/http.dart' as http;

class AnitubeService {
  var page = 0;
  var hasNextPage = false;
  Future<Home> carregarHome() async {
    var parsed = Uri(
        host: Constantes.ANITUBE_BASE_HOST,
        scheme: Constantes.ANITUBE_DEFAULT_SCHEME);
    try {
      var response = await http.get(parsed);
      if (response.statusCode == 403) {
        throw OverRatedException();
      }
      if (response.statusCode == 404) {
        throw NotFoundException();
      }
      return HomeParser().parseHome(response);
    } on SocketException {
      throw NoInternetConnection();
    }
  }

  Future<Detalhe> carregarDetalhe(String id) async {
    var uri = Uri(
      host: Constantes.ANITUBE_BASE_HOST,
      scheme: Constantes.ANITUBE_DEFAULT_SCHEME,
      path: id,
    );

    try {
      var response = await http.get(uri);
      if (response.statusCode == 403) {
        throw OverRatedException();
      }
      if (response.statusCode == 404) {
        throw NotFoundException();
      }
      var data = DetalheParser().praseDetalhe(response);
      data.id = id;
      return data;
    } on SocketException {
      throw NoInternetConnection();
    }
  }

  Future<AnimeStream> carregarStream(String id) async {
    var uri = Uri(
      host: Constantes.ANITUBE_BASE_HOST,
      scheme: Constantes.ANITUBE_DEFAULT_SCHEME,
      path: id,
    );
    try {
      var response = await http.get(uri);
      if (response.statusCode == 403) {
        throw OverRatedException();
      }
      if (response.statusCode == 404) {
        throw NotFoundException();
      }
      var data = StreamParser().parseStream(response);
      data.id = id;
      return data;
    } on SocketException {
      throw NoInternetConnection();
    }
  }

  Future<List<Lista>> carregarDublados({bool firstPage, String letra}) async {
    var uri = Uri();
    if (firstPage) {
      page = 1;
      uri = Uri(
          host: Constantes.ANITUBE_BASE_HOST,
          scheme: Constantes.ANITUBE_DEFAULT_SCHEME,
          path: Constantes.ANITUBE_LISTA_DUBLADA_PATH,
          queryParameters: {'letra': letra});
    } else if (hasNextPage) {
      uri = Uri(
          host: Constantes.ANITUBE_BASE_HOST,
          scheme: Constantes.ANITUBE_DEFAULT_SCHEME,
          path: '${Constantes.ANITUBE_LISTA_DUBLADA_PATH}/page/$page',
          queryParameters: {'letra': letra == '#' ? '#' : letra});
    }
    try {
      if (uri.toString() == '') {
        throw NoHaveData();
      }
      var response = await http.get(uri);
      if (response.statusCode == 403) {
        throw OverRatedException();
      }
      if (response.statusCode == 404) {
        throw NotFoundException();
      }
      if (ListasParser().parseNextPage(response) != '') {
        hasNextPage = true;
        page++;
      } else {
        hasNextPage = false;
      }
      return ListasParser().parseDubAndSub(response);
    } on SocketException {
      throw NoInternetConnection();
    }
  }

  Future<List<Lista>> carregarLegendados({bool firstPage, String letra}) async {
    var uri = Uri();
    if (firstPage) {
      page = 1;
      uri = Uri(
          host: Constantes.ANITUBE_BASE_HOST,
          scheme: Constantes.ANITUBE_DEFAULT_SCHEME,
          path: Constantes.ANITUBE_LISTA_LEGENDADA_PATH,
          queryParameters: {'letra': letra});
    } else if (hasNextPage) {
      uri = Uri(
          host: Constantes.ANITUBE_BASE_HOST,
          scheme: Constantes.ANITUBE_DEFAULT_SCHEME,
          path: '${Constantes.ANITUBE_LISTA_LEGENDADA_PATH}/page/$page',
          queryParameters: {'letra': letra});
    }
    if (uri.toString() == '') {
      throw NoHaveData();
    }
    try {
      var response = await http.get(uri);
      if (response.statusCode == 403) {
        throw OverRatedException();
      }
      if (response.statusCode == 404) {
        throw NotFoundException();
      }
      if (ListasParser().parseNextPage(response) != '') {
        hasNextPage = true;
        page++;
      } else {
        hasNextPage = false;
      }
      return ListasParser().parseDubAndSub(response);
    } on SocketException {
      throw NoInternetConnection();
    }
  }

  Future<List<Lista>> carregarBusca({bool firstPage, String busca}) async {
    var uri = Uri();
    if (firstPage) {
      page = 1;
    }
    if (firstPage) {
      uri = Uri(
          host: Constantes.ANITUBE_BASE_HOST,
          scheme: Constantes.ANITUBE_DEFAULT_SCHEME,
          queryParameters: {'s': busca});
    } else if (hasNextPage) {
      uri = Uri(
          host: Constantes.ANITUBE_BASE_HOST,
          scheme: Constantes.ANITUBE_DEFAULT_SCHEME,
          path: 'page/$page',
          queryParameters: {'s': busca});
    }
    if (uri.toString() == '') {
      throw NoHaveData();
    }
    try {
      var response = await http.get(uri);

      if (response.statusCode == 403) {
        throw OverRatedException();
      }
      if (response.statusCode == 404) {
        throw NotFoundException();
      }
      if (ListasParser().parseNextPage(response) != '') {
        hasNextPage = true;
        page++;
      } else {
        hasNextPage = false;
      }
      return ListasParser().parseSearchAndCategory(response);
    } on SocketException {
      throw NoInternetConnection();
    }
  }
}
