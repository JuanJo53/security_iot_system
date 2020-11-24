import 'package:http/http.dart' as http;

class Foco2Repository{

  Future<bool> estadoFoco2(int valor) async{
    String url = "http://blynk-cloud.com/QWI85H-jllIzyH1nTr2rqSH-njVuciR0/update/V4?value="+ valor.toString();
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