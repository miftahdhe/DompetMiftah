import 'package:flutter/material.dart';
import 'add_wallet_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "💼 Tabungan Miftah",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Card(
            color: const Color(0xFF1F2937),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Colors.orange,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bitcoin Wallet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "0.00000000 BTC",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "≈ Rp 0",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Card(
            color: const Color(0xFF1F2937),
            child: const ListTile(
              leading: Icon(Icons.show_chart,color: Colors.green),
              title: Text("Harga Bitcoin"),
              subtitle: Text("Loading..."),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            color: const Color(0xFF1F2937),
            child: const ListTile(
              leading: Icon(Icons.history,color: Colors.amber),
              title: Text("Transaksi Terakhir"),
              subtitle: Text("Belum ada transaksi"),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const AddWalletScreen(),
    ),
  );
},
              icon: const Icon(Icons.add),
              label: const Text(
                "Tambah Wallet",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
