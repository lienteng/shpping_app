import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.iconData = Icons.arrow_back,
    required this.title,
    this.leadingOnPress,
    this.actions,
  }) : super(key: key);
  final String title;
  final IconData iconData;
  final Function()? leadingOnPress;
  final dynamic actions;

  @override
  final Size preferredSize = const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          shape: const CircleBorder(),
          child: IconButton(
            icon: Icon(
              iconData,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            onPressed: leadingOnPress,
          ),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      actions: actions,
    );
  }
}
