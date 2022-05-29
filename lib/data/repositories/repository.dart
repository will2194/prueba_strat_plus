import 'package:get/get.dart';

import '../api/api_provider.dart';

class Repository extends GetxController {
  static Repository get to => Get.find<Repository>();
  final ApiProvider proveedor;

  Repository({required this.proveedor});

//obtner personajes
  Future<dynamic> getCharactersList() async {
    return await proveedor.getCharacters();
  }

//cargar mas personajes
  Future<dynamic> getMoreCharactersList(int limit, int offset) async {
    return await proveedor.getMoreCharacters(limit, offset);
  }
}
