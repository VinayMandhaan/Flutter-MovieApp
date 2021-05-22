import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_test/model/movie.dart';
import 'package:movie_test/model/movie_response.dart';
import 'package:movie_test/services/movies_services.dart';
import 'package:page_indicator/page_indicator.dart';
import '../styles/theme.dart' as Style;

class Playing extends StatefulWidget {
  @override
  _PlayingState createState() => _PlayingState();
}

class _PlayingState extends State<Playing> {

  var playingMovies;

  @override
  void initState() {
    playingMovies = MovieServices().getPlayingMovies();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieResponse>(
      future: playingMovies,
      // ignore: missing_return
      builder: (context, AsyncSnapshot <MovieResponse> snapshot) {
        if(snapshot.hasData){
          if(snapshot.data.error !=null && snapshot.data.error.length > 0){
            return _errorWidget(snapshot.data.error);
          }
          return _playingWidget(snapshot.data);
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

  Widget _playingWidget(MovieResponse data){
    List<Movie> movies = data.movies;
    if(movies.length == 0){
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Movies Not Found')
          ],
        ),
      );
    } else {
      return Container(
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8.0,
          padding: EdgeInsets.all(5.0),
          indicatorColor: Style.Colors.titleColor,
          indicatorSelectorColor: Style.Colors.secondaryColor,
          shape: IndicatorShape.circle(size: 5.0),
          pageView: PageView.builder(scrollDirection: Axis.horizontal, itemCount: movies.take(5).length, itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(image: NetworkImage("https://image.tmdb.org/t/p/original/" + movies[index].backPoster),
                    fit: BoxFit.cover)
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors:[
                        Style.Colors.primaryColor.withOpacity(1.0),
                        Style.Colors.primaryColor.withOpacity(0.0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                        0.0,
                        0.9
                      ]
                    )
                  ),
                ),
                Positioned(top: 0, bottom: 0, left: 0, right: 0, child: Icon(FontAwesomeIcons.playCircle, color: Style.Colors.secondaryColor, size: 40,)),
                Positioned(
                  bottom: 30,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(movies[index].title, style: TextStyle(
                          height: 2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
          length: movies.take(5).length,
        ),
      );
    }

  }
}