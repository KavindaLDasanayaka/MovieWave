import 'package:flutter/material.dart';
import 'package:moviewave/models/movie_model.dart';

class SearchDetailWidget extends StatelessWidget {
  final Movie movie;
  const SearchDetailWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          movie.posterPath == null
              ? SizedBox()
              : ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Release Date: ${movie.releaseDate}',
            style: TextStyle(fontSize: 14, color: Colors.red[600]),
          ),
          const SizedBox(height: 4),
          const Text(
            'Overview',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            movie.overview,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Average Vote: ${movie.voteAverage}',
                style: TextStyle(fontSize: 14, color: Colors.red[600]),
              ),
              Text(
                'Popularity: ${movie.popularity}',
                style: TextStyle(fontSize: 14, color: Colors.red[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
