import 'dart:convert';

import 'package:http/http.dart' as http;

class MoveSensorRepository{
  Future<int> estadoSensor() async{
    String url = "http://blynk-cloud.com/QWI85H-jllIzyH1nTr2rqSH-njVuciR0/get/V5";
    try{
      var res = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var t = jsonDecode(res.body);
      int valor = int.parse(t[0]);
      if(res.statusCode==200){
        print('Estado: '+valor.toString());
        return valor;
      }else{
        return null;
      }

    }
    catch(error){
      print(error);
      return null;
    }
  }
}