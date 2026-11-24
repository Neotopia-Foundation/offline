# Bez agenta: Polska, dysk 32 GB

[English version](README.md)

Ten folder pozwala zbudować podstawowy dysk offline dla Polski bez agenta AI. Uruchamiasz jeden skrypt. Skrypt pobiera stałą listę plików.

## Co dostajesz

- 51 plików, około 15 GB.
- Polską Wikipedię (wydanie mini), polski Wikisłownik i polskie Wikipodróże.
- Angielskie biblioteki medyczne i praktyczne: WikiProject Medicine, medyczną część Wikipedii, Appropedię oraz zestawy zimgit o wodzie, medycynie, żywności, węzłach i sytuacji po katastrofie.
- Mapy Polski na telefon do OsmAnd, 16 województw.
- Szpitale (Eurostat GISCO), punkty schronienia (dane.gov.pl) i nazwy miejscowości (GeoNames).
- Rządowy poradnik „Bądź gotowy”, jego angielską wersję i wytyczne UE o 72 godzinach samowystarczalności.
- Najmniejszy lokalny model AI, Gemma 4 E2B. Potrzebuje około 4–6 GB RAM.
- Programy do czytania na macOS, Windows, Linux i Android: Kiwix, kiwix-serve, llama.cpp, OsmAnd i VLC.

## Czego nie dostajesz

Te pliki pisze agent. Skrypt ich nie tworzy:

- `START-HERE.html` i instrukcji krok po kroku.
- Skryptów startowych, które dobierają model AI do pamięci.
- Pakietu do druku i testu offline.

Te kroki wykonujesz ręcznie. Opis jest niżej.

## Czego potrzebujesz

- macOS albo Linux z `bash` i `curl`. Na Windows użyj WSL. Budowy na Windows nie testowaliśmy.
- Zalecane: `aria2c` (`brew install aria2` albo `apt install aria2`). Wtedy pliki Kiwix od 1 GB idą przez BitTorrent. Klient BitTorrent w trakcie pobierania wysyła też fragmenty innym osobom.
- Dysk co najmniej 32 GB z systemem plików exFAT.

## Kroki

1. Pobierz `fetch.sh` i `manifest-pl.tsv` ze [strony wydań](https://github.com/Neotopia-Foundation/offline/releases).
2. Podłącz dysk. Uruchom skrypt z folderem docelowym na tym dysku:

   ```bash
   bash fetch.sh /Volumes/TWOJ_DYSK/NeotopiaOffline manifest-pl.tsv
   ```

   Na Linuksie dysk zwykle jest w `/media/<użytkownik>/`.
3. Gdy skrypt skończy, otwórz `_log/failed.tsv` w folderze docelowym. Pusty plik oznacza, że wszystkie pliki dotarły. Jeśli plik ma wiersze, uruchom to samo polecenie jeszcze raz. Skrypt pomija gotowe pliki i wznawia przerwane.
4. Rozpakuj mapy na telefon:

   ```bash
   cd /Volumes/TWOJ_DYSK/NeotopiaOffline/04_maps/osmand_phone
   for f in *.zip; do unzip -o "$f"; done
   ```

5. Sprawdź dysk. Brak wyniku oznacza, że wszystkie pliki są dobre:

   ```bash
   cd /Volumes/TWOJ_DYSK/NeotopiaOffline
   shasum -a 256 -c SHA256SUMS.txt | grep -v ': OK$'
   ```

## Jak używać dysku

- **Wikipedia i poradniki.** Zainstaluj Kiwix dla swojego systemu z `08_software/Kiwix/`. Otwórz pliki `.zim` z `03_zim/`. Poradniki PDF są w `01_guides/`.
- **Udostępnianie telefonom.** Rozpakuj kiwix-tools dla swojego systemu. Uruchom `kiwix-serve --port 8080 /ścieżka/do/03_zim/*.zim`. Telefony w tej samej sieci Wi-Fi otwierają `http://<ip-laptopa>:8080`.
- **Mapy.** Na Androidzie zainstaluj OsmAnd z `08_software/Android/`. Skopiuj pliki `.obf` na telefon i otwórz je w OsmAnd. Na iPhonie zainstaluj OsmAnd z App Store, póki masz internet.
- **Czat AI (opcja).** Rozpakuj llama.cpp dla swojego systemu z `08_software/llama.cpp/`. Na Macu najpierw uruchom `xattr -dr com.apple.quarantine <rozpakowany folder>`. Potem uruchom czat:

  ```bash
  ./llama-server -m /ścieżka/do/05_ai_model/gemma-4-E2B-it-Q4_K_M.gguf -c 2048 --port 8081
  ```

  Otwórz `http://127.0.0.1:8081` w przeglądarce. Ładowanie może trwać kilka minut. Model może się mylić. Zalecenia o pierwszej pomocy, lekach i wodzie bierz z poradników na dysku.

## Większy dysk

Na dysku 64 GB lub większym dodaj angielską Wikipedię (wydanie mini, około 13 GB). Dopisz ten wiersz na końcu `manifest-pl.tsv`. Kolumny oddziel tabulatorem:

```text
03_zim/wikipedia_en_all_mini_2026-09.zim	https://download.kiwix.org/zim/wikipedia/wikipedia_en_all_mini_2026-09.zim	CC BY-SA	
```

Większy model AI, inne kraje albo inne języki daje ścieżka z agentem w [neotopia-offline.md](../neotopia-offline.md).

## Ograniczenia

- Linki sprawdziliśmy 24.11.2026. Wydawcy często wymieniają pliki. Jeśli plik zwraca 404, otwórz jego folder w przeglądarce. Weź najnowszy plik o tym samym początku nazwy. Potem popraw wiersz w manifeście.
- Skrypt kończy się kodem 0 także wtedy, gdy część plików się nie pobrała. Zawsze czytaj `_log/failed.tsv`.
- Do użytku prywatnego możesz użyć wszystkich plików. Zanim skopiujesz dysk dla innych, przeczytaj sekcję 13 przewodnika.
