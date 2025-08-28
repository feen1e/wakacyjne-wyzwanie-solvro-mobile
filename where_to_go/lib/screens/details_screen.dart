import "dart:convert";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../db_places_provider.dart";

class DetailsScreen extends ConsumerWidget {
  static const route = "/details";
  final int id;

  const DetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final place = ref.watch(placeDetailsProvider(id));

    return place.when(
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stackTrace) => Scaffold(body: Center(child: Text("Error: $error"))),
        data: (place) {
          final isFavorited = place.isFavorite;

          final infoColumns = (jsonDecode(place.infoColumns) as List<dynamic>?)?.map((e) {
                final map = e as Map<String, dynamic>;
                final icon = _iconFromString(map["icon"] as String);
                final text = map["text"] as String;
                return InfoColumn(icon: icon, text: text);
              }).toList() ??
              [];
          return Scaffold(
            appBar: AppBar(
              title: Text(place.title),
              actions: [
                IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                    child: Icon(
                      isFavorited ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      key: ValueKey<bool>(isFavorited),
                      color: isFavorited ? Colors.redAccent.shade400 : null,
                    ),
                  ),
                  onPressed: () async {
                    await ref.read(placesRepositoryProvider).updateFavorite(place.id, isFavorite: !isFavorited);
                    ref.invalidate(placeDetailsProvider(id));
                    // ref.invalidate(allPlacesProvider);
                  },
                )
              ],
            ),
            body: Column(
              children: [
                Hero(
                  tag: place.title,
                  child: place.imagePath.isNotEmpty
                      ? Image.network(place.imagePath, fit: BoxFit.cover)
                      : Container(height: 200, color: Colors.grey.shade300),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.placeName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 8,
                        width: double.infinity,
                      ),
                      Text(place.description, style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: infoColumns
                      .map((e) => InfoColumn(
                            icon: e.icon,
                            text: e.text,
                          ))
                      .toList(),
                )
              ],
            ),
          );
        });
  }
}

class InfoColumn extends StatelessWidget {
  const InfoColumn({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 28, color: Theme.of(context).colorScheme.primary),
        const SizedBox(
          height: 4,
        ),
        Text(text, style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}

IconData _iconFromString(String name) {
  switch (name) {
    case "restaurant":
      return Icons.restaurant;
    case "terrain":
      return Icons.terrain;
    case "auto_awesome":
      return Icons.auto_awesome;
    case "downhill_skiing":
      return Icons.downhill_skiing;
    case "landscape":
      return Icons.landscape;
    case "train":
      return Icons.train;
    case "park":
      return Icons.park;
    case "local_florist":
      return Icons.local_florist;
    case "ramen_dining":
      return Icons.ramen_dining;
    case "theaters":
      return Icons.theaters;
    case "beach_access":
      return Icons.beach_access;
    case "sailing":
      return Icons.sailing;
    case "water":
      return Icons.water;
    case "wine_bar":
      return Icons.wine_bar;
    case "location_city":
      return Icons.location_city;
    case "museum":
      return Icons.museum;
    case "coffee":
      return Icons.coffee;
    case "celebration":
      return Icons.celebration;
    default:
      return Icons.info;
  }
}
