import 'dart:convert';

import "package:http/http.dart" as http;

String apiKey = "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";

class ApiServices {
  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey'
  };
  static apiFetch(String mssg) async {
    var fetch =
        await http.post(Uri.parse("https://api.openai.com/v1/completions"),
            headers: header,
            body: jsonEncode({
              "model": "text-davinci-003",
              "prompt": mssg,
              "temperature": 0,
              "max_tokens": 100,
              "top_p": 1,
              "stop": ["Human:", "AI:"]
            }));
    if (fetch.statusCode == 200) {
      var data = jsonDecode(fetch.body.toString());
      var message = data["choices"][0]["text"];
      return message;
    } else {
      print("Error");
    }
  }
}
