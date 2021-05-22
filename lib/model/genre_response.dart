import 'package:movie_test/model/genre.dart';

class GenreResponse {
  final List<Genre> genre;
  final String error;

  GenreResponse(this.genre, this.error);

  GenreResponse.fromJson(Map<String, dynamic> json) : genre = (
    json["genres"] as List).map((i) => new Genre.fromJson(i)).toList(),
    error = "";

  GenreResponse.withError(String errorVal) : genre = 
  List(),
  error = errorVal;
}