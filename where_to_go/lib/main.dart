import "package:flutter/material.dart";

import "dream_place_screen.dart";
import "gen/assets.gen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dream Place App",
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: PlacesList(places: places),
    );
  }
}

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<DreamPlaceScreen> places;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista Miejsc"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return GestureDetector(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      child: Image.asset(
                        place.image.path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      place.title,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute<Widget>(builder: (context) => place));
            },
          );
        },
      ),
    );
  }
}

List<DreamPlaceScreen> places = [
  DreamPlaceScreen(
    backgroundColor: Colors.lightBlue.shade50,
    title: "Rejkiawik, Islandia",
    image: Assets.images.reykjavikView,
    placeName: "Rejkiawik",
    placeDescription: "Stolica Islandii, znana z pięknych widoków i kultury.",
    infoColumns: const [
      InfoColumnData(icon: Icons.restaurant, text: "Restauracje"),
      InfoColumnData(icon: Icons.terrain, text: "Góry i wulkany"),
      InfoColumnData(icon: Icons.auto_awesome, text: "Zorze polarne"),
    ],
  ),
  DreamPlaceScreen(
    backgroundColor: Colors.deepPurple.shade50,
    title: "Zermatt, Szwajcaria",
    image: Assets.images.zermattView,
    placeName: "Zermatt",
    placeDescription: "Malownicza miejscowość u stóp Matterhorn, raj dla narciarzy i turystów górskich.",
    infoColumns: const [
      InfoColumnData(icon: Icons.downhill_skiing, text: "Narciarstwo"),
      InfoColumnData(icon: Icons.landscape, text: "Alpy i trekking"),
      InfoColumnData(icon: Icons.train, text: "Panoramiczne pociągi"),
    ],
  ),
  DreamPlaceScreen(
    backgroundColor: Colors.red.shade50,
    title: "Kioto, Japonia",
    image: Assets.images.kyotoView,
    placeName: "Kioto",
    placeDescription: "Dawna stolica Japonii, znana z świątyń, ogrodów i kwitnącej wiśni.",
    infoColumns: const [
      InfoColumnData(icon: Icons.park, text: "Świątynie i ogrody"),
      InfoColumnData(icon: Icons.local_florist, text: "Kwitnąca wiśnia"),
      InfoColumnData(icon: Icons.ramen_dining, text: "Kuchnia japońska"),
    ],
  ),
  DreamPlaceScreen(
    backgroundColor: Colors.indigo.shade50,
    title: "Sydney, Australia",
    image: Assets.images.sydneyView,
    placeName: "Sydney",
    placeDescription: "Tętniące życiem miasto znane z Opery, plaż i pięknych widoków nad zatoką.",
    infoColumns: const [
      InfoColumnData(icon: Icons.theaters, text: "Opera w Sydney"),
      InfoColumnData(icon: Icons.beach_access, text: "Plaże"),
      InfoColumnData(icon: Icons.sailing, text: "Rejsy w zatoce"),
    ],
  ),
  DreamPlaceScreen(
    backgroundColor: Colors.teal.shade50,
    title: "Kapsztad, RPA",
    image: Assets.images.capeTownView,
    placeName: "Kapsztad",
    placeDescription: "Malownicze miasto między górami a oceanem, pełne przyrody i kultury.",
    infoColumns: const [
      InfoColumnData(icon: Icons.terrain, text: "Góra Stołowa"),
      InfoColumnData(icon: Icons.water, text: "Ocean Atlantycki"),
      InfoColumnData(icon: Icons.wine_bar, text: "Winnice"),
    ],
  ),
  DreamPlaceScreen(
    backgroundColor: Colors.green.shade50,
    title: "Paryż, Francja",
    image: Assets.images.parisView,
    placeName: "Paryż",
    placeDescription: "Romantyczna stolica Francji, pełna sztuki, mody i kulinarnych przysmaków.",
    infoColumns: const [
      InfoColumnData(icon: Icons.location_city, text: "Wieża Eiffla"),
      InfoColumnData(icon: Icons.museum, text: "Luwr"),
      InfoColumnData(icon: Icons.coffee, text: "Kawiarnie"),
    ],
  ),
  DreamPlaceScreen(
    backgroundColor: Colors.green.shade50,
    title: "Rio de Janeiro, Brazylia",
    image: Assets.images.rioView,
    placeName: "Rio de Janeiro",
    placeDescription: "Miasto samby, karnawału i spektakularnych plaż w otoczeniu gór.",
    infoColumns: const [
      InfoColumnData(icon: Icons.landscape, text: "Góra Corcovado"),
      InfoColumnData(icon: Icons.beach_access, text: "Plaża Copacabana"),
      InfoColumnData(icon: Icons.celebration, text: "Karnawał"),
    ],
  ),
];
