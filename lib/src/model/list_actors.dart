

import 'package:movies_flutter_app/src/model/actors.dart';

class ListOfActors {

  List<Actors> listOfActors = [];

  ListOfActors();

  ListOfActors.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    // for ( var item in jsonList  ) {
    //   final actor = new Actors.fromJson(item);
    //   items.add( actor );
    // }
    
    jsonList.forEach((element) {
      final actor = new Actors.fromJson(element);
      listOfActors.add(actor);
    });
  }

}