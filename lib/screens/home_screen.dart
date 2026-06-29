import 'package:flutter/material.dart';
import '../models/wallet_model.dart';
import '../services/storage_service.dart';
import 'add_wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WalletModel? wallet;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadWallet();
  }

  Future<void> loadWallet() async {
    final wallets = await StorageService.loadWallets();

    if (wallets.isNotEmpty) {
      wallet = wallets.first;
    }

    setState(() {
      loading = false;
    });
  }

  Future<void> openAddWallet() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddWalletScreen(),
      ),
    );

    if (result == true) {
      await loadWallet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("💼 Tabungan Miftah"),
        centerTitle: true,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : wallet == null
              ? Center(
                  child: ElevatedButton.icon(
                    onPressed: openAddWallet,
                    icon: const Icon(Icons.add),
                    label: const Text("Tambah Wallet"),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.account_balance_wallet,
                                size: 60,
                                color: Colors.orange,
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                "Tabungan Miftah",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                wallet!.address,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: openAddWallet,
                        icon: const Icon(Icons.edit),
                        label: const Text("Ganti Wallet"),
                      ),
                    ],
                  ),
                ),
    );
  }
}
