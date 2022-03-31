import 'dart:io';

import 'package:camera_app/data_model.dart';
import 'package:camera_app/db_functions.dart';
import 'package:camera_app/displayimage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ImageModelAdapter().typeId)) {
    Hive.registerAdapter(ImageModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _image;
  @override
  Widget build(BuildContext context) {
    getallimages();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
              onPressed: () async {
                var image = await imageSelect();

                setState(() {
                  _image = image;
                  currentImage = image;
                });
                final _imagemod = ImageModel(image: _image);
                addimage(_imagemod);
              },
              icon: const Icon(Icons.photo_camera))
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ValueListenableBuilder(
                valueListenable: imageList,
                builder: (
                  BuildContext ctx,
                  List<ImageModel> imageList,
                  Widget? child,
                ) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      itemBuilder: (ctx, index) {
                        final data = imageList[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx1) {
                              return DisplayImage(
                                imagepath: data.image,
                                index: index,
                              );
                            }));
                          },
                          child: Container(
                            color: const Color.fromARGB(0, 0, 0, 0),
                            child: data.image != null
                                ? Image.file(
                                    File(data.image),
                                    fit: BoxFit.cover,
                                  )
                                : Container(),
                          ),
                        );
                      },
                      itemCount: imageList.length,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

saveimage() async {
  Directory? directory;
  String newpath = "/storage/emulated/0/Pictures";
  directory = Directory(newpath);
  return newpath;
}
