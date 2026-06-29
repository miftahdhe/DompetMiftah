import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _mempool =
      "https://mempool.space/api/address/";

  static const String _coinGecko =
      "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=idr";

  static Future<Map<String, dynamic>> getWalletData(
      String address) async {
    try {
      final walletRes =
          await http.get(Uri.parse("$_mempool$address"));

      final priceRes =
          await http.get(Uri.parse(_coinGecko));

      if (walletRes.statusCode != 200 ||
          priceRes.statusCode != 200) {
        throw Exception("API Error");
      }

      final wallet = jsonDecode(walletRes.body);
      final price = jsonDecode(priceRes.body);

      final balanceSat =
          wallet["chain_stats"]["funded_txo_sum"] -
              wallet["chain_stats"]["spent_txo_sum"];

      final balanceBtc = balanceSat / 100000000;

      final idr = price["bitcoin"]["idr"];

      return {
        "balance": balanceBtc,
        "idr": idr,
        "transactions": wallet["chain_stats"]["tx_count"],
      };
    } catch (e) {
      return {
        "balance": 0.0,
        "idr": 0,
        "transactions": 0,
      };
    }
  }
}
