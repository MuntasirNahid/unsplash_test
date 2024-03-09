import 'package:http/http.dart' as http;
import 'package:unsplash_image/styles/texts.dart';
import 'package:unsplash_image/utils/logger.dart';

class ApiService {
  ApiService._internal();
  static final ApiService _instance = ApiService._internal();

  static const baseUrl = 'https://api.unsplash.com/';

  factory ApiService() {
    return _instance;
  }

  final Logger _logger = Logger.getLogger((ApiService).toString());

  Future<http.Response> fetchPhotos() async {
    Uri url = Uri.parse(
      '$baseUrl/photos/?per_page=10&client_id=$clientId',
    );

    return await http.get(
      url,
    );
  }

  Future<http.Response> searchPhotos({
    required String query,
  }) async {
    Uri url = Uri.parse(
      //will
      '$baseUrl/search/photos?per_page=10&query=$query&client_id=$clientId',
    );

    return await http.get(
      url,
    );
  }
}
//https://api.unsplash.com/photos?per_page=3&query=football&client_id=1X0yZh0oIPvi1S7rK8qTWyhXrTQoyRVVCeDZap-jVtI'
