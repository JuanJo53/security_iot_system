import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:security_iot_system/constants.dart';
import 'package:security_iot_system/repository/foco1_repository.dart';
import 'package:security_iot_system/repository/foco2_repository.dart';
import 'package:security_iot_system/repository/rgb_repository.dart';
import 'package:security_iot_system/repository/servomotor_repository.dart';
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

  Foco1Repository foco1repository = Foco1Repository();
  Foco2Repository foco2repository = Foco2Repository();
  ServomotorRepository servomotorRepository = ServomotorRepository();
  RgbRepository rgbRepository = RgbRepository();

  void comandos(String comando) {
    switch(comando){
      case "prender foco uno":
        print('Foco uno prendido');
        foco1repository.estadoFoco1(1023);
        break;
      case "apagar foco uno":
        print('Apagar foco uno');
        foco1repository.estadoFoco1(0);
        break;
      case "prender foco dos":
        print('Foco dos prendido');
        foco2repository.estadoFoco2(1023);
        break;
      case "apagar foco dos":
        print('Apagar foco dos');
        foco2repository.estadoFoco2(0);
        break;
      case "prender motor":
        print('Prende motor');
        servomotorRepository.estadoServomotor(1);
        break;
      case "apagar motor":
        print('Apagar motor');
        servomotorRepository.estadoServomotor(0);
        break;
      case "prender foco rojo":
        print('Prende rojo');
        rgbRepository.estadoRgbRojo(1);
        break;
      case "apagar foco rojo":
        print('Apagar rojo');
        rgbRepository.estadoRgbRojo(0);
        break;
      case "prender foco verde":
        print('Prende verde');
        rgbRepository.estadoRgbVerde(1);
        break;
      case "apagar foco verde":
        print('Apagar verde');
        rgbRepository.estadoRgbVerde(0);
        break;
      case "prender foco azul":
        print('Prende azul');
        rgbRepository.estadoRgbAzul(1);
        break;
      case "apagar foco azul":
        print('Apagar azul');
        rgbRepository.estadoRgbAzul(0);
        break;
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        print("Microfono "+ available.toString());
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            print(_text);
            String a = _text.toLowerCase();
            print(a);
            comandos(a);
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
