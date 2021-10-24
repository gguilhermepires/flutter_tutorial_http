import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final message;
  Progress({this.message = 'Carregando'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(message)
        ],
      ),
    );
  }
}
