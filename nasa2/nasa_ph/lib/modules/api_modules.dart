import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/photos_models.dart';

class NasaApi {
  static const String apiKey = 'eQnprvXukgfNomTanZiHT1DqLApcABzFjI350dyZ';

  Future<List<Photo>> fetchPhotos() async {
    final url ='https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //Поле photos извлекается из JSON-ответа и преобразуется в список объектов Photo с помощью метода fromJson
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> photosJson = data['photos'];
      return photosJson.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('ошибка загрузки');
    }
  }
}