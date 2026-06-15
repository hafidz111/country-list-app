import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_list_app/models/country_model.dart';
import 'package:flutter/material.dart';

class CountryTile extends StatelessWidget {
  final CountryModel country;

  const CountryTile({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: country.flag,
          width: 60,
          height: 40,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            width: 60,
            height: 40,
            color: Colors.grey[300],
          ),
          errorWidget: (_, __, ___) => const Icon(Icons.flag),
        ),
        title: Text(country.name),
        subtitle: Text(country.capital),
      ),
    );
  }
}
