import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_database.dart";
import "app_router.dart";
import "dream_places_repository.dart";
import "theme/app_theme.dart";
import "theme/local_theme_repository.dart";
import "theme/theme_notifier.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await seedDatabase();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeNotifierProvider);
    final appThemeEnum = themeAsync.valueOrNull ?? AppThemeMode.system;
    final phoneBrightness = MediaQuery.of(context).platformBrightness;

    final appTheme = switch (appThemeEnum) {
      AppThemeMode.light => AppTheme().light,
      AppThemeMode.dark => AppTheme().dark,
      AppThemeMode.system => phoneBrightness == Brightness.dark ? AppTheme().dark : AppTheme().light,
    };

    return MaterialApp.router(
      title: "Dream Place App",
      theme: appTheme,
      routerConfig: goRouter,
    );
  }
}

Future<void> seedDatabase() async {
  final db = AppDatabase();
  final repo = DreamPlacesRepository(db);

  final existingPlaces = await repo.getAllPlaces();
  if (existingPlaces.isNotEmpty) {
    return;
  }

  final seedPlaces = <DreamPlacesCompanion>[
    DreamPlacesCompanion.insert(
      title: "Rejkiawik, Islandia",
      placeName: "Rejkiawik",
      description: "Stolica Islandii, znana z pięknych widoków i kultury.",
      imagePath:
          "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiTeHJAQ3LYDvGrXWLqy3amKWCGMO4jgWbDRTfgKXyJp53yH3VrS9lmWKr4C_pPVJAj1YsL_2QZb-uEk0CmdivaCefF5j6T2WR_3dhmp-Mgtaw1uxGTCfD5PPHaHa6SdYuFOKqHqhPVMWHE/s1600/reykjavik-1.jpg",
      infoColumns:
          '[{"icon":"restaurant","text":"Restauracje"}, {"icon":"terrain","text":"Góry i wulkany"}, {"icon":"auto_awesome","text":"Zorze polarne"}]',
    ),
    DreamPlacesCompanion.insert(
      title: "Zermatt, Szwajcaria",
      placeName: "Zermatt",
      description: "Malownicza miejscowość u stóp Matterhorn, raj dla narciarzy i turystów górskich.",
      imagePath:
          "https://d1brno4kbxrfxy.cloudfront.net/wp-content/blogs.dir/35/files/2022/12/RS4772_shutterstock_254090041-scr.jpg",
      infoColumns:
          '[{"icon":"downhill_skiing","text":"Narciarstwo"}, {"icon":"landscape","text":"Alpy i trekking"}, {"icon":"train","text":"Panoramiczne pociągi"}]',
    ),
    DreamPlacesCompanion.insert(
      title: "Kioto, Japonia",
      placeName: "Kioto",
      description: "Dawna stolica Japonii, znana z świątyń, ogrodów i kwitnącej wiśni.",
      imagePath:
          "https://www.travelcaffeine.com/wp-content/uploads/2020/03/hirano-shrine-cherry-blossom-hanami-sakura-season-kyoto-japan-torii-gate-sunburst.jpg",
      infoColumns:
          '[{"icon":"park","text":"Świątynie i ogrody"}, {"icon":"local_florist","text":"Kwitnąca wiśnia"}, {"icon":"ramen_dining","text":"Kuchnia japońska"}]',
    ),
    DreamPlacesCompanion.insert(
      title: "Sydney, Australia",
      placeName: "Sydney",
      description: "Tętniące życiem miasto znane z Opery, plaż i pięknych widoków nad zatoką.",
      imagePath: "https://eybktovvaye.exactdn.com/wp-content/uploads/2024/02/New-Zealand-vs-Australia-1536x863.jpeg",
      infoColumns:
          '[{"icon":"theaters","text":"Opera w Sydney"}, {"icon":"beach_access","text":"Plaże"}, {"icon":"sailing","text":"Rejsy w zatoce"}]',
    ),
    DreamPlacesCompanion.insert(
      title: "Kapsztad, RPA",
      placeName: "Kapsztad",
      description: "Malownicze miasto między górami a oceanem, pełne przyrody i kultury.",
      imagePath: "https://mytraveldairy.com/wp-content/uploads/2025/05/featured-1024x682.jpg",
      infoColumns:
          '[{"icon":"terrain","text":"Góra Stołowa"}, {"icon":"water","text":"Ocean Atlantycki"}, {"icon":"wine_bar","text":"Winnice"}]',
    ),
    DreamPlacesCompanion.insert(
      title: "Paryż, Francja",
      placeName: "Paryż",
      description: "Romantyczna stolica Francji, pełna sztuki, mody i kulinarnych przysmaków.",
      imagePath:
          "https://www.chooseparisregion.org/sites/default/files/news/6---Tour-Eiffel_AdobeStock_644956457_1920_72dpi.jpg",
      infoColumns:
          '[{"icon":"location_city","text":"Wieża Eiffla"}, {"icon":"museum","text":"Luwr"}, {"icon":"coffee","text":"Kawiarnie"}]',
    ),
    DreamPlacesCompanion.insert(
      title: "Rio de Janeiro, Brazylia",
      placeName: "Rio de Janeiro",
      description: "Miasto samby, karnawału i spektakularnych plaż w otoczeniu gór.",
      imagePath: "https://cdn.bookaway.com/media/files/5f3bdc55fb2e364a546de117.jpeg",
      infoColumns:
          '[{"icon":"landscape","text":"Góra Corcovado"}, {"icon":"beach_access","text":"Plaża Copacabana"}, {"icon":"celebration","text":"Karnawał"}]',
    ),
  ];

  await db.batch((batch) {
    batch.insertAll(db.dreamPlaces, seedPlaces);
  });
}
