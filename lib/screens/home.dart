import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_test/widgets/genre.dart';
import 'package:movie_test/widgets/playing.dart';
import '../styles/theme.dart' as Style;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.primaryColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.primaryColor,
        centerTitle: true,
        leading: Icon(EvaIcons.menu, color: Colors.white,),
        title: Text('MovFlix'),
        actions: [
          IconButton(icon: Icon(EvaIcons.search, color: Colors.white,), onPressed: null)
        ],
      ),
      body: ListView(
        children: [
          Playing(),
          MovieGenre()
        ],
      ),
    );
  }
}