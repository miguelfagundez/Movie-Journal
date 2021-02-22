import 'package:flutter/material.dart';
import 'package:movies_flutter_app/src/providers/movies_provider.dart';
import 'package:movies_flutter_app/src/utils/constants.dart';
import 'package:movies_flutter_app/src/utils/search_delegate.dart';
import 'file:///C:/Practice/movies_flutter_app/lib/src/widget/card_swiper.dart';
import 'package:movies_flutter_app/src/widget/movie_horizontal_widget.dart';



class HomePage extends StatelessWidget {
  final moviesProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopularMovies();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchDelegateClass());
            }
            ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _imageBackground(),
          _colorBackground(),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _swiperCards(),
                _popularMovies(context),
              ],
            ),
          ),
        ]
      )
    );
  }

  Widget _swiperCards() {

    return FutureBuilder(
        future: moviesProvider.getNowMovies(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if (snapshot.hasData){
            return CardSwiper(movies: snapshot.data);
          }else{
            return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
    );


  }

  Widget _popularMovies(BuildContext context) {

    final textStyle = TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold);

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0,),
            child: Text('Popular Movies:', style: textStyle)//Theme.of(context).textTheme.subtitle1,)
          ),
          SizedBox(height: 10.0,),
          StreamBuilder(
            stream: moviesProvider.popularMoviesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              // snapshot.data?.forEach((m) => print(m.title));
              if (snapshot.hasData){
                return MoviesHorizontal(
                    horizontalMoviesList: snapshot.data,
                  nextMoviesPage: moviesProvider.getPopularMovies,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }

            },
          ),
        ],
      ),
    );
  }

  Widget _imageBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(Constants.BACKGROUND1),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _colorBackground() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(108, 192, 218, 0.8),
    );
  }

}
