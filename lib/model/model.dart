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
        movieReviews:json['movieReviewsByMovieId']?['nodes']?.map((movie) => Review.fromJson(movie)).toList()?? []
        );
  }
}
class Review {
  final String id;
  final int? rating;
  final String title;
  final String ? body;
  final String userCreatorId;
  final String userCreator;

 Review({required this.id, required this.rating, required this.title, required this.body,  required this.userCreatorId, required this.userCreator,});
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json["id"],
        rating: json['rating'],
        title:json['title'],
        body:json['body'],
        userCreatorId:json["userByUserReviewerId"]['id'],
        userCreator:json["userByUserReviewerId"]['name'],
        );
  }
}