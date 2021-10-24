import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("REQUEST");
    print('data: $data.toString()');
    print('headers $data.headers');
    print('body $data.body');
    print('base url $data.baseUrl');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("RESPONSE");
    print('data: $data.toString()');
    print('headers $data.headers');
    print('body $data.body');
    print("status code $data.statusCode");
    return data;
  }

}