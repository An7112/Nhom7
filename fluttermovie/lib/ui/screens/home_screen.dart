import 'package:flutter/material.dart';
import 'package:fluttermovie/api.dart';
import 'package:fluttermovie/models/featuredmoviemodel.dart';
import 'package:fluttermovie/models/genremodel.dart';
import 'package:fluttermovie/ui/widgets/homepagefeaturedwidget.dart';
import 'package:fluttermovie/ui/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<FeaturedMovieModel>> featuredMovies;
  late Future<List<GenreModel>> genreList;
  late Api _api;
  @override
  void initState() {
    super.initState();
    _api = Api();
    featuredMovies = _api.getFeaturedMovies();
    genreList = _api.getGenreList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade100,
          elevation: 0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search, color: Colors.black), onPressed: () {})
          ],
          leading: IconButton(
              icon: Icon(Icons.menu, color: Colors.black), onPressed: () {}),
          title: Text(
            "TMDB",
            style: TextStyle(
                color: Colors.blue.shade900, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: FutureBuilder<List<FeaturedMovieModel>>(
                  future: featuredMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return HomePageFeaturedWidget(snapshot: snapshot);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 5.0),
                height: 61,
                child: FutureBuilder<List<GenreModel>>(
                  future: genreList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, id) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  15.0), //action adventure...
                              color: Colors.blue.shade900,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue,
                                  blurRadius: 2.5,
                                )
                              ],
                            ),
                            // width: MediaQuery.of(context).size.width / 2.5,
                            constraints: BoxConstraints(minWidth: 100),
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 5.0,
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              "${snapshot.data![id].name}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .apply(color: Colors.white),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SectionContainer(
                sectionTitle: "My List",
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: FutureBuilder<List<FeaturedMovieModel>>(
                    future: featuredMovies,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (ctx, id) {
                            return MovieContainer(snapshot: snapshot.data![id]);
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SectionContainer(
                sectionTitle: "Popular on TMDB",
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: FutureBuilder<List<FeaturedMovieModel>>(
                    future: featuredMovies,
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (ctx, id) {
                            return MovieContainer(snapshot: snapshot.data![id]);
                          },
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
