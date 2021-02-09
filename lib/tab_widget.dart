import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({Key key, @required this.scrollController, @required this.textValue}) : super(key: key);

  final ScrollController scrollController;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      controller: scrollController,
      children: [
        Text(textValue,
        textAlign: TextAlign.center),
      ],
    );
  }
}
