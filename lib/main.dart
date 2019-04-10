import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

void main() => runApp(Vcast());

class Vcast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vcast',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PlayBackButton(),
      ),
    );
  }
}

class PlayBackButton extends StatefulWidget {
  @override
  _PlayBackButtonState createState() => _PlayBackButtonState();
}

class _PlayBackButtonState extends State<PlayBackButton> {
  String url =
      'http://icdn7.downloadezy.live/2019/Majili/320/01%20-%20One%20Boy%20One%20Girl.mp3';
  FlutterSound _sound;
  bool _isPlaying = false;

  void _stop() async {
    await _sound.stopPlayer();
  }

  void _play() async {
    await _sound.startPlayer(url);
  }

  @override
  void initState() {
    super.initState();
    _sound = FlutterSound();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
      onPressed: () {
        if (_isPlaying) {
          _stop();
        } else {
          _play();
        }
        setState(() => _isPlaying = !_isPlaying);
      },
    );
  }
}
