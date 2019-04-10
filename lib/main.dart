import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vcast',
      home: BoringPage(),
    );
  }
}

class BoringPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: VcastApp()),
    );
  }
}

class VcastApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 9,
          child: Placeholder(),
        ),
        Flexible(
          flex: 2,
          child: AudioControls(),
        ),
      ],
    );
  }
}

class AudioControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlayBackButtons(),
      ],
    );
  }
}

class PlayBackButtons extends StatefulWidget {
  @override
  _PlayBackButtonsState createState() => _PlayBackButtonsState();
}

class _PlayBackButtonsState extends State<PlayBackButtons> {
  String url =
      'http://icdn7.downloadezy.live/2019/Majili/320/01%20-%20One%20Boy%20One%20Girl.mp3';
  FlutterSound _sound;
  bool _isPlaying = false;
  double _playPosition;
  Stream<PlayStatus> _playerSubscription;

  void _stop() async {
    await _sound.stopPlayer();
    setState(() => _isPlaying = false);
  }

  void _play() async {
    await _sound.startPlayer(url);

    _playerSubscription = _sound.onPlayerStateChanged
      ..listen((e) {
        if (e != null) {
          print(e.currentPosition);
          setState(() => _playPosition = (e.currentPosition / e.duration));
        }
      });
    setState(() => _isPlaying = true);
  }

  void _fastRewind() {}

  void _fastForward() {}

  @override
  void initState() {
    super.initState();
    _sound = FlutterSound();
    _playPosition = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Slider(
          value: _playPosition,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.fast_rewind),
              onPressed: null,
            ),
            IconButton(
              icon: _isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
              onPressed: () {
                if (_isPlaying) {
                  _stop();
                } else {
                  _play();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.fast_forward),
              onPressed: null,
            ),
          ],
        ),
      ],
    );
  }
}
