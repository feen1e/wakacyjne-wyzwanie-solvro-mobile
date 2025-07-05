# Wakacyjne wyzwanie - mobile

## Założenia

- Kurs będzie trwał 7 tygodni
- 5 cotygodniowych list zadań
- 2 tygodnie na projekt końcowy

## Wymagania

- Podstawowa znajomość darta

## Listy

### Lista 0 (instalacja fluttera i przygotowanie środowiska)

- Jak zaistalować i skonfigurać środowisko sprawdź [tu](https://docs.solvro.pl/sections/mobile/)

### Lista 1 (Zapoznanie z podstawowymi funkcjonalnościami frameworka)

1. **Płótno dla marzeń (Scaffold i AppBar)**
    - Każdy obraz potrzebuje płótna. W naszej aplikacji będzie nim Scaffold, który stanowi podstawową strukturę ekranu w Material Design.
    - Stwórz nowy projekt Fluttera: `flutter create wymarzone_miejsce`.
    - W `lib/main.dart` usuń domyślny kod i stwórz własny `StatelessWidget` o nazwie `DreamPlaceScreen`.
    - W metodzie `build` zwróć `Scaffold`. Ustaw jego `backgroundColor` na delikatny, jasny kolor (np. `Colors.grey[200]`).
    - Dodaj `AppBar` z tytułem (`title`) zawierającym nazwę Twojego wymarzonego miejsca, np. `Text('Santorini, Grecja')`.

2. **Obraz wart tysiąca słów (Image i zasoby lokalne)**
    - Wizytówka miejsca musi mieć zjawiskowe zdjęcie! Nauczymy się, jak dodawać obrazy, które są częścią naszej aplikacji.
    - Otwórz plik `pubspec.yaml` i "poinformuj" Fluttera o nowym folderze. W sekcji `flutter` odkomentuj i zmodyfikuj wpis `assets:`.
    - W `body` Twojego `Scaffold` umieść `Column`. Jako pierwszy element (`child`) dodaj widżet `Image.asset()`, podając ścieżkę do swojego zdjęcia. Użyj właściwości `fit: BoxFit.cover`, aby obraz ładnie wypełnił dostępną przestrzeń.
    - Znajdź w internecie zdjęcie swojego wymarzonego miejsca i zapisz je w folderze `assets/images/`.
    - Pamiętaj, że podana ścieżka do obrazka (np. `'assets/images/santorini.jpg'`) jest zwykłym tekstem — stringiem. To coś, czego staramy się unikać w programowaniu z kilku powodów:
        - **Brak bezpieczeństwa typów** – jeśli zrobisz literówkę w ścieżce (np. `'santorini.jgp'`), kompilator niczego nie zauważy. Aplikacja zbuduje się poprawnie, a błąd zauważysz dopiero w czasie działania programu (np. pusty widok lub błąd ładowania).
        - **Brak podpowiedzi składni** – IDE nie zna zawartości folderu `assets`, więc nie zaproponuje poprawnych ścieżek podczas pisania kodu.
        - **Utrudniony refactoring** – gdy przeniesiesz plik do innego folderu, musisz ręcznie poprawić wszystkie miejsca, gdzie użyta była stara ścieżka.
    - Rozwiązanie? Generowanie kodu! Użyjemy popularnej paczki, która automatycznie przeskanuje nasz folder assets i stworzy specjalną klasę z bezpiecznymi, statycznymi odwołaniami do wszystkich naszych zasobów.
    - Zgodnie z instrukcjami na tej [stronie](https://pub.dev/packages/flutter_gen_runner) dodaj paczkę, zapoznaj się z dokumentacją i wygeneruj scieżki do plików. Teraz możesz dodać scieżkę do pliku za pomocą wygenerowanej klasy Assets.

3. **Serce Informacji (Padding, Column, Text i TextStyle)**
    - Pod zdjęciem umieścimy najważniejsze informacje: tytuł i krótki opis, który zachęci do odwiedzin.
    - Bezpośrednio pod Image.asset() w Column dodaj widżet Padding. Doda on "oddech" wokół naszego bloku tekstowego. Ustaw padding: const EdgeInsets.all(16.0).
    - Jako dziecko Padding wstaw Column, który pozwoli ułożyć teksty jeden pod drugim. Ustaw w nim crossAxisAlignment: CrossAxisAlignment.start, aby teksty były wyrównane do lewej.
    - Wewnątrz tego Column dodaj:
        - Text z nazwą miejsca (np. "Białe miasteczko Oia"), używając TextStyle do powiększenia czcionki i pogrubienia.
        - SizedBox(height: 8) dla stworzenia małego odstępu.
        - Text z chwytliwym, jednozdaniowym opisem.

4. Wakacyjne Atrakcje w Pigułce (Row i Icon)
    - Przedstawmy graficznie główne atrakcje miejsca za pomocą ikon. Row idealnie nadaje się do układania elementów obok siebie.
    - Pod widżetem Padding dodaj Row. Ustaw mainAxisAlignment: MainAxisAlignment.spaceEvenly, aby równomiernie rozłożyć elementy na całej szerokości.
    - Wewnątrz Row umieść 3-4 widżety, z których każdy będzie Columnem.
    - Każdy z tych wewnętrznych Columnów powinien zawierać Icon (np. Icons.wb_sunny, Icons.beach_access, Icons.restaurant) oraz pod spodem Text z opisem (np. "Słońce", "Plaże", "Jedzenie").

5. Ożywiamy naszą Aplikację! (StatefulWidget i IconButton)
    - Na koniec dodajmy trochę życia! Umieścimy w AppBarze przycisk "ulubione", którego stan będzie można zmieniać.
    - Konwersja na StatefulWidget: Kliknij na nazwę klasy DreamPlaceScreen, użyj skrótu Ctrl + . (lub Cmd + .) i wybierz "Convert to StatefulWidget".
    - Dodanie stanu: W nowo powstałej klasie _DreamPlaceScreenState dodaj zmienną stanu: bool_isFavorited = false;.
    - Funkcja zmiany stanu: Stwórz metodę, która będzie zmieniać wartość _isFavorited i odświeżać interfejs za pomocą setState:
    - Dodanie przycisku: W AppBar dodaj właściwość actions. Jest to lista widżetów po prawej stronie tytułu. Umieść tam IconButton.
    - W onPressed wywołaj funkcję _toggleFavorite.
    - W icon użyj operatora warunkowego, aby wyświetlić inną ikonę w zależności od stanu _isFavorited.
6. Parametryzacja widgetu
    - Zastanów się jak użyć tego widgetu ponownie tylko z innymi danymi (bez przepisywania go od początku)
    - Jeśli ci się udał pierwszy krok spróbuj stworzyć widok na którym jest 5 przycisków i każdy [przekierowuje](https://docs.flutter.dev/ui/navigation) do ekranu szczegółowego z innymi danymi, który wcześniej stworzyłeś.
