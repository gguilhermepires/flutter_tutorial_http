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

  Future<Transaction>  save(Transaction transaction, String password) async {

    await Future.delayed(Duration(seconds: 10));

    final Response response = await client.post(Uri.parse('$basesUrl/transactions'),headers: {
      'Content-type':'application/json',
      'password': password,
    },body:  jsonEncode(transaction.toJson())
    ).timeout(Duration(seconds: 15));

    if (response.statusCode == 200){
      return Transaction.fromJson(jsonDecode(response.body));
    }
    // _throwHttpError(response.statusCode);
    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode){
    if( _statusCodeResponses.containsKey(statusCode)){
      final message = _statusCodeResponses[statusCode];
      if(message != null)
        return message;
    }
    return 'Unknown error';
  }

  void _throwHttpError(int statusCode) =>
      throw Exception(_statusCodeResponses[statusCode]);

  static final Map<int, String> _statusCodeResponses = {
    500: 'Erro ao submeter transação',
    400: 'Erro ao submeter transação',
    401: 'Não foi possível autenticar',
    409: 'Transaction already exists'
  };
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
}