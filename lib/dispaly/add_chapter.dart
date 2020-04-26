import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../database/data.dart';

class AddChapter extends StatefulWidget {
  @override
  _AddChapterState createState() => _AddChapterState();
}

class _AddChapterState extends State<AddChapter> {
  Manga productService = Manga();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController chapterNameController = TextEditingController();
  TextEditingController chapterImageLinkController = TextEditingController();
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;

  File _image1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "Add",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: grey.withOpacity(0.5), width: 2.5),
                                  onPressed: () {
                                    _selectImage(
                                      ImagePicker.pickImage(
                                          source: ImageSource.gallery),
                                    );
                                  },
                                  child: _displayChild1()),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'enter name',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: black, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: chapterNameController,
                        decoration: InputDecoration(hintText: 'Name'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'enter link',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: black, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: chapterImageLinkController,
                        decoration: InputDecoration(hintText: 'Link'),
                      ),
                    ),
                    FlatButton(
                      color: black,
                      textColor: white,
                      child: Text('ADD'),
                      onPressed: () {
                        validateAndUpload();
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }

  void _selectImage(Future<File> pickImage) async {
    File tempImg = await pickImage;
    setState(() => _image1 = tempImg);
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void validateAndUpload() async {
    if (_formKey.currentState.validate()) {
      setState(() => isLoading = true);
      productService.uploadChapter({
        "name": chapterNameController.text,
        "picturelink": chapterImageLinkController.text,
      });
      _formKey.currentState.reset();
      setState(() => isLoading = false);
      Navigator.pop(context);
    } else {
      setState(() => isLoading = false);
    }
  }
}
