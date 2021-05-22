import 'package:flutter/material.dart';
import 'package:movie_test/model/genre_response.dart';
import 'package:movie_test/services/movies_services.dart';
import 'package:movie_test/widgets/genre_list.dart';
import '../model/genre.dart';
import '../styles/theme.dart' as Style;

class MovieGenre extends StatefulWidget {
  @override
  _MovieGenreState createState() => _MovieGenreState();
}

class _MovieGenreState extends State<MovieGenre> {

  var movieGenre = null;
  @override
  void initState() {
    movieGenre = MovieServices().getGenre();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return FutureBuilder<GenreResponse>(
      future: movieGenre,
      // ignore: missing_return
      builder: (context, AsyncSnapshot <GenreResponse> snapshot) {
        if(snapshot.hasData){
          if(snapshot.data.error !=null && snapshot.data.error.length > 0){
            return _errorWidget(snapshot.data.error);
          }
          return _genreWidget(snapshot.data);
        } else if (snapshot.hasError){
          return _errorWidget(snapshot.error);
        } else {
          return _loadingWidget();
        }
      }
    );
  }

  Widget _loadingWidget(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          )
        ],
      )
    );
  }

  Widget _errorWidget(String error){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$error')
        ],
      ),
    );
  }

  Widget _genreWidget(GenreResponse data){
    List <Genre> genre = data.genre;
    if(genre.length == 0){
      return Container(
        child: Text('Genre Not Found'),
      );
    } else {
      return GenreList(genres: genre);
    }
  }
}