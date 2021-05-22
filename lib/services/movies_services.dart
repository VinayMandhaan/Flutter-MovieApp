import 'package:dio/dio.dart' as dartReq;
import 'package:movie_test/model/genre_response.dart';
import 'package:movie_test/model/movie_response.dart';
import 'package:movie_test/model/person_response.dart';

class MovieServices {
  final String apiKey = "1d098d9189d2470aee8cfd9a7fdaa894";
  static String mainUrl = "https://api.themoviedb.org/3";
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';
  var getPersonUrl = '$mainUrl/trending/person/week';

  Future<MovieResponse> getMovies() async {
    
    var params = {
      "api_key":apiKey,
      "language": "en-US",
      "page":1
    };

    try {
      dartReq.Response response = await dartReq.Dio().get(getPopularUrl, queryParameters:params);
      return MovieResponse.fromJson(response.data);
    } catch (err) {
      print(err);
      return MovieResponse.withError(err);
      }
  }

  Future<MovieResponse> getPlayingMovies() async {

    var params = {
      "api_key":apiKey,
      "language": "en-US",
      "page":1
    };

    try {
      dartReq.Response response = await dartReq.Dio().get(getPlayingUrl, queryParameters:params);
      return MovieResponse.fromJson(response.data);
    } catch (err) {
      print(err);
      return MovieResponse.withError(err);
      }
  }

  Future<GenreResponse> getGenre() async {

    var params = {
      "api_key":apiKey,
      "language": "en-US"
    };

    try {
      dartReq.Response response = await dartReq.Dio().get(getGenresUrl, queryParameters:params);
      return GenreResponse.fromJson(response.data);
    } catch (err) {
      print(err);
      return GenreResponse.withError(err);
      }
  }

  Future<PersonResponse> getPersons() async {

    var params = {
      "api_key":apiKey,
    };

    try {
      dartReq.Response response = await dartReq.Dio().get(getPersonUrl, queryParameters:params);
      return PersonResponse.fromJson(response.data);
    } catch (err) {
      print(err);
      return PersonResponse.withError(err);
      }
  }

  Future<MovieResponse> getMoviesByGenre(int id) async {

    var params = {
      "api_key":apiKey,
      "language": "en-US",
      "page":1,
      "with_genres": id
    };

    try {
      dartReq.Response response = await dartReq.Dio().get(getMoviesUrl, queryParameters:params);
      return MovieResponse.fromJson(response.data);
    } catch (err) {
      print(err);
      return MovieResponse.withError(err);
      }
  }

  
}
