import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_flutter_app/src/model/actors.dart';
import 'package:movies_flutter_app/src/model/movie.dart';
import 'package:movies_flutter_app/src/providers/movies_provider.dart';
import 'package:movies_flutter_app/src/utils/constants.dart';

class DetailsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 10.0,),
                _movieImgTitle(movie, context),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _createActorPageView(movie),
              ]),
          )
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie) {

    // This sliverappbar doesn't work - NEED TO BE CHECKED
    return SliverAppBar(
      elevation: 2.0, //
      backgroundColor: Colors.indigoAccent, // color
      expandedHeight: 200.0, // How much it can be expanded
      floating: false, //
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(movie.title, style: TextStyle(color: Colors.white, fontSize: 16.0),),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundPath()),
          placeholder: AssetImage(Constants.LOADING),
          fadeInDuration: Duration(milliseconds: 200),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _movieImgTitle(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: NetworkImage(movie.getPosterPath()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(movie.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 5.0,),
                  Text(movie.releaseDate,  style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 5.0,),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star_border, color: Colors.yellow,),
                      Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1,),
                    ],
                  ),
                ],
              ),
          )
        ],
      ),
    );
  }

  Widget _movieDescription(Movie movie) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _createActorPageView(Movie movie) {

    final provider = new MovieProvider();
    return FutureBuilder(
      future: provider.getActors(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if (snapshot.hasData){
          return _createActors(snapshot.data);
        }else{
          return CircularProgressIndicator();
        }
      },

    );
  }

  Widget _createActors(List<Actors> actors) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actors.length,
        itemBuilder: (context, index){
          return _actorCard(actors[index]);
        } ,
      ),
    );
  }

  Widget _actorCard(Actors actors){
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox( width: 500.0,),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                placeholder: AssetImage(Constants.NO_IMAGE),
                image: NetworkImage(actors.getActorPhoto()),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          Text(actors.name, overflow: TextOverflow.ellipsis,),
        ],
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
