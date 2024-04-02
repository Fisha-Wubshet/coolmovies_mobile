class Movie {
  final String id;
  final String imgUrl;
  final String? releaseDate;
  final String title;
  final List movieReviews;
  Movie({ required this.id, required this.imgUrl, required this.releaseDate, required this.title, required this.movieReviews});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json["id"],
        imgUrl:json["imgUrl"],
        releaseDate: json["releaseDate"],
        title: json["title"],
        movieReviews:json['movieReviewsByMovieId']['nodes'],
        );
  }
}