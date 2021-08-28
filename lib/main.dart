import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'home/index.dart';

void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(home: HomePage()));
}
