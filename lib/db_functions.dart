import 'dart:io';

import 'package:camera_app/data_model.dart';
import 'package:camera_app/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

var currentImage;
int count = 1;
ValueNotifier<List<ImageModel>> imageList = ValueNotifier([]);

void addimage(ImageModel value) async {
  final imagedb = await Hive.openBox<ImageModel>('image_db');
  await imagedb.add(value);
  var path = await saveimage();
  imageList.value.add(value);
  File(currentImage).copy('${path}/img$count.jpg');
  count++;

  imageList.notifyListeners();
}

Future<void> getallimages() async {
  final imagedb = await Hive.openBox<ImageModel>('image_db');
  imageList.value.clear();
  imageList.value.addAll(imagedb.values);
  imageList.notifyListeners();
}

Future<void> deleteimage(int id) async {
  final imagedb = await Hive.openBox<ImageModel>('image_db');
  var key = imagedb.keyAt(id);
  await imagedb.delete(key);
  getallimages();
}

Future<String> imageSelect() async {
  XFile? img = await ImagePicker().pickImage(source: ImageSource.camera);
  return img!.path;
}
