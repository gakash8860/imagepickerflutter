import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main()=>runApp(MaterialApp(
  home: SaveImageDemo(),
));
class SaveImageDemo extends StatefulWidget {
  @override
  _SaveImageDemoState createState() => _SaveImageDemoState();
}

class _SaveImageDemoState extends State<SaveImageDemo> {

  Future<File>  imageFile;

  pickImageFromGallery(ImageSource source){
    setState(() {
      imageFile=ImagePicker.pickImage(source: source);
    });

  }

  Widget imageFromGallery(){
    return FutureBuilder<File>(
      future: imageFile,


      builder: (BuildContext context, AsyncSnapshot<File> snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          if(null==snapshot){
            return const Text('Error');
          }
          return Image.file(snapshot.data);
        }
        if(null !=snapshot.error){
          return const Text('Error Picking Image',textAlign: TextAlign.center);
        }
        return const Text('No Image Selected');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SpaceOrion'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){
            pickImageFromGallery(ImageSource.gallery);
          }
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            imageFromGallery(),
          ],
        ),
      ),
    );
  }
}
