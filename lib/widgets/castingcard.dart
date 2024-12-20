import 'package:flutter/material.dart';
import 'package:movieapp/models/models.dart';
import 'package:movieapp/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieid;

  const CastingCards({super.key, required this.movieid});

  @override
  Widget build(BuildContext context) {
    final moviesprovider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesprovider.getCast(movieid),
        builder: (context, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 180,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          final List<Cast> cast = snapshot.data!;

          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return _CastCard(
                    actor: cast[index],
                  );
                }),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(
                actor.fullprofilePath,
              ),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            actor.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
