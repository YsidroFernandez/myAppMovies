class Movies {
  List<Movie> items = new List();

  Movies();

  Movies.formJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Movie.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Movie {

  String uniqueId;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJsonMap(Map<String, dynamic> jsonResponse) {
    popularity = jsonResponse['popularity'] / 1;
    voteCount = jsonResponse['vote_count'];
    video = jsonResponse['video'];
    posterPath = jsonResponse['poster_path'];
    id = jsonResponse['id'];
    adult = jsonResponse['adult'];
    backdropPath = jsonResponse['backdrop_path'];
    originalLanguage = jsonResponse['original_language'];
    originalTitle = jsonResponse['original_title'];
    genreIds = jsonResponse['genre_ids'].cast<int>();
    title = jsonResponse['title'];
    voteAverage = jsonResponse['vote_average'] / 1;
    overview = jsonResponse['overview'];
    releaseDate = jsonResponse['release_date'];
  }

  getImgApi() {
    if (posterPath == null) {
      return 'https://www.ceyesa.com.pe/uploads/imagenes-productos/olympus/n1266842-oln1266842.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getImgBackground() {
  
    if (backdropPath == null) {
      return 'https://www.ceyesa.com.pe/uploads/imagenes-productos/olympus/n1266842-oln1266842.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
