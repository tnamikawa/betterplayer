import 'package:better_player/better_player.dart';
import 'package:better_player_example/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NormalPlayerPage extends StatefulWidget {
  @override
  _NormalPlayerPageState createState() => _NormalPlayerPageState();
}

class _NormalPlayerPageState extends State<NormalPlayerPage> {
  late BetterPlayerController _betterPlayerController;
  late BetterPlayerDataSource _betterPlayerDataSource;

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            fit: BoxFit.contain,
            autoPlay: true,
            looping: true,
            deviceOrientationsAfterFullScreen: [
              DeviceOrientation.portraitDown,
              DeviceOrientation.portraitUp
            ],
            controlsConfiguration: BetterPlayerControlsConfiguration(
              loadingColor: Color(0xff48bcc1),
            ));
    _betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constants.forBiggerBlazesUrl,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration, countDownCapsule: CountDownCapsule(
      true, "サンプル"
    ));
    _betterPlayerController.setupDataSource(_betterPlayerDataSource);
    _betterPlayerController.addEventsListener((evt) {
      print('evt ' + evt.betterPlayerEventType.toString());
      if (evt.betterPlayerEventType == BetterPlayerEventType.countDownDone) {
        _betterPlayerController.play();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Normal player page"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
        ],
      ),
    );
  }
}
