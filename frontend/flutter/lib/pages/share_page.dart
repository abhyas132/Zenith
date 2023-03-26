import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenith/globalvariables.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SharePage extends StatefulWidget {
  const SharePage({super.key, required this.title});

  final String title;

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  TextEditingController controller = TextEditingController();

  // final url = GlobalVariables.baseUrl;
  final url = GlobalVariables.baseUrl;
  List<File> images = [];
  List<String> imageUrls = [];
  Future<List<File>> pickImages() async {
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return images;
  }

  Future<void> upload() async {
    try {
      final cloudinary = CloudinaryPublic('ddvkshhsl', 'wcs4kqai');

      print(images.length);
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: "community"),
        );
        //print("hii");
        imageUrls.add(res.secureUrl);
      }
      print("hii");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
    } catch (e) {
      print(e.toString());
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void uploadCommunityPost() async {
    if (controller.text.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      final res = http.post(
        Uri.parse('${url}api/v1/create/communityPost'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer " + token!
        },
        body: jsonEncode(
          {
            "image": "",
            "title": controller.text,
          },
        ),
      );
    } else {
      print("please choose imageor enter text");
    }
    // Image.network(response.secureUrl.toString());
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: GlobalVariables.backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: GlobalVariables.buttonColortile)),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "start typing here...",
                    ),
                    controller: controller,
                  ),
                ),
              ),
              // images.isNotEmpty
              //     ? CarouselSlider(
              //         items: images.map(
              //           (i) {
              //             return Builder(
              //               builder: (BuildContext context) => Image.file(
              //                 i,
              //                 fit: BoxFit.cover,
              //                 height: 200,
              //               ),
              //             );
              //           },
              //         ).toList(),
              //         options: CarouselOptions(
              //           viewportFraction: 1,
              //           height: 200,
              //         ),
              //       )
              // : GestureDetector(
              //     onTap: selectImages,
              //     child: DottedBorder(
              //       borderType: BorderType.Rect,
              //       radius: const Radius.circular(10),
              //       dashPattern: const [10, 4],
              //       strokeCap: StrokeCap.round,
              //       child: Container(
              //         width: double.infinity,
              //         height: 150,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Column(children: const [
              //           Icon(
              //             Icons.folder_open,
              //             size: 40,
              //           ),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           Text(
              //             'Select Product Images',
              //             style: TextStyle(
              //               fontSize: 15,
              //               color: Colors.grey,
              //             ),
              //           ),
              //         ]),
              //       ),
              //     ),
              //   ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 1,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: GlobalVariables.backgroundColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      context.loaderOverlay.show();
                      //await upload();
                      context.loaderOverlay.hide();
                      uploadCommunityPost();
                      Navigator.pop(context);
                    },
                    child: Container(child: Center(child: const Text("share"))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color generateRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
