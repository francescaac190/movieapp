import 'package:flutter/material.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:movieapp/search/search_delegate.dart';
import 'package:movieapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Peliculas en cines',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                      context: context,
                      delegate: MovieSearchDelegate(),
                    ),
                icon: Icon(
                  Icons.search_outlined,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              //cardswipper

              CardSwiper(movies: moviesProvider.onDisplayMovies),

              //lista horizontal

              Movieslider(movies: moviesProvider.onpoular, title: 'Populares')
            ],
          ),
        ));
  }
}
