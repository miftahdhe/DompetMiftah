import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/wallet_model.dart';

class StorageService {
  static const String walletKey = "wallets";

  static Future<void> saveWallets(List<WalletModel> wallets) async {
    final prefs = await SharedPreferences.getInstance();

    final data = wallets.map((e) => e.toJson()).toList();

    await prefs.setString(walletKey, jsonEncode(data));
  }

  static Future<List<WalletModel>> loadWallets() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(walletKey);

    if (json == null) return [];

    final List list = jsonDecode(json);

    return list.map((e) => WalletModel.fromJson(e)).toList();
  }

  static Future<void> addWallet(WalletModel wallet) async {
    final wallets = await loadWallets();
    wallets.add(wallet);
    await saveWallets(wallets);
  }
}
