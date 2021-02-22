
import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:movies_flutter_app/src/model/actors.dart';
import 'package:movies_flutter_app/src/model/list_actors.dart';
import 'package:movies_flutter_app/src/model/list_movies.dart';
import 'package:movies_flutter_app/src/model/movie.dart';
import 'package:movies_flutter_app/src/utils/constants.dart';


class MovieProvider{

  String _language = 'en-US';
  String restURLNow = '3/movie/now_playing';
  String restURLPopular = '3/movie/popular';
  String restURLSearchMovie = '3/search/movie';

  // Streams
  int _nPage = 0;
  bool _loadingMovies = false;
  List<Movie> _popularMovies = [];

  final _popularMoviesStreamController = StreamController<List<Movie>>.broadcast();
  Function(List<Movie>) get popularMoviesSink => _popularMoviesStreamController.sink.add;
  Stream<List<Movie>> get popularMoviesStream => _popularMoviesStreamController.stream;

  void disposeProvider(){
    _popularMoviesStreamController?.close();
  }

  Future<List<Movie>> _getResponse(Uri urlFinal) async {

    final response = await http.get(urlFinal);
    final decodeData = json.decode(response.body);
    final listOfMovies = new ListOfMovies.fromJsonList(decodeData['results']);

    return listOfMovies.items;
  }

  Future<List<Movie>> getNowMovies() async {
    final urlFinal = Uri.https(Constants.BASE_URL, restURLNow, {
      'api_key'  : Constants.API_KEY,
      'language' : _language,
      // 'page' : nPages
    });
    return await _getResponse(urlFinal);
    // final response = await http.get(urlFinal);
    // final decodeData = json.decode(response.body);
    // final listOfMovies = new ListOfMovies.fromJsonList(decodeData['results']);
    //
    // return listOfMovies.items;
  }

  Future<List<Movie>> getPopularMovies() async {

    if (_loadingMovies ) return [];

    _loadingMovies = true;

    (_nPage < 500) ? _nPage++ : _nPage=500;

    final urlFinal = Uri.https(Constants.BASE_URL, restURLPopular, {
      'api_key' : Constants.API_KEY,
      'language': _language,
      'page'    : _nPage.toString(),
    });

    final response = await _getResponse( urlFinal );

    // Stream
    _popularMovies.addAll( response );
    popularMoviesSink( _popularMovies );

    _loadingMovies = false;

    return response;
  }

  Future<List<Actors>> getActors( String movieId ) async {
    String restURLActors = '3/movie/$movieId/credits';

    final urlFinal = Uri.https(Constants.BASE_URL, restURLActors, {
      'api_key'  : Constants.API_KEY,
      'language' : _language,
      // 'page' : nPages
    });

    final response = await http.get(urlFinal);
    final decodeData = json.decode(response.body);
    final actors = new ListOfActors.fromJsonList(decodeData['cast']);

    return actors.listOfActors;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final urlFinal = Uri.https(Constants.BASE_URL, restURLSearchMovie, {
      'api_key'  : Constants.API_KEY,
      'language' : _language,
      'query'    : query
    });

    return await _getResponse(urlFinal);
  }
}