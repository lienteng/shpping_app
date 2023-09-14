import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index.isEven ? Theme.of(context).primaryColor : Colors.white,
          ),
        );
      },
    );
  }
}
