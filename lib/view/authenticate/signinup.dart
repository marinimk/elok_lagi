import 'package:elok_lagi/controller/auth.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignInUp extends StatefulWidget {
  @override
  _SignInUpState createState() => _SignInUpState();
}

class _SignInUpState extends State<SignInUp> {
  bool isSignupScreen = false;

  String username = '';
  String email = '';
  String password = '';
  String textError = '';
  String error = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xFFECF3F9),
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              "assets/images/elok_lagi_transparent.png"),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 90, left: 20),
                      color: Color(0xff76a973).withOpacity(.5),
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     BorderedText(
                      //       strokeColor: Colors.grey[800],
                      //       strokeWidth: 5,
                      //       child: Text(
                      //         'Welcome to Elok Lagi',
                      //         style: TextStyle(
                      //           fontSize: 25,
                      //           fontWeight: FontWeight.bold,
                      //           letterSpacing: 2,
                      //           color: Colors.yellow[700],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ),
                ),
                // Trick to add the shadow for the submit button
                buildBottomHalfContainer(true),
                //Main Contianer for Login and Signup
                AnimatedPositioned(
                  duration: Duration(milliseconds: 700),
                  curve: Curves.easeInOutBack,
                  top: isSignupScreen ? 220 : 230,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 700),
                    curve: Curves.easeInOutBack,
                    height: isSignupScreen ? 310 : 250,
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() => isSignupScreen = false);
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "LOGIN",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: !isSignupScreen
                                              ? Color(0xFF09126C)
                                              : Color(0XFFA7BCC7)),
                                    ),
                                    if (!isSignupScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.orange,
                                      )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() => isSignupScreen = true);
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      "SIGNUP",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSignupScreen
                                              ? Color(0xFF09126C)
                                              : Color(0XFFA7BCC7)),
                                    ),
                                    if (isSignupScreen)
                                      Container(
                                        margin: EdgeInsets.only(top: 3),
                                        height: 2,
                                        width: 55,
                                        color: Colors.orange,
                                      ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          if (isSignupScreen) buildSignupSection(),
                          if (!isSignupScreen) buildSigninSection()
                        ],
                      ),
                    ),
                  ),
                ),
                // Trick to add the submit button
                buildBottomHalfContainer(false),
              ],
            ),
          );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailTextField(Icons.email, "Email"),
            buildPasswordTextField(Icons.lock, "Password")
          ],
        ),
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildEmailTextField(
              Icons.email,
              "Email",
            ),
            buildPasswordTextField(Icons.lock, "Password"),
            Container(
              width: 200,
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "By pressing 'Submit' you agree to our ",
                  style: TextStyle(
                    color: Color(0XFF9BB3C0),
                  ),
                  children: [
                    TextSpan(
                      text: "term & conditions",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Text(error),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOutBack,
      top: isSignupScreen ? 490 : 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              if (showShadow)
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  spreadRadius: 1.5,
                  blurRadius: 10,
                )
            ],
          ),
          child: !showShadow
              ? GestureDetector(
                  onTap: () async {
                    if (isSignupScreen) {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'Please supply a valid email';
                          });
                        }
                      }
                    } else {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            error = 'Cannot sign in with those creds';
                          });
                        }
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.orange[200],
                        Colors.red[400],
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                )
              : Center(),
        ),
      ),
    );
  }

  Widget buildEmailTextField(IconData icon, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
          onChanged: (val) {
            setState(() => email = val);
          },
          validator: MultiValidator([
            RequiredValidator(errorText: 'Please enter an email'),
            EmailValidator(errorText: 'Email must be valid'),
          ]),
          keyboardType: TextInputType.emailAddress,
          decoration: textInputDecoration(icon, hintText)),
    );
  }

  Widget buildPasswordTextField(IconData icon, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
          onChanged: (val) {
            setState(() => password = val);
          },
          validator: MultiValidator([
            RequiredValidator(errorText: 'Please enter a password'),
            MinLengthValidator(6,
                errorText: 'Password must consist at least 6 characters'),
          ]),
          obscureText: true,
          keyboardType: TextInputType.text,
          decoration: textInputDecoration(icon, hintText)),
    );
  }
}
