import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/wallet_model.dart';
import '../services/api_service.dart';
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

  double balance = 0.0;
  int idrPrice = 0;
  int transactions = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final wallets = await StorageService.loadWallets();

    if (wallets.isNotEmpty) {
      wallet = wallets.first;

      final data =
          await ApiService.getWalletData(wallet!.address);

      balance = data["balance"];
      idrPrice = data["idr"];
      transactions = data["transactions"];
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (wallet == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("💼 Tabungan Miftah"),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton.icon(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddWalletScreen(),
                ),
              );

              loadData();
            },
            icon: const Icon(Icons.add),
            label: const Text("Tambah Wallet"),
          ),
        ),
      );
    }

    final rupiah = balance * idrPrice;

    return Scaffold(
      appBar: AppBar(
        title: const Text("💼 Tabungan Miftah"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
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

                  Text(
                    "${balance.toStringAsFixed(8)} BTC",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "≈ Rp ${rupiah.toStringAsFixed(0)}",
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Card(
            child: ListTile(
              leading: const Icon(Icons.show_chart),
              title: const Text("Harga Bitcoin"),
              subtitle: Text("Rp $idrPrice"),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Jumlah Transaksi"),
              subtitle: Text("$transactions transaksi"),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            child: ListTile(
              leading: const Icon(Icons.account_balance_wallet),
              title: const Text("Alamat Wallet"),
              subtitle: Text(wallet!.address),
              trailing: IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: wallet!.address),
                  );
          
                  if (!mounted) return;
          
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Alamat berhasil disalin"),
                    ),
                  );
                },
              ),
            ),
          ),
