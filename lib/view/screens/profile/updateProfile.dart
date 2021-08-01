import 'dart:io';
import 'package:elok_lagi/models/customer.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/models/users.dart';

class UpdateProfile extends StatefulWidget {
  @override
  UpdateProfileState createState() => UpdateProfileState();
}

class UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();

  String _username;
  String _location;
  String _phoneNum;

  String _userImageUrl;
  File _image;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return StreamBuilder<CustomerData>(
        stream: DatabaseService(uid: user.uid).customerData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CustomerData custData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                          radius: 80.0,
                          backgroundImage: _image == null
                              ? NetworkImage(custData.imageURL)
                              : FileImage(_image)),
                      ElevatedButton(
                        onPressed: () async {
                          var image = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          setState(() {
                            _image = File(image.path);
                          });
                        },
                        child: _image == null
                            ? Icon(Icons.add_photo_alternate)
                            : Icon(Icons.camera_alt_outlined),
                        style: circularElevatedButton(),
                      ),
                    ],
                  ),
                  updateTextFormField(
                      Icons.person_outline, 'Username', custData.username),
                  updateTextFormField(
                      Icons.pin_drop_outlined, 'Location', custData.location),
                  updateTextFormField(Icons.phone_android_outlined,
                      'Phone Number', custData.phoneNum),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        // style: ,
                        child: buttonTextRow(Icons.check_circle, 'Update'),
                        style: elevatedButtonStyle().copyWith(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        onPressed: () async {
                          String fileName;
                          Reference firebaseStorageRef;
                          UploadTask uploadTask;
                          TaskSnapshot taskSnapshot;
                          if (_image.path != null) {
                            fileName = DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString() +
                                basename(_image.path);
                            firebaseStorageRef =
                                FirebaseStorage.instance.ref().child(fileName);
                            uploadTask = firebaseStorageRef.putFile(_image);
                            taskSnapshot = await uploadTask;
                            await taskSnapshot.ref
                                .getDownloadURL()
                                .then((urlImage) {
                              _userImageUrl = urlImage;
                            });
                          } else {
                            //todo what to do if the user didnt pick an image
                          }

                          if (!_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid)
                                .updateCustomerData(
                                    _username ?? custData.username,
                                    _location ?? custData.location,
                                    _phoneNum ?? custData.phoneNum,
                                    _userImageUrl ?? custData.imageURL);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Data Saved')));
                          }
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        child: buttonTextRow(Icons.cancel, 'Cancel'),
                        style: elevatedButtonStyle().copyWith(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Padding updateTextFormField(IconData icon, String title, String initVal) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
          initialValue: initVal,
          validator: (val) => val.isEmpty
              ? 'please field in your new $widget.title.toLowerCase()'
              : '',
          onChanged: (val) => setState(() {
                switch (title) {
                  case 'Username':
                    _username = val;
                    break;
                  case 'Location':
                    _location = val;
                    break;
                  case 'Phone Number':
                    _phoneNum = val;
                    break;
                  default:
                }
              }),
          decoration: textInputDecoration(icon, title)),
    );
  }
}
