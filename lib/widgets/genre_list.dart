import 'package:flutter/material.dart';
import 'package:movie_test/model/genre.dart';
import '../styles/theme.dart' as Style;

class GenreList extends StatefulWidget {
  final List<Genre> genres;
  GenreList({Key key, @required this.genres})
  : super(key: key);
  @override
  _GenreListState createState() => _GenreListState(genres);
}

class _GenreListState extends State<GenreList> with SingleTickerProviderStateMixin {
  final List<Genre> genres;
  TabController _tabController;
  _GenreListState(this.genres);

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: genres.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: Style.Colors.primaryColor,
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Style.Colors.primaryColor,
              bottom: TabBar(
                controller: _tabController,
                indicatorColor: Style.Colors.secondaryColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                unselectedLabelColor: Style.Colors.titleColor,
                labelColor: Colors.white,
                isScrollable: true,
                tabs: genres.map((Genre val) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 15, top:10),
                    child: Text(val.name.toUpperCase(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,),
                  ));
                }).toList()

              ),
            ),
            preferredSize: Size.fromHeight(50),
          ),
          body: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: null,
          ),
        ),
      ),
    );
  }
}