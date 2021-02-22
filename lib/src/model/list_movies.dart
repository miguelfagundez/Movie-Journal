import 'package:movies_flutter_app/src/model/movie.dart';

class ListOfMovies {

  List<Movie> items = [];

  ListOfMovies();

  ListOfMovies.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final movie = new Movie.fromJsonMap(item);
      items.add( movie );
    }
  }

}