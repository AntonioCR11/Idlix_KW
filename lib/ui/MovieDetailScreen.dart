import 'package:dicoding_final_project/models/TitleResponse.dart';
import 'package:dicoding_final_project/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName='/movie_detail';
  final TitleResults titleResults;
  const MovieDetailScreen({Key? key, required this.titleResults}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieResponse>(
      future: fetchMovie(titleResults.imdbId.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var movie = snapshot.data?.results as Movie;
          
          return buildItem(context, movie);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator()) ;
      },
    );
  }
}

Widget buildItem(BuildContext context, Movie movie) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth < 900) {
        return Container(
          padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                        image: NetworkImage(movie.banner.toString()),
                        width: 200,
                        alignment: Alignment.center,
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                          return child;
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:  Text(
                        movie.title.toString(),
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      '(${movie.year.toString()})',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.movie_creation_outlined),
                              Text(
                                movie.type.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.access_time),
                              Text(
                                '${movie.movieLength.toString()} min',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.star_border_purple500_outlined),
                              Text(
                                '${movie.rating.toString()}/10',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Icon(Icons.people),
                              Text(
                                movie.popularity.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Rating",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Text(
                                movie.contentRating.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: () {
                          _launch(Uri.parse(movie.trailer.toString()));
                        },
                        child: const Text('Trailer'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:  Text(
                        movie.description.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        );
      }
      else {
        return Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LayoutBuilder(
                          builder: (BuildContext context,BoxConstraints constraints){
                            return Image(
                                image: NetworkImage(movie.banner.toString()),
                                width: constraints.maxWidth,
                                alignment: Alignment.center,
                                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                  return child;
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }
                            );
                          }
                      )
                    )
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child:  Text(
                                movie.title.toString(),
                                style: Theme.of(context).textTheme.headlineLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              '(${movie.year.toString()})',
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(Icons.movie_creation_outlined),
                                      Text(
                                        movie.type.toString(),
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.access_time),
                                      Text(
                                        '${movie.movieLength.toString()} min',
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.star_border_purple500_outlined),
                                      Text(
                                        '${movie.rating.toString()}/10',
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.people),
                                      Text(
                                        movie.popularity.toString(),
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Rating",
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                      Text(
                                        movie.contentRating.toString(),
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: OutlinedButton(
                                onPressed: () {
                                  _launch(Uri.parse(movie.trailer.toString()));
                                },
                                child: const Text('Trailer'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child:  Text(
                                movie.description.toString(),
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  )
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        );
      }
    },
  );
}

Future<void> _launch(Uri url) async {
  await canLaunchUrl(url)
      ? await launchUrl(url)
      : debugPrint("Cant Open Link!");
}