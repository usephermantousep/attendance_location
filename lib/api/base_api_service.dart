abstract class BaseApiServices {
  // Future<dynamic> get(String url, {Map<String, String>? headers});

  //USER MONGO DB ATLAS ALL REQUES USING POST
  Future<dynamic> post(String url, {Map<String, String>? headers, body});

  // Future<dynamic> put(String url, {Map<String, String>? headers, body});
  // Future<dynamic> delete(String url, {Map<String, String>? headers});
}
