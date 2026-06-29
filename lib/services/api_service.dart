import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> getBitcoinData() async {
    final url = Uri.parse(
      'https://blockchain.info/rawaddr/',
    );

    return {
      "balance": 0.0,
      "idr": 0,
      "transactions": [],
    };
  }
}
