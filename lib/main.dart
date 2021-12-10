import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<XFile> _image = [];

  pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image.add(XFile(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image.add(XFile(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker"),
      ),
      body: _image != null
          ? ListView.builder(
              itemCount: _image.length,
              itemBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 500,
                    margin: EdgeInsets.all(7.0),
                    child: kIsWeb == true
                        ? Image.network(_image[index].path)
                        : Image.file(
                            File(_image[index].path),
                            fit: BoxFit.cover,
                          ),
                  ))
          : Container(
              child: Text("No image selected"),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Wrap(
              children: [
                kIsWeb ==false ? ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text('Camera'),
                  onTap: () {
                    Navigator.pop(context);
                    pickImageFromCamera();
                  },
                ):
                Container(),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    // PickImageFromGallery();
                    pickImageFromGallery();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
