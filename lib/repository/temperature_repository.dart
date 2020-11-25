import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

class TemperatureRepository{
  Future<double> estadoTemperature() async{
    String url = "http://blynk-cloud.com/QWI85H-jllIzyH1nTr2rqSH-njVuciR0/get/A0";
    try{
      var res = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var t = jsonDecode(res.body);
      double valor = double.parse(t[0]);
      if(res.statusCode==200){
        //print("Done");
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