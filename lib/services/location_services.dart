
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = 'AIzaSyBxKqqALLOLyTYNed3HlKZ3FI8-PNMjPDM';
  Future<String> getPlaceID(String input) async{
    final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var placeid = json['candidates'][0]['place_id'] as String;

    return placeid;
  }

  Future<Map<String, dynamic>> getPlace(String input) async{
    final placeId = await getPlaceID(input);
    final String url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var results = json['result'] as Map<String, dynamic>;

    print(results);
    return results;

  }

}