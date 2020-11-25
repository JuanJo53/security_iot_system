import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:security_iot_system/constants.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'components/body.dart';

class HomeTwo extends StatefulWidget{
  HomeTwo({Key key, @required this.username}) : super(key: key);

  final String username;
  static String routeName = "/home";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeTwo();
  }

}

class _HomeTwo extends State<HomeTwo> {

  _HomeTwo({this.username});

  bool _isListening = false;
  stt.SpeechToText _speech;
  double _confidence = 1.0;
  String _text = 'Press the button and start speaking';

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            print(_text);
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  final String username;
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      /*FloatingActionButton(
        onPressed: (){
          print('Flotante');
       },
        child: Icon(Icons.mic),
        backgroundColor: kPrimaryColor,
      ),*/


    );
  }
}
