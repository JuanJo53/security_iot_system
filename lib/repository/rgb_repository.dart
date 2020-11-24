import 'package:http/http.dart' as http;

class RgbRepository{

  Future<bool> estadoRgbRojo(int valor) async{
    String url = "http://blynk-cloud.com/QWI85H-jllIzyH1nTr2rqSH-njVuciR0/update/V0?value="+ valor.toString();
    try{
      var res = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    if(res.statusCode==200){
      print("Done");
      return true;
    }else{
      return false;
    }

    }
    catch(error){
      print(error);
      return false;
    }
  }
  Future<bool> estadoRgbVerde(int valor) async{
    String url = "http://blynk-cloud.com/QWI85H-jllIzyH1nTr2rqSH-njVuciR0/update/V1?value="+ valor.toString();
    try{
      var res = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(res.statusCode==200){
        print("Done");
        return true;
      }else{
        return false;
      }

    }
    catch(error){
      print(error);
      return false;
    }
  }
  Future<bool> estadoRgbAzul(int valor) async{
    String url = "http://blynk-cloud.com/QWI85H-jllIzyH1nTr2rqSH-njVuciR0/update/V2?value="+ valor.toString();
    try{
      var res = await http.get(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(res.statusCode==200){
        print("Done");
        return true;
      }else{
        return false;
      }

    }
    catch(error){
      print(error);
      return false;
    }
  }
}