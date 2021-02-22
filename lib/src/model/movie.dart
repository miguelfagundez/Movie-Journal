
class Movie {

    String uniqueId = '';

    int voteCount;
    int id;
    bool video;
    double voteAverage;
    String title;
    double popularity;
    String posterPath;
    String originalLanguage;
    String originalTitle;
    List<int> genreIds;
    String backdropPath;
    bool adult;
    String overview;
    String releaseDate;

    Movie({
        this.voteCount,
        this.id,
        this.video,
        this.voteAverage,
        this.title,
        this.popularity,
        this.posterPath,
        this.originalLanguage,
        this.originalTitle,
        this.genreIds,
        this.backdropPath,
        this.adult,
        this.overview,
        this.releaseDate,
    });

    Movie.fromJsonMap( Map<String, dynamic> json ) {
        voteCount        = json['vote_count'];
        id               = json['id'];
        video            = json['video'];
        voteAverage      = json['vote_average'] / 1;
        title            = json['title'];
        popularity       = json['popularity'] / 1;
        posterPath       = json['poster_path'];
        originalLanguage = json['original_language'];
        originalTitle    = json['original_title'];
        genreIds         = json['genre_ids'].cast<int>();
        backdropPath     = json['backdrop_path'];
        adult            = json['adult'];
        overview         = json['overview'];
        releaseDate      = json['release_date'];
    }

    String getPosterPath(){
        if (posterPath == null){
            return 'https://www.eduprizeschools.net/wp-content/uploads/2016/06/No_Image_Available.jpg';
        }
        return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }

    String getBackgroundPath(){
        if (backdropPath == null){
            return 'https://www.eduprizeschools.net/wp-content/uploads/2016/06/No_Image_Available.jpg';
        }
        return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
}