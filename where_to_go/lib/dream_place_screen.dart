import "package:flutter/material.dart";

import "gen/assets.gen.dart";

class DreamPlaceScreen extends StatefulWidget {
  const DreamPlaceScreen(
      {super.key,
      required this.backgroundColor,
      required this.title,
      required this.image,
      required this.placeName,
      required this.placeDescription,
      required this.infoColumns});

  final Color backgroundColor;
  final String title;
  final AssetGenImage image;
  final String placeName;
  final String placeDescription;
  final List<InfoColumnData> infoColumns;

  @override
  State<DreamPlaceScreen> createState() => _DreamPlaceScreenState();
}

class _DreamPlaceScreenState extends State<DreamPlaceScreen> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: AppBar(
          backgroundColor: widget.backgroundColor,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
              onPressed: _toggleFavorite,
            )
          ],
        ),
        body: Column(
          children: [
            Image.asset(widget.image.path, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.placeName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                    width: double.infinity,
                  ),
                  Text(widget.placeDescription)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoColumn(
                  icon: widget.infoColumns[0].icon,
                  text: widget.infoColumns[0].text,
                ),
                InfoColumn(
                  icon: widget.infoColumns[1].icon,
                  text: widget.infoColumns[1].text,
                ),
                InfoColumn(
                  icon: widget.infoColumns[2].icon,
                  text: widget.infoColumns[2].text,
                ),
              ],
            )
          ],
        ));
  }
}

class InfoColumn extends StatelessWidget {
  const InfoColumn({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(icon), Text(text)],
    );
  }
}

class InfoColumnData {
  const InfoColumnData({required this.icon, required this.text});

  final IconData icon;
  final String text;
}
