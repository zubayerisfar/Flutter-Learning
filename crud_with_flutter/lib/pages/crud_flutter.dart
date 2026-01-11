import 'package:http/http.dart' as http;

const String baseUrl ="https://orthotropous-keisha-ungeodetically.ngrok-free.dev/";

class BaseClient{

  var client= http.Client();

  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl+api);
    var response= await client.get(url);
    
    if( response.statusCode==200){
      return response.body;
    } 
    else {
      throw Exception('Failed to load data');
    }
  }
  Future<dynamic> get_user(String api) async {
    var url = Uri.parse(baseUrl+api);
    var response= await client.get(url);
    
    if( response.statusCode==200){
      return response.body;
    } 
    else {
      throw Exception('Failed to load data');
    }
  }
}