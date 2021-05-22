import 'package:movie_test/model/movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final String error;

  MovieResponse(this.movies, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json) : movies = (
    json["results"] as List).map((i) => new Movie.fromJson(i)).toList(),
    error = "";

  MovieResponse.withError(String errorVal) : movies = 
  List(),
  error = errorVal;
}