import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {
  const CustomInputText({
    Key? key,
    this.text,
    this.prefixIcon = Icons.edit,
    this.controller,
  }) : super(key: key);

  final String? text;
  final IconData prefixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        label: Text(
          text!,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
