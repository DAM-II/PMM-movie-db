import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/now_playing_response.dart';
import 'package:movies_app/models/popular_movies_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = const String.fromEnvironment('TMDB_API_KEY');
  final String _language = 'en-GB';
  final String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    print('Movies Provider Initialised!');
    this.getOnDisplayMovies();
    this.getOnPopular();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');

    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnPopular() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final popularMoviesResponse = PopularMoviesResponse.fromJson(result.body);

    popularMovies = popularMoviesResponse.results;
    notifyListeners();
  }
}
