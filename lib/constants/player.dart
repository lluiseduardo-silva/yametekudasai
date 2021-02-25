import 'package:better_player/better_player.dart';

class MountPlayer {
  BetterPlayer mountWithUrl(String url) {
    return BetterPlayer(
      controller: BetterPlayerController(new BetterPlayerConfiguration(
        fullScreenByDefault: true,
        aspectRatio: 16 / 9,
        autoDispose: true,
        autoPlay: true,
        allowedScreenSleep: false,
        handleLifecycle: true,
      ))
        ..setupDataSource(new BetterPlayerDataSource.network(url,
            headers: {'referer': 'https://anitube.site'})),
    );
  }
}
