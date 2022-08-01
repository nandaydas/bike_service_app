import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType textInputType;

  const MyTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: textEditingController,
          keyboardType: textInputType,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
