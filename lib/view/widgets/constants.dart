import 'package:flutter/material.dart';

const colorsConst = {
  50: const Color(0xffF3F7F2), //10%
  100: const Color(0xffDAE8D9), //20%
  200: const Color(0xffC1D8C0), //30%
  300: const Color(0xffA8C9A6), //40%
  400: const Color(0xff8FB98D), //50%
  500: const Color(0xff76a973), //60%
  600: const Color(0xff60985D), //70%
  700: const Color(0xff507E4E), //80%
  800: const Color(0xff3F653E), //90%
  900: const Color(0xff2F4C2F), //100%
};

const colorsConstBrown = {
  50: const Color(0xffDFD6CD), //10%
  100: const Color(0xffCFC1B4), //20%
  200: const Color(0xffBFAC9B), //30%
  300: const Color(0xffAF9783), //40%
  400: const Color(0xffA0826A), //50%
  500: const Color(0xff705A48), //60%
  600: const Color(0xff705A48), //70%
  700: const Color(0xff3E3228), //80%
  800: const Color(0xff251E18), //90%
  900: const Color(0xff0C0A08), //100%
};

InputDecoration textInputDecoration(IconData icon, String title) {
  return InputDecoration(
      prefixIcon: Icon(icon, color: Color(0xFFB6C7D1)),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFFA7BCC7)),
          borderRadius: BorderRadius.all(Radius.circular(35.0))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0XFFA7BCC7)),
          borderRadius: BorderRadius.all(Radius.circular(35.0))),
      contentPadding: EdgeInsets.all(10),
      hintText: title,
      hintStyle: TextStyle(fontSize: 14, color: Color(0XFFA7BCC7)));
}

ButtonStyle elevatedButtonStyle() {
  return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      minimumSize: MaterialStateProperty.all(Size(100, 40)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0))));
}

ButtonStyle circularElevatedButton() {
  return ElevatedButton.styleFrom(
      shape: CircleBorder(), padding: EdgeInsets.all(10));
}

Row buttonTextRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon),
      SizedBox(width: 5),
      Text(text, style: TextStyle(fontSize: 16))
    ],
  );
}

extension CapExtension on String {
  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String get capitalizeFirstofEach => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}
