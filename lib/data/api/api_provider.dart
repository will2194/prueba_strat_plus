import 'dart:convert';

import 'package:get/get.dart';
import 'package:prueba_strat_plus/model/marvel_heroes_model.dart';
import 'package:crypto/crypto.dart';

const apikey = "12a3154cfdfb9b39df56d88ff3b91e69";
const privateKey = "f3d1476460cf4dd5a0b6197f6e94269147091b62";

class ApiProvider extends GetConnect {
  static ApiProvider get to => Get.find<ApiProvider>();

  @override
  onInit() async {
    httpClient.baseUrl = "https://gateway.marvel.com/v1/public";
  }

  Future<dynamic> getCharacters() async {
    final String ts = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = md5.convert(utf8.encode(ts + privateKey + apikey)).toString();

    final resultado = await get(
      "/characters?apikey=$apikey&hash=$hash&ts=$ts",
    );

    if (!resultado.isOk) {
      throw ("Error la obtener la lista de personajes (${resultado.statusCode!}: ${resultado.statusText})");
    }

    final MarvelHeroesModel marvelHeroesModel =
        MarvelHeroesModel.fromJson(resultado.body as Map<String, dynamic>);
    return marvelHeroesModel;
  }

  Future<dynamic> getMoreCharacters(int limit, int offset) async {
    final String ts = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = md5.convert(utf8.encode(ts + privateKey + apikey)).toString();

    final resultado = await get(
      "/characters?apikey=$apikey&hash=$hash&ts=$ts&limit=$limit&offset=$offset",
    );

    if (!resultado.isOk) {
      throw ("Error la obtener la lista de personajes (${resultado.statusCode!}: ${resultado.statusText})");
    }

    final MarvelHeroesModel marvelHeroesModel =
        MarvelHeroesModel.fromJson(resultado.body as Map<String, dynamic>);
    return marvelHeroesModel;
  }
}
