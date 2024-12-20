import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar pelicula';

  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black38,
          size: 130,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesprovide = Provider.of<MoviesProvider>(context, listen: false);

    moviesprovide.getSuggetionsByQuery(query);

    return StreamBuilder(
        stream: moviesprovide.suggestionsStream,
        builder: (context, AsyncSnapshot<List<Result>> snapshot) {
          if (!snapshot.hasData) return _emptyContainer();

          final movies = snapshot.data;

          return ListView.builder(
            itemCount: movies!.length,
            itemBuilder: (context, index) => MovieItem(movie: movies[index]),
          );
        });
  }
}

class MovieItem extends StatelessWidget {
  final Result movie;
  const MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroid = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroid!,
        child: FadeInImage(
          placeholder: AssetImage('assets/no-image.jpg'),
          image: NetworkImage(movie.fullImageurl),
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title!),
      subtitle: Text(
        movie.overview!,
        maxLines: 2,
      ),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
    ;
  }
}
