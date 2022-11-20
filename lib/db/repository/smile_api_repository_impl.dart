import 'package:smile_game/db/repository/smile_api_repository.dart';
import 'package:http/http.dart' as http;



class SmileApiRepositoryImpl extends SmileApiRepository{

  @override
  Future<http.Response> getData() async {
    final url =
    Uri.https('marcconrad.com', '/uob/smile/api.php', {'q': '{https}'});

    final response = await http.get(url);
    return response;
  }

}