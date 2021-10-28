import 'dart:convert';
import 'package:curso_flutter_sql_lite/models/contact.dart';
import 'package:curso_flutter_sql_lite/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor()],
  requestTimeout: Duration(seconds: 10)
);


