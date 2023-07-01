// 📦 Package imports:
import 'package:http/http.dart' as http;

class Connection {
  Uri uri;
  Connection({required this.uri});

  String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2ZWZiNzA4ZWZhZjQzZDMwYzkxZjBiOGMwYmFiNWVjZSIsInN1YiI6IjY0OWJiM2QzYzM5MjY2MDEwNjBiMDhiZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.OEb7yyOnWYYZX72-_LaiLQOKbCjyEYLpF2456g1aXVo";

  Map<String, String> setHeader({Map<String, String>? header}) {
    Map<String, String> defaultHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    if (header != null) {
      defaultHeader.addAll(header);
    }

    return defaultHeader;
  }

  Future<http.Response> get({int? timeout}) async {
    http.Response response;
    try {
      response = await http.get(uri, headers: setHeader()).timeout(
            Duration(seconds: timeout ?? 60),
            onTimeout: () => throw ('Request Time Out'),
          );
      return response;
    } catch (e) {
      if (e.toString().toLowerCase().contains('time out')) {
        return http.Response('$e', 522);
      }
      return http.Response('$e', 1001);
    }
  }
}
