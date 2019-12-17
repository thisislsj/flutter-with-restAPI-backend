//configure rest api URL and functions for send and receive data

import 'dart:convert';
import 'package:http/http.dart' as http;

class URLS{
  static const String BASE_URL = 'http://dummy.restapiexample.com/api/v1';
  //define the API URL, here a dummy rest api is used
}

class ApiService{
  static Future<List<dynamic>>getEmployees() async{
    final response = await http.get('${URLS.BASE_URL}/employees');
    if(response.statusCode==200){
      return json.decode(response.body);
    }else{
      return null;
    }
  }


static Future<bool> addEmployee(body) async{
  final response= await http.post('${URLS.BASE_URL}/create',body: body);
  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}

}