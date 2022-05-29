import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/api/api_provider.dart';
import 'data/repositories/repository.dart';
import 'presentation/pages/home_page.dart';

void main() {
  Get.put(Repository(proveedor: Get.put(ApiProvider())));

  runApp(
    GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
