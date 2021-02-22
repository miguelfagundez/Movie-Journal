import 'package:flutter/material.dart';
import 'package:movies_flutter_app/src/model/movie.dart';
import 'package:movies_flutter_app/src/utils/constants.dart';
import 'package:movies_flutter_app/src/utils/constants.dart';

class MoviesHorizontal extends StatelessWidget {

  final List<Movie> horizontalMoviesList;
  final Function nextMoviesPage;

  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3,
  );
  
  MoviesHorizontal({
    @required this.horizontalMoviesList,
    @required this.nextMoviesPage
  });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
        if (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
            nextMoviesPage();
        }
    });

    print(horizontalMoviesList.length);
    return Container(
      height: _screenSize.height*0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: horizontalMoviesList.length,
        itemBuilder:(context, index){
          return _returnAMovie(context, horizontalMoviesList[index]);
        } ,
        // children: _horizontalMovies(context),
      ),
    );
  }

  Widget _returnAMovie(BuildContext context, Movie movie){

    movie.uniqueId = '${movie.id}-small';
    final captionStyle = TextStyle(color: Colors.white, fontSize: 13.0,);
    //Theme.of(context).textTheme.caption
    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage(Constants.NO_IMAGE),
                image: NetworkImage(movie.getPosterPath()),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(height: 5.0,),
          Center(
            child: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: captionStyle,
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: (){
        print('Movie title: ${movie.title}');
        Navigator.pushNamed(
            context,
            'details',
            arguments: movie
        );
      },
      child: card,
    );
  }


  // Thi is not used anymore
  List<Widget> _horizontalMovies(BuildContext context) {

    return horizontalMoviesList.map((movie){
      return _returnAMovie(context, movie);
    }).toList();
  }
}
