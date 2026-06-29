import 'package:flutter/material.dart';
import '../models/wallet_model.dart';
import '../services/storage_service.dart';

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({super.key});

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  Future<void> saveWallet() async {
    final address = addressController.text.trim();

    if (address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Masukkan alamat Bitcoin"),
        ),
      );
      return;
    }

    final wallet = WalletModel(
      name: "Tabungan Miftah",
      address: address,
    );

    await StorageService.saveWallets([wallet]);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tabungan Miftah"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.account_balance_wallet,
              size: 80,
              color: Colors.orange,
            ),
            const SizedBox(height: 25),
            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Alamat Bitcoin",
                hintText: "bc1...",
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: saveWallet,
                icon: const Icon(Icons.save),
                label: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
