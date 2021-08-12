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
import 'package:form_field_validator/form_field_validator.dart';

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
                  updateNameTextFormField(
                      Icons.person_outline, 'Username', custData.username),
                  updateLocationTextFormField(
                      Icons.pin_drop_outlined, 'Location', custData.location),
                  updatePhoneTextFormField(Icons.phone_android_outlined,
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
                          String fileName =
                              DateTime.now().millisecondsSinceEpoch.toString() +
                                  basename(_image.path);
                          Reference firebaseStorageRef =
                              FirebaseStorage.instance.ref().child(fileName);
                          UploadTask uploadTask =
                              firebaseStorageRef.putFile(_image);
                          TaskSnapshot taskSnapshot = await uploadTask;
                          await taskSnapshot.ref
                              .getDownloadURL()
                              .then((urlImage) {
                            _userImageUrl = urlImage;
                          });
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid)
                                .updateCustomerData(
                                    _username ?? custData.username,
                                    _location ?? custData.location,
                                    _phoneNum ?? custData.phoneNum,
                                    _userImageUrl ?? custData.imageURL);
                            Navigator.pop(context);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Data Saved')));
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

  Padding updateNameTextFormField(IconData icon, String title, String initVal) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
          initialValue: initVal,
          validator: RequiredValidator(errorText: 'Please enter your name'),
          onChanged: (val) => setState(() => _username = val),
          decoration: textInputDecoration(icon, title)),
    );
  }

  Padding updateLocationTextFormField(
      IconData icon, String title, String initVal) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
          initialValue: initVal,
          validator: RequiredValidator(errorText: 'Please enter your location'),
          onChanged: (val) => setState(() => _location = val),
          decoration: textInputDecoration(icon, title)),
    );
  }

  Padding updatePhoneTextFormField(
      IconData icon, String title, String initVal) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
          initialValue: initVal,
          validator: MultiValidator([
            RequiredValidator(errorText: 'Please enter your phone number'),
            MinLengthValidator(10, errorText: 'Enter a valid phone number')
          ]),
          onChanged: (val) => setState(() => _phoneNum = val),
          decoration: textInputDecoration(icon, title)),
    );
  }
}
