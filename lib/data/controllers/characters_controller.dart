import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/marvel_heroes_model.dart';
import '../repositories/repository.dart';

class CharactersController extends GetxController with StateMixin {
  static CharactersController get to => Get.find<CharactersController>();
  final Repository repository;

//Valores para tener control del listado
  RxList<Result> characterList = RxList();
  RxList<Result> characterFilterList = RxList();
  RxInt limit = RxInt(20);

  CharactersController({required this.repository});

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    getCharacters();
    super.onInit();
  }

//Metodo para obtener personajes
  getCharacters() async {
    try {
      change(null, status: RxStatus.loading());
      final resultado = await repository.getCharactersList();

      resultado.data.results.map((e) => characterList.add(e)).toList();
      resultado.data.results.map((e) => characterFilterList.add(e)).toList();

      limit = RxInt(10);

      change(resultado, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
    update();
  }

//Metodo para obtener mas personajes
  getMoreCharactersList() async {
    try {
      final resultado = await repository.getMoreCharactersList(
          limit.value, characterList.length);

      resultado.data.results.map((e) => characterList.add(e)).toList();
      resultado.data.results.map((e) => characterFilterList.add(e)).toList();

      limit = RxInt(10);
    } catch (e) {
      debugPrint(e.toString());
    }
    update();
  }

//Metodo para buscar personajes por nombre
  searchCharacters(String search) {
    characterFilterList.clear();
    characterList.map((e) {
      if (e.name.toLowerCase().contains(search.toLowerCase())) {
        characterFilterList.add(e);
      }
    }).toList();
    update();
  }
}
