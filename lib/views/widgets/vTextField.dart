import 'package:flutter/material.dart';

Widget vTextField(
    String hintTxt, TextEditingController controller, bool validate) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          errorText: validate? "Can\'t be empty!" : null,
          hintText: hintTxt,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ),
  );
}
