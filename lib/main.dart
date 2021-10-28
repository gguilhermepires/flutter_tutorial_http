import 'package:curso_flutter_sql_lite/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'components/transaction_auth_dialog.dart';
import 'http/webclient.dart';
import 'models/contact.dart';
import 'models/transaction.dart';


void main() {
  runApp(BytebankApp());


}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.blueAccent,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        )
      ),
      home: Dashboard()
    );
  }
}

