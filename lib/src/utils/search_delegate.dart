import 'package:flutter/material.dart';
import 'package:movies_flutter_app/src/model/movie.dart';
import 'package:movies_flutter_app/src/providers/movies_provider.dart';
import 'package:movies_flutter_app/src/utils/constants.dart';

class SearchDelegateClass extends SearchDelegate{

  // String movieSelected = '';

  // final allMovies = [
  //   'Spiderman',
  //   'Superman',
  //   'Batman',
  //   'Ironman',
  //   'Ironman 2',
  //   'Avengers',
  //   'Avenger: End Game',
  //   'Soul',
  //   'Captain America',
  // ];

  // final recentMovies = [
  //   'Spiderman',
  //   'Superman',
  //   'Batman',
  // ];

  @override
  List<Widget> buildActions(BuildContext context) {
  // Action to clean or delete your search
   return <Widget>[
     IconButton(
         icon: Icon(Icons.clear),
         onPressed: (){
           query = '';
         }
     ),
   ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon at the beginning
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Build the result to show
    return Center(
      child: Container(
        child: Text('movieSelected'),
      ),
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Suggestion that show when a person writes
  //
  //
  //   final suggestedMovies = (query.isEmpty)
  //                           ? recentMovies
  //                           : allMovies.where((movie) => movie.toLowerCase()
  //                                                       .startsWith(query.toLowerCase()))
  //                                                       .toList();
  //   return ListView.builder(
  //     itemCount: suggestedMovies.length,
  //       itemBuilder: (context, i){
  //         return ListTile(
  //           leading: Icon(Icons.movie),
  //           title: Text(suggestedMovies[i]),
  //           onTap: (){
  //             movieSelected = suggestedMovies[i];
  //             showResults(context);
  //           },
  //         );
  //       },
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestion that show when a person writes
    if (query.isEmpty) return Container();

    final provider = new MovieProvider();

    return FutureBuilder(
        future: provider.searchMovies(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot){
          if (snapshot.hasData){
            final movies = snapshot.data;
            return ListView(
              children: movies.map((movie){
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(movie.getPosterPath()),
                    placeholder: AssetImage(Constants.NO_IMAGE),
                    width: 60.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.originalTitle),
                  onTap: (){
                    close(context, null);
                    // movie.uniqueId = '';
                    Navigator.pushNamed(context, 'details', arguments: movie);
                  },
                );
              }).toList()
            );
          }else{
            return Center(
                child: CircularProgressIndicator()
            );
          }
        } ,
    );
  }

}