import 'package:elok_lagi/master.dart';
import 'package:elok_lagi/view/screens/profile.dart';
import 'package:elok_lagi/services/auth.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:login_singup/config/palette.dart';

class SignInUp extends StatefulWidget {
  @override
  _SignInUpState createState() => _SignInUpState();
}

class _SignInUpState extends State<SignInUp> {
  bool isSignupScreen = true;
  bool isMale = true;
  bool isRememberMe = false;

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
                          image: AssetImage("assets/images/nachos.png"),
                          fit: BoxFit.fill),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 90, left: 20),
                      color: Color(0xFF3b5999).withOpacity(.85),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Welcome to",
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 2,
                                color: Colors.yellow[700],
                              ),
                              children: [
                                TextSpan(
                                  text: isSignupScreen ? " Rizona," : " Back,",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow[700],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            isSignupScreen
                                ? "Signup to Continue"
                                : "Signin to Continue",
                            style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Trick to add the shadow for the submit button
                buildBottomHalfContainer(true),
                //Main Contianer for Login and Signup
                AnimatedPositioned(
                  duration: Duration(milliseconds: 700),
                  curve: Curves.easeInOutBack,
                  top: isSignupScreen ? 200 : 230,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 700),
                    curve: Curves.easeInOutBack,
                    height: isSignupScreen ? 380 : 250,
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
                                  setState(
                                    () {
                                      isSignupScreen = false;
                                    },
                                  );
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
                                  setState(
                                    () {
                                      isSignupScreen = true;
                                    },
                                  );
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
                // Bottom buttons
                Positioned(
                  top: MediaQuery.of(context).size.height - 100,
                  right: 0,
                  left: 0,
                  child: Column(
                    children: [
                      Text(
                          isSignupScreen ? "Or Signup with" : "Or Signin with"),
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildTextButton(
                              Icons.face,
                              "Facebook",
                              Color(0xFF3B5999),
                            ),
                            buildTextButton(
                              Icons.add,
                              "Google",
                              Color(0xFFDE4B39),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
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
            buildTextField(Icons.mail_outline, "Email", false, true),
            buildTextField(Icons.lock, "Password", true, false),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isRememberMe,
                      activeColor: Color(0XFF9BB3C0),
                      onChanged: (value) {
                        setState(
                          () {
                            isRememberMe = !isRememberMe;
                          },
                        );
                      },
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0XFFA7BCC7),
                      ),
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0XFFA7BCC7),
                    ),
                  ),
                )
              ],
            )
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
            buildTextField(Icons.person, "Username", false, false),
            buildTextField(Icons.email, "Email", false, true),
            buildTextField(Icons.lock, "Password", true, false),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          isMale = true;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color:
                                isMale ? Color(0XFF9BB3C0) : Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: isMale
                                    ? Colors.transparent
                                    : Color(0XFFA7BCC7)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.person,
                            color: isMale ? Colors.white : Color(0xFFB6C7D1),
                          ),
                        ),
                        Text(
                          "Male",
                          style: TextStyle(
                            color: Color(0XFFA7BCC7),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          isMale = false;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color:
                                isMale ? Colors.transparent : Color(0XFF9BB3C0),
                            border: Border.all(
                                width: 1,
                                color: isMale
                                    ? Color(0XFFA7BCC7)
                                    : Colors.transparent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.create,
                            color: isMale ? Color(0xFFB6C7D1) : Colors.white,
                          ),
                        ),
                        Text(
                          "Female",
                          style: TextStyle(
                            color: Color(0XFFA7BCC7),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                      //recognizer: ,
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

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
          minimumSize: Size(145, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.easeInOutBack,
      top: isSignupScreen ? 535 : 430,
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
                        setState(() {
                          loading = true;
                        });
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
                        setState(() {
                          loading = true;
                        });
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

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        validator: (val) {
          if (val.isEmpty) {
            if (isEmail) {
              return 'isi email';
            } else if (isPassword) {
              textError = 'isi password';
            } else {
              textError = 'isi username';
            }
            return textError;
          } else {
            return null;
          }
        },
        onChanged: (val) {
          if (isEmail) {
            setState(() {
              email = val;
            });
          } else if (isPassword) {
            setState(() {
              password = val;
            });
          } else {
            setState(() {
              username = val;
            });
          }
        },
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Color(0xFFB6C7D1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0XFFA7BCC7),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(35.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0XFFA7BCC7),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(35.0),
            ),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color(0XFFA7BCC7),
          ),
        ),
      ),
    );
  }
}