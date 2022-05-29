import 'package:flutter/material.dart';

import '../../model/marvel_heroes_model.dart';

class HeroDetailPage extends StatelessWidget {
  final Result hero;

  const HeroDetailPage({
    Key? key,
    required this.hero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    String backgroundImage =
        "${hero.thumbnail.path}/portrait_uncanny.${hero.thumbnail.extension}";

    final imageUrl =
        "${hero.thumbnail.path}/standard_large.${hero.thumbnail.extension}";

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      width: size.width,
      height: size.height,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          title: Text(hero.name),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              Image.network(
                imageUrl,
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                hero.description,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Comics",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
