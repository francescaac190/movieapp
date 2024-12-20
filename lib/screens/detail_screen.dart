import 'package:flutter/material.dart';
import 'package:movieapp/models/movie.dart';
import 'package:movieapp/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Result movie = ModalRoute.of(context)?.settings.arguments as Result;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(movie: movie),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _PosterTitulo(movie: movie),
              _Overview(movie: movie),
              CastingCards(movieid: movie.id!),
            ],
          ),
        ),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final Result movie;

  const _CustomAppBar({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              movie.title!,
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            )),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullbackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterTitulo extends StatelessWidget {
  final Result movie;

  const _PosterTitulo({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    var textTheme2 = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 24),
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Hero(
            tag: movie.heroid!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullImageurl),
                height: 150,
              ),
            ),
          ),
          SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title!,
                  style: textTheme2.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle!,
                  style: textTheme2.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      movie.voteAverage.toString(),
                      style: textTheme2.bodySmall,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Result movie;

  const _Overview({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(movie.overview!,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
