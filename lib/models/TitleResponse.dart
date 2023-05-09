import 'dart:convert';
import 'package:http/http.dart' as http;

class TitleResponse {
  List<TitleResults>? results;

  TitleResponse({this.results});

  TitleResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <TitleResults>[];
      json['results'].forEach((v) {
        results!.add(new TitleResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TitleResults {
  String? imdbId;
  String? title;

  TitleResults({this.imdbId, this.title});

  TitleResults.fromJson(Map<String, dynamic> json) {
    imdbId = json['imdb_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imdb_id'] = this.imdbId;
    data['title'] = this.title;
    return data;
  }
}


Future<TitleResponse> fetchMovieByTitle(String title) async {
  final response = await http
      .get(Uri.parse('https://moviesminidatabase.p.rapidapi.com/movie/imdb_id/byTitle/$title/'),
      headers: { 'X-RapidAPI-Key': 'ac5a518096msh95a71ac86a59b97p1dddb4jsn1b2ff16034b7',}
  );

  if (response.statusCode == 200) {
    return TitleResponse.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load movie!');
  }
}