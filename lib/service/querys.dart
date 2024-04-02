// query of fetch Movies Query
String fetchMoviesQuery=r"""
query MyQuery {
  allMovies {
    nodes {
      id
      imgUrl
      releaseDate
      title
      movieReviewsByMovieId {
        nodes {
          id
          rating
          title
          body
          userByUserReviewerId {
               name
               id
             }
        }
      }
    }
  }
}
""";

// query for add Review
String addReviewQuery(movieId,userReviewerId,title,rating,body){
  return """
mutation MyMutation {
  createMovieReview(
   input: {movieReview: { movieId: "$movieId", userReviewerId: "$userReviewerId",title: "$title", rating: $rating, body: "$body"}}
  ) {
    query {
      allMovies {
        nodes {
          id
          imgUrl
          releaseDate
          title
          movieReviewsByMovieId {
            nodes {
              id
              rating
              title
              body
              userByUserReviewerId {
               name
               id
             }
            }
          }
        }
      }
    }
  }
}
""";}

// query of fetch current User
String fetchCurrentUserQuery=r"""
    query MyQuery {
  currentUser {
    id
  }
}
""";

// query for delete review
String deleteReviewQuery(reviewId){
  return """
 mutation MyMutation {
  deleteMovieReviewById(input: {id: "$reviewId"}) {
     query {
      allMovies {
        nodes {
          id
          imgUrl
          releaseDate
          title
          movieReviewsByMovieId {
            nodes {
              id
              rating
              title
              body
              userByUserReviewerId {
               name
               id
             }
            }
          }
        }
      }
    }
  }
}
""";
}