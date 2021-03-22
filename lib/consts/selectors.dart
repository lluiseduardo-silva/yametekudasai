class Constantes {
  static const String ANITUBE_EPISODES_LIST =
      '.epiContainer > .epiSubContainer > .epiItem';
  static const String ANITUBE_ANIMES_CONTAINER = '.aniContainer';
  static const String ANITUBE_ANIME_ITEM = '.aniItem';
  static const String ANITUBE_LISTA_PAGINADA_COM_FOTO = '.listaPagAnimes > div';
  static const String ANITUBE_LISTA_PAGINADA_SEM_FOTO = '.listaPagAnimes > a';
  static const String ANITUBE_BASE_HOST = 'www.anitube.site';
  static const String ANITUBE_DEFAULT_SCHEME = 'https';
  static const String ANITUBE_LISTA_LEGENDADA_PATH =
      'lista-de-animes-legendados-online';
  static const String ANITUBE_LISTA_DUBLADA_PATH =
      'lista-de-animes-dublados-online';
  static const String ANITUBE_BUSCA_PAGINADA_COM_FOTO =
      '.searchPagContainer > div';
  static const String ANITUBE_BUSCA_PAGINADA_SEM_FOTO =
      '.searchPagContainer > a';
  static String parseId(String url) =>
      url.replaceAll('https://www.anitube.site', '').replaceAll('/', '');
  static const String ANITUBE_DETALHES_EPISODES_LIST =
      '.pagAniListaContainer > a';
}
