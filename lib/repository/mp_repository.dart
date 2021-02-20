import 'package:mbunge/models/mp.dart';
import 'package:mbunge/util/http/endpoints.dart';
import 'package:mbunge/util/http/http.dart';

abstract class MpInterface {
  Future<List<MPs>> getAllMps();
}

class MpRepository implements MpInterface {
  // inject services
  final HttpClient httpClient = HttpClient();
  final Endpoints endpoints = Endpoints();

  // singleton
  static final MpRepository _mpRepository = MpRepository._internal();
  factory MpRepository() {
    return _mpRepository;
  }
  MpRepository._internal();

  @override
  Future<List<MPs>> getAllMps() async {
    final response = await httpClient.getRequest(
      endpoint: endpoints.allMpsEndpoint,
    );
    if (response == null || response?.statusCode != 200) {
      throw Exception(response.body ?? "shit");
    }
    final mPs = mPsFromJson(response.body);
    return mPs;
  }
}
