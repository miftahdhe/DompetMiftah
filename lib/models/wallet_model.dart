class WalletModel {
  final String name;
  final String address;

  WalletModel({
    required this.name,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
    };
  }

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      name: json["name"],
      address: json["address"],
    );
  }
}
