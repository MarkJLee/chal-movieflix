import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_model.dart';
import 'package:movieflix/services/api_service.dart';
import 'package:movieflix/widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<MovieModel>> popularMovies =
      ApiService.getMovies(MovieUrlType.popular);
  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService.getMovies(MovieUrlType.nowPlaying);
  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getMovies(MovieUrlType.comingSoon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movieflix',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            )),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Popular Movies',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot);
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Now in Cinemas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: nowPlayingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Coming soon",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: comingSoonMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return makeList(snapshot);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemBuilder: (context, index) {
          var movie = snapshot.data![index];
          return Movie(
            id: movie.id,
            posterPath: movie.posterPath,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemCount: snapshot.data!.length);
  }
}
