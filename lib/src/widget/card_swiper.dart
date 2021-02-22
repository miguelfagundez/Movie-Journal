import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_flutter_app/src/model/movie.dart';
import 'package:movies_flutter_app/src/utils/constants.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  CardSwiper({
   @required this.movies
  });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return getCards(_screenSize);
  }

  Widget getCards(Size screenSize){
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: screenSize.width * 0.80,
        itemHeight: screenSize.height *0.50,
        itemBuilder: (BuildContext context, int index){

          movies[index].uniqueId = '${movies[index].id}-card';

          return Hero(
            tag: movies[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child:  GestureDetector(
                onTap: (){
                  Navigator.pushNamed(
                      context, 'details',
                      arguments: movies[index]);
                },
                child: FadeInImage(
                  image: NetworkImage(movies[index].getPosterPath()),
                  placeholder: AssetImage(Constants.NO_IMAGE),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
    // Before
    // return Container(
    //   padding: EdgeInsets.only(top: 30.0),
    //   width: double.infinity,
    //   height: 300.0,
    //   child: Swiper(
    //     layout: SwiperLayout.STACK,
    //     itemWidth: 250.0,
    //     itemBuilder: (BuildContext context, int index){
    //       return Image.network(
    //         "http://via.placeholder.com/350x150",
    //         fit: BoxFit.fill,
    //       );
    //     },
    //     itemCount: 3,
    //     //pagination: new SwiperPagination(),
    //     //control: new SwiperControl(),
    //   ),
    // );
  }
}
