import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/controllers/characters_controller.dart';
import '../../data/repositories/repository.dart';
import '../../model/marvel_heroes_model.dart';
import '../widgets/marvel_characters_list_item.dart';
import 'hero_detail_page.dart';

class HomePage extends GetView<CharactersController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    List<Result> characterList = [];
    List<Result> characterFilterList = [];

    Get.lazyPut(() => CharactersController(repository: Repository.to));
    controller.consultarUsuarios();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel'),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: controller.obx(
              (result) {
                MarvelHeroesModel marvelHeroesModel =
                    result as MarvelHeroesModel;
                counter = marvelHeroesModel.data.count;

                characterList = marvelHeroesModel.data.results;
                characterFilterList = marvelHeroesModel.data.results;

                return Column(
                  children: [
                    TextField(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: "Buscar",
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      onChanged: (search) {
                        print(characterFilterList.length);
                        characterFilterList = characterList
                            .where((x) => x.name
                                .toLowerCase()
                                .contains(search.toLowerCase()))
                            .toList();
                        print(characterFilterList.length);
                      },
                    ),
                    Text(
                      "${marvelHeroesModel.data.total}/$counter",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: characterFilterList.length,
                        itemBuilder: (_, index) {
                          Result hero = characterFilterList[index];

                          return GestureDetector(
                            child: MarvelCharacterListItem(
                              hero: hero,
                            ),
                            onTap: () => Get.to(
                              HeroDetailPage(
                                hero: hero,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => const Divider(),
                      ),
                    ),
                  ],
                );
              },
              onLoading: const CircularProgressIndicator(color: Colors.red),
              onError: (error) => Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
