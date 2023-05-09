import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieResponse {
  Movie? results;

  MovieResponse({this.results});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    results = json['results'] != null ? new Movie.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> results = new Map<String, dynamic>();
    if (this.results != null) {
      results['results'] = this.results!.toJson();
    }
    return results;
  }
}

class Movie {
  String? imdbId;
  String? title;
  int? year;
  int? popularity;
  String? description;
  String? contentRating;
  int? movieLength;
  double? rating;
  String? createdAt;
  String? trailer;
  String? imageUrl;
  String? release;
  String? plot;
  String? banner;
  String? type;

  Movie(
      {this.imdbId,
        this.title,
        this.year,
        this.popularity,
        this.description,
        this.contentRating,
        this.movieLength,
        this.rating,
        this.createdAt,
        this.trailer,
        this.imageUrl,
        this.release,
        this.plot,
        this.banner,
        this.type});

  Movie.fromJson(Map<String, dynamic> json) {
    imdbId = json['imdb_id'];
    title = json['title'];
    year = json['year'];
    popularity = json['popularity'];
    description = json['description'];
    contentRating = json['content_rating'];
    movieLength = json['movie_length'];
    rating = json['rating'];
    createdAt = json['created_at'];
    trailer = json['trailer'];
    imageUrl = json['image_url'];
    release = json['release'];
    plot = json['plot'];
    banner = json['banner'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imdb_id'] = this.imdbId;
    data['title'] = this.title;
    data['year'] = this.year;
    data['popularity'] = this.popularity;
    data['description'] = this.description;
    data['content_rating'] = this.contentRating;
    data['movie_length'] = this.movieLength;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['trailer'] = this.trailer;
    data['image_url'] = this.imageUrl;
    data['release'] = this.release;
    data['plot'] = this.plot;
    data['banner'] = this.banner;
    data['type'] = this.type;
    return data;
  }
}

Future<MovieResponse> fetchMovie(String imdb_id) async {
  final response = await http
      .get(Uri.parse('https://moviesminidatabase.p.rapidapi.com/movie/id/$imdb_id/'),
      headers: { 'X-RapidAPI-Key': 'ac5a518096msh95a71ac86a59b97p1dddb4jsn1b2ff16034b7',}
  );

  if (response.statusCode == 200) {
    return MovieResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load movie!');
  }
}