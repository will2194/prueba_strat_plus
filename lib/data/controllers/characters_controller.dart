import 'package:get/get.dart';

import '../repositories/repository.dart';

class CharactersController extends GetxController with StateMixin {
  static CharactersController get to => Get.find<CharactersController>();
  final Repository repository;

  CharactersController({required this.repository});

  @override
  void onInit() {
    change(null, status: RxStatus.empty());
    super.onInit();
  }

  consultarUsuarios() async {
    try {
      change(null, status: RxStatus.loading());
      final resultado = await repository.getCharactersList();
      change(resultado, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
