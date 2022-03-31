import 'package:hive_flutter/hive_flutter.dart';

part 'data_model.g.dart';

@HiveType(typeId: 1)
class ImageModel {
  @HiveField(0)
  final image;

  ImageModel({
    this.image,
  });
}
