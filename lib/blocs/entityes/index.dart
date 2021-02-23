//Modelos Relacionados a Stream de animes
class AnimeStream {
  List<Fontes> fontes;
  String data;

  AnimeStream({this.fontes, this.data});

  AnimeStream.fromJson(Map<String, dynamic> json) {
    if (json['fontes'] != null) {
      fontes = new List<Fontes>();
      json['fontes'].forEach((v) {
        fontes.add(new Fontes.fromJson(v));
      });
    }
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fontes != null) {
      data['fontes'] = this.fontes.map((v) => v.toJson()).toList();
    }
    data['data'] = this.data;
    return data;
  }
}

class Fontes {
  String url;
  Headers headers;

  Fontes({this.url, this.headers});

  Fontes.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    headers =
    json['headers'] != null ? new Headers.fromJson(json['headers']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    if (this.headers != null) {
      data['headers'] = this.headers.toJson();
    }
    return data;
  }
}

class Headers {
  String referer;
  String userAgent;
  String acceptEncoding;
  String range;

  Headers({this.referer, this.userAgent, this.acceptEncoding, this.range});

  Headers.fromJson(Map<String, dynamic> json) {
    referer = json['referer'];
    userAgent = json['user-agent'];
    acceptEncoding = json['accept-encoding'];
    range = json['range'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['referer'] = this.referer;
    data['user-agent'] = this.userAgent;
    data['accept-encoding'] = this.acceptEncoding;
    data['range'] = this.range;
    return data;
  }
}
//Fim dos modelos relacionados a stream de animes

//Modelos relacionados aos detalhes dos animes
class DetalheAnime {
  Detalhes detalhes;
  String data;

  DetalheAnime({this.detalhes, this.data});

  DetalheAnime.fromJson(Map<String, dynamic> json) {
    detalhes = json['detalhes'] != null
        ? new Detalhes.fromJson(json['detalhes'])
        : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.detalhes != null) {
      data['detalhes'] = this.detalhes.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

class Detalhes {
  String titulo;
  String sinopse;
  String ano;
  String capa;
  String pageLink;
  List<Episodios> episodios;

  Detalhes({this.titulo, this.sinopse, this.ano, this.capa, this.episodios, this.pageLink});

  Detalhes.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    sinopse = json['sinopse'];
    ano = json['ano'];
    capa = json['capa'];
    pageLink = json['pageLink'];
    if (json['episodios'] != null) {
      episodios = new List<Episodios>();
      json['episodios'].forEach((v) {
        episodios.add(new Episodios.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['sinopse'] = this.sinopse;
    data['ano'] = this.ano;
    data['capa'] = this.capa;
    data['pageLink'] = this.pageLink;
    if (this.episodios != null) {
      data['episodios'] = this.episodios.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Episodios {
  String titulo;
  String link;

  Episodios({this.titulo, this.link});

  Episodios.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['link'] = this.link;
    return data;
  }
}
//Fim dos modelos relacionados aos detalhes dos animes
//Modelos relacionados a homepage
class Home {
  Animes animes;
  String data;

  Home({this.animes, this.data});

  Home.fromJson(Map<String, dynamic> json) {
    animes =
    json['animes'] != null ? new Animes.fromJson(json['animes']) : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.animes != null) {
      data['animes'] = this.animes.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

class Animes {
  List<MaisAssistidos> maisAssistidos;
  List<EpisodiosRecentes> episodiosRecentes;
  List<Adicionados> adicionados;
  List<Lancamentos> lancamentos;

  Animes(
      {this.maisAssistidos,
        this.episodiosRecentes,
        this.adicionados,
        this.lancamentos});

  Animes.fromJson(Map<String, dynamic> json) {
    if (json['MaisAssistidos'] != null) {
      maisAssistidos = new List<MaisAssistidos>();
      json['MaisAssistidos'].forEach((v) {
        maisAssistidos.add(new MaisAssistidos.fromJson(v));
      });
    }
    if (json['EpisodiosRecentes'] != null) {
      episodiosRecentes = new List<EpisodiosRecentes>();
      json['EpisodiosRecentes'].forEach((v) {
        episodiosRecentes.add(new EpisodiosRecentes.fromJson(v));
      });
    }
    if (json['Adicionados'] != null) {
      adicionados = new List<Adicionados>();
      json['Adicionados'].forEach((v) {
        adicionados.add(new Adicionados.fromJson(v));
      });
    }
    if (json['Lancamentos'] != null) {
      lancamentos = new List<Lancamentos>();
      json['Lancamentos'].forEach((v) {
        lancamentos.add(new Lancamentos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.maisAssistidos != null) {
      data['MaisAssistidos'] =
          this.maisAssistidos.map((v) => v.toJson()).toList();
    }
    if (this.episodiosRecentes != null) {
      data['EpisodiosRecentes'] =
          this.episodiosRecentes.map((v) => v.toJson()).toList();
    }
    if (this.adicionados != null) {
      data['Adicionados'] = this.adicionados.map((v) => v.toJson()).toList();
    }
    if (this.lancamentos != null) {
      data['Lancamentos'] = this.lancamentos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaisAssistidos {
  String title;
  String cover;
  String sub;
  String pageLink;

  MaisAssistidos({this.title, this.cover, this.sub, this.pageLink});

  MaisAssistidos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cover = json['cover'];
    sub = json['sub'];
    pageLink = json['pageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['sub'] = this.sub;
    data['pageLink'] = this.pageLink;
    return data;
  }
}

class EpisodiosRecentes {
  String titulo;
  String linkVisualizaAoEP;
  String thumbnail;
  String tipo;

  EpisodiosRecentes(
      {this.titulo, this.linkVisualizaAoEP, this.thumbnail, this.tipo});

  EpisodiosRecentes.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    linkVisualizaAoEP = json['linkVisualizaçaoEP'];
    thumbnail = json['thumbnail'];
    tipo = json['tipo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titulo'] = this.titulo;
    data['linkVisualizaçaoEP'] = this.linkVisualizaAoEP;
    data['thumbnail'] = this.thumbnail;
    data['tipo'] = this.tipo;
    return data;
  }
}

class Adicionados {
  String title;
  String cover;
  String tipo;
  String pageLink;

  Adicionados({this.title, this.cover, this.tipo, this.pageLink});

  Adicionados.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cover = json['cover'];
    tipo = json['tipo'];
    pageLink = json['pageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['tipo'] = this.tipo;
    data['pageLink'] = this.pageLink;
    return data;
  }
}

class Lancamentos {
  String title;
  String cover;
  String sub;
  String pageLink;

  Lancamentos({this.title, this.cover, this.sub, this.pageLink});

  Lancamentos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cover = json['cover'];
    sub = json['sub'];
    pageLink = json['pageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['sub'] = this.sub;
    data['pageLink'] = this.pageLink;
    return data;
  }
}
//Fim dos modelos relacionados a HomePage de animes
//Modelos de listagem de todos animes
class Lista {
  Animeslista animeslista;
  String data;

  Lista({this.animeslista, this.data});

  Lista.fromJson(Map<String, dynamic> json) {
    animeslista = json['animeslista'] != null
        ? new Animeslista.fromJson(json['animeslista'])
        : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.animeslista != null) {
      data['animeslista'] = this.animeslista.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

class Animeslista {
  List<Dadoslista> dadoslista;
  String nextpage;

  Animeslista({this.dadoslista, this.nextpage});

  Animeslista.fromJson(Map<String, dynamic> json) {
    if (json['dadoslista'] != null) {
      dadoslista = new List<Dadoslista>();
      json['dadoslista'].forEach((v) {
        dadoslista.add(new Dadoslista.fromJson(v));
      });
    }
    nextpage = json['nextpage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dadoslista != null) {
      data['dadoslista'] = this.dadoslista.map((v) => v.toJson()).toList();
    }
    data['nextpage'] = this.nextpage;
    return data;
  }
}

class Dadoslista {
  String title;
  String pageLink;

  Dadoslista({this.title, this.pageLink});

  Dadoslista.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    pageLink = json['pageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['pageLink'] = this.pageLink;
    return data;
  }
}
//Fim dos modelos relacionados a lista de animes
//Modelos de busca
class Busca {
  Animesbusca animesbusca;
  String data;

  Busca({this.animesbusca, this.data});

  Busca.fromJson(Map<String, dynamic> json) {
    animesbusca = json['animesbusca'] != null
        ? new Animesbusca.fromJson(json['animesbusca'])
        : null;
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.animesbusca != null) {
      data['animesbusca'] = this.animesbusca.toJson();
    }
    data['data'] = this.data;
    return data;
  }
}

class Animesbusca {
  List<Dadosbusca> dadosbusca;
  String nextpage;

  Animesbusca({this.dadosbusca, this.nextpage});

  Animesbusca.fromJson(Map<String, dynamic> json) {
    if (json['dadosbusca'] != null) {
      dadosbusca = new List<Dadosbusca>();
      json['dadosbusca'].forEach((v) {
        dadosbusca.add(new Dadosbusca.fromJson(v));
      });
    }
    nextpage = json['nextpage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dadosbusca != null) {
      data['dadosbusca'] = this.dadosbusca.map((v) => v.toJson()).toList();
    }
    data['nextpage'] = this.nextpage;
    return data;
  }
}

class Dadosbusca {
  String title;
  String cover;
  String sub;
  String pageLink;

  Dadosbusca({this.title, this.cover, this.sub, this.pageLink});

  Dadosbusca.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    cover = json['cover'];
    sub = json['sub'];
    pageLink = json['pageLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['sub'] = this.sub;
    data['pageLink'] = this.pageLink;
    return data;
  }
}
//Fim dos modelos relacionados a busca de animes