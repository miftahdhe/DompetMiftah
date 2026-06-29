import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _blockstream =
      "https://blockstream.info/api/address/";

  static const String _coinGecko =
      "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=idr";

  static Future<Map<String, dynamic>> getWalletData(
      String address) async {
    try {
      final walletRes =
          await http.get(Uri.parse("$_blockstream$address"));

      final priceRes =
          await http.get(Uri.parse(_coinGecko));

      print("===== API DEBUG =====");
      print("Wallet URL : $_blockstream$address");
      print("Wallet Status : ${walletRes.statusCode}");
      print(walletRes.body);

      print("Price URL : $_coinGecko");
      print("Price Status : ${priceRes.statusCode}");
      print(priceRes.body);
      print("=====================");

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
        "transactions":
            wallet["chain_stats"]["tx_count"],
      };
    } catch (e, s) {
      print("===== ERROR =====");
      print(e);
      print(s);
      print("=================");

      return {
        "balance": 0.0,
        "idr": 0,
        "transactions": 0,
      };
    }
  }
}
