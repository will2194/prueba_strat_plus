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
    Get.lazyPut(() => CharactersController(repository: Repository.to));

    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.getMoreCharactersList();
      }
    });

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
                      onChanged: (search) =>
                          controller.searchCharacters(search),
                    ),
                    Text(
                      "${marvelHeroesModel.data.total}/${controller.characterFilterList.length}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: GetBuilder<CharactersController>(
                        builder: (_dx) => ListView.builder(
                          controller: _scrollController,
                          itemCount: _dx.characterFilterList.length,
                          itemBuilder: (context, index) {
                            Result hero = controller.characterFilterList[index];

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
                        ),
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
