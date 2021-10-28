import 'dart:async';

import 'package:curso_flutter_sql_lite/components/progress.dart';
import 'package:curso_flutter_sql_lite/components/response_dialog.dart';
import 'package:curso_flutter_sql_lite/components/transaction_auth_dialog.dart';
import 'package:curso_flutter_sql_lite/http/webclient.dart';
import 'package:curso_flutter_sql_lite/http/webclients/transaction_webclient.dart';
import 'package:curso_flutter_sql_lite/models/contact.dart';
import 'package:curso_flutter_sql_lite/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _sending = false;
  @override
  Widget build(BuildContext context) {
    print(transactionId);
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                visible: _sending,
                child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Progress(message: 'Enviando',),
              ),),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'), onPressed: () {
                    final double? value = double.tryParse(_valueController.text);
                    if(value != null){
                      final transactionCreated = Transaction(transactionId,value, widget.contact);
                      showDialog(context: context, builder: (contextDialog){
                        return TransactionAuthDialog(onConfirm: (String password) async {
                          print(password);
                          _save(transactionCreated, password, context);
                        },);
                      });
                    }
                  },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(Transaction transactionCreated, String password, BuildContext context) async {
    setState(() {
      _sending = true;
    });
    final transaction = await  _webClient.save(transactionCreated, password).
      catchError((e){
        _showFailureMessage(context, message: e.message);
      }, test: (e) => e is TimeoutException)
      .catchError((e){
        _showFailureMessage(context, message: e.message);
      }, test: (e) => e is Exception).
    catchError((e){
      _showFailureMessage(context);
    }).whenComplete(() =>
        setState(() {
          _sending = false;
        })
    );

    if(transaction != null){
      _showSucessMessage(context);
    }

  }

  Future<void> _showSucessMessage(BuildContext context, {String message='Transação cadastrada com sucesso'}) async {
     await showDialog(context: context, builder: (contextBuilder){
      return SuccessDialog(message);
    }).then((value) =>  Navigator.pop(context));
  }

  void _showFailureMessage(BuildContext context, {String message = "Unknown error"}) {
       showDialog(context: context, builder: (contextDialog){
      return FailureDialog(message);
    });
  }
}