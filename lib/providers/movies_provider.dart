import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = const String.fromEnvironment('TMDB_API_KEY');
  final String _language = 'en-GB';
  final String _page = '1';

  MoviesProvider() {
    print('Movies Provider Initialised!');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');

    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['results'];

      print('Number: $itemCount');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
