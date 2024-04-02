import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../model/model.dart';
import 'querys.dart';

class MovieService {
  static final HttpLink _httpLink = HttpLink( 
    Platform.isAndroid ? 'http://10.0.2.2:5001/graphql' : 'http://localhost:5001/graphql',
    );
  static final ValueNotifier<GraphQLClient> _client = ValueNotifier(
    GraphQLClient(link: _httpLink, cache: GraphQLCache(store: InMemoryStore())),
  );
  static GraphQLClient get client => _client.value;

// fetch movies service
  static Future<List<Movie>> fetchMovies() async {
    final query = gql(fetchMoviesQuery);
    final result = await client.query(QueryOptions(document: query));
    if (result.hasException) {
      throw Exception(result.exception);
    }
    final data = result.data!['allMovies']['nodes'] as List;
    return data.map((movie) => Movie.fromJson(movie)).toList();
  }

// add review service
  static Future<List<Movie>> addReview(movieId,userReviewerId,title,rating,body) async {
    final query = gql(addReviewQuery(movieId,userReviewerId,title,rating,body));
    final result = await client.query(QueryOptions(document: query));
    if (result.hasException) {
      throw Exception(result.exception);
    }
    final data = result.data!['createMovieReview']['query']['allMovies']['nodes']  as List ;
    return data.map((review) => Movie.fromJson(review)).toList();
  }

// fetch current user service
static Future<String> fetchCurrentUser() async {
    final query = gql(fetchCurrentUserQuery);
    final result = await client.query(QueryOptions(document: query));
    if (result.hasException) {
      throw Exception(result.exception);
    }
    final data = result.data!['currentUser'];
    return data['id'];
  }

// delete Review service
static Future<List<Movie>> deleteReview(reviewId) async {
    final query = gql(deleteReviewQuery(reviewId));

    final result = await client.query(QueryOptions(document: query));
    if (result.hasException) {
      throw Exception(result.exception);
    }
    final data = result.data!['deleteMovieReviewById']['query']['allMovies']['nodes']  as List ;
    return data.map((review) => Movie.fromJson(review)).toList();
  }
}