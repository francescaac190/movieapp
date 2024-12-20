import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Result> movies;

  const CardSwiper({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (movies.length == 0) {
      return Container(
        height: size.height * 0.5,
        width: double.infinity,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Container(
      width: size.width,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.45,
        itemBuilder: (context, index) {
          final movie = movies[index];
          movie.heroid = 'swiper-${movie.id}';
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: Hero(
              tag: movie.heroid!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullImageurl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
