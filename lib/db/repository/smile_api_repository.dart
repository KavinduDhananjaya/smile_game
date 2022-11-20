import 'package:http/http.dart' as http;

abstract class SmileApiRepository {
  Future<http.Response> getData();
}
