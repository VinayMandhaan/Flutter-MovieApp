import 'package:movie_test/model/person.dart';

class PersonResponse {
  final List<Person> person;
  final String error;

  PersonResponse(this.person, this.error);

  PersonResponse.fromJson(Map<String, dynamic> json) : person = (
    json["results"] as List).map((i) => new Person.fromJson(i)).toList(),
    error = "";

  PersonResponse.withError(String errorVal) : person = 
  List(),
  error = errorVal;
}