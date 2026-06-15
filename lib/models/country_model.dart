class CountryModel {
  final String name;
  final String capital;
  final String flag;

  CountryModel({required this.name, required this.capital, required this.flag});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json["names"]?["common"] ?? "",
      capital: (json["capitals"] as List?)?.isNotEmpty == true
          ? json["capitals"][0]["name"]
          : "No Capital",
      flag: json["flag"]?["url_png"] ?? "",
    );
  }
}
