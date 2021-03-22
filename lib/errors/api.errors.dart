class OverRatedException implements Exception {
  final String cause;
  OverRatedException({
    this.cause,
  });
}

class NotFoundException implements Exception {
  final String cause;
  NotFoundException({
    this.cause,
  });
}

class NoHaveData implements Exception {
  final String cause;
  NoHaveData({
    this.cause,
  });
}

class NoInternetConnection implements Exception {
  final String cause;

  NoInternetConnection({this.cause});
}
