import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = const String.fromEnvironment('TMDB_API_KEY');
  final String _language = 'en-GB';
  final String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> casting = {};

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

  Future<List<Cast>> getMovieCast(int movieId) async {
    var url = Uri.https(_baseUrl, '3/movie/$movieId/credits',
        {'api_key': _apiKey, 'language': _language});

    final result = await http.get(url);

    final movieCreditsResponse = MovieCreditsResponse.fromJson(result.body);

    casting[movieId] = movieCreditsResponse.cast;
    return movieCreditsResponse.cast;
  }
}
