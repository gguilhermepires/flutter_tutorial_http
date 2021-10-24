import 'dart:convert';

import 'package:curso_flutter_sql_lite/models/contact.dart';
import 'package:curso_flutter_sql_lite/models/transaction.dart';
import 'package:http/http.dart';

import '../webclient.dart';
const String basesUrl = 'http://192.168.15.12:8080';

class TransactionWebClient {

  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(Uri.parse('$basesUrl/transactions'))
        .timeout(Duration(seconds: 15));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json)=> Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final Response response = await client.post(Uri.parse('$basesUrl/transactions'),headers: {
      'Content-type':'application/json',
      'password':'1000',
    },body:  jsonEncode(transaction.toJson())
    ).timeout(Duration(seconds: 15));
    return await Transaction.fromJson(jsonDecode(response.body));
  }

}