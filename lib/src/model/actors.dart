
class Actors{

  bool adult;
  int gender;
  int id;
  double popularity;
  String known_for_department;
  String name;
  String original_name;
  String profile_path;
  int cast_id;
  String character;
  String credit_id;
  int order;

  Actors({
    this.cast_id,
    this.character,
    this.credit_id,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profile_path
  });

  Actors.fromJson(Map<String, dynamic> json){
    this.cast_id      = json['cast_id'];
    this.character    = json['character'];
    this.credit_id    = json['credit_id'];
    this.gender       = json['gender'];
    this.id           = json['id'];
    this.name         = json['name'];
    this.order        = json['order'];
    this.profile_path = json['profile_path'];
  }

  String getActorPhoto(){
    if (profile_path == null){
      return 'https://www.eduprizeschools.net/wp-content/uploads/2016/06/No_Image_Available.jpg';
    }
    return 'https://image.tmdb.org/t/p/w500/$profile_path';
  }
}