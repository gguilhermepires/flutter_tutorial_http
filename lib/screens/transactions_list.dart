import 'package:curso_flutter_sql_lite/components/centered_message.dart';
import 'package:curso_flutter_sql_lite/components/progress.dart';
import 'package:curso_flutter_sql_lite/http/webclient.dart';
import 'package:curso_flutter_sql_lite/http/webclients/transaction_webclient.dart';
import 'package:curso_flutter_sql_lite/models/contact.dart';
import 'package:curso_flutter_sql_lite/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        initialData: [],
        future:Future.delayed(Duration(seconds: 1)).then((value) => _webClient.findAll())  ,
        builder: (context, snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              // TODO: Handle this case.
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              // TODO: Handle this case.
              break;
            case ConnectionState.done:
              if(snapshot.hasData){
                List<Transaction> transactions = snapshot.data as List<Transaction>;
                if(transactions.isNotEmpty){
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              return CenteredMessage('Lista vazia');
              break;
          }
          return CenteredMessage('Erro ao carregar lista');
        },
      ),
    );
  }
}


