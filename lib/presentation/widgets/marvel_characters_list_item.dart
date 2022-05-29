import 'package:flutter/material.dart';

import '../../model/marvel_heroes_model.dart';

//item del listado de personajes
class MarvelCharacterListItem extends StatelessWidget {
  final Result hero;

  const MarvelCharacterListItem({
    Key? key,
    required this.hero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        "${hero.thumbnail.path}/standard_large.${hero.thumbnail.extension}";

    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                width: 100,
                height: 100,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hero.name,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      hero.description,
                      maxLines: 5,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
