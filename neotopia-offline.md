# Neotopia Offline

**Build your own offline survival library for any European country, with your own AI agent.**

- Publisher: Neotopia Foundation (Fundacja Neotopia). Repository: https://github.com/neotopia-foundation/offline
- Inspired by Lastbook (https://github.com/Immortal-Protocols/lastbook, MIT licence). This is an independent project. It is not an official Lastbook edition.
- Snapshot date: 2026-11-21. All sizes, versions and links were checked on 2026-11-20 or 2026-11-21.
- Reference build, core part: Poland plus Bulgaria, 139 GB, 309 files, all checksums verified. The extension modules (sections 19 to 29) add more. Measure the final size from the disk, not from this line.
- Scope: EU-27, EEA and EFTA, the United Kingdom, the Western Balkans, Ukraine, Moldova, Turkey and the South Caucasus.
- Not in scope: Russia and Belarus. The project does not produce packs for them.
- Licence: the text is CC BY 4.0. All code blocks and scripts are MIT. Details: `LICENSE.md` in the repository.

---

## 0. How to use this file

### 0.1 For people

1. Give this file to your AI agent, for example Claude Code, Codex or Gemini CLI.
2. Tell the agent your country, your languages and the size of your disk.
3. The agent asks you some more questions. Then it writes a download list and downloads everything.
4. At the end you get a disk that works without internet. It holds maps, encyclopedias, medical guides, repair manuals, a local AI chat and the apps to open all of it.

You do not need to read the rest of this file. The rest is for your agent.

### 0.2 For AI agents: your contract

Follow these rules. They are written for an agent that runs shell commands on the user's computer.

1. **Interview first.** Ask the questions in section 1 before you download anything. Ask them in one batch.
2. **Budget before download.** Calculate the total size with sections 3 to 7. Show the total to the user. Get a clear "yes" before you start.
3. **Use the manifest format.** Write all items to one `manifest.tsv` file (section 11). Then run `fetch.sh` (section 12.1). Do not download items by hand one at a time.
4. **Resolve "latest" at run time.** The file names in this document were current on 2026-11-21. Kiwix, Geofabrik, F-Droid and GitHub publish new versions often. Read the directory listing or the API before you write a row. Section 10 tells you how.
5. **Verify.** Check the checksums when the publisher gives them. Always make `SHA256SUMS.txt` for the whole disk (section 12.1).
6. **Do not touch other data.** Write only into the target folder. Many users keep other files on the same disk.
7. **No personal data.** Do not download, collect or upload the user's personal documents. Offer the encrypted container in section 9.6 instead.
8. **Licences.** Private use of everything in this file is allowed. Redistribution is a different question. Read section 13 before you copy the disk for other people.
9. **Report honestly.** List every item that failed, with its HTTP code. Do not report a 404 or a 403 as success.
10. **Prefer silence.** Do not play sounds. If the user wants a notification, use a silent method.
11. **Video needs a licence check.** Follow the order in section 19.2. Do not download a video with a standard licence on your own initiative.
12. **Finish with a drill.** Run the offline test in section 27.4 before you tell the user that the disk is ready.
13. **Pack for a world without internet.** Every tool needs its installer, dependencies, manual, launcher and runbook on the disk (section 31). Write `START-HERE` in each household language.
14. **Spare the mirrors.** Kiwix, Geofabrik and the other sources are free services with limited bandwidth. Install `aria2c` before you start, so that `fetch.sh` takes large ZIM files over BitTorrent (section 12.1). Do not download the same large file twice. Do not run more than four downloads at the same time.
15. **Say what the local AI is for.** The local chat does not read the library. It can explain a passage that the user copies from the library (section 31.6). It can give wrong answers. For medicine, water and first aid, the user must follow the guides and medical ZIM files on the disk. Tell the user this before the first chat. Write it in `README.txt` too.

---

## 1. Interview questions

Ask these questions in one message. Offer the default in brackets.

| # | Question | Why it matters | Default |
|---|---|---|---|
| 1 | Which country or countries? Which regions inside them? | Maps and local guides | One country |
| 2 | Which languages do you read? Which languages do others in your household read? | Wikipedia and dictionary packs | Local language plus English |
| 3 | How large is the disk? Is it empty? Which file system does it use? | Budget, 4 GB file limit | Ask for `df -h` output |
| 4 | Which devices will read the disk? Mac, Windows, Linux, Android phone, iPhone, Raspberry Pi? | Which apps to include | All desktop systems plus Android |
| 5 | How strong is the weakest computer? How much RAM does it have? | Size of the AI model | 16 GB RAM |
| 6 | What matters most? Medicine, food and water, repair and energy, maps, children's education, radio communication? | Order of priority when space runs out | Medicine, water, maps first |
| 7 | Do you live near a border? Which neighbour countries do you need? | Extra maps | None |
| 8 | Will you copy this disk for other people? | Licence rules in section 13 | Private use only |
| 9 | How fast is your internet? Is there a data cap? | Download time, order of downloads | No cap |
| 10 | Do you want video lessons? How many GB may they use? | Video is the largest optional part (section 19) | None in tier S, 10 GB in tier M |
| 11 | Are there children in the household? Which school years? | School material (section 21) | No |
| 12 | Do you need to talk with people who speak another language? | Offline translation and speech tools (section 20) | No |
| 13 | What do people in your household read, hear and play for pleasure? | Books, audiobooks and games (section 28) | Classics in the local language |
| 14 | Does anyone depend on medicines, medical devices, sign language or a minority language? Are there babies, older people or animals? | Household essentials (section 30). Store the answers only in the encrypted container | — |

After the interview, write a short summary for the user. Include the country codes, languages, tier and target folder.

---

## 2. Disk layout

Use this folder layout. Number the folders so that the order stays the same in every file manager.

```
NeotopiaOffline/
  README.txt                 what is here, how to start, in the user's language
  MANIFEST.tsv               copy of the manifest used for this build
  SHA256SUMS.txt             checksums of all files
  _log/                      download logs, failed.tsv
  01_guides/<CC>/            national preparedness guides
  01_guides/EU/              EU-level guides
  02_manuals/                international manuals (first aid, water, food, shelter)
  03_zim/                    Kiwix ZIM libraries (Wikipedia, medicine, repair)
  04_maps/<CC>/osm/          OpenStreetMap extract (.osm.pbf)
  04_maps/<CC>/dem_glo30/    terrain tiles (Copernicus DEM)
  04_maps/<CC>/worldcover/   land-cover tiles (ESA WorldCover)
  04_maps/<CC>/geonames/     place names and postcodes
  04_maps/<CC>/addresses/    address points (Parquet)
  04_maps/<CC>/help_points/  hospitals, shelters
  04_maps/osmand_phone/      ready-to-use phone maps (.obf)
  05_ai_model/               GGUF model for local AI chat
  06_upstream_lastbook/      optional: original US Lastbook app, for reference
  07_cad_robotics/           open hardware designs
  08_software/               apps for all systems, Android APKs, boot tools
  09_radio/                  radio frequencies, firmware and notes
  10_video/                  video lessons outside ZIM files, with licence records
  11_language_tools/         offline translation, speech and OCR models
  12_children/               school material and Kolibri
  13_print_first/            pages to print on paper before a crisis
  14_books_audio_games/      classics, audiobooks and games
```

**File system.** Use exFAT for a disk that must work on Mac, Windows and Linux. FAT32 cannot hold files larger than 4 GB. Many items here are larger. NTFS is read-only on many Macs.

**Safe removal.** Always eject the disk in the operating system before you unplug it. An unclean unplug forces a file-system check at the next mount. On a 1 TB exFAT disk this check took about 80 seconds in our test.

---

## 3. Size tiers

Pick a tier from the free space. Keep 10 % of the disk free. All figures are in GB (10^9 bytes). "Local" means the user's country and languages.

| Tier | Disk | What you get |
|---|---|---|
| **S** | 32 GB | Apps, small AI model, medical and practical English ZIMs, local Wikipedia "mini", phone maps, OSM extract, guides |
| **M** | 128 GB | Tier S, plus a large AI model, full English Wikipedia without images, local Wikipedia without images, repair and DIY libraries, terrain, addresses, CAD software |
| **L** | 256 GB | Tier M, plus science textbooks, more Q&A libraries, neighbour maps, robotics designs, all phone apps |
| **XL** | 512 GB and more | Tier L, plus Wikipedia with images, Project Gutenberg English (206 GB), several countries |

### 3.1 Formula

```
total = A_apps + B_model + C_core_zims + D_wikipedia_en + E_local_language + F_maps + G_guides + H_extras + I_video + J_language_tools + K_children
```

Use the tables in sections 4 to 9 and 19 to 25 for each term. Add 3 % for file-system overhead.

Suggested budgets for the optional parts:

| Tier | I video | J language tools | K children |
|---|---|---|---|
| S | 0 GB, or transcripts only | 0.3 GB | 0.5 GB |
| M | 5–10 GB | 1 GB | 5 GB |
| L | 30 GB | 3 GB | 25 GB |
| XL | 100 GB and more | 5 GB | 170 GB and more (Khan Academy) |

### 3.2 Worked example: Poland, tier M (128 GB disk)

| Part | Items | GB |
|---|---|---|
| A apps | Kiwix, llama.cpp, Android APKs, boot tools, CHIRP | 2.0 |
| B model | Gemma 4 26B A4B, Q4_K_M | 16.9 |
| C core ZIMs | mdwiki, Wikipedia medicine, Appropedia, zimgit set, Wikivoyage EN, iFixit, StackExchange practical set, Wikibooks EN, OSM wiki | 16.5 |
| D Wikipedia EN | `wikipedia_en_all_nopic` | 52.7 |
| E local | `wikipedia_pl_all_nopic`, `wiktionary_pl`, `wikivoyage_pl`, PhET PL | 9.2 |
| F maps | OSM PL 2.1, OsmAnd PL 1.9, DEM 1.9, WorldCover 1.0, addresses 0.5, GeoNames | 7.4 |
| G guides | national, EU and international PDFs | 0.1 |
| H extras | FreeCAD, OpenSCAD, KiCad | 4.3 |
| **Total** | | **109.1** |

With 3 % file-system overhead, the build needs about 112.4 GB. A 128 GB disk keeps about 15.6 GB free. That is the 10 % reserve (12.8 GB) plus about 2.8 GB.

### 3.3 Worked example: Bulgaria, tier S (32 GB disk)

| Part | Items | GB |
|---|---|---|
| A apps | Kiwix, llama.cpp, Android APKs (arm64 only) | 1.2 |
| B model | Gemma 4 E4B, Q4_K_M | 5.0 |
| C core ZIMs | mdwiki, Wikipedia medicine, Appropedia, zimgit set, Wikivoyage EN | 5.1 |
| D Wikipedia EN | `wikipedia_en_all_mini` | 13 |
| E local | `wikipedia_bg_all_nopic` 1.6, `wiktionary_bg` 0.1, PhET BG 0.1 | 1.8 |
| F maps | OSM BG 0.2, OsmAnd BG 0.3, addresses (from OSM) 0.004, GeoNames | 0.5 |
| G guides | | 0.05 |
| **Total** | | **26.7** |

Sections 30 and 31 were added after these examples. Add about 6 GB to each example: the small model next to the large one, the reader programs, launchers and runbooks. The Poland M example then needs about 115 GB, and about 118.6 GB with the 3 % overhead. A 128 GB disk with a 10 % reserve allows about 115.2 GB. So trim about 4 GB, for example `wikibooks_en_all_nopic` (3.5 GB) and `wikisource_en_all_nopic`, or use a 256 GB disk. The Bulgaria S example needs a different model choice (section 3.4).

**Real capacity.** A "32 GB" stick has fewer usable bytes than its label. Check the free space with `df -h` or the file manager after formatting. Plan with that number, not with the label.

### 3.4 Quick path: 32 GB pocket build

Use this fixed profile when the disk is 32 GB. Target: 25 GB or less.

| Include | GB, about |
|---|---|
| Kiwix for each household system, Kiwix and OsmAnd for Android, VLC for Android | 0.7 |
| Gemma 4 E2B (smallest model) and the llama.cpp build for each household system | 3.3 |
| `mdwiki_en_all_maxi`, `wikipedia_en_medicine_nopic`, `appropedia_en_all_maxi`, zimgit set | 4.0 |
| Local Wikipedia: `mini`, or `nopic` when it is smaller than 2 GB | 0.3–5 |
| `wikipedia_en_all_mini` | 14 |
| OsmAnd maps of the region, unzipped. Delete the `.zip` files after the check | 0.1–2 |
| Help points CSV (section 23), national guide, EU guidelines, `START-HERE`, print pack | 0.1 |

Leave out: QGIS, CAD, Linux ISO, Kolibri, video, DEM, WorldCover, Gutenberg, the 26B model. If the total is over 25 GB, replace `wikipedia_en_all_mini` with the local Wikipedia only.

---

## 4. Part A: software (any country)

Include the readers in every build. Without them, ZIM files and the AI model are useless on a fresh computer.

### 4.1 Desktop and server

| Item | Systems | Size MB | Source (resolve latest) | Licence |
|---|---|---|---|---|
| Kiwix for macOS | macOS | 6 | `https://download.kiwix.org/release/kiwix-macos/` (`kiwix-macos_<v>.dmg`) | GPL-3.0 |
| Kiwix Desktop | Windows | 157 | `https://download.kiwix.org/release/kiwix-desktop/` (`kiwix-desktop_windows_x64_<v>.zip`) | GPL-3.0 |
| Kiwix Desktop | Linux | 168 | same folder (`kiwix-desktop_x86_64_<v>.appimage`) | GPL-3.0 |
| kiwix-tools (`kiwix-serve`) | macOS arm64, Linux x86_64, Linux aarch64, Windows | 10–20 each | `https://download.kiwix.org/release/kiwix-tools/` | GPL-3.0 |
| llama.cpp binaries | macOS arm64/x64, Ubuntu x64 (CPU, Vulkan), Windows x64 (CPU, Vulkan) | 12–38 each | GitHub `ggml-org/llama.cpp` releases. The reference build uses tag `b12032`, the version pinned by upstream Lastbook | MIT |
| FreeCAD | macOS arm64, Windows, Linux AppImage, source | 650, 519, 821, 98 | GitHub `FreeCAD/FreeCAD` releases. Each file has an official `-SHA256.txt` | LGPL-2.1+ |
| OpenSCAD 2021.01 | macOS, Windows, Linux, source | 29, 22, 41, 16 | `https://files.openscad.org/` | GPL-2.0+ |
| KiCad | macOS universal, Windows | 1406, 969 | `https://downloads.kicad.org/kicad/` (Linux: use the distribution package) | GPL-3.0+ |
| Ventoy | Windows, Linux | 17, 20 | GitHub `ventoy/Ventoy` releases, with `sha256.txt` | GPL-3.0 |
| Rufus | Windows | 2 | GitHub `pbatard/rufus` releases | GPL-3.0 |
| CHIRP (radio programming) | Windows, macOS arm64/x64, Linux AppImage, source | 24–72 each | `https://archive.chirpmyradio.com/chirp_next/next-<YYYYMMDD>/` with `SHA256SUM` | GPL-3.0 |

**`kiwix-serve` is important.** One laptop can serve all ZIM files over Wi-Fi to every phone nearby. Command: `kiwix-serve --port 8080 /path/to/03_zim/*.zim`. People open `http://<laptop-ip>:8080` in a browser.

**CHIRP gotcha.** The CHIRP archive uses a Cloudflare browser check. `curl` gets a challenge page, not the file. Open the folder in a real browser, download the files, then verify them against `SHA256SUM`. Do not try to bypass the check.

### 4.2 Android apps

All APKs come from F-Droid or from the developer's own release page. Most apps exist in two builds. `arm64-v8a` is for phones from about 2017 onwards. `armeabi-v7a` is for older phones. Take both if you do not know the phones.

| App | Purpose | Size MB | Source |
|---|---|---|---|
| F-Droid | App store for open-source apps | 13 | `https://f-droid.org/F-Droid.apk` |
| Kiwix | Read ZIM files | 99 | `https://download.kiwix.org/release/kiwix-android/` |
| OsmAnd | Offline maps and navigation. Opens `.obf` files from the disk | 160 | F-Droid `net.osmand.plus` |
| Organic Maps | Simple offline maps (maps download inside the app) | 66 | GitHub `organicmaps/organicmaps` releases |
| Briar | Messenger over Bluetooth and Wi-Fi, no internet needed | 51 | F-Droid `org.briarproject.briar.android` |
| Meshtastic | Messenger over LoRa radio nodes | 48–65 | GitHub `meshtastic/Meshtastic-Android` releases |
| VLC | Video and audio | 50 | F-Droid `org.videolan.vlc` |
| KOReader | PDF and EPUB reader | 30 | F-Droid `org.koreader.launcher.fdroid` |
| MuPDF viewer | Light PDF reader | 17 | F-Droid `com.artifex.mupdf.viewer.app` |
| Material Files | File manager | 11 | F-Droid `me.zhanghai.android.files` |
| KeePassDX | Offline password manager | 17 | F-Droid `com.kunzisoft.keepass.libre` |
| Termux | Linux terminal | 114 | F-Droid `com.termux` |
| GPSTest | GPS status without network | 4 | F-Droid `com.android.gpstest.osmdroid` |
| Sky Map | Star map for orientation | 24 | F-Droid `com.google.android.stardroid` |
| AnkiDroid | Flash cards (first aid, languages) | 41 | F-Droid `com.ichi2.anki` |
| Binary Eye | QR and barcode reader | 8 | F-Droid `de.markusfisch.android.binaryeye` |
| RTL-SDR driver | USB radio receiver | 7 | F-Droid `marto.rtl_tcp_andro` |

**How to find the right F-Droid file.** Call `https://f-droid.org/api/v1/packages/<package>`. It gives `suggestedVersionCode`. One version can have several codes, one per CPU type. The package page `https://f-droid.org/en/packages/<package>/` shows the CPU type next to each download link. The file URL is `https://f-droid.org/repo/<package>_<versionCode>.apk`.

**iPhone.** iOS cannot install apps from a file. Install Kiwix, OsmAnd or Organic Maps from the App Store while you still have internet. Then copy ZIM and map files to the phone.

---

## 5. Part B: AI model

The model gives a local chat that answers questions from the user's own words. It runs with llama.cpp. It needs no internet.

| Model (GGUF, Unsloth) | File | Size GB | RAM needed, about | Use when |
|---|---|---|---|---|
| Gemma 4 26B A4B it, UD-Q4_K_M | `gemma-4-26B-A4B-it-UD-Q4_K_M.gguf` | 16.9 | 24 GB | Laptop or desktop with 24 GB RAM or more |
| Gemma 4 E4B it, Q4_K_M | `gemma-4-E4B-it-Q4_K_M.gguf` | 5.0 | 8 GB | Normal laptop |
| Gemma 4 E2B it, Q4_K_M | `gemma-4-E2B-it-Q4_K_M.gguf` | 3.1 | 4–6 GB | Weak laptop, Raspberry Pi 5 |

- Licence: Apache-2.0 for all three. Keep the licence text next to the file.
- Source pattern: `https://huggingface.co/unsloth/<repo>/resolve/<commit>/<file>?download=true`.
- Pin the commit. The reference build uses commit `c099eb48e663fd284577b04978a94ffccb261841` of `unsloth/gemma-4-26B-A4B-it-GGUF`.
- The expected SHA-256 of the 26B file is `f2c28b3dc4776931ac6f879e11f203dec637ea0f14267a86ec8f6165f63f293f`. This is the value pinned in upstream Lastbook. Our download matched it.
- The RAM figures are estimates. Test the model on the user's weakest computer before you finish.
- Warn the user: the model can be wrong. For medicine, it must not replace the medical ZIMs and guides on the same disk.

Start command:

```
llama-server -m 05_ai_model/<file>.gguf --port 8081 -c 8192
```

Then open `http://localhost:8081` in a browser.

Always ship a small model (E4B or E2B) next to the large one. A household laptop with 16 GB RAM cannot run the 26B model. Section 31.5 has launchers that pick the model by memory.

`llama-server` listens only on `127.0.0.1` by default. Phones on the home network can reach it only with `--host 0.0.0.0` (section 31.7).

---

## 6. Part C and D: knowledge libraries (ZIM)

All ZIM files come from `https://download.kiwix.org/zim/<project>/`. The file name has the form `<project>_<lang>_<selection>_<flavour>_<YYYY-MM>.zim`.

- `nopic` means no images. It is the best value for text.
- `maxi` means full images. It is two to three times larger.
- `mini` means only the introduction of each article. It is about a quarter of `nopic`.

### 6.1 Core English set (any country)

Sizes are from the reference build.

| File (date at snapshot) | GB | Content | Licence |
|---|---|---|---|
| `mdwiki_en_all_maxi_2025-11` | 2.3 | WikiProject Medicine articles | CC BY-SA |
| `wikipedia_en_medicine_nopic_2026-10` | 1.0 | Medical subset of Wikipedia | CC BY-SA 4.0 |
| `appropedia_en_all_maxi_2026-02` | 0.6 | Appropriate technology, sanitation, energy | CC BY-SA 4.0 |
| `zimgit-water_en_2024-08` | 0.02 | Water treatment | check per file |
| `zimgit-medicine_en_2024-08` | 0.07 | Field medicine | check per file |
| `zimgit-food-preparation_en_2025-04` | 0.1 | Food preparation and storage | check per file |
| `zimgit-knots_en_2024-08` | 0.03 | Knots | check per file |
| `zimgit-post-disaster_en_2024-05` | 0.6 | Post-disaster manuals | check per file |
| `wikivoyage_en_all_nopic_2026-09` | 0.3 | Travel and local practical information | CC BY-SA 4.0 |
| `ifixit_en_all_2025-12` | 3.6 | Repair guides | CC BY-NC-SA 3.0 |
| `energypedia_en_all_nopic_2026-06` | 0.7 | Off-grid energy | check |
| `diy.stackexchange.com_en_all_2026-10` | 2.1 | Home repair Q&A | CC BY-SA |
| `gardening.stackexchange.com_en_all_2026-10` | 0.9 | Growing food | CC BY-SA |
| `mechanics.stackexchange.com_en_all_2026-10` | 0.3 | Vehicle repair | CC BY-SA |
| `cooking.stackexchange.com_en_all_2026-10` | 0.2 | Cooking | CC BY-SA |
| `outdoors.stackexchange.com_en_all_2026-10` | 0.1 | Outdoor skills | CC BY-SA |
| `ham.stackexchange.com_en_all_2026-10` | 0.08 | Amateur radio | CC BY-SA |
| `wikibooks_en_all_nopic_2026-10` | 3.5 | Textbooks | CC BY-SA 4.0 |
| `openstreetmap-wiki_en_all_nopic_2026-10` | 0.5 | How to use and edit OSM data | CC BY-SA 2.0 |
| `wikisource_en_all_nopic_2026-09` | 3.9 | Source texts | CC BY-SA / PD |

### 6.2 English Wikipedia

| File | GB | Tier |
|---|---|---|
| `wikipedia_en_all_mini_<date>` | 13 | S |
| `wikipedia_en_all_nopic_<date>` | 49–53 | M, L |
| `wikipedia_en_all_maxi_<date>` | 119 | XL |

The 53 GB file broke off once in our test at 28 GB. `curl -C -` resumed it. Download the largest files last.

### 6.3 Science and learning (tier L)

| File group | GB | Licence |
|---|---|---|
| LibreTexts: `libretexts.org_en_{bio,chem,eng,geo,med,phys,math,k12,workforce,stats}` | 10.0 | mixed, mostly CC BY-NC-SA |
| StackExchange: electronics 4.3, physics 1.8, chemistry 0.4, biology 0.4, engineering 0.3, bicycles 0.5, woodworking 0.1, homebrew 0.04, sustainability 0.03, earthscience 0.1 | 7.9 | CC BY-SA 4.0 |
| `wikiversity_en_all_maxi` | 2.0 | CC BY-SA 4.0 |
| DevDocs: python, c, cpp, bash, git, html, css, javascript, docker | 0.03 | mixed |
| PhET simulations per language (`phet_<lang>_all`) | 0.1 each | check: the PhET licensing page (`https://phet.colorado.edu/en/licensing/`) is the reference. An independent review reports CC BY-NC 4.0 for the HTML simulations. Not verified by us |
| Project Gutenberg in a local language (`gutenberg_<lang>_all`) | 0.003–1 | public domain |
| Project Gutenberg English (`gutenberg_en_all`) | 206 | public domain. XL only |

### 6.4 Local language packs

Section 15 lists the Wikipedia, Wiktionary, Wikivoyage and Wikibooks sizes for every language in scope.

**Rules for the agent:**
1. For each language the user reads, take `wikipedia_<lang>_all_nopic`. In tier S take `mini` when it exists.
2. Add `wiktionary_<lang>_all_nopic` and `wikivoyage_<lang>_all_nopic` when they exist.
3. Norwegian Bokmål uses the code `nb` in Wikipedia files. Project Gutenberg uses `no`. Kiwix mixes two-letter and three-letter codes (example: `ron` for Romanian school files). Check the listing.
4. Montenegro has no own Wikipedia language code here. Use `sr` and `sh` (Serbo-Croatian).
5. For a minority language, check that the file exists in the Kiwix listing before you add it.

---

## 7. Part F: maps and geodata

### 7.1 Sources

| Layer | Source and URL pattern | Licence | Notes |
|---|---|---|---|
| OSM extract | Geofabrik: `https://download.geofabrik.de/<path>-latest.osm.pbf`. Index: `https://download.geofabrik.de/index-v1.json` | ODbL 1.0 | The full street map. Many tools can read it |
| Phone maps | OsmAnd: `https://download.osmand.net/download?standard=yes&file=<Name>_europe_2.obf.zip`. Index: `https://download.osmand.net/get_indexes?gzip=false` (gzip data) | ODbL 1.0 | Large countries are split into regions. Unzip and open the `.obf` in OsmAnd |
| Terrain | Copernicus DEM GLO-30, 1°×1° tiles: `https://copernicus-dem-30m.s3.amazonaws.com/Copernicus_DSM_COG_10_<N|S>LL_00_<E|W>LLL_00_DEM/<same>.tif` | Copernicus DEM licence. Fixed notice required (section 13) | About 35 MB per land tile. Sea tiles do not exist (404) |
| Land cover | ESA WorldCover 2021 v200, 3°×3° tiles: `https://esa-worldcover.s3.eu-central-1.amazonaws.com/v200/2021/map/ESA_WorldCover_10m_2021_v200_<N|S>LL<E|W>LLL_Map.tif` | CC BY 4.0 | About 70 MB per tile. Tile corners are multiples of 3° |
| Place names | GeoNames: `https://download.geonames.org/export/dump/<CC>.zip`, plus `cities15000.zip` and `admin1CodesASCII.txt` | CC BY 4.0 | Small |
| Postcodes | GeoNames: `https://download.geonames.org/export/zip/<CC>.zip` | CC BY 4.0 | Not every country |
| Hospitals | Eurostat GISCO: `https://gisco-services.ec.europa.eu/pub/healthcare/last/gpkg/<CC>.gpkg` | per country, read `metadata` PDF | EU and some EFTA only. Test the URL |
| Addresses | Overture Maps (section 7.3), or OSM `addr:*` (section 12.3) | Overture: per source. OSM: ODbL | See the table column "Overture addresses" |
| Shelters (PL) | `https://api.dane.gov.pl/resources/1393918,punkty-schronienia-dane-csv/file` | CC BY 4.0 | Poland only. Look for a similar national dataset in other countries |

### 7.2 Tile generator

Use `tiles.py` (section 12.2) with the bounding box from section 14. A bounding box covers sea and border areas. So some tiles return 404. This is normal. The table in section 14 gives the real number of land tiles, counted against the country outline.

**Islands.** Portugal, Spain, Greece, Norway, Denmark and Finland have islands far from the mainland. One large box gives hundreds of empty tiles. Make one box per island group instead.

### 7.3 Addresses

1. Check the column "Overture addresses" in section 14.
2. If it says "yes", run `overture_addresses.py` (section 12.4). It reads the Overture release straight from Amazon S3 with DuckDB. No account is needed.
3. If it says "no → OSM", run `osm_addresses.py` (section 12.3) on the OSM extract.
4. If it says "test", run the Overture script first. If the result has 0 rows, use the OSM script.

Reference results:
- Poland, Overture release `2026-11-18.0`: 8,638,513 addresses from 16 regional sources, 541 MB.
- Bulgaria, Overture: 0 rows. OSM fallback: 182,456 addresses, 3.5 MB. 39 % have no town name and 74 % have no postcode. OSM address data is weak in many countries outside the EU core.

---

## 8. Part G: guides and manuals

### 8.1 EU and international (any country)

| Item | URL | Licence | Size MB |
|---|---|---|---|
| EU 72-hour self-sufficiency guidelines, SWD(2026) 826 | `https://civil-protection-knowledge-network.europa.eu/system/files/2026-11/sufficiency-of-at-least-72-hours-under-the-eu-preparedness-union-strategy.pdf` | EU, check notice | 0.3 |
| WHO heat-health action plans | `https://heathealth.info/wp-content/uploads/9789289055406-eng.pdf` | CC BY-NC-SA 3.0 IGO | 9 |
| IFRC Psychological First Aid guide (2018) | `https://mhpsshub.org/wp-content/uploads/2019/05/PFA-Guide-low-res.pdf` | ask IFRC PS Centre before redistribution | 3 |
| IFRC PFA, EU4Health edition | `https://mhpsshub.org/wp-content/uploads/2023/03/EU4HEALTH-PFA.pdf` | as above | 1 |
| Management of earthquake risk in the EU | `https://preparecenter.org/wp-content/uploads/2025/10/Management-of-Earthquake-Risk-in-the-European-Union.pdf` | check | 4 |
| PERC report, Valencia DANA floods 2025 | Zurich Foundation publication, English | check | 14 |
| FEMA emergency wood gasifier (1989), **historical document** | `https://archive.org/download/FEMAEmergencyGassifer/FEMA_emergency_gassifer.pdf` | US public domain. EU status unclear | 2 |
| BfR botulism Q&A | `https://mobil.bfr.bund.de/cm/349/rare-but-avoidable-questions-and-answers-about-botulism.pdf` | check | 0.3 |

**Index of national brochures.** The EU Civil Protection Knowledge Network keeps copies of many national brochures. Start at `https://civil-protection-knowledge-network.europa.eu/list-of-terms/risk-awareness-communication`. Hosting there is not permission to redistribute.

Removed after review: the EMA paracetamol Annex I. It is a regulatory list of products, not patient advice. For medicines, use the patient leaflets in section 30.2.

The gasifier manual is a 1989 engineering document. Store it with the history and engineering material, not with household heating advice. A gasifier makes carbon monoxide.

These items failed in our build. Do not rely on them:
- INEE Minimum Standards 2024: 403 to scripts.
- BfR DIY preservation: 404.
- DTIC ADA208249 gasifier: 403.
- EFI wildfire prevention 2023: 404.
- Linköping mirror of the Swedish brochure: 404.

### 8.2 National guides

Section 16 lists the best known guide for every country in scope. It gives the URL, the English status and the licence status.

---

## 9. Part H: extras

### 9.1 Open hardware and robotics (tier L)

| Repository | Size MB | Licence |
|---|---|---|
| `PCrnjak/PAROL6-Desktop-robot-arm` | 141 | CERN-OHL-S-2.0 / GPL-3.0 |
| `TheRobotStudio/SO-ARM100` | 92 | Apache-2.0 |
| `LibreSolar/bms-c1` (battery management) | 12 | CERN-OHL-W-2.0 / Apache / CC BY-SA 4.0 |
| `open-dynamic-robot-initiative/open_robot_actuator_hardware` | 659 | BSD-3 |
| `openflexure/openflexure-microscope` (GitLab) | 18 | CERN-OHL-S-2.0 |

Download pattern: `https://github.com/<owner>/<repo>/archive/HEAD.zip`.

More open hardware worth adding:
- Open Source Ecology, Global Village Construction Set. CC BY-SA 4.0, CERN-OHL-S-2.0 and AGPL. Only some machines have finished releases.
- Appropedia ZIM (section 6.1) already covers many small projects.

### 9.2 Upstream Lastbook (optional reference)

The original US app and its "Small" pack: `https://downloads.lastbook.org/` (`Lastbook-<v>-mac.dmg`, `-Setup.exe`, `_amd64.deb`, `Lastbook-Small-<date>.zip`, about 7.7 GB). The app is MIT. The licence of the pack content is not published. Use it for private reference only.

### 9.3 Neighbour maps

Add the OSM extract and the OsmAnd files of each neighbour country from section 14. This costs 0.05 to 7 GB per country.

### 9.4 Radio

Write a one-page frequency sheet in the user's language. It is in `09_radio/`. Include:
- PMR446: 16 analogue channels, 446.00625 to 446.19375 MHz, 12.5 kHz steps, 0.5 W ERP. The exemption from a licence applies to approved hand-held radios with a fixed antenna. Print the national rule. Source: CEPT decision on PMR446, `https://docdb.cept.org/document/448`.
- Mark clearly which frequencies are for listening only. Amateur frequencies need a licence to transmit.
- CB 27 MHz: channel 9 is the emergency channel in many countries. Some radios in Poland use a channel grid 5 kHz lower.
- IARU Region 1 emergency centres of activity: 3.760, 7.110, 14.300, 18.160 and 21.360 MHz.
- FM calling frequencies: 145.500 MHz (2 m) and 433.500 MHz (70 cm).
- Meshtastic region setting for Europe: `EU_868`.
- National long-wave or AM public broadcasters, if any. Example: Polskie Radio Program 1 on 225 kHz.
- A family plan: one fixed channel and one fixed listening time.

Mark the sheet "verify before use". Radio rules and broadcast schedules change.

### 9.5 Boot disk

Ventoy (section 4.1) turns a second USB stick into a boot disk for many ISO files. Add one Linux live ISO, for example Debian or Ubuntu (3–6 GB). It can start a computer with a broken system.

### 9.6 Personal documents

Do not download personal data. Offer this instead:
1. Make an encrypted container, for example with VeraCrypt.
2. The user copies scans of ID documents, insurance, medical records, contacts and a password-manager export into it.
3. The user keeps the password in their head or on paper, not on the disk.

---

## 10. Resolving the latest version

| Source | How to find the newest file |
|---|---|
| Kiwix ZIM and apps | Read the HTML listing of the folder. Sort the names with a version sort. Take the newest date for your exact name stem |
| Geofabrik | `https://download.geofabrik.de/index-v1.json`. Field `properties.urls.pbf`. The `-latest` file name never changes |
| OsmAnd | `https://download.osmand.net/get_indexes?gzip=false`. The body is gzip data. Read `<region>` elements with `type="map"`, `name` and `containerSize` |
| F-Droid | `https://f-droid.org/api/v1/packages/<package>` |
| GitHub releases | `gh api repos/<owner>/<repo>/releases/latest` or `https://api.github.com/repos/<owner>/<repo>/releases/latest` |
| Hugging Face | `https://huggingface.co/api/models/<repo>` (field `sha`) and `/tree/main` (file sizes) |
| Overture | `https://docs.overturemaps.org/release/latest/`. Release names look like `2026-11-18.0` |
| GeoNames | Fixed URLs. Updated daily |

---

## 11. Manifest format

One UTF-8 text file. Tab-separated. First line is the header.

```
dest	url	licence	note
03_zim/mdwiki_en_all_maxi_2025-11.zim	https://download.kiwix.org/zim/other/mdwiki_en_all_maxi_2025-11.zim	CC BY-SA	
04_maps/PL/osm/poland-latest.osm.pbf	https://download.geofabrik.de/europe/poland-latest.osm.pbf	ODbL 1.0	
```

- `dest` is the path inside the target folder.
- `url` is the direct download URL.
- `licence` and `note` are for people. `fetch.sh` ignores them.
- The `licence` column is the start of your licence register. Keep it accurate.

---

## 12. Scripts

### 12.1 `fetch.sh`: resumable downloader

Requirements: `bash`, `curl`, and `shasum` (macOS) or `sha256sum` (Linux). The script picks the checksum command itself.

Strongly recommended: `aria2c` (`brew install aria2`, `apt install aria2`, `winget install aria2.aria2`). With it, the script takes Kiwix ZIM files of 1 GB or more over BitTorrent. This spares the Kiwix mirrors. Without it, the script falls back to HTTP.

```bash
#!/usr/bin/env bash
# Download a set from manifest.tsv into ROOT.
# Resumable: re-run to continue.
# Kiwix ZIM files of 1 GB or more go over BitTorrent when aria2c is installed.
# All other files use curl. They land as <dest>.part and are renamed on success.
# Usage: fetch.sh <ROOT> [manifest.tsv]
set -u
ROOT="${1:?target folder}"
MAN="${2:-$(dirname "$0")/manifest.tsv}"
LOG="$ROOT/_log"
TORRENT_MIN="${TORRENT_MIN:-1000000000}"   # bytes
SEED_MIN="${SEED_MIN:-0}"                  # minutes to seed after a torrent download
mkdir -p "$LOG"
# One run at a time. A second run on the same ROOT would download the same files twice.
if ! mkdir "$LOG/.lock" 2>/dev/null; then
  echo "STOP another fetch.sh runs on $ROOT. If it does not, delete $LOG/.lock"; exit 1
fi
trap 'rmdir "$LOG/.lock" 2>/dev/null' EXIT
cp "$MAN" "$ROOT/MANIFEST.tsv"
: > "$LOG/failed.tsv"
if command -v sha256sum >/dev/null; then SUM="sha256sum"; else SUM="shasum -a 256"; fi
HAVE_ARIA=0; command -v aria2c >/dev/null && HAVE_ARIA=1
[ $HAVE_ARIA = 0 ] && echo "NOTE aria2c not found. Large Kiwix files will use HTTP, not BitTorrent."

fail() { printf '%s\t%s\t%s\n' "$1" "$2" "$3" >> "$LOG/failed.tsv"; echo "FAIL $2 $1"; }

# Compare a Kiwix file with the publisher's .sha256. Other sources: no check here.
kiwix_sha_ok() {
  case "$2" in https://download.kiwix.org/*.zim) ;; *) return 0 ;; esac
  want=$(curl -sfL "$2.sha256" | cut -d' ' -f1)
  [ -z "$want" ] && return 0
  [ "$($SUM "$1" | cut -d' ' -f1)" = "$want" ]
}

use_torrent() {
  [ $HAVE_ARIA = 1 ] || return 1
  case "$2" in https://download.kiwix.org/*.zim) ;; *) return 1 ;; esac
  [ "$(basename "$1")" = "$(basename "$2")" ] || return 1
  len=$(curl -sIL "$2" | tr -d '\r' | awk 'tolower($1)=="content-length:"{n=$2} END{print n+0}')
  [ "$len" -ge "$TORRENT_MIN" ]
}

one() {
  dest="$1"; url="$2"; out="$ROOT/$dest"
  [ -s "$out" ] && [ ! -e "$out.aria2" ] && { echo "SKIP $dest"; return 0; }
  mkdir -p "$(dirname "$out")"
  if use_torrent "$dest" "$url"; then
    # BitTorrent checks every piece against the torrent hash. aria2c resumes from <file>.aria2.
    if aria2c --dir="$(dirname "$out")" --follow-torrent=mem --seed-time="$SEED_MIN" \
         --continue=true --file-allocation=none --auto-file-renaming=false \
         --console-log-level=warn --summary-interval=0 "$url.torrent" >>"$LOG/aria2.log" 2>&1; then
      echo "OK   $dest (torrent)"
    else fail "$dest" torrent "$url"; fi
    return 0
  fi
  code=$(curl -sS -L --fail --retry 5 --retry-delay 10 --connect-timeout 30 \
         -A "Mozilla/5.0 offline-library-fetch" \
         -C - -o "$out.part" -w '%{http_code}' "$url" 2>>"$LOG/curl.err")
  rc=$?
  # 416 means the .part file is already complete.
  if [ $rc -eq 0 ] || { [ "$code" = "416" ] && [ -s "$out.part" ]; }; then
    if kiwix_sha_ok "$out.part" "$url"; then mv "$out.part" "$out"; echo "OK   $dest"
    else rm -f "$out.part"; fail "$dest" sha256 "$url"; fi
  else
    [ "$code" = "404" ] && rm -f "$out.part"
    fail "$dest" "$code" "$url"
  fi
}

# Pass 1: small files, 4 in parallel. Pass 2: big files, one at a time.
BIG='wikipedia_en_all|gutenberg_en|\.gguf|Lastbook-Small'
while IFS=$'\t' read -r d u; do
  while [ "$(jobs -rp | wc -l)" -ge 4 ]; do sleep 1; done
  one "$d" "$u" &
done < <(tail -n +2 "$MAN" | grep -vE "$BIG" | cut -f1,2)
wait
tail -n +2 "$MAN" | grep -E "$BIG" | cut -f1,2 | while IFS=$'\t' read -r d u; do one "$d" "$u"; done

# Checksums. Skip macOS AppleDouble files (._*) that exFAT creates.
( cd "$ROOT" && find . -type f ! -path './_log/*' ! -name '*.part' ! -name '*.aria2' ! -name 'SHA256SUMS.txt' ! -name '._*' -print0 \
  | sort -z | xargs -0 $SUM > SHA256SUMS.txt )
echo "DONE $(date). Failed: $(wc -l < "$LOG/failed.tsv")"; du -sh "$ROOT"
```

Notes:
- 404 on DEM and WorldCover tiles over the sea is normal.

Known limits of `fetch.sh` (from an independent review on 2026-11-21). Handle them in the agent workflow:
- **Skip by name.** The script skips any file that already exists. Files with fixed names, such as `*-latest.osm.pbf` and GeoNames ZIPs, change upstream. For an update, download to a new name, verify, then replace. Keep the old verified copy until the new one passes.
- **HTTP 416.** The script treats a 416 answer with a partial file as complete. A 416 only says that the range could not be served. Compare the size with the server's `Content-Length` before you accept the file.
- **Exit status.** The script ends with status 0 even when `failed.tsv` has rows. The agent must read `failed.tsv` and decide which failures block the build.
- **Target check.** Before the first write, check that the target folder is on the intended disk, that the disk has enough free space and that every `dest` stays inside the target folder.
- **BitTorrent uploads.** A BitTorrent client sends pieces to other peers while it downloads, also with `SEED_MIN=0`. Tell the user before you use the torrent path.
- **Completeness.** A checksum list made from the files on disk proves integrity, not completeness. Compare the list of files with the manifest. The BagIt format (RFC 8493) describes this check.
- Run the script again after a failure. It skips finished files and resumes `.part` and `.aria2` files.
- For each Kiwix file over HTTP, the script compares the file with the publisher's `.sha256`. A mismatch deletes the file and writes `sha256` to `failed.tsv`. BitTorrent checks every piece by itself.
- To give back to Kiwix, seed for a while after each torrent: `SEED_MIN=30 fetch.sh <ROOT>`.
- To change the torrent threshold, set `TORRENT_MIN` in bytes.
- Only one run per target folder. A second run stops with a message. After a crash, delete `_log/.lock`.
- Status: tested on 2026-11-21 on macOS (HTTP path, checksum check) and on Ubuntu with aria2 1.37.0 (BitTorrent path, resume after an interruption). All checksums matched the Kiwix `.sha256` files.
- To verify the disk later: `cd <ROOT> && shasum -a 256 -c SHA256SUMS.txt | grep -v ': OK$'`. No output means all files are good. For 140 GB on a USB disk this takes about one hour.

### 12.2 `tiles.py`: DEM and WorldCover rows

```python
"""Print manifest rows for Copernicus DEM GLO-30 and ESA WorldCover tiles.
Usage: python3 tiles.py <CC> <west> <south> <east> <north> [dem|wc|both]
"""
import math, sys

cc = sys.argv[1]
w, s, e, n = map(float, sys.argv[2:6])
what = sys.argv[6] if len(sys.argv) > 6 else 'both'

def ns(lat, width): return f"{'N' if lat >= 0 else 'S'}{abs(lat):0{width}d}"
def ew(lon, width): return f"{'E' if lon >= 0 else 'W'}{abs(lon):0{width}d}"

if what in ('dem', 'both'):
    for lat in range(math.floor(s), math.ceil(n)):
        for lon in range(math.floor(w), math.ceil(e)):
            name = f"Copernicus_DSM_COG_10_{ns(lat, 2)}_00_{ew(lon, 3)}_00_DEM"
            print(f"04_maps/{cc}/dem_glo30/{name}.tif\t"
                  f"https://copernicus-dem-30m.s3.amazonaws.com/{name}/{name}.tif\t"
                  f"Copernicus DEM GLO-30\t")
if what in ('wc', 'both'):
    for lat in range(3 * math.floor(s / 3), math.ceil(n), 3):
        for lon in range(3 * math.floor(w / 3), math.ceil(e), 3):
            name = f"ESA_WorldCover_10m_2021_v200_{ns(lat, 2)}{ew(lon, 3)}_Map"
            print(f"04_maps/{cc}/worldcover/{name}.tif\t"
                  f"https://esa-worldcover.s3.eu-central-1.amazonaws.com/v200/2021/map/{name}.tif\t"
                  f"CC BY 4.0\t")
```

Example: `python3 tiles.py PL 14 49 24.2 55 >> manifest.tsv`. This gives the same 81 rows as the reference build.

### 12.3 `osm_addresses.py`: addresses from OSM

Requirements: Python 3.10 or newer, `pip install duckdb` in a virtual environment. DuckDB's spatial extension reads `.osm.pbf` directly. No GDAL or osmium is needed.

```python
"""Extract addr:* points from an OSM .pbf to Parquet.
Usage: python -I osm_addresses.py <in.osm.pbf> <out.parquet> <CC>
Nodes keep their coordinates. Ways (mostly buildings) get the mean of their node coordinates.
Relations are skipped. Output licence: ODbL 1.0, (c) OpenStreetMap contributors.
"""
import os, sys
import duckdb

src, out, cc = sys.argv[1], sys.argv[2], sys.argv[3].upper()
tmp = out + '.part'
con = duckdb.connect()
con.execute("INSTALL spatial; LOAD spatial;")
con.execute("SET preserve_insertion_order=false;")
con.execute(f"""
CREATE TEMP TABLE osm AS
SELECT kind, id, tags, refs, lat, lon FROM ST_ReadOSM('{src}')
WHERE kind = 'node' OR (kind = 'way' AND tags['addr:housenumber'] IS NOT NULL);""")
con.execute("""
CREATE TEMP TABLE way_xy AS
WITH w AS (SELECT id, unnest(refs) AS ref FROM osm WHERE kind = 'way')
SELECT w.id, avg(n.lat) AS lat, avg(n.lon) AS lon
FROM w JOIN osm n ON n.kind = 'node' AND n.id = w.ref GROUP BY w.id;""")
cols = f"""
  '{cc}' AS country, tags['addr:postcode'] AS postcode,
  coalesce(tags['addr:street'], tags['addr:place']) AS street,
  tags['addr:housenumber'] AS number,
  coalesce(tags['addr:unit'], tags['addr:flats']) AS unit,
  coalesce(tags['addr:city'], tags['addr:town'], tags['addr:village'], tags['addr:place']) AS city,
  tags['addr:city:en'] AS city_en, tags['addr:street:en'] AS street_en,"""
con.execute(f"""
COPY (
  SELECT {cols} lon, lat, 'node' AS osm_type, id AS osm_id
  FROM osm WHERE kind = 'node' AND tags['addr:housenumber'] IS NOT NULL
  UNION ALL
  SELECT {cols} x.lon, x.lat, 'way' AS osm_type, o.id AS osm_id
  FROM osm o JOIN way_xy x USING (id) WHERE o.kind = 'way'
) TO '{tmp}' (FORMAT PARQUET, COMPRESSION ZSTD);""")
n = con.execute(f"SELECT count(*) FROM read_parquet('{tmp}')").fetchone()[0]
print('rows', n)
os.replace(tmp, out) if n else os.remove(tmp)
```

For Bulgaria (0.2 GB extract) the script needs about 10 seconds. For Germany or France (5 GB) expect much longer run times and 16 GB RAM or more. Cut a region first if the computer is small.

### 12.4 `overture_addresses.py`: addresses from Overture

```python
"""Export Overture Maps addresses for one country to Parquet.
Usage: python -I overture_addresses.py <out_root> <release> <CC> <west> <south> <east> <north>
Example: python -I overture_addresses.py ./04_maps 2026-11-18.0 PL 14.0 49.0 24.2 55.0
"""
import sys, pathlib, duckdb

root, rel, cc = pathlib.Path(sys.argv[1]), sys.argv[2], sys.argv[3]
x0, y0, x1, y1 = map(float, sys.argv[4:8])
src = f"s3://overturemaps-us-west-2/release/{rel}/theme=addresses/type=address/*"
out = root / cc / 'addresses' / f'overture_addresses_{cc}_{rel}.parquet'
out.parent.mkdir(parents=True, exist_ok=True)
con = duckdb.connect()
for ext in ('httpfs', 'spatial'):
    con.execute(f"INSTALL {ext}; LOAD {ext};")
con.execute("SET s3_region='us-west-2';")
q = f"""SELECT * FROM read_parquet('{src}', hive_partitioning=1)
        WHERE bbox.xmin BETWEEN {x0} AND {x1} AND bbox.ymin BETWEEN {y0} AND {y1}
        AND country = '{cc}'"""
con.execute(f"COPY ({q}) TO '{out}.part' (FORMAT PARQUET, COMPRESSION ZSTD)")
n = con.execute(f"SELECT count(*) FROM read_parquet('{out}.part')").fetchone()[0]
if n:
    pathlib.Path(f'{out}.part').rename(out)
    print(cc, 'rows', n, con.execute(f"SELECT DISTINCT unnest(sources).dataset FROM read_parquet('{out}')").fetchall())
else:
    pathlib.Path(f'{out}.part').unlink()
    print(cc, 'rows 0: use osm_addresses.py')
```

The query reads only the needed parts of the Overture files over the network. For Poland it read a few GB and wrote 541 MB. Each address keeps its `sources` field. Use it for attribution.

---

## 13. Licences and law

This section is practical guidance. It is not legal advice.

### 13.1 Private use

The user may download everything in this file for private, non-commercial use.

### 13.2 Copying the disk for other people

Each item keeps its own licence. Before you copy the disk for others, check these rules:

| Licence type | Examples | Rule |
|---|---|---|
| CC BY, CC BY-SA, OGL v3, CC0 | Wikipedia, GeoNames, WorldCover, UK guides, NL guide text | Allowed. Keep attribution. Keep share-alike for adapted versions |
| ODbL | OSM extracts, OsmAnd maps, OSM addresses | Allowed. Credit "© OpenStreetMap contributors". A changed database must stay ODbL |
| CC BY-NC, CC BY-NC-SA | iFixit, LibreTexts, WHO | Allowed only without payment and without commercial purpose |
| GPL, AGPL, LGPL | Kiwix, KiCad, FreeCAD, Android apps | Allowed. You must offer the source code. The disk already holds the sources for FreeCAD and OpenSCAD. For other apps, add the source archives or a written offer |
| Apache-2.0, MIT, BSD | llama.cpp, Gemma 4, Organic Maps | Allowed. Keep the licence text and the notices |
| Copernicus DEM | terrain tiles | Allowed. Keep this notice: "© DLR e.V. 2010-2014 and © Airbus Defence and Space GmbH 2014-2018 provided under COPERNICUS by the European Union and ESA. All rights reserved." |
| No licence stated | most national guides | Link to them. Ask the publisher before you copy the PDF for others |
| "Permission required" | German BBK guide, Austrian ÖZSV guides | Ask first |

### 13.3 AI model

The Gemma 4 files are Apache-2.0. Keep the licence text. Say that the file is a quantisation by Unsloth. Do not use Google trademarks for your own build.

If an organisation offers the AI chat to the public in the EU, the AI Act transparency duty (Article 50) can apply. Tell users that they talk to an AI.

---

## 14. Country map table

How to read this table:
- **Geofabrik path**: put it into `https://download.geofabrik.de/<path>-latest.osm.pbf`. The short form `europe/<name>-latest.osm.pbf` also works.
- **OSM .pbf GB** and **OsmAnd GB**: measured with HTTP HEAD on 2026-11-21.
- **bbox**: west, south, east, north in degrees. It comes from the Geofabrik outline, which includes territorial waters.
- **DEM tiles ≤** and **WorldCover tiles ≤**: tiles that touch the outline. This is an upper limit. Coastal tiles can be missing.
- **DEM GB ≈** uses 35 MB per tile. **WC GB ≈** uses 70 MB per tile.
- **GeoNames**: size of `<CC>.zip`.
- **Overture addresses**: "yes" was confirmed in our research. "no → OSM" means Overture has no addresses there. "test" means not checked. Run the Overture script and see.
- San Marino and Vatican City are inside the Geofabrik Italy extract. Cut them out with `osmium extract` or use the OsmAnd files.
- Cyprus: the Geofabrik extract covers the whole island.
- Norway: the outline includes Svalbard. Most of the 699 DEM tiles are Svalbard and sea. Use a mainland box if Svalbard is not needed.
- Portugal: the box includes the Azores and Madeira. Use one box per island group.

### EU-27

| Code | Country | Geofabrik path | OSM .pbf GB | OsmAnd GB | bbox (W,S,E,N) | DEM tiles ≤ | DEM GB ≈ | WorldCover tiles ≤ | WC GB ≈ | GeoNames | Overture addresses |
|---|---|---|---|---|---|---|---|---|---|---|---|
| AT | Austria | `europe/austria/austria` | 0.8 | 1.2 | 9.53,46.37,17.16,49.02 | 25 | 0.9 | 5 | 0.4 | 1.5M | yes (2026-11) |
| BE | Belgium | `europe/belgium/belgium` | 0.7 | 0.9 | 2.34,49.49,6.41,51.6 | 11 | 0.4 | 5 | 0.4 | 663K | yes (2026-11) |
| BG | Bulgaria | `europe/bulgaria/bulgaria` | 0.2 | 0.3 | 22.35,41.23,29.19,44.22 | 26 | 0.9 | 6 | 0.4 | 746K | no → OSM |
| HR | Croatia | `europe/croatia/croatia` | 0.2 | 0.3 | 13.09,42.16,19.46,46.56 | 25 | 0.9 | 6 | 0.4 | 782K | yes (2026-11) |
| CY | Cyprus | `europe/cyprus/cyprus` | 0.04 | 0.06 | 31.95,34.23,34.96,36.0 | 9 | 0.3 | 3 | 0.2 | 286K | no → OSM |
| CZ | Czechia | `europe/czech-republic/czech-republic` | 1.0 | 1.1 | 12.08,48.54,18.86,51.06 | 21 | 0.7 | 5 | 0.4 | 1.5M | yes (2026-11) |
| DK | Denmark | `europe/denmark/denmark` | 0.5 | 0.6 | 7.7,54.44,15.65,58.06 | 29 | 1.0 | 6 | 0.4 | 463K | yes (2026-11) |
| EE | Estonia | `europe/estonia/estonia` | 0.1 | 0.2 | 20.85,57.5,28.21,60.0 | 24 | 0.8 | 4 | 0.3 | 545K | yes (2026-11) |
| FI | Finland | `europe/finland/finland` | 0.8 | 1.2 | 19.02,59.29,31.62,70.1 | 109 | 3.8 | 22 | 1.5 | 13M | yes (2026-11) |
| FR | France | `europe/france/france` | 5.1 | 6.6 | -6.94,41.24,9.9,51.43 | 123 | 4.3 | 22 | 1.5 | 7.0M | yes (2026-11) |
| DE | Germany | `europe/germany/germany` | 4.9 | 7.0 | 5.86,47.27,15.05,55.15 | 72 | 2.5 | 15 | 1.1 | 7.2M | yes, except Bavaria |
| GR | Greece | `europe/greece/greece` | 0.3 | 0.5 | 18.97,34.59,29.66,41.75 | 64 | 2.2 | 10 | 0.7 | 1.7M | no → OSM |
| HU | Hungary | `europe/hungary/hungary` | 0.3 | 0.5 | 16.11,45.73,22.91,48.59 | 22 | 0.8 | 6 | 0.4 | 685K | no → OSM |
| IE | Ireland | `europe/ireland-and-northern-ireland/ireland-and-northern-ireland` | 0.4 | 0.5 | -14.4,49.6,-5.06,56.87 | 59 | 2.1 | 10 | 0.7 | 798K | no → OSM |
| IT | Italy | `europe/italy/italy` | 2.3 | 3.1 | 6.6,35.08,19.12,47.1 | 109 | 3.8 | 19 | 1.3 | 4.2M | yes (2026-11) |
| LV | Latvia | `europe/latvia/latvia` | 0.1 | 0.2 | 19.73,55.66,28.26,58.09 | 25 | 0.9 | 8 | 0.6 | 1.0M | yes (2026-11) |
| LT | Lithuania | `europe/lithuania/lithuania` | 0.2 | 0.3 | 20.62,53.89,26.84,56.45 | 20 | 0.7 | 5 | 0.4 | 1.2M | yes (2026-11) |
| LU | Luxembourg | `europe/luxembourg/luxembourg` | 0.05 | 0.07 | 5.73,49.45,6.53,50.18 | 4 | 0.1 | 2 | 0.1 | 53K | yes (2026-11) |
| MT | Malta | `europe/malta/malta` | 0.01 | 0.01 | 14.0,35.52,14.86,36.33 | 2 | 0.1 | 2 | 0.1 | 104K | no → OSM |
| NL | Netherlands | `europe/netherlands/netherlands` | 1.4 | 1.6 | 2.94,50.75,7.23,54.02 | 17 | 0.6 | 6 | 0.4 | 711K | yes (2026-11) |
| PL | Poland | `europe/poland/poland` | 2.1 | 2.8 | 13.99,48.99,24.16,55.23 | 64 | 2.2 | 13 | 0.9 | 1.9M | yes (2026-11) |
| PT | Portugal | `europe/portugal/portugal` | 0.4 | 0.7 | -31.6,29.7,-6.18,42.16 | 218 | 7.6 | 32 | 2.2 | 1.1M | yes (2026-11) |
| RO | Romania | `europe/romania/romania` | 0.3 | 0.5 | 20.24,43.61,30.28,48.27 | 50 | 1.8 | 12 | 0.8 | 1.9M | no → OSM |
| SK | Slovakia | `europe/slovakia/slovakia` | 0.3 | 0.5 | 16.83,47.73,22.57,49.62 | 15 | 0.5 | 5 | 0.4 | 443K | yes (2026-11) |
| SI | Slovenia | `europe/slovenia/slovenia` | 0.3 | 0.3 | 13.31,45.42,16.6,46.88 | 7 | 0.2 | 2 | 0.1 | 408K | yes (2026-11) |
| ES | Spain | `europe/spain/spain` | 1.5 | 2.5 | -9.78,35.26,5.1,44.15 | 107 | 3.7 | 20 | 1.4 | 3.2M | yes (2026-11) |
| SE | Sweden | `europe/sweden/sweden` | 1.0 | 1.4 | 10.54,55.03,24.22,69.07 | 132 | 4.6 | 23 | 1.6 | 2.5M | no → OSM |

### EEA, EFTA and UK

| Code | Country | Geofabrik path | OSM .pbf GB | OsmAnd GB | bbox (W,S,E,N) | DEM tiles ≤ | DEM GB ≈ | WorldCover tiles ≤ | WC GB ≈ | GeoNames | Overture addresses |
|---|---|---|---|---|---|---|---|---|---|---|---|
| NO | Norway | `europe/norway/norway` | 1.4 | 1.7 | -11.37,57.55,35.53,81.05 | 699 | 24.5 | 96 | 6.7 | 15M | test |
| IS | Iceland | `europe/iceland/iceland` | 0.06 | 0.1 | -25.7,62.85,-12.42,67.5 | 80 | 2.8 | 15 | 1.1 | 459K | test |
| LI | Liechtenstein | `europe/liechtenstein/liechtenstein` | 0.00 | 0.01 | 9.47,47.05,9.64,47.27 | 1 | 0.0 | 1 | 0.1 | 51K | test |
| CH | Switzerland | `europe/switzerland/switzerland` | 0.6 | 0.8 | 5.95,45.82,10.5,47.81 | 15 | 0.5 | 3 | 0.2 | 2.6M | test |
| GB | United Kingdom | `europe/united-kingdom/united-kingdom` | 2.3 | 3.1 | -14.86,49.42,2.64,61.14 | 133 | 4.7 | 23 | 1.6 | 3.5M | test |

### Neighbours

| Code | Country | Geofabrik path | OSM .pbf GB | OsmAnd GB | bbox (W,S,E,N) | DEM tiles ≤ | DEM GB ≈ | WorldCover tiles ≤ | WC GB ≈ | GeoNames | Overture addresses |
|---|---|---|---|---|---|---|---|---|---|---|---|
| UA | Ukraine | `europe/ukraine/ukraine` | 0.9 | 1.4 | 22.13,44.01,40.24,52.39 | 117 | 4.1 | 22 | 1.5 | 2.3M | test |
| MD | Moldova | `europe/moldova/moldova` | 0.1 | 0.2 | 26.61,45.46,30.19,48.49 | 10 | 0.4 | 4 | 0.3 | 151K | test |
| RS | Serbia | `europe/serbia/serbia` | 0.2 | 0.4 | 18.81,42.23,23.01,46.19 | 19 | 0.7 | 4 | 0.3 | 741K | test |
| BA | Bosnia and Herzegovina | `europe/bosnia-herzegovina/bosnia-herzegovina` | 0.2 | 0.2 | 15.72,42.55,19.63,45.28 | 15 | 0.5 | 4 | 0.3 | 1.3M | test |
| ME | Montenegro | `europe/montenegro/montenegro` | 0.03 | 0.05 | 18.17,41.62,20.36,43.56 | 8 | 0.3 | 2 | 0.1 | 368K | test |
| MK | North Macedonia | `europe/macedonia/macedonia` | 0.03 | 0.05 | 20.45,40.85,23.04,42.38 | 9 | 0.3 | 4 | 0.3 | 905K | test |
| AL | Albania | `europe/albania/albania` | 0.05 | 0.08 | 18.9,39.63,21.06,42.66 | 11 | 0.4 | 3 | 0.2 | 376K | test |
| XK | Kosovo | `europe/kosovo/kosovo` | 0.03 | 0.05 | 20.01,41.85,21.79,43.28 | 5 | 0.2 | 3 | 0.2 | 217K | test |
| TR | Turkey | `europe/turkey/turkey` | 0.7 | 1.0 | 25.52,35.72,44.86,43.07 | 135 | 4.7 | 24 | 1.7 | 3.5M | test |
| GE | Georgia | `europe/georgia/georgia` | 0.1 | 0.2 | 39.88,41.05,46.74,43.59 | 19 | 0.7 | 6 | 0.4 | 439K | test |
| AM | Armenia | `asia/armenia/armenia` | 0.05 | 0.08 | 43.44,38.84,46.64,41.31 | 10 | 0.4 | 3 | 0.2 | 1.1M | test |
| AZ | Azerbaijan | `asia/azerbaijan/azerbaijan` | 0.05 | 0.09 | 44.75,38.25,51.72,42.67 | 31 | 1.1 | 8 | 0.6 | 617K | test |
| AD | Andorra | `europe/andorra/andorra` | 0.00 | 0.01 | 1.41,42.43,1.79,42.66 | 1 | 0.0 | 1 | 0.1 | 96K | test |
| MC | Monaco | `europe/monaco/monaco` | 0.00 | 0.00 | 7.41,43.48,7.6,43.75 | 1 | 0.0 | 1 | 0.1 | 8.8K | test |
| SM | San Marino | `europe/italy/italy` | use italy | 0.00 | 12.4,43.89,12.52,43.99 | 1 | 0.0 | 1 | 0.1 | 12K | test |
| VA | Vatican City | `europe/italy/italy` | use italy | 0.00 | 12.44,41.9,12.46,41.91 | 1 | 0.0 | 1 | 0.1 | 12K | test |

## 15. Language packs

Sizes come from the Kiwix listings on 2026-11-21. A dash means that Kiwix has no such file. "Countries" lists where this document suggests the language.

| Code | Language | Countries | Wikipedia nopic | Wikipedia maxi | Wikipedia mini | Wiktionary nopic | Wikivoyage nopic | Wikibooks nopic |
|---|---|---|---|---|---|---|---|---|
| `az` | Azerbaijani | AZ | 946M | 3.1G | 354M | 46M | — | 8.5M |
| `bg` | Bulgarian | BG | 1.5G | 4.3G | 536M | 91M | — | 4.1M |
| `bs` | Bosnian | BA | 645M | 1.4G | — | — | — | 966K |
| `ca` | Catalan | AD, ES | 4.0G | 15G | 1.2G | 371M | — | 11M |
| `cs` | Czech | CZ | 3.2G | 9.3G | 943M | 162M | — | 15M |
| `cy` | Welsh | GB | 730M | 2.7G | 392M | 13M | — | 352K |
| `da` | Danish | DK | 1.3G | 3.8G | 548M | 33M | — | 16M |
| `de` | German | AT, BE, CH, DE, LI, LU | 17G | 45G | 4.4G | 1.2G | 207M | 2.6G |
| `el` | Greek | CY, GR | 1.9G | 4.9G | 524M | 1.1G | 5.6M | 12M |
| `en` | English | GB, IE, MT | 49G | 119G | 13G | 14G | 260M | 3.3G |
| `es` | Spanish | ES | 12G | 34G | 3.8G | 625M | 41M | 89M |
| `et` | Estonian | EE | 848M | 2.7G | 338M | 95M | — | 4.3M |
| `eu` | Basque | ES | 2.4G | 8.4G | 718M | 38M | — | 11M |
| `fi` | Finnish | FI | 2.6G | 7.4G | 1.0G | 502M | 5.6M | 21M |
| `fr` | French | BE, CH, FR, LU, MC | 12G | 52G | 5.3G | 4.6G | 65M | 317M |
| `ga` | Irish | IE | 221M | 1.0G | — | 2.9M | — | — |
| `gl` | Galician | ES | 1.3G | 3.6G | 478M | 72M | — | 4.0M |
| `hr` | Croatian | BA, HR | 969M | 2.9G | 320M | 22M | — | 4.2M |
| `hu` | Hungarian | HU | 4.0G | 11G | 1.1G | 750M | — | 119M |
| `hy` | Armenian | AM | 2.5G | 5.9G | 1.1G | 266M | — | 1.4M |
| `is` | Icelandic | IS | 181M | 676M | — | 66M | — | 5.7M |
| `it` | Italian | CH, IT, SM, VA | 10G | 30G | 3.3G | 480M | 105M | 1.6G |
| `ka` | Georgian | GE | 1.0G | 2.7G | 418M | 38M | — | 19M |
| `ku` | Kurdish | TR | 248M | 893M | — | 464M | — | 1.6M |
| `la` | Latin | VA | 347M | 1.6G | 172M | 40M | — | 2.8M |
| `lb` | Luxembourgish | LU | 194M | 688M | — | 6.3M | — | — |
| `lt` | Lithuanian | LT | 747M | 2.5G | 320M | 638M | — | 15M |
| `lv` | Latvian | LV | 598M | 1.7G | — | 7.7M | — | — |
| `mk` | Macedonian | MK | 962M | 2.8G | 331M | 6.6M | — | 1.1M |
| `mt` | Maltese | MT | 58M | 318M | — | 2.0M | — | — |
| `nb` | Norwegian Bokmål | NO | 2.8G | 7.9G | 950M | 80M | — | 6.0M |
| `nl` | Dutch | BE, NL | 5.4G | 22G | 2.4G | 829M | 15M | 86M |
| `nn` | Norwegian Nynorsk | NO | 550M | 2.0G | 236M | 6.0M | — | — |
| `pl` | Polish | PL | 7.5G | 21G | 2.0G | 899M | 47M | 56M |
| `pt` | Portuguese | PT | 6.6G | 19G | 1.6G | 353M | 17M | 55M |
| `rm` | Romansh | CH | 17M | 79M | — | — | — | — |
| `ro` | Romanian | MD, RO | 3.0G | 8.7G | 967M | 133M | 2.9M | 4.4M |
| `sh` | Serbo-Croatian | ME | 3.7G | 5.5G | 1.4G | 457M | — | — |
| `sk` | Slovak | SK | 1.2G | 3.4G | 621M | 27M | — | 4.8M |
| `sl` | Slovenian | SI | 1.0G | 3.1G | 369M | 16M | — | 4.8M |
| `sq` | Albanian | AL, XK | 423M | 1.2G | — | 25M | — | 22M |
| `sr` | Serbian | BA, ME, RS, XK | 6.4G | 11G | 1.9G | 343M | — | 7.4M |
| `sv` | Swedish | FI, SE | 7.1G | 16G | 3.7G | 483M | 5.1M | 8.6M |
| `tr` | Turkish | CY, TR | 3.5G | 8.3G | 1.1G | 775M | — | 16M |
| `uk` | Ukrainian | UA | 10G | 26G | 4.4G | 74M | 11M | 9.1M |

Kiwix listings use binary units. "49G" means 49 GiB, which is about 52.6 GB. Multiply by 1.074 to get GB. Example: `wikipedia_en_all_nopic` (2026-06) is 52.7 GB on disk.

## 16. National preparedness guides

How to read this table:
- **Status of the link.** "verified" means HTTP 200 and a PDF on 2026-11-20 or 2026-11-21. "secondary" means a mirror, not the publisher. "browser" means the server blocks scripts and needs a real browser.
- **Reuse.** "unclear" means that we found no licence statement. Link to these files. Ask the publisher before you copy them for other people.
- **Numbers.** 112 works in all EU and EEA countries. In the UK, 999 and 112 both work. In Switzerland and Liechtenstein: 112, 117 police, 118 fire, 144 ambulance. Norway: 112 police, 110 fire, 113 ambulance.
- **Neighbour numbers** were checked on 2026-11-21 against official sources: national 112 services, ministries, the BEREC emergency-access database and the Transport Community 112 roadmap (June 2026). A cell names its source when the source is weaker. The 112 rollout in UA and RS is still in progress. Check these two again before you print them.
- Some countries have no good guide. For them, add these general guides:
  - the EU 72-hour guidelines,
  - the Polish RCB handbook (CC BY 3.0 PL, English),
  - the Dutch guide text (CC0).

### 16.1 EU-27

| CC | Guide (English title) | Publisher | Year | Best link | English | Reuse |
|---|---|---|---|---|---|---|
| AT | "Stockpiling the right way" and "Self-protection guide" | Österreichischer Zivilschutzverband (association, not state) | not verified | `https://lienz.gv.at/media/frontend/dokumente/Bevorraten.pdf` (secondary) | no | permission required |
| BE | "Facing crises" / "Prepared together" (28 pp., 72 h kit) | NCCN, National Crisis Centre | 2026 | `https://civil-protection-knowledge-network.europa.eu/system/files/2025-11/be_faire-face-aux-crises.pdf` (verified, secondary, FR) | yes per press, get it at samenvoorbereid.be | unclear |
| BG | "Disaster backpack" one-page checklist (GDPBZN) and the Bulgarian Red Cross family disaster kit booklet | GDPBZN, Ministry of Interior. Bulgarian Red Cross | 2025 | `https://pojarna.com/wp-content/uploads/2025/01/%D1%80%D0%B0%D0%BD%D0%B8%D1%86%D0%B0-%D0%B7%D0%B0-%D0%B1%D0%B5%D0%B4%D1%81%D1%82%D0%B2%D0%B8%D1%8F.pdf` (non-government host). Red Cross: `https://en.redcross.bg/files/9992-SemeenKomplekt.pdf` (verified PDF) | no | unclear. No full national guide found |
| HR | "Role of citizens in civil protection" plus web advice | Ministry of Interior, Civil Protection Directorate | 2023 | `https://civilna-zastita.gov.hr/upute-za-gradjane-5467/5467` (web) | no | unclear |
| CY | "Family Communication Emergency Plan" | Cyprus Civil Defence | 2025 | `https://www.gov.cy/media/sites/156/2025/12/English-familyPlan.pdf` | yes | unclear |
| CZ | "72 hours: practical handbook for crisis situations" | Ministry of the Interior and Fire Rescue Service | 2025 | `https://www.72h.gov.cz` | yes, also Ukrainian | unclear |
| DK | "Prepared for crises" | Danish Emergency Management Agency | 2024 | `https://brs.dk/globalassets/brs---beredskabsstyrelsen/dokumenter/forberedt/oversaettelser/-forberedt-pa-kriser_uk-.pdf` (returned HTML to scripts, browser) | yes | unclear |
| EE | "Be prepared" (Ole valmis) | Estonian Rescue Board | 2024 | `https://olevalmis.ee` | yes, also Russian | unclear |
| FI | "Preparing for incidents and crises" (web) plus NESA power-shortage and backup-power PDFs | Ministry of the Interior, NESA, SPEK | 2024–2026 | `https://www.suomi.fi/guides/preparedness` | yes | unclear. Printing for personal use allowed |
| FR | "Tous responsables: face aux risques, agissons" | SGDSN | 2025 | Download page: `https://www.info.gouv.fr/risques/se-preparer-a-une-situation-durgence` (browser). Easy-read PDF: `https://www.info.gouv.fr/upload/media/mixed/0001/16/0ff61ef4d6ef8145c41db79d523a1886fbd4f896.pdf` (verified PDF) | no | Etalab 2.0 as site default, per independent review. Check third-party images |
| DE | "Planning ahead for crises and disasters" (40 pp.) | BBK | 11/2025 | `https://www.ettlingen.de/site/Ettlingen-2021/get/params_E1441149346_Dattachment/3856928/BBK-Planning-ahead-for-crises-and-disasters_English%20November%202025.pdf` (verified, secondary) | yes | permission required, no commercial use |
| GR | "Protection guidelines" (web) and "Make your own plan" leaflet. OASP earthquake leaflet in English | General Secretariat for Civil Protection, OASP | 2021–2022 | `https://civilprotection.gov.gr/en/odigies-prostasias` and `https://oasp.gr/sites/default/files/library/2021-02/3PTYXO%20AGGLIKO%20OASP.pdf` | web yes, OASP yes | unclear |
| HU | web pages only | BM OKF, disaster management | — | `https://www.katasztrofavedelem.hu/62/lakossagfelkeszites` | no | unclear |
| IE | "Be Emergency Ready" | Office of Emergency Planning | 2026 | `https://www.sdcc.ie/en/services/environment/be-emergency-ready/english_accessible_booklet.pdf` (verified, secondary). Official: gov.ie/BeEmergencyReady (browser) | yes, also Irish | unclear |
| IT | "I don't take risks" (Io non rischio), multi-risk brochure | Civil Protection Department and partners | campaign since 2011 | `https://eventi.protezionecivile.gov.it/static/c2828dd8a06a45e69e3be33238647783/sfogliabile-multirischio-inr_0.pdf` (verified) | web yes | unclear |
| LV | "What to do in the first 72 hours" | Ministry of Defence | 2024 | `https://www.mod.gov.lv/sites/mod/files/document/72H%20buklets_ENG_WEB_2024.pdf` | yes | unclear |
| LT | "What should I do if war or crisis comes" | Ministry of National Defence | 2025 | `https://civil-protection-knowledge-network.europa.eu/system/files/2025-12/if-war-or-crisis-comes-what-should-i-do.pdf` (verified, secondary) | yes | unclear |
| LU | "My 72-hour autonomy guide" | Lëtz Prepare portal, HCPN | 2026 | `https://letzprepare.public.lu/dam-assets/images/guide-letzeprepare/hcpn-campagne26-guide-accessible-fr-002.pdf` (FR) | not confirmed | unclear |
| MT | household emergency manual (announced) | Civil Protection Department | 2026 | not online | not confirmed | unclear |
| NL | "Prepare for an emergency" (Denk vooruit) | NCTV | 2025 | `https://english.denkvooruit.nl/information-booklet` | yes | text CC0, images excluded |
| PL | "Safety Handbook. Read it, practice, keep it!" (54 pp.) | Government Centre for Security (RCB) | 2025 | `https://www.gov.pl/attachment/4d6947da-a6b2-4890-83ef-b2c8eb4a11df` (verified) | yes | CC BY 3.0 PL, gov.pl site default |
| PT | "Earthquakes: prepare and protect yourself" | ANEPC | 2018 | `https://prociv.gov.pt/media/ovjbpe1c/sismos-prepare-se-e-proteja-se.pdf` | no | unclear |
| RO | "Guide for crisis situations" | Romanian Government, DSU | 2023–2024 | `https://civil-protection-knowledge-network.europa.eu/system/files/2025-12/ro-guide-en.pdf` (secondary) | yes, by file name | unclear |
| SK | "What to do in case of crisis or armed conflict" | Ministry of the Interior | 2025 | `https://civil-protection-knowledge-network.europa.eu/system/files/2025-12/conflict-brochure-eng.pdf` (secondary). Also on minv.sk | yes | unclear |
| SI | web page only | URSZR | — | `https://www.gov.si/teme/bodite-pripravljeni-ob-nesrecah/` | no | unclear |
| ES | "Self-protection" web pages, family guide PDF. Catalonia has its own 72 h campaign | DGPCE | 2025 | `https://www.proteccioncivil.es/coordinacion/gestion-de-riesgos/autoproteccion` | no | unclear |
| SE | "In case of crisis or war" | MCF (former MSB) | 2024 | `https://www.mcf.se/en/advice-for-individuals/the-brochure-in-case-of-crisis-or-war/download-and-order-the-brochure-in-case-of-crisis-or-war/` (browser) | yes | unclear |

### 16.2 EEA, EFTA and UK

| CC | Guide (English title) | Publisher | Year | Best link | English | Reuse |
|---|---|---|---|---|---|---|
| NO | "Advice on emergency preparedness" (one week) plus easy-read edition | DSB | 2025 | `https://sikkerhverdag.no/globalassets/din-beredskap/brosjyrer-alle-sprak/dsb-egenberedskap-engelsk-web.pdf` (browser). Easy-read: `https://civil-protection-knowledge-network.europa.eu/system/files/2025-12/dsb_kortlest_engelsk_digital_enkeltsider.pdf` | yes | unclear |
| IS | "3 days: are you prepared?" | Icelandic Red Cross with Almannavarnir | — | `https://www.raudikrossinn.is/english/projects/domestic-projects/disaster-services-and-emergency-relief/3-days-are-you-prepared/` | yes (web) | unclear |
| LI | "Informed safely in an emergency" (alerting only) | Office for Civil Protection | 2026 | `https://www.llv.li/serviceportal2/amtsstellen/amt-fuer-bevoelkerungsschutz/sicher-informiert-im-notfall_mai-2026.pdf` (browser) | no | unclear. Uses Swiss stockpile material |
| CH | "Sound advice: emergency stockpile" (Kluger Rat – Notvorrat) plus Alertswiss emergency plan | BWL / FONES, BABS | 2025 | `https://bundespublikationen.admin.ch/fr/product/000000000862725146/Kluger%20Rat%20-%20Notvorrat` | no | unclear |
| GB | "Be Ready" checklist and household emergency plan | Cabinet Office | current | `https://beready.campaign.gov.uk/be-ready-for-emergencies/` | yes | OGL v3.0 |

### 16.3 Neighbours

| CC | Guide (English title) | Publisher | Best link | English | Emergency numbers (checked 2026-11-21) |
|---|---|---|---|---|---|
| UA | "Safety ABC" (web) | State Emergency Service (DSNS) | `https://dsns.gov.ua/abetka-bezpeki` (browser) | no | 112 works in the whole country except the temporarily occupied territories (four centres: Kyiv, Lviv, Dnipro, Odesa. Ministry of Internal Affairs, status April 2026, `https://mvs.gov.ua/jevropeiska-integraciia/ugoda-pro-asociaciiu-1`). Also 101 fire, 102 police, 103 ambulance, 104 gas |
| MD | "Guide to actions in risk situations" (first 72 h). New "Resilience Guide" from 19 Nov 2026, no official PDF found yet | IGSU | `https://igsu.gov.md/sites/default/files/media/images/preventie_documents/ghidul-actiunilor-in-situatii-de-risc.pdf` (verified) | web page `https://igsu.gov.md/en/node/2152` | 112 works in the whole country. Old numbers still listed: 901 fire, 902 police, 903 ambulance |
| RS | "Family handbook for emergencies" | Ministry of Interior with OSCE | `https://www.osce.org/files/f/documents/4/1/118659.pdf` (verified, secondary) | no | 192 police, 193 fire, 194 ambulance. Use these first. 112 works only in some areas |
| BA | "Family handbook for natural and other disasters" | UNICEF with civil protection | `https://opcinasapna.ba/images/Porodicni_%20prirucnik_za_ponasanja_u_slucaju_prirodnih_i_drugih_nesreca.pdf` (verified, secondary) | no | 122 police, 123 fire, 124 ambulance. 112 does not work |
| ME | "Guide to action in emergencies" (school-oriented) | Ministry of Interior with UNICEF | `https://www.unicef.org/montenegro/media/3276/file/MNE-media-MNEpublication63.pdf` (verified, secondary) | no | 112, also 122 police, 123 fire, 124 ambulance |
| MK | not found | Protection and Rescue Directorate | — | — | 112, also 192 police, 193 fire, 194 ambulance |
| AL | "Guide book in civil protection" (with emergency-box checklist) | National Civil Protection Agency (AKMC) | `https://akmc.gov.al/wp-content/uploads/2025/11/Udhezues-Praktik-per-Mbrojtjen-Civile-1.pdf` (verified) | not confirmed | 129 police, 128 fire, 127 ambulance, 126 traffic police. 112 works only in Tirana (one source also names Durrës) |
| XK | no national guide found. Fallback: Albanian edition of the Serbian OSCE handbook (not a Kosovo source) | — | `https://www.osce.org/files/f/documents/7/a/204061.pdf` | no | 112, also 192 police, 193 fire, 194 ambulance |
| TR | no national PDF found. Fallback: "First 72 hours for the individual and family in an earthquake" (Istanbul) | AFAD, Istanbul Governorship | `https://www.ipkb.gov.tr/wp-content/uploads/2019/07/First-72-hours-for-the-individual-and-family-in-an-earthquake.pdf` (not verified). Turkish: "Güvenli Yaşam" booklet, Çankırı AFAD, `https://cankiri.afad.gov.tr/kurumlar/cankiri.afad/dOKUMANLAR/Guvenli_Yasam_Klavuzu/gy_1_egitim_kitapcigi.pdf` (verified PDF) | yes | 112 for all services. It replaced 155, 156, 110 and other old numbers |
| GE | not found. Check es.gov.ge by hand | Emergency Management Service | — | — | 112 for all services |
| AM | "Guidebook for codes of conduct for disasters" (listed) | Rescue Service, Ministry of Internal Affairs | `https://rescue.mia.gov.am/en/library` | title in English | 112 since February 2026. 911, 101 and 102 redirect to 112 (state news agency, not a ministry source) |
| AZ | "Family emergency preparedness plan" (web) | Ministry of Emergency Situations | `https://fhn.gov.az/en/education/ethical-stand/family-emergency-preparedness-plan` | yes (web) | 112, also 102 police, 103 ambulance, 104 gas. 101 fire is not on the ministry page |
| AD | Hazards and emergency numbers sheet (Catalan) | Government of Andorra | `https://www.govern.ad/documents/d/guest/1aposicio_riscos_1-1-?download=true` (verified PDF) | no | 112, also 110 police, 118 fire, 116 medical emergency (official sites, search excerpts only) |
| MC | not found | Public Security | — | — | 112, also 17 police, 18 fire and ambulance (official sites, search excerpts only) |
| SM | not found | Civil Protection RSM | — | — | 112, 113 police, 115 fire. 118 ambulance is not verified |
| VA | not found. Use Italian material | Governorate | — | — | Italian 112. Not verified from an official Vatican source |

---

## 17. Lessons from the reference build

These problems happened during the Poland and Bulgaria build in November 2026. Plan for them.

1. **Kiwix redirects.** `download.kiwix.org` answers with a redirect to a mirror. Always use `curl -L`.
2. **Long downloads break.** The 53 GB Wikipedia file stopped at 28 GB. `curl -C -` resumed it. Run `fetch.sh` again after any failure.
3. **Browser checks.** CHIRP (Cloudflare), INEE (403) and some government sites block scripts. Open them in a real browser. Never try to bypass a check.
4. **Dead links.** Five PDFs failed with 404 or 403 out of 300 items. Report them. Look for an official mirror, for example on the EU Knowledge Network.
5. **Sea tiles.** Many DEM and WorldCover tiles over the sea return 404. This is correct.
6. **macOS on exFAT.** macOS writes `._*` files next to every file. Exclude them from checksums. They do no harm.
7. **Unclean unplug.** After an unplug without eject, macOS runs `fsck_exfat` before it mounts the disk again. Do not stop this check. Wait.
8. **Overture gaps.** Overture had 0 addresses for Bulgaria. Always check the row count. Use the OSM script as a fallback.
9. **Organic Maps files.** The official map server refused directory listing. Community mirrors exist, for example `https://cdn-nl1.organicmaps.app/`. Manual transfer to a phone was not tested. Use OsmAnd `.obf` files as the tested option.
10. **Homebrew failure.** `brew install duckdb` failed on an older macOS. `pip install duckdb` in a virtual environment worked.
11. **Checksum time.** A full check of 114 GB on a USB 3 disk took about one hour. Run it in the background.
12. **Disk sharing.** The user's disk had other folders. The scripts wrote only into the target folder. Keep it that way.
13. **Right size, wrong content.** A model download broke with an HTTP/2 error and resumed with `curl -C -`. The file had the exact expected size but a wrong SHA-256. The server then hung while loading it. Always compare the hash, not only the size. For large files, retry from zero over HTTP/1.1 (`--http1.1`) after a failed check.
14. **Folder names differ between builds.** The reference disk uses Polish folder names (`05_model_ai`, `08_oprogramowanie`). Launchers written for the English layout in section 2 failed there. Generate launchers from the actual paths of the build, then test them.
15. **Small internal disk.** The build computer had less than 1 GB free on its internal disk. Large files could not be checked there first. Check the free space of the build computer too.
16. **Slow but careful, or fast and wrong.** Gemma 4 E4B ran from the USB disk on a Mac with Apple silicon and 16 GB RAM. Loading took about 4 minutes. With its default reasoning, one answer about river water took about 5 minutes and was correct. With reasoning switched off, the answer took 15 seconds and contained two errors. Keep reasoning on for safety questions. Tell the household that answers can take minutes.
17. **Download errors are not always the disk.** The same 5 GB model failed its hash twice, each time with a different wrong value. A test that hashed the network stream and the file on disk at the same time then gave three matching, correct values. The errors came from the transfer, not from the disk. Hash every large file. Retry from zero on a mismatch.

---

## 18. Maintenance and contributions

- Rebuild the disk every 6 to 12 months. Maps, Wikipedia and apps change. Old national guides get new editions.
- To update, re-run the agent with this file. `fetch.sh` skips files that are already present. Delete old versions by hand after the new ones are verified.
- Report new guides, dead links and licence answers from publishers to the Neotopia Offline repository (https://github.com/neotopia-foundation/offline). Include the URL, the date you checked and the HTTP result.
- Do not add sources that you have not opened yourself.

### Snapshot data

| Item | Value |
|---|---|
| Snapshot date | 2026-11-21 |
| Overture release | 2026-11-18.0 |
| llama.cpp tag | b12032 |
| Gemma 4 26B commit | c099eb48e663fd284577b04978a94ffccb261841 |
| Kiwix macOS / desktop / tools / Android | 3.18.0 / 2.5.1 / 3.8.2 / 4.0.1 |
| FreeCAD / OpenSCAD / KiCad | 1.1.4 / 2021.01 / 10.0.8 |
| Ventoy / Rufus / CHIRP | 1.1.18 / 4.16 / 20261120 |
| OsmAnd / Organic Maps / Meshtastic (Android) | 5.4.11 / 2026.11.11 / 2.8.4 |
| yt-dlp / Kolibri / Meshtastic firmware | 2026.10.26 / 0.19.5 / 2.7.26 |
| Argos Translate package index | 100 packages, model version 1.9 |

---

# Extension modules

Sections 19 to 29 and 33 are optional. Section 30 lists household essentials. Section 31 makes every tool work offline. Section 32 adds the emergency page and crisis cards. Sections 30, 31 and 32 apply to every build. They add video, language tools, school material, local survival layers and durability. Add them after the core parts fit in the budget.

## 19. Video lessons

### 19.1 When video is worth the space

Some skills are easier to learn from video than from text. Examples are first aid, knots, tool use, repairs and food preservation. Video also costs the most space. Decide the budget first (section 3.1).

Measured samples from 2026-11-21, for lecture-style video with `yt-dlp`:

| Quality | Sample | GB per hour, about |
|---|---|---|
| 360p | 2.0 h = 167 MB | 0.08 |
| 480p | 0.65 h = 82 MB | 0.12 |
| 720p | 2.0 h = 564 MB | 0.28 |

Video with much motion can be two to three times larger. For skills, 480p is usually enough. Subtitles and transcripts need almost no space.

### 19.2 Order of sources

Use the first source in this list that has the content.

1. **Kiwix video ZIM files (section 19.3).** One file, one reader, no setup. This is the default.
2. **The publisher's own download.** Many publishers offer files outside YouTube. Examples are MIT OpenCourseWare course downloads (CC BY-NC-SA), TED, the Internet Archive, Wikimedia Commons and PeerTube servers. Read the licence on the publisher's page.
3. **YouTube videos marked "Creative Commons Attribution".** The creator gives the CC BY licence. It permits copying and sharing with attribution. Check the licence of every video, not of the channel (section 19.4).
4. **Written permission from the creator.** Many small creators agree. Keep the answer with the files.
5. **Videos with the standard YouTube licence.** YouTube's terms restrict downloads with tools. National private-copy rules differ between countries. The agent does not download these on its own initiative. If the user asks for them, the agent explains this point first. Then it marks each item `PRIVATE-ONLY` in the manifest. These items must stay out of every copy made for other people.

### 19.3 Kiwix video libraries

Source: `https://download.kiwix.org/zim/videos/`, `/zim/ted/` and `/zim/other/`. Sizes are from the Kiwix listings on 2026-11-21, in binary units (multiply by 1.074 for GB). We did not check the licence inside each file. Read the ZIM's own "about" page before you share it.

| File stem | Size | Content |
|---|---|---|
| `lrnselfreliance_en_all` | 3.7G | Self-reliance and homestead skills |
| `quickguidesformedicine_en_all` | 503M | Short medical explainers |
| `canadian-prepper_en_preppingfood` | 2.0G | Food storage. North American channel: units, products and laws differ from Europe |
| `canadian-prepper_en_winterprepping` | 1.2G | Cold-weather preparation |
| `canadian-prepper_en_bugoutconcepts` | 2.7G | Evacuation planning |
| `canadian-prepper_en_bugoutroll` | 838M | Evacuation kit |
| `urban-prepper_en_all` | 2.1G | Preparedness in cities |
| `s2underground_en_all` | 5.1G | Field communication and radio. US channel: many radio bands and rules shown are not legal in Europe. Check against section 9.4 |
| `crashcourse_en_all` | 21G | School courses: science, history, more |
| `khanacademy_en_all` | 168G | Full Khan Academy in English. Also `es` 150G and `fr` 94G |
| `ted_mul_medicine` | 3.4G | TED talks, subtitles in many languages |
| `ted_mul_public-health` | 2.2G | |
| `ted_mul_natural-disaster` | 683M | |
| `ted_mul_agriculture` / `farming` / `food` / `water` | 1.2G / 790M / 2.2G / 832M | |
| `ted_mul_energy` / `engineering` | 1.8G / 2.7G | |
| `ted_mul_kids` | 3.7G | |
| `ted_mul_all` | 85G | All TED talks |
| `voa_learning_en_all` | 6.6G | Learn English |
| `coreyms_en_python-tutorials` | 2.4G | Programming lessons |
| `studio.blender.org_en_open-movies` | 421M | Open films, for morale |
| `cest-pas-sorcier_fr_all` | 45G | French science series. Topic parts exist: `medecine` 2.9G, `energie` 1.1G, `agronomie` 4.9G |
| `universcience-tv_fr_all` | 37G | French science video |
| `la-chaine-de-maths-et-tiques_fr_all` | 14G | French school mathematics |
| `mooc-energie-climat_fr_all` | 265M | French course on energy and climate |

Most Kiwix video libraries are in English or French. For other languages, TED talks with subtitles are the best ready-made source.

Useful text libraries in the same folders:

| File stem | Size | Content |
|---|---|---|
| `trueprepper.com_en_all` | 1.3G | Preparedness articles and checklists |
| `gardenology.org_en_all` | 107M | Plant encyclopedia for gardeners |
| `usda-2015_en` | 19M | Food nutrient tables |
| `theworldfactbook_en_all` | 388M | Country facts |
| `restarters_en_all_maxi` | 16M | Repair of electric devices |
| `scoutwiki.org_<lang>_all_maxi` | 13–47M | Scout skills. Languages: `en`, `da`, `es`, `fi`, `it`, `nl` |
| `librepathology_en_all_maxi` | 91M | Pathology reference |
| `wikiskripta_cs_all_maxi` | 267M | Czech medical study notes |
| `archlinux_en_all_maxi`, `termux_en_all_maxi`, `postmarketos_en_all_maxi` | 37M, 2M, 29M | System administration |
| `freecodecamp_en_all` | 11M | Programming exercises. Also `de`, `es`, `it`, `pt` |

### 19.4 YouTube videos with a CC BY licence

**Finding from 2026-11-21.** We checked the newest videos of 12 channels on preparedness, health, repair and open hardware. Only one channel used the Creative Commons licence: Open Source Ecology (`@marcinose`). So CC BY on YouTube is rare. Do not assume it. Check each video.

These channels had the standard YouTube licence on their newest videos:
- Khan Academy. Use the Kiwix file instead.
- MIT OpenCourseWare. Use the course download on its own site instead.
- Appropedia, Kiwix, KiCad and Meshtastic.
- IFRC, WHO, Medical Aid Films and Global Health Media Project.
- Practical Engineering.

Tools:
- `yt-dlp` (Unlicense): one file per system, 22–39 MB, from GitHub `yt-dlp/yt-dlp` releases. Put the three binaries in `08_software/`.
- `ffmpeg`: `yt-dlp` needs it to join video and audio. Take a static build for each system.

Command that downloads only CC-marked videos:

```bash
yt-dlp --match-filters "license*=Creative Commons" \
  -f "bv*[height<=480]+ba/b[height<=480]" --merge-output-format mp4 \
  --write-info-json --write-subs --write-auto-subs --sub-langs "en,pl" --convert-subs srt \
  --download-archive 10_video/_archive.txt --sleep-requests 1 --sleep-interval 5 \
  -o "10_video/%(channel)s/%(upload_date)s %(title).100B [%(id)s].%(ext)s" \
  "https://www.youtube.com/@<channel>/videos"
```

- The filter skips every video without the Creative Commons mark. We tested it on one CC channel and one standard channel.
- `--write-info-json` stores the licence, the channel and the URL next to each file. This is your licence record.
- `--download-archive` lets you run the command again later. It then gets only new videos.
- Change `--sub-langs` to the user's languages.
- To estimate the size first, add `--simulate --print "%(filesize_approx)s"` and sum the numbers.

Attribution: keep a file `10_video/ATTRIBUTION.md` with title, creator, URL and licence for each video.

### 19.5 Transcripts only

A transcript gives most of the information of a talk in a few kilobytes. It also makes the content searchable and usable by the local AI model.

```bash
yt-dlp --skip-download --write-subs --write-auto-subs --sub-langs "en" --convert-subs srt \
  -o "10_video/transcripts/%(channel)s/%(title).100B [%(id)s]" "<URL>"
```

The licence order in section 19.2 applies to transcripts too.

### 19.6 Topics to cover

Use this list to choose videos. It is a list of topics, not of channels.

- First aid: bleeding control, CPR, recovery position, burns, fractures, hypothermia.
- Water: filters, boiling, chlorination, rain collection, well care.
- Food: canning, drying, fermenting, bread without a shop, storage pests.
- Heat and power: stove safety, carbon monoxide, small solar systems, batteries, generators.
- Repair: bicycle, small engine, plumbing, basic electrics, sewing.
- Communication: PMR and CB use, antenna basics, Meshtastic setup.
- Growing food: seed saving, compost, potatoes and beans, small animals.
- Shelter and movement: knots, tarps, map and compass, winter clothing.
- Children: school lessons in the local language.

---

## 20. Offline language tools

Europe has many languages. In a crisis, people move across borders. These tools work without internet.

| Tool | What it does | Files and size | Licence |
|---|---|---|---|
| Argos Translate | Text translation | About 67 MB per direction (English→Polish measured). Index: `https://raw.githubusercontent.com/argosopentech/argospm-index/main/index.json` | MIT (software). Check each model |
| whisper.cpp | Speech to text. It can also translate speech into English text | `ggml-tiny` 77 MB, `base` 147 MB, `small` 487 MB, `large-v3-turbo-q5_0` 574 MB, `medium` 1.5 GB, `large-v3-turbo` 1.6 GB, `large-v3` 3.1 GB. From Hugging Face `ggerganov/whisper.cpp` | MIT |
| Tesseract OCR | Text from photos and scans | About 5 MB per language from `tesseract-ocr/tessdata_fast` (Polish measured: 4.8 MB) | Apache-2.0 |
| multilingual-e5-small | Search by meaning over the whole library, for the AI chat | 470 MB, Hugging Face `intfloat/multilingual-e5-small` | MIT |
| Piper | Text to speech | Size per voice not measured | Check each voice |

**Argos language coverage on 2026-11-21.** The index has 100 packages. Languages with a pair to or from English that matter here: `az`, `bg`, `ca`, `cs`, `da`, `de`, `el`, `es`, `et`, `eu`, `fi`, `fr`, `ga`, `gl`, `hu`, `it`, `lt`, `lv`, `nb`, `nl`, `pl`, `pt`, `ro`, `sk`, `sl`, `sq`, `sv`, `tr`, `uk`.

Not in the index: Croatian, Serbian, Bosnian, Macedonian, Maltese, Icelandic, Georgian, Armenian and Luxembourgish. For these languages, use the local AI model for translation. Tell the user that its quality is not tested.

Rules for the agent:
1. Take both directions for each language pair. Argos translates between two non-English languages through English.
2. The Python packages need an offline install. Use `pip download <package> -d wheels/` on a computer with the same system and Python version as the target.
3. For whisper, `small` is a good default. `large-v3-turbo-q5_0` is a newer model of about the same size. Test both on the user's computer.

---

## 21. Children and school

A long crisis stops school. Plan for it when the household has children.

| Item | Size | Notes |
|---|---|---|
| Kolibri 0.19.5 (offline learning platform) | Windows 142 MB, macOS 79 MB, Linux `.deb` 94 MB, Android 205 MB, Raspberry Pi image 936 MB | MIT. GitHub `learningequality/kolibri` releases. One device can serve lessons to others over Wi-Fi |
| Kolibri channels | not measured | Import channels inside Kolibri while you are online. Khan Academy exists there in many languages. Check the size in the import screen |
| `khanacademy_en_all` (ZIM) | 168G | Also `es` and `fr`. No other languages as ZIM |
| `crashcourse_en_all` (ZIM) | 21G | Secondary-school level |
| PhET simulations, `phet_<lang>_all` | 0.1 GB each | Physics, chemistry and maths, in many languages |
| `ted_mul_kids` | 3.7G | |
| `klexikon_de_all_maxi` | 129M | German encyclopedia for children |
| `moldova-ministry-education_ron_clasa1` to `clasa9` | 0.13–1.4G each, about 3.8G in total | Romanian school lessons, years 1 to 9 |
| `africanstorybook.org_mul_all` | 8.1G | Picture books in many languages |
| `open-textbook-library_<lang>_all` | 28–52M | Index of open textbooks. Languages: `bg`, `de`, `el`, `es`, `fr`, `nl`, `sl`, `uk`, `az` |
| Wikibooks and Wikijunior in the local language | see section 15 | |
| Project Gutenberg in the local language | small | Classic literature |

Also look for the national open-textbook portal of the country. Many education ministries publish free school books as PDF. Check the licence on the portal.

---

## 22. Capturing web-only pages

Many national guides are web pages, not PDF files. Section 16 shows this for Finland, Hungary, Slovenia, Croatia, Spain, Azerbaijan and others. Capture them while the internet works.

| Method | Use when | Command or tool |
|---|---|---|
| Print to PDF | A few pages | Browser print dialog. Headless: `chrome --headless --print-to-pdf=out.pdf <URL>` |
| Mirror | One section of a site | `wget --mirror --convert-links --page-requisites --no-parent --wait=1 <URL>` |
| ZIM | A whole site, to read in Kiwix | Zimit (`openzim/zimit` container, GPL-3.0) |

Rules for the agent:
1. Capture only the pages that the user needs. Do not mirror a whole government site.
2. Wait at least one second between requests. Obey `robots.txt`.
3. Store the URL and the date of capture next to each file.
4. A captured page keeps the publisher's rights. Mark it `PRIVATE-ONLY` unless the site states an open licence.

---

## 23. Local survival layers from OSM

The OSM extract already holds the places that matter in a crisis. `osm_pois.py` writes them to one CSV file. Every phone and every spreadsheet program can open it.

Reference result for Bulgaria: 42,000 points in 13 seconds, 2.5 MB. The file includes:
- 6,485 drinking-water points and 2,484 springs,
- 1,727 pharmacies and 562 hospitals,
- 1,968 fuel stations,
- 1,978 shelters (the OSM tag also covers simple weather shelters),
- 170 bunkers.

The CSV keeps the local name and the English name in separate columns. The column `shelter_type` comes from OSM. Use it to tell weather shelters from public shelters. Official shelter lists win over OSM.

OSM data is made by volunteers. It is not complete. A missing point does not mean that the place does not exist.

```python
"""Extract survival-relevant points from an OSM .pbf to CSV.
Usage: python -I osm_pois.py <in.osm.pbf> <out.csv>
Output licence: ODbL 1.0, (c) OpenStreetMap contributors.
"""
import sys
import duckdb

src, out = sys.argv[1], sys.argv[2]
AMENITY = ('hospital', 'clinic', 'doctors', 'pharmacy', 'drinking_water', 'water_point', 'fuel',
           'police', 'fire_station', 'shelter', 'toilets', 'veterinary', 'marketplace',
           'community_centre', 'place_of_worship', 'school', 'ferry_terminal')
RULES = f"""
  CASE
    WHEN tags['amenity'] IN {AMENITY} THEN tags['amenity']
    WHEN tags['emergency'] IN ('defibrillator','assembly_point','phone','ambulance_station','water_tank','fire_hydrant','siren')
      THEN 'emergency_' || tags['emergency']
    WHEN tags['man_made'] IN ('water_well','water_tower','water_tap') THEN tags['man_made']
    WHEN tags['natural'] = 'spring' THEN 'spring'
    WHEN tags['shop'] IN ('supermarket','convenience','hardware','doityourself','bakery','agrarian','gas') THEN 'shop_' || tags['shop']
    WHEN tags['military'] = 'bunker' OR tags['building'] = 'bunker' THEN 'bunker'
    WHEN tags['tourism'] IN ('alpine_hut','wilderness_hut','camp_site') THEN tags['tourism']
    WHEN tags['power'] = 'plant' THEN 'power_plant'
    WHEN tags['aeroway'] IN ('aerodrome','helipad') THEN tags['aeroway']
  END"""
con = duckdb.connect()
con.execute("INSTALL spatial; LOAD spatial; SET preserve_insertion_order=false;")
con.execute(f"""
CREATE TEMP TABLE hit AS
SELECT kind, id, lat, lon, refs, tags, {RULES} AS category
FROM ST_ReadOSM('{src}') WHERE tags IS NOT NULL AND kind IN ('node','way') AND ({RULES}) IS NOT NULL;""")
con.execute(f"""
CREATE TEMP TABLE way_xy AS
WITH w AS (SELECT id, unnest(refs) AS ref FROM hit WHERE kind = 'way')
SELECT w.id, avg(n.lat) AS lat, avg(n.lon) AS lon
FROM w JOIN (SELECT id, lat, lon FROM ST_ReadOSM('{src}') WHERE kind = 'node') n ON n.id = w.ref
GROUP BY w.id;""")
con.execute(f"""
COPY (
  SELECT category, tags['name'] AS name, tags['name:en'] AS name_en, tags['shelter_type'] AS shelter_type,
         round(coalesce(h.lat, x.lat), 6) AS lat, round(coalesce(h.lon, x.lon), 6) AS lon,
         tags['opening_hours'] AS opening_hours, tags['phone'] AS phone,
         tags['drinking_water'] AS drinking_water, tags['access'] AS access,
         kind AS osm_type, h.id AS osm_id
  FROM hit h LEFT JOIN way_xy x ON h.kind = 'way' AND x.id = h.id
  WHERE coalesce(h.lat, x.lat) IS NOT NULL
  ORDER BY category, name
) TO '{out}' (HEADER, DELIMITER ',');""")
```

### 23.1 Offline routing

OsmAnd calculates routes on the phone from its own `.obf` files. BRouter is a second routing engine for Android. It needs its own data files.

- Source: `https://brouter.de/brouter/segments4/<E|W>LL_<N|S>LL.rd5`.
- One file covers 5° × 5°. The name gives the south-west corner in steps of 5°. Example: `E20_N50.rd5` covers 20–25° E and 50–55° N.
- Measured sizes: 67 MB, 69 MB and 91 MB for three files over Central and South-East Europe.

### 23.2 Hazard maps

These European datasets are useful. We did not verify their download links or licences. Find them at run time and read the terms.

- River flood hazard maps for Europe from the EU Joint Research Centre.
- The European seismic hazard model ESHM20.
- National flood-risk maps under the EU Floods Directive.
- Locations of nuclear plants and large chemical sites. OSM has many of them (`power=plant` in the CSV above).

### 23.3 Solar data for the user's location

The JRC tool PVGIS gives solar radiation data for any point in Europe. Save the monthly values for the user's home while online. They help to size a small solar system. We did not verify the API terms. Read them first.

---

## 24. Radio firmware and software

A Meshtastic radio needs firmware. The usual web flasher needs internet. So keep the firmware files on the disk.

| Item | Size | Source |
|---|---|---|
| Meshtastic firmware 2.7.26, `firmware-esp32` | 38 MB | GitHub `meshtastic/firmware` releases |
| `firmware-esp32s3` | 162 MB | same |
| `firmware-nrf52840` | 44 MB | same |
| `firmware-rp2040` | 2 MB | same |

- Ask the user which radio boards they own. Take only the matching files.
- Each board family has its own way to load firmware without internet. Save the offline flashing instructions for the user's boards from the Meshtastic documentation.
- Region setting for Europe: `EU_868`.

Other radio software to consider. We did not verify versions or sizes:
- SDR receiver software for a USB radio stick.
- `fldigi`, `WSJT-X` and `JS8Call` for digital modes. Transmitting needs an amateur licence.

---

## 25. Books, audio and morale

A long crisis is also boring and hard on the mind. Add some content for rest. Section 28 has the full list. This table is a short start.

| Item | Size | Licence |
|---|---|---|
| Project Gutenberg in the local language (`gutenberg_<lang>_all`) | 0.003–1 GB | public domain in the USA. Check the national term of protection |
| `onemorelibrary.com_<lang>_all` (classic books) | `de` 235M, `es` 1.4G, `fr` 445M, `it` 383M, `fi` 27M, `sv` 14M, `mul` 6.4G | check |
| `wikisource_<lang>_all_nopic` | varies | CC BY-SA / public domain |
| `studio.blender.org_en_open-movies` | 421M | check the file's "about" page |
| The user's own music, films, photos and books | — | the user copies these |

More sources to check at run time: national free-book projects (for example Wolne Lektury in Poland), LibriVox audiobooks and Standard Ebooks. We did not verify their bulk-download terms.

Add simple games and a rule book for card games. They cost almost no space.

---

## 26. Print-first pack

A disk needs power and a working device. Paper needs neither. The agent prepares a folder `13_print_first/` with PDF pages. The user prints them now.

1. **Emergency card.** Numbers, addresses, meeting points, blood groups, allergies, daily medicines. The user fills in the personal fields by hand.
2. **Family plan.** Who collects the children, where to meet, which radio channel, at which hours.
3. **Local map.** Home area at walking scale, with water points, pharmacies and hospitals from section 23.
4. **Regional map.** Roads to two places where the family can stay.
5. **Radio sheet** from section 9.4.
6. **First-aid quick pages** from the national guide, if its licence allows printing.
7. **Water treatment table.** Take the doses from the national guide or from a WHO document on the disk. Do not write doses from memory.
8. **How to start the disk.** One page: which program opens which folder.
9. **The national guide itself,** if it is short.

Rule for the agent: every medical and chemical number on a printed page must come from a document on the disk. Give the document name and the page number.

---

## 27. Durability, copies and the offline drill

### 27.1 Copies

- Keep at least two copies on two separate disks. Keep them in two places.
- Keep one copy unplugged. This protects it from malware, power surges and mistakes.

### 27.2 Ageing

- Flash memory can lose data when it stays without power for years. Reading the data does not refresh it. Hard disks can fail mechanically.
- Plug in each copy every 6 to 12 months. Run the checksum test from section 12.1.
- Every 2 to 3 years, copy the whole library to a new disk. Verify the new copy. Then retire the old disk.
- exFAT has no journal. A power cut during writing can damage it. Eject before unplugging. Keep one copy that nobody writes to.
- For a 10 to 20 year archive, consider archival optical discs (for example M-DISC) for the core content. We did not test them.
- Keep formats that future computers can open: plain UTF-8 text, CSV, PDF and HTML next to Parquet and ZIM. Export the address and help-point files to CSV too. Keep the source code of the readers (`libzim`, `kiwix-tools`, `llama.cpp`), so that someone can build them again.
- For the most important files, add parity data with `par2`. It can repair small damage. Example: `par2 create -r5 file.zim`. This needs 5 % more space.

### 27.3 Power and devices

The disk is useful only with a device that can read it. Check these points with the user:
- A phone or tablet with the apps installed, and a cable or adapter for the disk.
- A way to charge without the grid, for example a power bank and a small solar panel.
- A laptop that still starts without internet and without a cloud login.
- A Raspberry Pi with `kiwix-serve` is a low-power library for a whole house. The projects Internet-in-a-Box and Kiwix Hotspot offer ready images. We did not test them.

### 27.4 Offline drill

Do this test before you call the disk ready. Run it in two rounds.

- **Round A, no radio.** Turn off Wi-Fi, mobile data and Bluetooth on every device. Do tasks 1 to 9, 11 and 12.
- **Round B, local network only.** Unplug the internet cable from the router. Keep the local Wi-Fi on. Do task 10.

Do each task on the weakest device that the household will use.

| # | Task | Pass when |
|---|---|---|
| 1 | Open the medical ZIM and find "burn" | The article opens in Kiwix |
| 2 | Open Wikipedia in the local language | A search gives results |
| 3 | Find the home address on the phone map | OsmAnd shows the street |
| 4 | Route to the nearest hospital | OsmAnd draws a route |
| 5 | Find the nearest drinking-water point | The CSV or the map shows it |
| 6 | Open the national guide | The PDF opens |
| 7 | Ask the AI model a question about a document on the disk | It answers. Then open the cited document in Kiwix or a PDF reader and confirm the passage. An answer without a local source does not pass |
| 8 | Translate one sentence | Argos gives a result |
| 9 | Play one video | The player shows picture and sound |
| 10 | Serve the library to a second device | The second device opens Kiwix pages over Wi-Fi |
| 11 | Install one Android app from the disk | The app starts |
| 12 | Verify three random files | The checksums match |

Also open the print pack (section 26) and `EMERGENCY.html` (section 32) on the weakest device.

Write the result of each task into `_log/drill.txt`. Report every failed task to the user. Every task for a function that the household chose in the interview is required. Do not call the disk ready while a required task fails.

---

## 28. Reading, listening and play

People at home without internet need more than manuals. They need stories, music, games and things to learn. This section lists content with clear rights. It replaces the short list in section 25.

Put these items in `14_books_audio_games/`. ZIM files stay in `03_zim/`.

### 28.1 Copyright rule for Europe

Read this before you build a pack for other people.

- In the EU, a work is free 70 years after the author's death. In 2026 this covers authors who died in 1955 or earlier.
- Exception: Spain applies 80 years to authors who died before 7 December 1987. Check other national exceptions for the target country.
- A translation has its own term. It runs 70 years from the translator's death. Homer is free. A modern translation of Homer is not.
- Project Gutenberg and LibriVox follow United States law. A small part of their content is still protected in the EU.
- For a private disk, the user decides. For a public pack, check the author's and the translator's year of death for each book.
- A Gutenberg ZIM file is one block. You cannot remove single books from it. We did not resolve this point for public packs. An EU publisher needs legal advice here, or a set built from single checked books.

### 28.2 Books

**Project Gutenberg by language** (`https://download.kiwix.org/zim/gutenberg/gutenberg_<lang>_all_<date>.zim`). Sizes from the Kiwix listing on 2026-11-21, binary units.

| Language | Size | Language | Size | Language | Size |
|---|---|---|---|---|---|
| `bg` | 3.5M | `fi` | 1.5G | `nl` | 3.9G |
| `ca` | 49M | `fr` | 9.8G | `no` | 45M |
| `cs` | 9.5M | `ga` | 3.3M | `pl` | 20M |
| `cy` | 49M | `gl` | 3.4M | `pt` | 499M |
| `da` | 64M | `grc` (Ancient Greek) | 4.7M | `ro` | 5.5M |
| `de` | 10G | `hu` | 1.0G | `sl` | 4.6M |
| `el` | 139M | `is` | 9.5M | `sr` | 3.5M |
| `es` | 1.7G | `it` | 1.0G | `sv` | 210M |
| `et` | 2.1M | `la` (Latin) | 155M | `en` | 206G |

**English Gutenberg by subject.** The English library also exists in parts, by Library of Congress class (`gutenberg_en_lcc-<class>`). These parts make English classics affordable.

| Part | Size | Content |
|---|---|---|
| `lcc-pa` | 498M | Greek and Latin classics in English: Homer, Plato, Virgil, Marcus Aurelius |
| `lcc-pg` | 261M | Slavic literature in English |
| `lcc-pt` | 724M | German, Dutch and Scandinavian literature |
| `lcc-pq` | 3.8G | French, Italian and Spanish literature |
| `lcc-pr` | 15G | English literature |
| `lcc-ps` | 15G | American literature |
| `lcc-pz` | 18G | Fiction and children's books |
| `lcc-b` | 5.9G | Philosophy, psychology and religion |
| `lcc-m` | 3.7G | Music and books on music |
| `lcc-d` | 37G | History |
| `lcc-q` / `lcc-t` / `lcc-s` | 17G / 12G / 4.2G | Science, technology, agriculture |
| `lcc-r` | 1.9G | Medicine |

Warning: the science, technology and medicine parts hold books that are about 100 years old. They are history, not guidance. Do not use `lcc-r` for medical decisions.

**Wikisource and Wikiquote in the local language.** Wikisource holds national classics, laws and historical texts. It is often larger than the local Gutenberg.

| Language | Wikisource nopic | Wikiquote nopic | Language | Wikisource nopic | Wikiquote nopic |
|---|---|---|---|---|---|
| `bg` | 17M | 16M | `it` | 1.8G | 194M |
| `cs` | 209M | 20M | `nl` | 85M | 3.9M |
| `da` | 89M | 1.7M | `pl` | 1.9G | 78M |
| `de` | 1.1G | 16M | `pt` | 1.5G | 26M |
| `el` | 125M | 5.5M | `ro` | 109M | 2.0M |
| `en` | 3.6G | 383M | `sl` | 212M | 6.8M |
| `es` | 381M | 30M | `sr` | 140M | 13M |
| `fi` | 53M | 8.7M | `sv` | 166M | 4.2M |
| `fr` | 11G | 29M | `uk` | 591M | 58M |
| `hr` | 54M | 4.8M | `hu` | 74M | 7.0M |
| `hy` | 107M | 6.9M | `la` | 320M | 2.2M |

**National free libraries.** Many countries have a project that publishes checked national classics. Look for it.

- Poland: Wolne Lektury. On 2026-11-21 its API listed 7,693 books. 1,703 of them have an audiobook. Formats are EPUB, MOBI, PDF and TXT.
  - Book list: `https://wolnelektury.pl/api/books/`.
  - File pattern: `https://wolnelektury.pl/media/book/epub/<slug>.epub`.
  - Each book record has a licence field. Read it. We did not measure the total size.
- Other projects to check at run time: Standard Ebooks (English), Projekt Gutenberg-DE, Gallica (French), Liber Liber (Italian), Runeberg (Nordic). We did not verify their download terms.

**For children:** Vikidia is an encyclopedia for ages 8 to 13. Sizes with images: `fr` 1.3G, `es` 127M, `it` 104M, `en` 74M, `eu` 39M. See also section 21.

### 28.3 Audiobooks

Audio needs no screen and little power. It works in the dark and while people do other work. One phone with a speaker serves a whole room.

**LibriVox** has volunteer recordings of free books. The readers give their recordings to the public domain.

- API: `https://librivox.org/api/feed/audiobooks?format=json&title=^<start of title>`.
- Useful fields: `language`, `totaltime`, `url_zip_file`.
- The ZIP files hold MP3 at 64 kbit/s. This is about 29 MB per hour.
- The server builds each ZIP on request. It sends no file size. Calculate the size from `totaltime`.

Examples from the API on 2026-11-21:

| Title | Language | Length | Size, about |
|---|---|---|---|
| Iliad (Homer) | English | 14 h 30 min | 420 MB |
| Odyssey (Homer, Butler translation) | English | 11 h 18 min | 330 MB |
| Meditations (Marcus Aurelius) | English | 6 h 59 min | 200 MB |
| Don Quixote, volume 1 | English | 21 h 17 min | 620 MB |
| Quo Vadis (Sienkiewicz) | English | 20 h 58 min | 610 MB |

Rules for the agent:
1. Filter by the `language` field. Most LibriVox books are in English. German, French, Spanish, Dutch, Italian and Polish have fewer titles.
2. Check the national free library for audio in the local language. Example: Wolne Lektury has "Pan Tadeusz" as an audiobook of 8 h 44 min.
3. Keep the LibriVox credit file that comes inside each ZIP.

### 28.4 A starter canon

Use this list to choose books and audiobooks. All of these authors died before 1956. Check the translator for each translated edition.

- **Ancient:** Homer, Aesop, Plato, Marcus Aurelius, Epictetus, Virgil, Ovid.
- **Sacred texts:** the texts of the user's own tradition, in an old free translation.
- **European classics:** Dante, Cervantes, Shakespeare, Goethe, Hugo, Dumas, Tolstoy, Dostoevsky, Chekhov, Dickens, Austen.
- **Adventure and survival:** Defoe ("Robinson Crusoe"), Verne, Jack London, Stevenson, Conan Doyle.
- **Children:** the Brothers Grimm, Andersen, Carroll, Collodi ("Pinocchio"), Korczak.
- **Polish:** Mickiewicz, Słowacki, Prus, Sienkiewicz, Reymont, Żeromski, Leśmian.
- **Bulgarian:** Botev, Vazov, Yavorov.
- **For each other country:** ask the user for five national authors. Then check the year of death.

### 28.5 Music and film

Clear-rights music and film are harder to find than books. We verified only the first item.

- `studio.blender.org_en_open-movies` (ZIM, 421M): open animated films.
- `chopin.lib.uchicago.edu_en_all` (ZIM, 8.2G): early editions of Chopin scores.
- Recordings to check at run time: Musopen, the Open Goldberg Variations, the Internet Archive.
- Sheet music to check at run time: the Mutopia Project and IMSLP.
- Old films: the rights differ by country. Check each film.

Making music costs no disk space. Add chord charts and a songbook of traditional songs in the local language, if a free one exists.

The user's own music, films and photos matter most. Remind the user to copy them.

### 28.6 Games

**Desktop games.** All are open source. Sizes are from the releases on 2026-11-21.

| Game | Kind | Size | Licence |
|---|---|---|---|
| Luanti 5.18.0 (former Minetest) | Building in a block world. Good for children. Works on a local network | 13–16 MB | LGPL-2.1 |
| Unciv 5.0.1 | Turn-based civilisation building | 55 MB (`.jar`), 100 MB (Windows) | MPL-2.0 |
| Mindustry 160.8 | Factory building and defence | 84 MB (`.jar`) | GPL-3.0 |
| Endless Sky 0.11.4 | Space trading and exploration | 350 MB | GPL-3.0 |
| SuperTuxKart 1.5 | Kart racing, several players on one computer | 700 MB | GPL-3.0 |
| OpenTTD 15.3 | Transport simulation | not measured | GPL-2.0 |
| Battle for Wesnoth, 0 A.D., Stockfish (chess engine) | Strategy, chess | not measured | GPL |

The `.jar` files need Java. Put a Java runtime on the disk or take the native builds.

**Android games from F-Droid.** We checked that each package exists.

| App | Package | Kind |
|---|---|---|
| Simon Tatham's Puzzles | `name.boyle.chris.sgtpuzzles` | About 40 logic puzzles in one small app |
| Shattered Pixel Dungeon | `com.shatteredpixel.shatteredpixeldungeon` | Dungeon adventure |
| Unciv | `com.unciv.app` | Civilisation building |
| Luanti | `net.minetest.minetest` | Block world |
| Battle for Wesnoth | `org.wesnoth.Wesnoth` | Turn-based strategy |
| Mindustry | `io.anuke.mindustry` | Factory building |
| DroidFish | `org.petero.droidfish` | Chess with an engine |
| Lexica | `com.serwylo.lexica` | Word game |
| Privacy Friendly Sudoku | `org.secuso.privacyfriendlysudoku` | Sudoku |

**Games without power.** These matter most when batteries are empty.

- Print the rules of five card games and three dice games in the local language.
- Print boards for chess, draughts and nine men's morris. Coins and buttons can serve as pieces.
- Add paper-and-pencil games and puzzles for children.
- Take the rules from Wikipedia or Wikibooks on the disk. Give the article name on each printed page.

### 28.7 Things to learn

Learning fills time and helps later. These libraries are small.

| File stem | Size | Topic |
|---|---|---|
| `voa_learning_en_all` | 6.6G | English lessons with video |
| `wiktionary_<lang>_all_nopic` | see section 15 | Dictionary |
| `proofwiki.org_en_all_maxi` | 180M | Mathematics proofs |
| `artofproblemsolving_en_all_maxi` | 196M | Mathematics problems |
| `cuisinelibre.org_fr_all` | 244M | Recipes in French |
| `kochwiki.org_de_all_maxi` | 71M | Recipes in German |
| `explainxkcd_en_all_maxi` | 138M | Comics with explanations |
| `scoutwiki.org_<lang>_all_maxi` | 13–47M | Outdoor skills and group games |
| Wikibooks in the local language | see section 15 | Cookbooks, language courses, chess, music theory |

### 28.8 Suggested budgets

| Tier | Budget | Content |
|---|---|---|
| S | 2 GB | Gutenberg and Wikiquote in the local language, `gutenberg_en_lcc-pa`, three audiobooks, Android games |
| M | 15 GB | Tier S, plus Wikisource in the local language, 20 audiobooks, desktop games, open films |
| L | 60 GB | Tier M, plus `gutenberg_en_lcc-pr` and `lcc-pz`, 60 audiobooks, `voa_learning_en_all` |
| XL | 250 GB | Tier L, plus the full `gutenberg_en_all` |

Ask the user two questions before you choose:
1. Who is in the household? Children, teenagers and older people need different content.
2. Which languages do they read for pleasure? People often prefer their first language for stories.

---

## 29. Concrete catalogue: books, audio, games and video

This section lists exact files with direct links. All links answered on 2026-11-21. The reference build downloads the items in 29.1 to 29.4 and the Kiwix and Creative Commons items in 29.5. The speaker lists in 29.5 are links only. They have the standard YouTube licence (section 19.2). File names carry a date. Resolve the newest date at run time (section 10).

Size units: Kiwix sizes are binary (G = GiB). LibriVox and Wolne Lektury sizes are estimates at 29 MB per hour.

### 29.1 Book libraries by language (ZIM)

| Language | Project Gutenberg | Wikisource | Wikiquote | Vikidia (children) |
|---|---|---|---|---|
| Albanian (`sq`) | — | — | [1.0M](https://download.kiwix.org/zim/wikiquote/wikiquote_sq_all_nopic_2026-10.zim) | — |
| Ancient Greek (`grc`) | [4.7M](https://download.kiwix.org/zim/gutenberg/gutenberg_grc_all_2025-10.zim) | — | — | — |
| Armenian (`hy`) | — | [107M](https://download.kiwix.org/zim/wikisource/wikisource_hy_all_nopic_2026-10.zim) | [6.9M](https://download.kiwix.org/zim/wikiquote/wikiquote_hy_all_nopic_2026-10.zim) | — |
| Azerbaijani (`az`) | — | [34M](https://download.kiwix.org/zim/wikisource/wikisource_az_all_nopic_2026-07.zim) | [18M](https://download.kiwix.org/zim/wikiquote/wikiquote_az_all_nopic_2026-07.zim) | — |
| Basque (`eu`) | — | [17M](https://download.kiwix.org/zim/wikisource/wikisource_eu_all_nopic_2026-10.zim) | [1.1M](https://download.kiwix.org/zim/wikiquote/wikiquote_eu_all_nopic_2026-10.zim) | [39M](https://download.kiwix.org/zim/vikidia/vikidia_eu_all_maxi_2026-09.zim) |
| Bosnian (`bs`) | — | [13M](https://download.kiwix.org/zim/wikisource/wikisource_bs_all_nopic_2026-10.zim) | [7.4M](https://download.kiwix.org/zim/wikiquote/wikiquote_bs_all_nopic_2026-10.zim) | — |
| Bulgarian (`bg`) | [3.5M](https://download.kiwix.org/zim/gutenberg/gutenberg_bg_all_2025-12.zim) | [17M](https://download.kiwix.org/zim/wikisource/wikisource_bg_all_nopic_2026-10.zim) | [16M](https://download.kiwix.org/zim/wikiquote/wikiquote_bg_all_nopic_2026-10.zim) | — |
| Catalan (`ca`) | [49M](https://download.kiwix.org/zim/gutenberg/gutenberg_ca_all_2025-12.zim) | [36M](https://download.kiwix.org/zim/wikisource/wikisource_ca_all_nopic_2026-10.zim) | [13M](https://download.kiwix.org/zim/wikiquote/wikiquote_ca_all_nopic_2026-10.zim) | [5.0M](https://download.kiwix.org/zim/vikidia/vikidia_ca_all_maxi_2026-09.zim) |
| Croatian (`hr`) | — | [54M](https://download.kiwix.org/zim/wikisource/wikisource_hr_all_nopic_2026-10.zim) | [4.8M](https://download.kiwix.org/zim/wikiquote/wikiquote_hr_all_nopic_2026-10.zim) | — |
| Czech (`cs`) | [9.5M](https://download.kiwix.org/zim/gutenberg/gutenberg_cs_all_2025-12.zim) | [209M](https://download.kiwix.org/zim/wikisource/wikisource_cs_all_nopic_2026-10.zim) | [20M](https://download.kiwix.org/zim/wikiquote/wikiquote_cs_all_nopic_2026-07.zim) | — |
| Danish (`da`) | [64M](https://download.kiwix.org/zim/gutenberg/gutenberg_da_all_2025-12.zim) | [89M](https://download.kiwix.org/zim/wikisource/wikisource_da_all_nopic_2026-10.zim) | [1.7M](https://download.kiwix.org/zim/wikiquote/wikiquote_da_all_nopic_2026-10.zim) | — |
| Dutch (`nl`) | [3.9G](https://download.kiwix.org/zim/gutenberg/gutenberg_nl_all_2026-01.zim) | [85M](https://download.kiwix.org/zim/wikisource/wikisource_nl_all_nopic_2026-10.zim) | [3.9M](https://download.kiwix.org/zim/wikiquote/wikiquote_nl_all_nopic_2026-10.zim) | — |
| English (`en`) | [18G](https://download.kiwix.org/zim/gutenberg/gutenberg_en_lcc-pz_2026-03.zim) | — | [383M](https://download.kiwix.org/zim/wikiquote/wikiquote_en_all_nopic_2026-10.zim) | [74M](https://download.kiwix.org/zim/vikidia/vikidia_en_all_maxi_2026-09.zim) |
| Estonian (`et`) | [2.1M](https://download.kiwix.org/zim/gutenberg/gutenberg_et_all_2026-01.zim) | [25M](https://download.kiwix.org/zim/wikisource/wikisource_et_all_nopic_2026-10.zim) | [48M](https://download.kiwix.org/zim/wikiquote/wikiquote_et_all_nopic_2026-10.zim) | — |
| Finnish (`fi`) | [1.5G](https://download.kiwix.org/zim/gutenberg/gutenberg_fi_all_2026-01.zim) | [53M](https://download.kiwix.org/zim/wikisource/wikisource_fi_all_nopic_2026-10.zim) | [8.7M](https://download.kiwix.org/zim/wikiquote/wikiquote_fi_all_nopic_2026-10.zim) | — |
| French (`fr`) | [9.8G](https://download.kiwix.org/zim/gutenberg/gutenberg_fr_all_2026-01.zim) | [11G](https://download.kiwix.org/zim/wikisource/wikisource_fr_all_nopic_2025-09.zim) | [29M](https://download.kiwix.org/zim/wikiquote/wikiquote_fr_all_nopic_2026-08.zim) | [1.3G](https://download.kiwix.org/zim/vikidia/vikidia_fr_all_maxi_2026-09.zim) |
| Galician (`gl`) | [3.4M](https://download.kiwix.org/zim/gutenberg/gutenberg_gl_all_2026-01.zim) | [5.7M](https://download.kiwix.org/zim/wikisource/wikisource_gl_all_nopic_2026-10.zim) | [2.1M](https://download.kiwix.org/zim/wikiquote/wikiquote_gl_all_nopic_2026-10.zim) | — |
| Georgian (`ka`) | — | — | [6.5M](https://download.kiwix.org/zim/wikiquote/wikiquote_ka_all_nopic_2026-10.zim) | — |
| German (`de`) | [10G](https://download.kiwix.org/zim/gutenberg/gutenberg_de_all_2026-01.zim) | [1.1G](https://download.kiwix.org/zim/wikisource/wikisource_de_all_nopic_2026-09.zim) | [16M](https://download.kiwix.org/zim/wikiquote/wikiquote_de_all_nopic_2026-10.zim) | — |
| Greek (`el`) | [139M](https://download.kiwix.org/zim/gutenberg/gutenberg_el_all_2026-01.zim) | [125M](https://download.kiwix.org/zim/wikisource/wikisource_el_all_nopic_2026-10.zim) | [5.5M](https://download.kiwix.org/zim/wikiquote/wikiquote_el_all_nopic_2026-10.zim) | — |
| Hungarian (`hu`) | [1.0G](https://download.kiwix.org/zim/gutenberg/gutenberg_hu_all_2026-01.zim) | [74M](https://download.kiwix.org/zim/wikisource/wikisource_hu_all_nopic_2026-10.zim) | [7.0M](https://download.kiwix.org/zim/wikiquote/wikiquote_hu_all_nopic_2026-10.zim) | — |
| Icelandic (`is`) | [9.5M](https://download.kiwix.org/zim/gutenberg/gutenberg_is_all_2026-01.zim) | [17M](https://download.kiwix.org/zim/wikisource/wikisource_is_all_nopic_2026-10.zim) | [711K](https://download.kiwix.org/zim/wikiquote/wikiquote_is_all_nopic_2026-10.zim) | — |
| Irish (`ga`) | [3.3M](https://download.kiwix.org/zim/gutenberg/gutenberg_ga_all_2026-01.zim) | — | — | — |
| Italian (`it`) | [1.0G](https://download.kiwix.org/zim/gutenberg/gutenberg_it_all_2026-01.zim) | [1.8G](https://download.kiwix.org/zim/wikisource/wikisource_it_all_nopic_2026-03.zim) | [194M](https://download.kiwix.org/zim/wikiquote/wikiquote_it_all_nopic_2026-10.zim) | [104M](https://download.kiwix.org/zim/vikidia/vikidia_it_all_maxi_2026-09.zim) |
| Latin (`la`) | [155M](https://download.kiwix.org/zim/gutenberg/gutenberg_la_all_2026-01.zim) | [320M](https://download.kiwix.org/zim/wikisource/wikisource_la_all_nopic_2026-09.zim) | [2.2M](https://download.kiwix.org/zim/wikiquote/wikiquote_la_all_nopic_2026-10.zim) | — |
| Lithuanian (`lt`) | — | [6.4M](https://download.kiwix.org/zim/wikisource/wikisource_lt_all_nopic_2026-10.zim) | [5.2M](https://download.kiwix.org/zim/wikiquote/wikiquote_lt_all_nopic_2026-10.zim) | — |
| Macedonian (`mk`) | — | [14M](https://download.kiwix.org/zim/wikisource/wikisource_mk_all_nopic_2026-10.zim) | — | — |
| Norwegian (`no`) | [45M](https://download.kiwix.org/zim/gutenberg/gutenberg_no_all_2026-01.zim) | — | — | — |
| Norwegian Bokmål (`nb`) | — | [107M](https://download.kiwix.org/zim/wikisource/wikisource_nb_all_nopic_2026-10.zim) | [2.5M](https://download.kiwix.org/zim/wikiquote/wikiquote_nb_all_nopic_2026-10.zim) | — |
| Norwegian Nynorsk (`nn`) | — | — | [3.1M](https://download.kiwix.org/zim/wikiquote/wikiquote_nn_all_nopic_2026-10.zim) | — |
| Polish (`pl`) | [20M](https://download.kiwix.org/zim/gutenberg/gutenberg_pl_all_2026-01.zim) | [1.9G](https://download.kiwix.org/zim/wikisource/wikisource_pl_all_nopic_2026-09.zim) | [78M](https://download.kiwix.org/zim/wikiquote/wikiquote_pl_all_nopic_2026-10.zim) | — |
| Portuguese (`pt`) | [499M](https://download.kiwix.org/zim/gutenberg/gutenberg_pt_all_2025-10.zim) | [1.5G](https://download.kiwix.org/zim/wikisource/wikisource_pt_all_nopic_2026-10.zim) | [26M](https://download.kiwix.org/zim/wikiquote/wikiquote_pt_all_nopic_2026-10.zim) | [18M](https://download.kiwix.org/zim/vikidia/vikidia_pt_all_maxi_2026-09.zim) |
| Romanian (`ro`) | [5.5M](https://download.kiwix.org/zim/gutenberg/gutenberg_ro_all_2026-01.zim) | [109M](https://download.kiwix.org/zim/wikisource/wikisource_ro_all_nopic_2026-07.zim) | [2.0M](https://download.kiwix.org/zim/wikiquote/wikiquote_ro_all_nopic_2026-10.zim) | — |
| Serbian (`sr`) | [3.5M](https://download.kiwix.org/zim/gutenberg/gutenberg_sr_all_2026-01.zim) | [140M](https://download.kiwix.org/zim/wikisource/wikisource_sr_all_nopic_2026-10.zim) | [13M](https://download.kiwix.org/zim/wikiquote/wikiquote_sr_all_nopic_2026-10.zim) | — |
| Slovak (`sk`) | — | [3.7M](https://download.kiwix.org/zim/wikisource/wikisource_sk_all_nopic_2026-10.zim) | [7.0M](https://download.kiwix.org/zim/wikiquote/wikiquote_sk_all_nopic_2026-10.zim) | — |
| Slovenian (`sl`) | [4.6M](https://download.kiwix.org/zim/gutenberg/gutenberg_sl_all_2026-01.zim) | [212M](https://download.kiwix.org/zim/wikisource/wikisource_sl_all_nopic_2026-10.zim) | [6.8M](https://download.kiwix.org/zim/wikiquote/wikiquote_sl_all_nopic_2026-10.zim) | — |
| Spanish (`es`) | [1.7G](https://download.kiwix.org/zim/gutenberg/gutenberg_es_all_2026-01.zim) | [381M](https://download.kiwix.org/zim/wikisource/wikisource_es_all_nopic_2026-10.zim) | [30M](https://download.kiwix.org/zim/wikiquote/wikiquote_es_all_nopic_2026-10.zim) | [127M](https://download.kiwix.org/zim/vikidia/vikidia_es_all_maxi_2026-09.zim) |
| Swedish (`sv`) | [210M](https://download.kiwix.org/zim/gutenberg/gutenberg_sv_all_2026-01.zim) | [166M](https://download.kiwix.org/zim/wikisource/wikisource_sv_all_nopic_2026-10.zim) | [4.2M](https://download.kiwix.org/zim/wikiquote/wikiquote_sv_all_nopic_2026-10.zim) | — |
| Turkish (`tr`) | — | [44M](https://download.kiwix.org/zim/wikisource/wikisource_tr_all_nopic_2026-10.zim) | [14M](https://download.kiwix.org/zim/wikiquote/wikiquote_tr_all_nopic_2026-07.zim) | — |
| Ukrainian (`uk`) | — | [591M](https://download.kiwix.org/zim/wikisource/wikisource_uk_all_nopic_2026-10.zim) | [58M](https://download.kiwix.org/zim/wikiquote/wikiquote_uk_all_nopic_2026-10.zim) | — |
| Welsh (`cy`) | [49M](https://download.kiwix.org/zim/gutenberg/gutenberg_cy_all_2026-01.zim) | [96M](https://download.kiwix.org/zim/wikisource/wikisource_cy_all_nopic_2026-10.zim) | [756K](https://download.kiwix.org/zim/wikiquote/wikiquote_cy_all_nopic_2026-10.zim) | — |

English Gutenberg parts used in the reference build:

- [gutenberg_en_lcc-pa_2026-03.zim](https://download.kiwix.org/zim/gutenberg/gutenberg_en_lcc-pa_2026-03.zim) (498M)
- [gutenberg_en_lcc-pr_2026-03.zim](https://download.kiwix.org/zim/gutenberg/gutenberg_en_lcc-pr_2026-03.zim) (15G)
- [gutenberg_en_lcc-pz_2026-03.zim](https://download.kiwix.org/zim/gutenberg/gutenberg_en_lcc-pz_2026-03.zim) (18G)
- [studio.blender.org_en_open-movies_2026-09.zim](https://download.kiwix.org/zim/videos/studio.blender.org_en_open-movies_2026-09.zim) (421M)
- [explainxkcd_en_all_maxi_2026-10.zim](https://download.kiwix.org/zim/other/explainxkcd_en_all_maxi_2026-10.zim) (138M)
- [klexikon_de_all_maxi_2026-11.zim](https://download.kiwix.org/zim/other/klexikon_de_all_maxi_2026-11.zim) (129M)

The English Wikisource (3.6G) is in the core set (section 6.1).

### 29.2 LibriVox audiobooks

All recordings are public domain. The text or translation can still be protected in the EU. Check before you share. The link is the static MP3 archive (64 kbit/s). The item page is `https://archive.org/details/<item>`.

| Language | Author | Title | Hours | Download |
|---|---|---|---|---|
| English | Homer | Iliad (Version 2) | 14.1 | [iliadv2_2407_librivox](https://archive.org/download/iliadv2_2407_librivox/iliadv2_2407_librivox_64kb_mp3.zip) |
| English | Homer | Odyssey | 11.3 | [odyssey_butler_librivox](https://archive.org/download/odyssey_butler_librivox/odyssey_butler_librivox_64kb_mp3.zip) |
| English | Marcus Aurelius | Meditations | 7.0 | [meditations_0708_librivox](https://archive.org/download/meditations_0708_librivox/meditations_0708_librivox_64kb_mp3.zip) |
| English | Daniel Defoe | Robinson Crusoe (version 2) | 11.4 | [robinson_crusoe_1006_librivox](https://archive.org/download/robinson_crusoe_1006_librivox/robinson_crusoe_1006_librivox_64kb_mp3.zip) |
| English | Robert Louis Stevenson | Treasure Island (Version 4) | 7.6 | [treasure_island_1307_librivox](https://archive.org/download/treasure_island_1307_librivox/treasure_island_1307_librivox_64kb_mp3.zip) |
| English | Lewis Carroll | Alice's Adventures in Wonderland (Version 8) | 3.6 | [aliceinwonderland_2106_librivox](https://archive.org/download/aliceinwonderland_2106_librivox/aliceinwonderland_2106_librivox_64kb_mp3.zip) |
| English | Jacob & Wilhelm Grimm | Grimms' Fairy Tales (version 2) | 11.1 | [grimm_fairy_tales_1202_librivox](https://archive.org/download/grimm_fairy_tales_1202_librivox/grimm_fairy_tales_1202_librivox_64kb_mp3.zip) |
| English | Rudyard Kipling | Jungle Book (Version 3) | 5.7 | [junglebook_1504_librivox](https://archive.org/download/junglebook_1504_librivox/junglebook_1504_librivox_64kb_mp3.zip) |
| English | Sir Arthur Conan Doyle | Adventures of Sherlock Holmes (version 3) | 11.2 | [adventures_sherlockholmes_1007_librivox](https://archive.org/download/adventures_sherlockholmes_1007_librivox/adventures_sherlockholmes_1007_librivox_64kb_mp3.zip) |
| English | Jules Verne | Around the World in Eighty Days | 8.8 | [around_the_world1_librivox](https://archive.org/download/around_the_world1_librivox/around_the_world1_librivox_64kb_mp3.zip) |
| English | Jane Austen | Pride and Prejudice (version 6, dramatic reading) | 12.0 | [prideandprejudice_1107_librivox](https://archive.org/download/prideandprejudice_1107_librivox/prideandprejudice_1107_librivox_64kb_mp3.zip) |
| English | Charles Dickens | Christmas Carol (version 07) | 3.7 | [christmas_carol_7_1410_librivox](https://archive.org/download/christmas_carol_7_1410_librivox/christmas_carol_7_1410_librivox_64kb_mp3.zip) |
| English | Aesop | Aesop's Fables - new translation | 4.5 | [aesops_fables_-_new_translation_1407_librivox](https://archive.org/download/aesops_fables_-_new_translation_1407_librivox/aesops_fables_-_new_translation_1407_librivox_64kb_mp3.zip) |
| English | Niccolò Machiavelli | Art of War (Neville Translation) | 7.0 | [artofwar_2008_librivox](https://archive.org/download/artofwar_2008_librivox/artofwar_2008_librivox_64kb_mp3.zip) |
| English | Henry David Thoreau | Walden, Version 2 | 12.0 | [walden_version_2_nb_1501_librivox](https://archive.org/download/walden_version_2_nb_1501_librivox/walden_version_2_nb_1501_librivox_64kb_mp3.zip) |
| German | Jacob & Wilhelm Grimm | Kinder- und Hausmärchen | 29.7 | [kinder_und_hausmaerchen_2003_librivox](https://archive.org/download/kinder_und_hausmaerchen_2003_librivox/kinder_und_hausmaerchen_2003_librivox_64kb_mp3.zip) |
| German | Johann Wolfgang von Goethe | Faust, Der Tragödie zweiter Teil | 10.6 | [faust2_1008_librivox](https://archive.org/download/faust2_1008_librivox/faust2_1008_librivox_64kb_mp3.zip) |
| German | Franz Kafka | Verwandlung | 2.1 | [verwandlung_mw_0811_librivox](https://archive.org/download/verwandlung_mw_0811_librivox/verwandlung_mw_0811_librivox_64kb_mp3.zip) |
| German | Theodor Storm | Schimmelreiter (Version 2) | 5.1 | [derschimmelreiter_2601_librivox](https://archive.org/download/derschimmelreiter_2601_librivox/derschimmelreiter_2601_librivox_64kb_mp3.zip) |
| German | Theodor Fontane | Effi Briest (Version 2) | 13.9 | [effi_briest_1304_librivox](https://archive.org/download/effi_briest_1304_librivox/effi_briest_1304_librivox_64kb_mp3.zip) |
| German | Wilhelm Busch | Max und Moritz | 0.3 | [max_und_moritz_librivox](https://archive.org/download/max_und_moritz_librivox/max_und_moritz_librivox_64kb_mp3.zip) |
| German | Johanna Spyri | Heidis Lehr- und Wanderjahre | 6.0 | [heidis_lehrjahre_0710](https://archive.org/download/heidis_lehrjahre_0710/heidis_lehrjahre_0710_64kb_mp3.zip) |
| French | Jules Verne | Vingt mille lieues sous les mers | 15.6 | [20000_lieues_sous_les_mers_1010_librivox](https://archive.org/download/20000_lieues_sous_les_mers_1010_librivox/20000_lieues_sous_les_mers_1010_librivox_64kb_mp3.zip) |
| French | Auguste Villiers de l'Isle-Adam | Contes cruels | 8.8 | [contescruels_1012_librivox](https://archive.org/download/contescruels_1012_librivox/contescruels_1012_librivox_64kb_mp3.zip) |
| French | Voltaire | Candide ou L'optimisme | 3.9 | [candide_ou_loptimisme_b_librivox](https://archive.org/download/candide_ou_loptimisme_b_librivox/candide_ou_loptimisme_b_librivox_64kb_mp3.zip) |
| Spanish | Miguel de Cervantes Saavedra | Don Quijote 2 | 22.1 | [don_quijote_2_1001_librivox](https://archive.org/download/don_quijote_2_1001_librivox/don_quijote_2_1001_librivox_64kb_mp3.zip) |
| Spanish | Anonymous | Lazarillo de Tormes | 1.9 | [lazarillo_0912_librivox](https://archive.org/download/lazarillo_0912_librivox/lazarillo_0912_librivox_64kb_mp3.zip) |
| Spanish | Rafael Pombo | Fábulas y Verdades | 8.9 | [fabulasyverdades_2412_librivox](https://archive.org/download/fabulasyverdades_2412_librivox/fabulasyverdades_2412_librivox_64kb_mp3.zip) |
| Spanish | Benito Pérez Galdós | Marianela | 6.0 | [marianela_2104_librivox](https://archive.org/download/marianela_2104_librivox/marianela_2104_librivox_64kb_mp3.zip) |
| Spanish | Gustavo Adolfo Bécquer | Leyendas | 10.1 | [leyendas_becquer_1208_librivox](https://archive.org/download/leyendas_becquer_1208_librivox/leyendas_becquer_1208_librivox_64kb_mp3.zip) |
| Italian | Edmondo de Amicis | Cuore | 10.6 | [cuore_fg_librivox](https://archive.org/download/cuore_fg_librivox/cuore_fg_librivox_64kb_mp3.zip) |
| Italian | Dante Alighieri | Divina Commedia | 10.9 | [divina_commedia_librivox](https://archive.org/download/divina_commedia_librivox/divina_commedia_librivox_64kb_mp3.zip) |
| Dutch | Multatuli | Max Havelaar | 12.6 | [max_havelaar_as_librivox](https://archive.org/download/max_havelaar_as_librivox/max_havelaar_as_librivox_64kb_mp3.zip) |
| Dutch | Jacob & Wilhelm Grimm | Sprookjes Verzameld door de Gebroeders Grimm, deel twee | 6.2 | [sprookjes_verzameld_door_de_gebroeders_grimm_deel_twee__librivox](https://archive.org/download/sprookjes_verzameld_door_de_gebroeders_grimm_deel_twee__librivox/sprookjes_verzameld_door_de_gebroeders_grimm_deel_twee__librivox_64kb_mp3.zip) |
| Dutch | Nicolaas Beets | Camera Obscura | 22.0 | [camera_obscura_0809_librivox](https://archive.org/download/camera_obscura_0809_librivox/camera_obscura_0809_librivox_64kb_mp3.zip) |
| Portuguese | Joaquim Maria Machado de Assis | Dom Casmurro | 8.5 | [dom_casmurro_2102_librivox](https://archive.org/download/dom_casmurro_2102_librivox/dom_casmurro_2102_librivox_64kb_mp3.zip) |
| Portuguese | Joaquim Maria Machado de Assis | Contos Fluminenses e Histórias da Meia-Noite | 10.4 | [contos_fluminenses_1202_librivox](https://archive.org/download/contos_fluminenses_1202_librivox/contos_fluminenses_1202_librivox_64kb_mp3.zip) |
| Finnish | Aleksis Kivi | Seitsemän veljestä | 13.8 | [seitseman_veljesta_0802_librivox](https://archive.org/download/seitseman_veljesta_0802_librivox/seitseman_veljesta_0802_librivox_64kb_mp3.zip) |
| Ancient Greek | Homer | Odyssey (Book 6) | 0.6 | [odyssey_bk6_1012_librivox](https://archive.org/download/odyssey_bk6_1012_librivox/odyssey_bk6_1012_librivox_64kb_mp3.zip) |
| Hungarian | Géza Gárdonyi | Egri csillagok | 17.5 | [egri_csillagok_1101_librivox](https://archive.org/download/egri_csillagok_1101_librivox/egri_csillagok_1101_librivox_64kb_mp3.zip) |

More titles: search `https://librivox.org/api/feed/audiobooks?format=json&title=^<title>` and keep results with the right `language`. Languages with many titles: English, German, French, Spanish, Dutch, Italian, Portuguese. Few or none: most Central and Eastern European languages. Use the national free library instead (29.3).

### 29.3 Wolne Lektury (Polish): audiobooks and e-books

- Catalogue API: `https://wolnelektury.pl/api/books/` (7,693 entries on 2026-11-21, 1,703 with audio).
- E-book pattern: `https://wolnelektury.pl/media/book/epub/<slug>.epub`. The reference build takes all EPUB files.
- Audiobook pattern: `https://wolnelektury.pl/media/book/audio.epub/<slug>.audio.epub`. One file holds the whole recording.
- Licence: public domain or a free licence. Each file states its licence.

Complete audiobooks (top-level books, 103 items, 588 hours):

| Author | Title | Hours | Link |
|---|---|---|---|
| Adam Mickiewicz | Konrad Wallenrod | 2.3 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/konrad-wallenrod.audio.epub) |
| Adam Mickiewicz | Pan Tadeusz, czyli ostatni zajazd na Litwie | 8.7 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/pan-tadeusz.audio.epub) |
| Andrzej Frycz Modrzewski | O poprawie Rzeczypospolitej | 14.8 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/o-poprawie-rzeczypospolitej.audio.epub) |
| Antoine de Saint Exupéry | Mały Książę | 1.7 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/saint-exupery-maly-ksiaze.audio.epub) |
| Arthur Conan Doyle | Groźny cień | 6.7 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/grozny-cien.audio.epub) |
| Arthur Conan Doyle | Studium w szkarłacie | 5.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/doyle-studium-w-szkarlacie.audio.epub) |
| Arthur Conan Doyle | Znak czterech | 5.2 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/doyle-znak-czterech.audio.epub) |
| Artur Schopenhauer | Erystyka, czyli sztuka prowadzenia sporów | 1.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/schopenhauer-sztuka-prowadzenia-sporow.audio.epub) |
| Arystofanes | Chmury | 3.2 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/arystofanes-chmury.audio.epub) |
| Arystoteles | Poetyka | 1.7 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/arystoteles-poetyka.audio.epub) |
| Autor nieznany  | Dzieje Tristana i Izoldy | 5.7 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/dzieje-tristana-i-izoldy.audio.epub) |
| Autor nieznany  | Pieśń o Rolandzie | 4.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/piesn-o-rolandzie.audio.epub) |
| Bolesław Prus | Katarynka | 0.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/katarynka.audio.epub) |
| Bolesław Prus | Z legend dawnego Egiptu | 0.2 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/z-legend-dawnego-egiptu.audio.epub) |
| Bolesław Prus | Zemsta | 0.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/prus-zemsta.audio.epub) |
| Charles Dickens | Opowieść wigilijna | 3.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/dickens-opowiesc-wigilijna.audio.epub) |
| Charles Perrault | Kopciuszek | 0.3 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/perrault-kopciuszek.audio.epub) |
| Charlotte Brontë | Dziwne losy Jane Eyre | 21.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/bronte-dziwne-losy-jane-eyre.audio.epub) |
| Cyprian Kamil Norwid | Promethidion | 0.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/promethidion.audio.epub) |
| Edgar Allan Poe | Beczka Amontillada | 0.3 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/beczka-amontillada.audio.epub) |
| Edgar Allan Poe | Berenice | 0.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/berenice.audio.epub) |
| Edgar Allan Poe | Czarny kot | 0.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/czarny-kot.audio.epub) |
| Edgar Allan Poe | Diabeł na wieży | 0.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/diabel-na-wiezy.audio.epub) |
| Edgar Allan Poe | Hop-frog | 0.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/hop-frog.audio.epub) |
| Edgar Allan Poe | Król Dżumiec | 0.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/krol-dzumiec.audio.epub) |
| Edgar Allan Poe | Maska śmierci szkarłatnej | 0.3 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/maska-smierci-szkarlatnej.audio.epub) |
| Edgar Allan Poe | Prawdziwy opis wypadku z p. Waldemarem | 0.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/prawdziwy-opis-wypadku-z-p-waldemarem.audio.epub) |
| Edgar Allan Poe | Serce oskarżycielem | 0.3 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/serce-oskarzycielem.audio.epub) |
| Edgar Allan Poe | Tajemnica Marii Rogêt | 2.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/poe-tajemnica-marii-roget.audio.epub) |
| Edgar Allan Poe | Zagłada domu Usherów | 0.8 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/zaglada-domu-usherow.audio.epub) |
| Edith Nesbit | Poszukiwacze skarbu | 2.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/nesbit-poszukiwacze-skarbu.audio.epub) |
| Edith Nesbit | Przygody młodych Bastablów | 4.2 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/nesbit-przygody-mlodych-bastablow.audio.epub) |
| Eleanor H. Porter | Pollyanna | 4.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/porter-pollyanna.audio.epub) |
| Eleanor H. Porter | Pollyanna dorasta | 8.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/porter-pollyanna-dorasta.audio.epub) |
| Feliks Salten | Bambi | 4.8 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/salten-bambi.audio.epub) |
| Ferdynand Ossendowski | Ludzie, zwierzęta, bogowie | 10.0 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/ossendowski-ludzie-zwierzeta-bogowie.audio.epub) |
| Ferdynand Ossendowski | Mocni ludzie | 5.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/ossendowski-mocni-ludzie.audio.epub) |
| Ferdynand Ossendowski | Słoń Birara | 4.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/ossendowski-slon-birara.audio.epub) |
| Frances Hodgson Burnett | Mała księżniczka | 7.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/mala-ksiezniczka.audio.epub) |
| Frances Hodgson Burnett | Tajemniczy ogród | 8.2 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/tajemniczy-ogrod.audio.epub) |
| François Rabelais | Gargantua i Pantagruel | 6.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/gargantua-i-pantagruel.audio.epub) |
| Gabriela Zapolska | Moralność pani Dulskiej | 2.2 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/moralnosc-pani-dulskiej.audio.epub) |
| George Gordon Byron | Giaur | 1.2 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/giaur.audio.epub) |
| George Orwell | Rok 1984 | 10.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/orwell-rok-1984.audio.epub) |
| Halina Górska | O księciu Gotfrydzie, rycerzu Gwiazdy Wigilijnej | 3.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/gorska-o-ksieciu-gotfrydzie.audio.epub) |
| Henryk Sienkiewicz | Janko Muzykant | 0.3 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/janko-muzykant.audio.epub) |
| Henryk Sienkiewicz | Latarnik | 0.7 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/latarnik.audio.epub) |
| Henryk Sienkiewicz | Quo vadis | 20.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/quo-vadis.audio.epub) |
| Henryk Sienkiewicz | W pustyni i w puszczy | 13.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/w-pustyni-i-w-puszczy.audio.epub) |
| Herbert George Wells | Wehikuł czasu | 4.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/wells-wehikul-czasu.audio.epub) |
| Homer | Iliada | 10.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/homer-iliada.audio.epub) |
| Homer | Odyseja | 13.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/homer-odyseja.audio.epub) |
| Honoré de Balzac | Ojciec Goriot | 11.0 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/ojciec-goriot.audio.epub) |
| Hugh Lofting | Doktor Dolittle i jego zwierzęta | 2.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/hugh-lofting-doktor-dolittle-i-jego-zwierzeta.audio.epub) |
| Ignacy Krasicki | Monachomachia | 0.8 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/monachomachia.audio.epub) |
| Jan Chryzostom Pasek | Pamiętniki | 14.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/pamietniki.audio.epub) |
| Jan Grabowski | Finek | 2.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/grabowski-finek.audio.epub) |
| Janusz Korczak | Kajtuś Czarodziej | 7.0 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/korczak-kajtus-czarodziej.audio.epub) |
| Janusz Korczak | Król Maciuś Pierwszy | 9.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/krol-macius-pierwszy.audio.epub) |
| Joanna Papuzińska | Nasza mama czarodziejka | 0.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/papuzinska-nasza-mama-czarodziejka.audio.epub) |
| Johanna Spyri | Heidi | 7.0 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/heidi.audio.epub) |
| Joseph Conrad | Tajny agent | 9.8 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/conrad-tajny-agent.audio.epub) |
| Jules Gabriel Verne | 20 000 mil podmorskiej żeglugi | 16.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/20-000-mil-podmorskiej-zeglugi.audio.epub) |
| Jules Gabriel Verne | W osiemdziesiąt dni dookoła świata | 5.8 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/w-80-dni-dookola-swiata.audio.epub) |
| Julian Ursyn Niemcewicz | Powrót posła | 1.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/powrot-posla.audio.epub) |
| Juliusz Słowacki | Balladyna | 4.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/balladyna.audio.epub) |
| Juliusz Słowacki | Kordian | 3.3 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/kordian.audio.epub) |
| Jędrzej Kitowicz | Opis obyczajów i zwyczajów za panowania Augusta III | 16.7 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/kitowicz-opis-obyczajow-i-zwyczajow-za-panowania-augusta-iii.audio.epub) |
| Karel Čapek | Fabryka Absolutu | 5.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/capek-fabryka-absolutu.audio.epub) |
| Karel Čapek | Inwazja jaszczurów | 8.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/capek-inwazja-jaszczurow.audio.epub) |
| Louisa May Alcott | Małe kobietki | 8.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/alcott-male-kobietki.audio.epub) |
| Lucy Maud Montgomery | Ania z Wyspy | 7.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/montgomery-ania-z-wyspy.audio.epub) |
| Maria Konopnicka | O krasnoludkach i sierotce Marysi | 6.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/o-krasnoludkach-i-sierotce-marysi.audio.epub) |
| Mark Twain | Książę i żebrak | 8.8 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/ksiaze-i-zebrak.audio.epub) |
| Mark Twain | Przygody Hucka Finna | 9.8 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/twain-przygody-hucka-finna.audio.epub) |
| Mark Twain | Przygody Tomka Sawyera | 6.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/przygody-tomka-sawyera.audio.epub) |
| Miguel de Cervantes Saavedra | Don Kichot z La Manchy | 34.0 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/don-kichot-z-la-manchy.audio.epub) |
| Molière (Molier) | Skąpiec | 2.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/skapiec.audio.epub) |
| Niccolò Machiavelli | Książę | 3.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/machiavelli-traktat-o-ksieciu.audio.epub) |
| Oscar Wilde | Duch z Canterville | 1.2 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/wilde-duch-z-canterville.audio.epub) |
| Oscar Wilde | Portret Doriana Graya | 8.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/wilde-portret-doriana-graya.audio.epub) |
| Piotr Skarga | Kazania sejmowe | 4.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/skarga-kazania-sejmowe.audio.epub) |
| Platon | Obrona Sokratesa | 1.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/obrona-sokratesa.audio.epub) |
| Platon | Państwo | 19.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/platon-panstwo.audio.epub) |
| Robert Louis Stevenson | Doktor Jekyll i pan Hyde | 2.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/stevenson-dr-jekyll-i-mr-hyde.audio.epub) |
| Rudyard Kipling | Księga dżungli | 6.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/ksiega-dzungli.audio.epub) |
| Rudyard Kipling | Takie sobie bajeczki | 3.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/kipling-takie-sobie-bajeczki.audio.epub) |
| Sofokles | Antygona | 1.3 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/antygona.audio.epub) |
| Sofokles | Król Edyp | 1.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/krol-edyp.audio.epub) |
| Stanisław Staszic | Przestrogi dla Polski | 5.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/przestrogi-dla-polski.audio.epub) |
| Stefan Żeromski | Echa leśne | 0.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/echa-lesne.audio.epub) |
| Stefan Żeromski | Przedwiośnie | 10.9 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/przedwiosnie.audio.epub) |
| Stefan Żeromski | Rozdzióbią nas kruki, wrony | 0.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/zeromski-rozdziobia-nas-kruki-wrony.audio.epub) |
| Stefan Żeromski | Syzyfowe prace | 7.8 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/syzyfowe-prace.audio.epub) |
| Susan Coolidge | Co Kasia robiła | 5.2 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/coolidge-co-kasia-robila.audio.epub) |
| Tadeusz Borowski | Ludzie, którzy szli | 0.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/borowski-ludzie-ktorzy-szli.audio.epub) |
| Uriel Waldo Cutler | O królu Arturze i rycerzach Okrągłego Stołu | 6.4 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/cutler-o-krolu-arturze-i-rycerzach-okraglego-stolu.audio.epub) |
| Wacław Potocki | Transakcja wojny chocimskiej | 16.0 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/potocki-transakcja-wojny-chocimskiej.audio.epub) |
| Wergiliusz  | Eneida | 11.1 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/wergiliusz-eneida.audio.epub) |
| William Shakespeare (Szekspir) | Hamlet | 4.7 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/hamlet.audio.epub) |
| William Shakespeare (Szekspir) | Makbet | 2.5 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/makbet.audio.epub) |
| Zygmunt Krasiński | Nie-Boska komedia | 2.6 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/nie-boska-komedia.audio.epub) |
| Łukasz Orbitowski, Jacek Świdziński | #manto | 4.7 | [audio.epub](https://wolnelektury.pl/media/book/audio.epub/orbitowski-manto.audio.epub) |

Other national free libraries. The home pages answered on 2026-11-21. We did not verify their bulk-download terms:
- German: https://www.projekt-gutenberg.org/
- French: https://gallica.bnf.fr/ (blocks scripts, use a browser)
- Italian: https://www.liberliber.it/
- Nordic: https://runeberg.org/
- English, edited: https://standardebooks.org/
- Slovak: https://zlatyfond.sme.sk/ (blocks scripts, use a browser)
- Croatian: https://lektire.skole.hr/
- Bulgarian: https://chitanka.info/
- Ukrainian: https://www.ukrlib.com.ua/

### 29.4 Games

| Game | Systems | Direct link |
|---|---|---|
| Luanti | luanti-5.18.0-win64.zip | https://github.com/luanti-org/luanti/releases/download/5.18.0/luanti-5.18.0-win64.zip |
| Luanti | luanti_5.18.0_macos12.3_arm64.zip | https://github.com/luanti-org/luanti/releases/download/5.18.0/luanti_5.18.0_macos12.3_arm64.zip |
| Unciv | Unciv-Windows64.zip | https://github.com/yairm210/Unciv/releases/download/5.0.1/Unciv-Windows64.zip |
| Unciv | Unciv-Linux64.zip | https://github.com/yairm210/Unciv/releases/download/5.0.1/Unciv-Linux64.zip |
| Unciv | Unciv.jar | https://github.com/yairm210/Unciv/releases/download/5.0.1/Unciv.jar |
| Mindustry | Mindustry.jar | https://github.com/Anuken/Mindustry/releases/download/v160.8/Mindustry.jar |
| EndlessSky | Endless-Sky-v0.11.4.dmg | https://github.com/endless-sky/endless-sky/releases/download/v0.11.4/Endless-Sky-v0.11.4.dmg |
| EndlessSky | EndlessSky-v0.11.4-win64-setup.exe | https://github.com/endless-sky/endless-sky/releases/download/v0.11.4/EndlessSky-v0.11.4-win64-setup.exe |
| EndlessSky | Endless_Sky-v0.11.4-x86_64.AppImage | https://github.com/endless-sky/endless-sky/releases/download/v0.11.4/Endless_Sky-v0.11.4-x86_64.AppImage |
| SuperTuxKart | SuperTuxKart-1.5-linux-x86_64.tar.gz | https://github.com/supertuxkart/stk-code/releases/download/1.5/SuperTuxKart-1.5-linux-x86_64.tar.gz |
| SuperTuxKart | SuperTuxKart-1.5-mac-signed.zip | https://github.com/supertuxkart/stk-code/releases/download/1.5/SuperTuxKart-1.5-mac-signed.zip |
| java | jre21-mac-aarch64.tar.gz | https://api.adoptium.net/v3/binary/latest/21/ga/mac/aarch64/jre/hotspot/normal/eclipse |
| java | jre21-windows-x64.zip | https://api.adoptium.net/v3/binary/latest/21/ga/windows/x64/jre/hotspot/normal/eclipse |
| java | jre21-linux-x64.tar.gz | https://api.adoptium.net/v3/binary/latest/21/ga/linux/x64/jre/hotspot/normal/eclipse |

Android games from F-Droid:

- https://f-droid.org/repo/name.boyle.chris.sgtpuzzles_149.apk
- https://f-droid.org/repo/com.shatteredpixel.shatteredpixeldungeon_922.apk
- https://f-droid.org/repo/com.unciv.app_1285.apk
- https://f-droid.org/repo/net.minetest.minetest_5180000.apk
- https://f-droid.org/repo/org.wesnoth.Wesnoth_1192900002.apk
- https://f-droid.org/repo/io.anuke.mindustry_1115.apk
- https://f-droid.org/repo/org.petero.droidfish_100.apk
- https://f-droid.org/repo/com.serwylo.lexica_30018.apk
- https://f-droid.org/repo/org.secuso.privacyfriendlysudoku_101.apk

The `.jar` games (Unciv, Mindustry) need Java. The Temurin JRE 21 links above come from the Adoptium API.

### 29.5 Video

**Kiwix video libraries.** Direct links:

- [lrnselfreliance_en_all_2026-09.zim](https://download.kiwix.org/zim/videos/lrnselfreliance_en_all_2026-09.zim) (3.7G)
- [quickguidesformedicine_en_all_2026-06.zim](https://download.kiwix.org/zim/videos/quickguidesformedicine_en_all_2026-06.zim) (503M)
- [canadian-prepper_en_preppingfood_2026-10.zim](https://download.kiwix.org/zim/videos/canadian-prepper_en_preppingfood_2026-10.zim) (2.0G)
- [canadian-prepper_en_winterprepping_2026-08.zim](https://download.kiwix.org/zim/videos/canadian-prepper_en_winterprepping_2026-08.zim) (1.2G)
- [canadian-prepper_en_bugoutconcepts_2026-08.zim](https://download.kiwix.org/zim/videos/canadian-prepper_en_bugoutconcepts_2026-08.zim) (2.7G)
- [canadian-prepper_en_bugoutroll_2026-10.zim](https://download.kiwix.org/zim/videos/canadian-prepper_en_bugoutroll_2026-10.zim) (838M)
- [urban-prepper_en_all_2026-08.zim](https://download.kiwix.org/zim/videos/urban-prepper_en_all_2026-08.zim) (2.1G)
- [s2underground_en_all_2026-10.zim](https://download.kiwix.org/zim/videos/s2underground_en_all_2026-10.zim) (5.1G)
- [voa_learning_en_all_2025-01.zim](https://download.kiwix.org/zim/videos/voa_learning_en_all_2025-01.zim) (6.6G)
- [coreyms_en_python-tutorials_2026-09.zim](https://download.kiwix.org/zim/videos/coreyms_en_python-tutorials_2026-09.zim) (2.4G)
- [cest-pas-sorcier_fr_medecine_2026-11.zim](https://download.kiwix.org/zim/videos/cest-pas-sorcier_fr_medecine_2026-11.zim) (2.9G)
- [cest-pas-sorcier_fr_energie_2026-11.zim](https://download.kiwix.org/zim/videos/cest-pas-sorcier_fr_energie_2026-11.zim) (1.1G)
- [cest-pas-sorcier_fr_agronomie_2026-11.zim](https://download.kiwix.org/zim/videos/cest-pas-sorcier_fr_agronomie_2026-11.zim) (4.9G)
- [cest-pas-sorcier_fr_all_2026-11.zim](https://download.kiwix.org/zim/videos/cest-pas-sorcier_fr_all_2026-11.zim) (45G)
- [universcience-tv_fr_all_2026-10.zim](https://download.kiwix.org/zim/videos/universcience-tv_fr_all_2026-10.zim) (37G)
- [la-chaine-de-maths-et-tiques_fr_all_2026-10.zim](https://download.kiwix.org/zim/videos/la-chaine-de-maths-et-tiques_fr_all_2026-10.zim) (14G)
- [mooc-energie-climat_fr_all_2026-08.zim](https://download.kiwix.org/zim/videos/mooc-energie-climat_fr_all_2026-08.zim) (265M)
- [dirtybiology_fr_all_2026-10.zim](https://download.kiwix.org/zim/videos/dirtybiology_fr_all_2026-10.zim) (4.5G)
- [e-penser_fr_all_2026-08.zim](https://download.kiwix.org/zim/videos/e-penser_fr_all_2026-08.zim) (6.6G)
- [micmaths_fr_all_2026-08.zim](https://download.kiwix.org/zim/videos/micmaths_fr_all_2026-08.zim) (2.8G)

TED by topic (`https://download.kiwix.org/zim/ted/`, subtitles in many languages): `ted_mul_medicine`, `ted_mul_public-health`, `ted_mul_natural-disaster`, `ted_mul_water`, `ted_mul_food`, `ted_mul_agriculture`, `ted_mul_farming`, `ted_mul_energy`, `ted_mul_engineering`, `ted_mul_kids`, `ted_mul_war`, `ted_mul_refugees`, `ted_mul_mental-health`, `ted_mul_parenting`.

**Creative Commons talks outside YouTube.**

- media.ccc.de: all talks of the Chaos Communication Congress, CC BY 4.0 by default. API: `https://media.ccc.de/public/events/search?q=<name>`.
- Joscha Bach at CCC (reference build, 7 talks):
  - https://cdn.media.ccc.de/congress/2024/h264-sd/38c3-122-eng-deu-pol-Self_Models_of_Loving_Grace_sd.mp4
  - https://cdn.media.ccc.de/congress/2018/h264-sd/35c3-10030-eng-deu-fra-The_Ghost_in_the_Machine_sd.mp4
  - https://cdn.media.ccc.de/congress/2015/h264-sd/32c3-7483-en-de-Computational_Meta-Psychology_sd.mp4
  - https://cdn.media.ccc.de/congress/2013/mp4-lq/30c3-5526-en-How_to_Build_a_Mind_h264-iprod.mp4
  - https://cdn.media.ccc.de/congress/2014/h264-sd/31c3-6573-en-de-From_Computation_to_Consciousness_sd.mp4
  - https://cdn.media.ccc.de/congress/2023/h264-sd/37c3-12167-eng-deu-fra-Synthetic_Sentience_sd.mp4
  - https://cdn.media.ccc.de/congress/2016/h264-sd/33c3-8369-eng-deu-fra-Machine_Dreams_sd.mp4

**YouTube channels with CC BY videos** (checked per video on 2026-11-21):

- Open Source Ecology, Marcin Jakubowski: https://www.youtube.com/@marcinose (3,123 videos, about 985 hours. The reference build takes 150 practical videos.)

**Speakers on systems, civilisation and the mind.** These recordings have the standard YouTube licence. List them as links. Download only for private use (section 19.2). Ask the channel owners before you add them to a public pack.

Daniel Schmachtenberger, most viewed long recordings:

- Daniel Schmachtenberger: Steering Civilization Away from Self-Destruction / Lex Fridman Podcast #191 (Lex Fridman, 4.3 h): https://www.youtube.com/watch?v=hGRNUw559SE
- The War on Sensemaking, Daniel Schmachtenberger (Rebel Wisdom, 1.8 h): https://www.youtube.com/watch?v=7LqaotiGWjQ
- Daniel Schmachtenberger: "A Vision for Betterment" / The Great Simplification 126 (Nate Hagens, 3.3 h): https://www.youtube.com/watch?v=tmusbHBKW84
- Daniel Schmachtenberger: "Artificial Intelligence and The Superorganism" / The Great Simplification (Nate Hagens, 3.2 h): https://www.youtube.com/watch?v=_P8PLHvZygo
- Daniel Schmachtenberger on The Portal (with host Eric Weinstein), Ep. #027 - On Avoiding Apocalypses (Eric Weinstein, 3.6 h): https://www.youtube.com/watch?v=_b4qKv1Ctv8
- DarkHorse Podcast with Daniel Schmachtenberger & Bret Weinstein (Bret Weinstein, 3.2 h): https://www.youtube.com/watch?v=YPJug0s2u4w
- Daniel Schmachtenberger l An introduction to the Metacrisis l Stockholm Impact/Week 2023 (Norrsken, 0.8 h): https://www.youtube.com/watch?v=4kBoLVvoqVY
- Moloch, AI & Capitalism: The System Eating Itself / Daniel Schmachtenberger & Liv Boeree (Liv Boeree, 1.5 h): https://www.youtube.com/watch?v=KCSsKV5F4xc
- The Psychological Drivers of the Metacrisis: John Vervaeke Iain McGilchrist Daniel Schmachtenberger (The Consilience Project, 3.4 h): https://www.youtube.com/watch?v=-6V0qmDZ2gg
- Game Theory, False Narratives, Survival, Life Advice - Daniel Schmachtenberger / BSP# 20 (Before Skool, 3.7 h): https://www.youtube.com/watch?v=LSx8j8lSewA
- Neurohackers Advice on What We Must Do to Stop the End of Civilization / Daniel Schmachtenberger (Tom Bilyeu, 1.8 h): https://www.youtube.com/watch?v=db-Xn2gzGxU
- Daniel Schmachtenberger / Reality, Meaning & Self-Development / Modern Wisdom Podcast 179 (Chris Williamson, 1.5 h): https://www.youtube.com/watch?v=tJQac_T_rPo
- The Dark Side of Conscious Ai / Daniel Schmachtenberger (Curt Jaimungal, 4.3 h): https://www.youtube.com/watch?v=g7WtcTATa2U
- War on Sensemaking V, Daniel Schmachtenberger (Rebel Wisdom, 1.5 h): https://www.youtube.com/watch?v=0v5RiMdSqwk
- The Wide Boundary Impacts of AI with Daniel Schmachtenberger / TGS 132 (Nate Hagens, 1.8 h): https://www.youtube.com/watch?v=1NFuddEAi5s
- War on Sensemaking II, Daniel Schmachtenberger (Rebel Wisdom, 1.6 h): https://www.youtube.com/watch?v=9QGrffjOFko
- In Search of the Third Attractor, Daniel Schmachtenberger (part 1) (Rebel Wisdom, 2.8 h): https://www.youtube.com/watch?v=8XCXvzQdcug
- Saving Civilization: Healthcare, Tech, Democracy (w/Daniel Schmachtenberger) (Zubin, 2.6 h): https://www.youtube.com/watch?v=_7aIgHoydP8
- Daniel Schmachtenberger „Nicht zerbrechen, sondern biegen, Teil 1: Energie-Blindheit“ / The Great... (Nate Hagens, 1.5 h): https://www.youtube.com/watch?v=3bxzo79SjpE
- Making Sense of Sensemaking: Daniel Schmachtenberger, Jamie Wheal, Jordan Hall (Rebel Wisdom, 2.7 h): https://www.youtube.com/watch?v=8Es_WTEgZHE
- The Metacrisis: Making Sense in a Nonsensical World with Daniel Schmachtenberger & Thomas Ermacora (Harvest Series, 1.3 h): https://www.youtube.com/watch?v=6aKI2C61jVE
- Daniel Schmachtenberger’s talk at Emergence (John B, 0.4 h): https://www.youtube.com/watch?v=eh7qvXfGQho
- How To Survive The Age Of Artificial Intelligence w/ Daniel Schmachtenberger (Aubrey Marcus, 2.3 h): https://www.youtube.com/watch?v=p4NlLuNj0v8
- Warum chronische Krankheiten explodieren! / Daniel Schmachtenberger (Mark Hyman, MD, 1.3 h): https://www.youtube.com/watch?v=JTz4Mncy1u0
- Daniel Schmachtenberger – Developing a Deeper Understanding of Life (Deep Transformation Podcast, 2.1 h): https://www.youtube.com/watch?v=iAcB0yBtXLM

Joscha Bach, most viewed long recordings:

- Joscha Bach: Artificial Consciousness and the Nature of Reality / Lex Fridman Podcast #101 (Lex Fridman, 3.0 h): https://www.youtube.com/watch?v=P-2P3MSZrBM
- Joscha Bach: Nature of Reality, Dreams, and Consciousness / Lex Fridman Podcast #212 (Lex Fridman, 3.2 h): https://www.youtube.com/watch?v=rIpUf-Vy2JA
- Joscha Bach: Life, Intelligence, Consciousness, AI & the Future of Humans / Lex Fridman Podcast #392 (Lex Fridman, 2.9 h): https://www.youtube.com/watch?v=e8qJsk1j2zE
- We exist inside the story that the brain tells itself (Joscha Bach) / AI Podcast Clips (Lex Fridman, 0.4 h): https://www.youtube.com/watch?v=tyrPMVMb-Uw
- Joscha Bach: Time, Simulation Hypothesis, Existence (Curt Jaimungal, 3.2 h): https://www.youtube.com/watch?v=3MNBxfrmfmI
- Your Future & Reality Will Change Forever: AI, God, Consciousness & Simulation Theory / Joscha Bach (Tom Bilyeu, 3.0 h): https://www.youtube.com/watch?v=xhcLsJjy-gc
- Donald Hoffman Λ Joscha Bach: Consciousness, Gödel, Reality (Curt Jaimungal, 2.3 h): https://www.youtube.com/watch?v=bhSlYfVtgww
- Joscha Bach - Why Your Thoughts Aren't Yours. (Machine Learning Street Talk, 1.9 h): https://www.youtube.com/watch?v=3MkJEGE9GRY
- Michael Levin Λ Joscha Bach: Collective Intelligence (Curt Jaimungal, 1.9 h): https://www.youtube.com/watch?v=kgMFnfB5E_A
- Why Consciousness Might Not Be Hard At All (Joscha Bach) (Machine Learning Street Talk, 1.6 h): https://www.youtube.com/watch?v=yW_ngvMFlYs
- A Cognitive Scientist’s Guide to Consciousness & The Illusion of Reality / Joscha Bach (André Duqum, 1.5 h): https://www.youtube.com/watch?v=HTCRIX3P32M
- Joscha Bach Λ John Vervaeke: Mind, Idealism, Computation (Curt Jaimungal, 3.0 h): https://www.youtube.com/watch?v=rK7ux_JhHM4
- Joscha Bach PUSHES Roman Yampolskiy: Only ASI Can Save Us! (Dr Brian Keating and The Roman Forum with Roman Yampolskiy, 1.1 h): https://www.youtube.com/watch?v=ayW7SDyAjZo
- Joscha Bach Λ Ben Goertzel: Conscious Ai, LLMs, AGI (Curt Jaimungal, 2.0 h): https://www.youtube.com/watch?v=xw7omaQ8SgA
- Simulation #409 Dr. Joscha Bach - Conscious Machines (Simulation, 1.7 h): https://www.youtube.com/watch?v=0KD2N6jmD4w
- This is the dawn of machine consciousness / Joscha Bach FULL INTERVIEW (The Institute of Art and Ideas, 0.6 h): https://www.youtube.com/watch?v=Y1QOf6HEbHQ
- Joscha Bach Λ Karl Friston: Ai, Death, Self, God, Consciousness (Curt Jaimungal, 2.6 h): https://www.youtube.com/watch?v=CcQMYNi9a2w
- Deepfaking the Human Mind / feat. Joscha Bach (AM I?, 0.4 h): https://www.youtube.com/watch?v=SGZ784mBuU0
- "We Are All Software" - Joscha Bach (Machine Learning Street Talk, 1.0 h): https://www.youtube.com/watch?v=34VOI_oo-qM
- Joscha Bach: Consciousness, Artificial Intelligence, and the Threat of AI Apocalypse (Robinson Erhardt, 2.3 h): https://www.youtube.com/watch?v=XcNlv9gp20o
- Joscha Bach on the Bible, emotions and how AI could be wonderful. (Vance Crowe, 1.8 h): https://www.youtube.com/watch?v=4H1L2Bpltbs
- From Language to Consciousness  (Guest: Joscha Bach) (The Computing Brain, 2.3 h): https://www.youtube.com/watch?v=ApHnqHfFWBk
- Joscha Bach and Connor Leahy [HQ VERSION] (Machine Learning Street Talk, 1.5 h): https://www.youtube.com/watch?v=Z02Obj8j6FQ
- Joscha Bach—Is AI Risk Real? (The Inside View, 2.9 h): https://www.youtube.com/watch?v=YeXHQts3xYM
- Joscha Bach: "You Are Not Who You Think You Are!" (Dr Brian Keating, 1.5 h): https://www.youtube.com/watch?v=7bqdPHLIY8w

Open text sources for these themes. Read their terms before you copy:
- The Consilience Project: https://consilienceproject.org/
- Civilization Emerging: https://civilizationemerging.com/
- Joscha Bach: http://bach.ai/
- The Great Simplification (Nate Hagens): https://www.thegreatsimplification.com/ (blocks scripts, use a browser)


---

## 30. Household essentials

An independent review with a second AI model (Codex) on 2026-11-21 found these gaps. We checked every link below on the same day.
- "PDF" means that the link answered with a PDF file.
- "page" means an HTML page. Save it as PDF (section 22).
- "browser" means that the server blocks scripts. Open it in a real browser.
- Redistribution rights are **not verified** unless a licence is named. Use these items for the household's own disk. Ask the publisher before you share them.

Most examples come from one country. Each row says what to look for in the user's own country.

### 30.1 Water, sanitation and food safety

| Need | Example source | Link | Status | Look for at home |
|---|---|---|---|---|
| Boil-water notice versus do-not-consume notice | Irish Water | `https://www.water.ie/help/water-quality/do-not-consume-notice` | page | The local water utility's notice types |
| Household water treatment after disasters | WHO technical note | `https://www.who.int/publications/m/item/household-water-treatment-and-safe-storage-following-emergencies-and-disasters` | page with PDF, about 0.8 MB | — |
| Water treatment basics | CDC | `https://www.cdc.gov/water-emergency/about/` | browser | — |
| Toilets and wastewater when pumps stop | Helsinki Region Environmental Services (HSY) | `https://www.hsy.fi/en/water-and-sewers/tips-for-water-use/preparing-for-power-outages/` | page | The local sewer operator's advice. Flats can have water while wastewater pumps are down |
| Home food preservation | UK government guidance | `https://www.gov.uk/guidance/consumer-advice-for-food-preservation-at-home` | page, Open Government Licence v3.0 | The national food-safety authority |

Rule: boiling does not make water with fuel or chemicals safe. Print this next to the water-point map from section 23.

### 30.2 Medicines, devices and first aid

| Need | Source | Link | Status |
|---|---|---|---|
| Patient leaflet for each medicine the household takes | EMA links to the national registers of authorised medicines | `https://www.ema.europa.eu/en/medicines/national-registers-authorised-medicines` | page |
| Example of a product information PDF (insulin) | EMA, Lantus | `https://www.ema.europa.eu/en/medicines/human/EPAR/lantus` | page with PDF |
| Power-failure plan for home medical devices | US FDA workbook | `https://www.fda.gov/media/80782/download` | PDF, about 5 MB |
| Resuscitation and choking, for bystanders | European Resuscitation Council, "Guidelines for Everyone" | `https://www.erc.edu/download-centre/` | page. Free for educational use, per the review |

Rules for the agent:
1. Ask the user which medicines and medical devices the household depends on. Do not store the answers outside the encrypted container (section 9.6).
2. For each medicine, save the patient leaflet for the exact product, strength and language.
3. Prepare a blank paper form: medicine, dose, pharmacy, refill contact, storage. The user fills it in by hand.
4. For each device, the user records battery runtime, supplier and backup plan with the care team.

### 30.3 Heat and cold

| Need | Source | Link | Status |
|---|---|---|---|
| Keeping warm or cool during a national power outage | UK Chief Medical Officers | `https://www.gov.uk/government/publications/public-health-advice-from-uk-cmos-during-a-national-power-outage/keeping-warm-or-cool-in-extreme-weather-scripts-for-broadcast-media` | page, Open Government Licence v3.0 |

Print a one-page heating sheet: carbon monoxide danger, no grills or generators indoors, one warm room, layers of clothing, the nearest public warm place.

### 30.4 Pregnancy, babies, older people and mental health

| Need | Source | Link | Status |
|---|---|---|---|
| Pregnancy and baby books | HSE Ireland | `https://www2.hse.ie/babies-children/pregnancy-child-books/` | page |
| Infant feeding in emergencies | CDC handouts | `https://www.cdc.gov/infant-feeding-emergencies-toolkit/php/handouts/index.html` | browser |
| Care for a person with dementia | WHO, "iSupport for Dementia" | `https://www.who.int/publications/i/item/9789241515863` | page with PDF, about 7.6 MB, CC BY-NC-SA 3.0 IGO |
| Self-help for stress | WHO, "Doing What Matters in Times of Stress" | `https://www.who.int/publications/i/item/9789240003927` | page with PDF, about 3.2 MB, CC BY-NC-SA 3.0 IGO. Audio exists in several languages |

### 30.5 Communication and accessibility

| Need | Source | Link | Status |
|---|---|---|---|
| Picture board for health needs | ARASAAC (Spanish) | `https://static.arasaac.org/materials/553/es/Castellano_Libro_de_la_Salud.pdf` | PDF, CC BY-NC-SA |
| Preparedness videos in German Sign Language | BBK | `https://www.bbk.bund.de/DE/Service/Gebaerdensprache/DGS-Videos-Ratgeber/dgs-videos-ratgeber_node.html` | page |
| Preparedness guides in Sámi and other languages | DSB Norway | `https://www.dsb.no/en/Safe-everyday-life/Self-preparedness/Self-preparedness-in-several-languages/` | page |
| Finnish guidance with sign-language versions | Suomi.fi | `https://www.suomi.fi/guides/preparedness/checklist?a=cb51&a=f4e6` | page |
| Local public-warning radio, transmitter by transmitter | Krisinformation, Sweden (P4) | `https://www.krisinformation.se/en/get-prepared/stay-informed-in-a-crisis/all-frequencies-for-swedish-radio-p4/` | page |

Add a question to the interview: which sign language or minority language does anyone in the household use?

### 30.6 Official meeting points

Switzerland publishes its emergency meeting points as an open dataset:
- `https://data.geo.admin.ch/api/stac/v0.9/collections/ch.babs.notfalltreffpunkte` (STAC API, JSON)
- `https://www.geo.admin.ch/en/dataset-24012025` (page)

Look for a similar dataset in the user's country. Keep official places apart from OSM points. OSM "shelter" includes simple weather shelters (section 23).

### 30.7 Money, rights, animals and equipment

| Need | Source | Link | Status |
|---|---|---|---|
| Cash and payments when cards fail | De Nederlandsche Bank | `https://www.dnb.nl/en/payments/cash-in-your-emergency-kit/` | browser. Use the amounts only for the Netherlands |
| Rights of victims of crime, by country | European e-Justice Portal | `https://e-justice.europa.eu/topics/your-rights/victims-crime/victims-rights-country_en` | page |
| Pet evacuation plan | Stroud District Council | `https://www.stroud.gov.uk/media/xn5d3qor/pet-preparedness-plan-august-2023.pdf` | PDF |
| Farm animals in extreme weather | UK Defra | `https://www.gov.uk/guidance/keeping-farm-animals-and-horses-in-extreme-weather` | page, Open Government Licence v3.0 |
| Owner manuals for the household's own car and bicycle parts | Manufacturer sites, for example Škoda | `https://www.skoda.co.uk/owners/your-skoda` | page |

### 30.8 Growing food, school and culture

| Need | Source | Link | Status |
|---|---|---|---|
| Vegetable growing calendar (Atlantic climate example) | Teagasc, Ireland | `https://teagasc.ie/crops/horticulture/vegetables/vegetable-publications/` (terms: `https://teagasc.ie/about/corporate-responsibility/terms-of-use/`) | page with PDF, about 5.4 MB. Personal copying only |
| School workbook with answers (example: French year 6 maths) | Sésamath | `https://manuel.sesamath.net/index.php?page=telechargement_6e_cahier_2025` (licence FAQ: `https://manuel.sesamath.net/?page=faq`) | page. GNU FDL or CC BY-SA, per the review |
| Local history photos | Helsinki City Museum | `https://www.helsinginkaupunginmuseo.fi/en/picture-browsery/` | page. CC BY 4.0, per the review |
| Bible in modern English (example of a free sacred text) | Open English Bible | `https://openenglishbible.org/` | page. CC0, per the review |

Look for a growing calendar from the national agricultural advisory service of the user's country. Look for open workbooks for each child's school year.

### 30.9 Maps that people can use

| Need | Source | Link | Status |
|---|---|---|---|
| Desktop GIS to open the raw layers | QGIS | `https://qgis.org/download/` | page. GPL |
| Canary Islands map data | GRAFCAN | `https://www.grafcan.es/servicios/ventas-y-descargas/` | page |
| Flood maps for Ireland | Office of Public Works | `https://www.floodinfo.ie/about_floodmaps/data_available/` | page |

Raw files can pass a checksum test and still be useless without a viewer. Always add a printable local map and a place list (section 26).

### 30.10 Disk security and phones

| Need | Source | Link |
|---|---|---|
| VeraCrypt without installation | VeraCrypt portable mode | `https://veracrypt.io/en/Portable%20Mode.html` |
| Risks of removable media | CISA | `https://www.cisa.gov/sites/default/files/publications/RisksOfPortableDevices.pdf` |
| External storage on iPhone | Apple | `https://support.apple.com/en-gb/guide/iphone/iph95baac91f/26/ios/26` |
| Verify signed Linux images | Debian | `https://www.debian.org/CD/verify` |
| Export and import Kolibri content offline | Kolibri documentation | `https://kolibri.readthedocs.io/en/latest/manage/command_line.html` |
| Ventoy installation (it erases the target stick) | Ventoy | `https://www.ventoy.net/en/doc_start.html` |

Rules for the agent:
1. Test that the encrypted container opens under the user's normal account, without internet.
2. Build every copy for other people from an explicit list. Exclude medical records, credentials, personal maps and logs.
3. Test a large file on the real phone with the real adapter. Some phones need a powered hub.
4. Before Ventoy installs, name the target stick and confirm with the user. Ventoy erases it.
5. Import Kolibri channels once on a clean device without internet, to prove that the export is complete.

---

## 31. Offline operation: scenarios, runbooks and launchers

A disk full of files is not yet a working library. After the outage, nobody can download a missing driver, a Python package or a manual. This section makes sure that every task works from the disk alone.

Source: a scenario review by a second AI model (Codex) on 2026-11-21, plus our own checks. We checked all its links on the same day.

### 31.1 The rule

**No step after the build may need the internet, an app store, a package manager or knowledge that is not written on the disk.**

For every tool on the disk, the agent packs six things:
1. **Installer or portable build** for each operating system in the household. Check the processor type: Intel or Apple silicon Mac, x64 or ARM Windows, x86_64 or ARM Linux.
2. **All dependencies.** Examples: runtime libraries, Python and its wheels, Java, device drivers, game data.
3. **The manual for the same version.** Save it as HTML or PDF. Also save the output of `--help`.
4. **A launcher script** that starts the tool with the right files from the disk. The launcher finds the disk from its own location. It must not depend on a drive letter.
5. **A runbook** in each household language: what you need, which file to open, what you should see, what to do if it fails.
6. **A test result.** Which device, which system version, passed or failed, date.

Unpack all archives at build time. People in a crisis should not need to unzip, untar or install a decompression tool. Keep the original archives too, for repair.

### 31.2 START-HERE folder

Put this at the top of the disk, next to `README.txt`:

```text
NeotopiaOffline/
  START-HERE.html          Language and task chooser. Works offline in any browser
  START-HERE.txt           The same choices as plain text with file paths
  START-HERE/
    <language>/
      01-local-chat.txt             Windows, Intel Mac, Apple silicon, low-memory mode
      02-medical-sources.txt        Find an article. Ask the AI about one passage. Check the source
      03-wikipedia-and-wifi.txt     Open the ZIMs. Make Wi-Fi without a router. Connect phones
      04-android-maps.txt           Install an APK. Import a map. Route to a named hospital
      05-spoken-translation.txt     Record speech. Correct the text. Translate. Reply
      06-addresses-and-maps.txt     Find an address and a help point. Open map layers
      07-radio-and-mesh.txt         Identify the cable. Back up the radio. Flash the board
      08-rescue-boot.txt            Write a boot stick. Boot Linux. Open the library
      09-school-day.txt             Import lessons. Start a class. Resume tomorrow
      10-video-and-audio.txt        Play a lesson. Turn on captions. Go to the next chapter
      11-private-documents.txt      Open the encrypted container. Close it safely
      12-restore-the-library.txt    Restore from the second copy. Verify every file
      13-phone-and-power-bank.txt   Copy the essentials to a phone. Work on battery
      14-welcome.txt                For a new person: medical help, hospital, translation, lessons
      15-offline-game.txt           Start the included game. Save and reopen a world
    launch/                         Tested launcher scripts named in the runbooks
    docs/                           Manuals for the shipped software versions
    print/                          Language chooser, hospital list, maps, quick cards
```

Use language names in their own script: English, Polski, Български, Українська. Print `START-HERE` and keep the paper copy with each disk.

### 31.3 Scenario check

Status after the review on 2026-11-21. "Covered" means the guide already gives a complete procedure.

| # | Scenario | Status | What was missing | Fix (details in 31.4 to 31.7) |
|---|---|---|---|---|
| 1 | Start the AI chat on Windows and Mac | partial | No launcher. No model choice by RAM. The 26B model needs about 24 GB RAM. A 16 GB laptop cannot run it | Launchers in 31.5. Always ship a small model next to the large one |
| 2 | Ask a medical question with a source | missing | The chat has no access to the ZIM files | Manual method in 31.6 |
| 3 | Serve the library to phones without a router | partial | The drill keeps the router on. No hotspot procedure. Port and firewall steps missing | 31.5 and 31.7 |
| 4 | Fresh Android phone: apps and maps | partial | No sideload steps. Map files are zipped | Unzip `.obf` at build time. Runbook 04 |
| 5 | Spoken translation | partial | whisper.cpp ships Windows and Linux builds only. Argos needs Python and many packages | 31.4. Test on a clean computer |
| 6 | Read addresses and help points | partial | No program to read Parquet. QGIS installers not required | DuckDB CLI and QGIS in 31.4. Ready queries |
| 7 | Radio and Meshtastic | partial | No USB cable drivers. No standalone flasher | Drivers and `esptool` in 31.4 |
| 8 | Laptop fails: boot Linux | missing | No ISO on the disk. No Mac image writer. Boot keys unknown | 31.4. Record the boot key of each computer |
| 9 | School day with Kolibri | partial | Lessons not exported. Port 8080 conflicts with Kiwix | Ports in 31.7. Export channels at build time |
| 10 | Video and audiobooks | partial | No desktop player. `.audio.epub` playback untested | VLC in 31.4. Unpack one audiobook to MP3 files and test it |
| 11 | Open the encrypted container elsewhere | partial | VeraCrypt installers missing. Mac needs a FUSE package | 31.4 |
| 12 | Restore from the second copy | missing | Only three files are checked | Verify every file against the final list. 31.8 |
| 13 | Phone and power bank only | partial | No list of what to copy to the phone | Phone copy list: maps, medical ZIM, guides, hospital list, audio |
| 14 | A new person arrives | partial | No task-based start page | `START-HERE` in 31.2 |
| 15 | Start a game offline | missing | Luanti has no game after installation. It asks to download one | Add Minetest Game (31.4) and a saved starter world |

### 31.4 Files to add

All links answered on 2026-11-21. "browser" means that the site blocks scripts.

| Purpose | File | Size | Link |
|---|---|---|---|
| Small AI model for 8–16 GB RAM | `gemma-4-E4B-it-Q4_K_M.gguf` | 5.0 GB | `https://huggingface.co/unsloth/gemma-4-E4B-it-GGUF` |
| Smallest AI model for 4–8 GB RAM | `gemma-4-E2B-it-Q4_K_M.gguf` | 3.1 GB | `https://huggingface.co/unsloth/gemma-4-E2B-it-GGUF` |
| llama.cpp server manual, same version | `tools/server/README.md` at tag `b12032` | small | `https://raw.githubusercontent.com/ggml-org/llama.cpp/b12032/tools/server/README.md` |
| llama.cpp build notes | `docs/build.md` at tag `b12032` | small | `https://raw.githubusercontent.com/ggml-org/llama.cpp/b12032/docs/build.md` |
| Visual C++ runtime for Windows builds, if a test needs it | Microsoft redistributable | about 25 MB | `https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist` |
| Kiwix server manual | HTML | small | `https://kiwix-tools.readthedocs.io/en/latest/kiwix-serve.html` |
| Parquet and CSV reader | DuckDB CLI 2.0.1 | 18–39 MB | `https://github.com/duckdb/duckdb/releases/download/v2.0.1/duckdb-cli-windows-amd64.zip`, `.../duckdb-cli-osx-universal.tar.gz`, `.../duckdb-cli-linux-amd64.tar.gz` |
| Desktop GIS | QGIS standalone installers | 0.6–1.3 GB | `https://qgis.org/download/` |
| Speech to text, Windows and Linux | whisper.cpp binaries (release `b5907`: `whisper-bin-x64.zip` 8 MB, `whisper-bin-ubuntu-x64.tar.gz` 9 MB) | 8–9 MB | `https://github.com/ggml-org/whisper.cpp/releases/tag/b5907` |
| Speech to text, macOS | no ready binary. Build at build time and test. The release has an `xcframework` for developers only | — | `https://github.com/ggml-org/whisper.cpp` |
| Text to speech | Piper | 18–25 MB | `https://github.com/rhasspy/piper/releases` |
| Python for Argos | Python 3.12.10 installers | 27–67 MB | `https://www.python.org/ftp/python/3.12.10/python-3.12.10-amd64.exe`, `.../python-3.12.10-macos11.pkg` |
| Argos offline notes | troubleshooting page | small | `https://argos-translate.readthedocs.io/en/latest/source/troubleshooting.html` |
| Media player | VLC 3.0.23 | 46–58 MB | `https://download.videolan.org/pub/videolan/vlc/3.0.23/win64/vlc-3.0.23-win64.exe`, `https://download.videolan.org/pub/videolan/vlc/3.0.23/macosx/vlc-3.0.23-universal.dmg` |
| PDF and EPUB reader for Windows | SumatraPDF 3.5.2 | about 10 MB | `https://www.sumatrapdfreader.org/dl/rel/3.5.2/SumatraPDF-3.5.2-64-install.exe` |
| EPUB reader for Linux | KOReader AppImage | 38 MB | `https://github.com/koreader/koreader/releases` |
| Unpacking archives on Windows | 7-Zip | about 2 MB | `https://www.7-zip.org/a/7z2501-x64.exe` |
| Encrypted container | VeraCrypt 1.26.31: Windows MSI, Windows portable, Mac DMG for FUSE-T, each with a `.sig` file. FUSE-T 1.2.9 installer for the Mac | 30–40 MB | `https://github.com/veracrypt/VeraCrypt/releases/tag/VeraCrypt_1.26.31`, `https://github.com/macos-fuse-t/fuse-t/releases/tag/1.2.9`, `https://veracrypt.io/en/Downloads.html` |
| ESP32 flasher without Python | esptool 5.6.0 | 59–74 MB | `https://github.com/espressif/esptool/releases/download/v5.6.0/esptool-v5.6.0-windows-amd64.zip`, `...-macos-arm64.tar.gz`, `...-macos-amd64.tar.gz`, `...-linux-amd64.tar.gz` |
| Meshtastic flashing guides | ESP32 and nRF52 pages | small | `https://meshtastic.org/docs/getting-started/flashing-firmware/esp32/cli-script/`, `https://meshtastic.org/docs/getting-started/flashing-firmware/nrf52/drag-n-drop/`, `https://meshtastic.org/docs/getting-started/serial-drivers/` |
| USB serial drivers for radio cables | FTDI, Silicon Labs CP210x, WCH CH34x | small | `https://ftdichip.com/Drivers/` (browser), `https://www.silabs.com/developer-tools/usb-to-uart-bridge-vcp-drivers` (browser), `https://www.wch-ic.com/downloads/CH341SER_EXE.html` |
| CHIRP first steps | beginner's guide | small | `https://chirpmyradio.com/projects/chirp/wiki/Beginners_Guide` (browser) |
| Linux rescue system | Debian live ISO and its signed checksums | 3–6 GB | `https://www.debian.org/CD/live/`, `https://www.debian.org/CD/verify` |
| Image writer for Mac | balenaEtcher | about 100–150 MB | `https://etcher.balena.io/` |
| Raspberry Pi image and imager | Raspberry Pi OS, Imager | 0.5–3 GB | `https://www.raspberrypi.com/software/` (browser) |
| Kolibri offline import | command-line manual and PDF manual | small | `https://kolibri.readthedocs.io/en/latest/manage/command_line.html`, `https://kolibri.readthedocs.io/en/latest/manage/options_ini.html` |
| Game data for Luanti | Minetest Game, tag `5.8.0` | small | `https://github.com/luanti-org/minetest_game` |
| Java for Intel Macs | Temurin JRE 21, `mac/x64` | about 50 MB | `https://api.adoptium.net/v3/binary/latest/21/ga/mac/x64/jre/hotspot/normal/eclipse` |
| File-check tool for parity data | par2cmdline | small | `https://github.com/Parchive/par2cmdline/releases` |
| Android sideload help | Google help page | small | `https://support.google.com/pixelphone/answer/7391672` |
| OsmAnd import and routing help | OsmAnd docs | small | `https://osmand.net/docs/user/personal/import-export/`, `https://osmand.net/docs/user/navigation/setup/route-navigation/` |

Space: these files add about 10 GB with QGIS, the two small models and one Linux ISO. Budget them before content (section 3).

### 31.5 Launcher templates

The agent writes these files at build time and tests them. Paths follow the folder layout in section 2. Change them if the build uses other names.

**Model choice by memory.** Use the largest model that fits:

| RAM of the computer | Model | Context |
|---|---|---|
| less than 8 GB | E2B, 3.1 GB | `-c 2048` |
| 8 to 23 GB | E4B, 5.0 GB | `-c 4096` |
| 24 GB or more | 26B A4B, 16.9 GB | `-c 8192` |

These limits are estimates. The weakest-computer test decides.

`START-HERE/launch/Chat-Mac.command`:

```bash
#!/bin/bash
# Starts the local AI chat on a Mac. Double-click in Finder.
D="$(cd "$(dirname "$0")/../.." && pwd)"
if [ "$(uname -m)" = "arm64" ]; then B="$D/08_software/llama.cpp/macos-arm64"; else B="$D/08_software/llama.cpp/macos-x64"; fi
RAM=$(( $(sysctl -n hw.memsize) / 1073741824 ))
M=""
for pick in "24 gemma-4-26B-A4B-it-UD-Q4_K_M.gguf 8192" "8 gemma-4-E4B-it-Q4_K_M.gguf 4096" "0 gemma-4-E2B-it-Q4_K_M.gguf 2048"; do
  set -- $pick
  if [ "$RAM" -ge "$1" ] && [ -f "$D/05_ai_model/$2" ]; then M="$2"; C="$3"; break; fi
done
if [ -z "$M" ]; then echo "No model fits this computer. Use Kiwix instead."; read -r; exit 1; fi
echo "RAM: ${RAM} GB. Model: $M. Loading can take several minutes."
xattr -dr com.apple.quarantine "$B" 2>/dev/null
( for i in $(seq 1 300); do
    curl -sf -o /dev/null http://127.0.0.1:8081/health && { open "http://127.0.0.1:8081"; exit 0; }
    sleep 2
  done ) &
"$B/llama-server" -m "$D/05_ai_model/$M" -c "$C" --host 127.0.0.1 --port 8081
```

The `/health` address answers with an error while the model loads. The browser opens only when the model is ready.

On Windows, write three launchers with fixed models: `Chat-Windows-small.cmd` (E2B), `Chat-Windows-medium.cmd` (E4B) and `Chat-Windows-large.cmd` (26B). The runbook tells the user how to find the RAM: Settings, System, About, "Installed RAM". Template for the medium one:

```bat
@echo off
rem Starts the local AI chat on Windows with the medium model. Double-click.
set "D=%~dp0..\.."
set "B=%D%\08_software\llama.cpp\win-cpu-x64"
set "M=%D%\05_ai_model\gemma-4-E4B-it-Q4_K_M.gguf"
if not exist "%M%" (echo The medium model is not on this disk. Use Chat-Windows-small.cmd. & pause & exit /b 1)
start "" powershell -NoProfile -WindowStyle Hidden -Command "for($i=0;$i -lt 300;$i++){try{if((Invoke-WebRequest -UseBasicParsing http://127.0.0.1:8081/health).StatusCode -eq 200){Start-Process http://127.0.0.1:8081;break}}catch{};Start-Sleep 2}"
"%B%\llama-server.exe" -m "%M%" -c 4096 --host 127.0.0.1 --port 8081
pause
```

Notes:
- `--host 127.0.0.1` keeps the chat on this computer. To let phones on the home network use the chat, change it to `--host 0.0.0.0`. Do this only in a trusted network. The server has no password by default.
- If the chat does not start, the most common causes are: too little RAM, a wrong processor build, or a missing runtime library. The runbook lists these in this order.

`START-HERE/launch/Serve-Library.command` (Mac and Linux):

```bash
#!/bin/bash
# Serves all ZIM files to phones and laptops on the local network.
D="$(cd "$(dirname "$0")/../.." && pwd)"
shopt -s nullglob
S="$D/08_software/kiwix"
if [ "$(uname)" = "Darwin" ]; then
  if [ "$(uname -m)" = "arm64" ]; then K="$S/kiwix-tools-macos-arm64"; else K="$S/kiwix-tools-macos-x64"; fi
  IP=""; for i in $(ifconfig -l); do a=$(ipconfig getifaddr "$i" 2>/dev/null); [ -n "$a" ] && IP="$IP $a"; done
else
  case "$(uname -m)" in aarch64|arm64) K="$S/kiwix-tools-linux-arm64" ;; *) K="$S/kiwix-tools-linux-x64" ;; esac
  IP=$(hostname -I)
fi
for a in $IP; do echo "On each phone, open: http://$a:8080"; done
"$K/kiwix-serve" --port 8080 "$D"/03_zim/*.zim "$D"/03_zim/*/*.zim
```

On Windows, build a library file once at build time with `kiwix-manage library.xml add <file.zim>` for each file. Then start `kiwix-serve.exe --library --port 8080 library.xml`. Check that the paths in `library.xml` still work after the drive letter changes. If they do not, regenerate the file with a launcher at start.

### 31.6 Medical answers with a source

The chat model does not read the ZIM files. It answers from its own training. Its answers can be wrong. Use this method until a search tool is added:
1. Search the medical ZIM in Kiwix. Open the article.
2. Copy the relevant paragraph.
3. Paste it into the chat with the question. Write: "Answer only from this text. Name the sentence that supports the answer."
4. Compare the answer with the article. The article wins.

Add this method to runbook 02 and to the print pack. Test it in the drill (section 27.4, task 7).

A fully automatic method needs a search index of the ZIM text and a program that passes the found passages to the model. The upstream Lastbook app has such a function for its own library. A future app can bring it later. Do not promise it on a self-built disk.

### 31.7 Network and ports

| Service | Port | Address on phones |
|---|---|---|
| Kiwix library | 8080 | `http://<laptop-address>:8080` |
| AI chat | 8081 | `http://<laptop-address>:8081` (only with `--host 0.0.0.0`) |
| Kolibri | 8082 | set `HTTP_PORT = 8082` under `[Deployment]` in Kolibri's `options.ini` |

**Wi-Fi without a router.** The router may have no power. Options, in order:
1. **Phone hotspot.** Turn mobile data off. Turn the hotspot on. Join the laptop and the other phones. Some phones block traffic between clients. Test this at build time.
2. **Laptop hotspot.** Windows has "Mobile hotspot" in the settings. A Linux laptop can share Wi-Fi with NetworkManager. Test with the real laptop.
3. **Raspberry Pi access point.** Prepare and test the image at build time.

On the laptop, allow the server through the firewall for private networks. Phones may warn "no internet". Tell people to stay connected.

### 31.8 Restore and handover test

**Restore.** After the build is complete, write `EXPECTED-FILES.tsv` with the path, size and SHA-256 of every file, including runbooks, launchers and generated maps. To restore: copy the second disk to a blank disk, then check every line of the list. Report missing and changed files by name. Then open one ZIM from the restored copy. On Windows, PowerShell `Get-FileHash` computes the same SHA-256 values.

**Handover test.** Give the second copy to a person who did not build it. Switch the router off. Use a fresh user account on each test device. The person works only from `START-HERE`. Write down the first step where they need help. Fix that step on the disk. Repeat.

---

## 32. European crisis cards and the emergency page

Source: a review with a third AI model (Gemini, through Antigravity CLI) on 2026-11-21. We checked the links.

### 32.1 One emergency page at the top of the disk

Write `EMERGENCY.html` at the top of the disk, next to `START-HERE.html`. It opens in any browser without a server. It has no links to programs. Content, in the household languages:
- bleeding, CPR, choking, burns, poisoning,
- safe water in one table,
- the national alarm signals,
- emergency numbers, the poison-control number, the nearest hospital with address.

Rules:
1. Take every instruction and every number from a document on the disk. Name the document and page under each block.
2. Use large type (16 point or more), high contrast and short lines.
3. Print the same page. Laminate it if possible.
4. Make an audio version for people who cannot read it. Piper (section 20) can read the text aloud. Test the voice for each language.

### 32.2 Cards for the print pack

Add these cards to `13_print_first/`. Fill them only from national or international sources on the disk. Do not write numbers or procedures from memory.

| Card | Content | Where to find the source |
|---|---|---|
| Alarms and numbers | National siren signals and their meaning. The name of the national phone alert system and how to turn it on. Emergency numbers besides 112. Poison-control number | National guide (section 16). Examples of phone alert names: NL-Alert, FR-Alert, IT-alert, ES-Alert, RO-ALERT, Alert RCB (PL). Check the name and the phone settings for the country |
| Radiation and nuclear accident | Go in, stay in, tune in. Sealing a room. Cleaning after exposure. Iodine tablets only on official instruction | National guide. WHO guideline on iodine thyroid blocking (2017): `https://www.who.int/publications/i/item/9789241550185` |
| Armed conflict and unexploded ammunition | Shelter rules, the "two walls" rule, what to do during shelling. Do not touch, mark, report | National guide (PL, SE, FI, LT, LV, EE, SK guides cover war). For mines in the Balkans and Ukraine, use the national mine-action authority |
| Crossing a border | ID or passport rules, consent for children travelling with one parent, motor insurance (Green Card), pet passport and rabies record, European Health Insurance Card, embassy addresses in neighbour countries, Red Cross family tracing, small cash in two currencies | Government travel pages of the country. Red Cross Restoring Family Links |
| US to European conversion | Mains voltage 230 V and wire colours (brown, blue, green-yellow). Metric and US units. US drug names and European names (example: acetaminophen = paracetamol). Radio rules differ (section 9.4) | Use when a source on the disk is from the USA (many ZIM files, FEMA, CDC) |
| Power, cold and shared devices | Airplane mode, low brightness, dark mode. Warm lithium batteries above 0 °C before charging. Who may write to the disk. Eject before unplug | Device manuals. Section 27 |

### 32.3 Languages of people in the household

The scope excludes country packs for Russia and Belarus. It does not exclude languages. If a person in the household reads Russian, Arabic or another language, add the Wikipedia, Wiktionary and Argos packs for that language (sections 15 and 20).

---

## 33. Rebuilding knowledge for years, not days

Most of this guide helps for days and weeks. These sources help for years. Budget 1 to 3 GB in tier M and more in tier L. We checked that the home pages answered on 2026-11-21. Redistribution terms are **not verified** unless named.

| Topic | Source | Link | Notes |
|---|---|---|---|
| Clinical medicine with European drug names | MSF Medical Guidelines (clinical, essential drugs, obstetrics) | `https://medicalguidelines.msf.org/` | Free online. Check the download and reuse terms |
| Medicine without a doctor | Hesperian Health Guides ("Where There Is No Doctor", "Where Women Have No Doctor", dentist and others) | `https://hesperian.org/` | Ask Hesperian before you share copies |
| Humanitarian minimum standards: water, food, shelter, health | Sphere Handbook | `https://spherestandards.org/handbook/` | browser |
| Low-tech energy, heat and tools | Low-tech Magazine (solar web site) | `https://solar.lowtechmagazine.com/` | Check the licence on the site |
| Appropriate technology | Appropedia ZIM | section 6.1 | CC BY-SA |
| Food growing and storage | FAO publications, national agricultural advisory services | `https://www.fao.org/publications/` | Many FAO titles are CC BY-NC-SA 3.0 IGO. Check each |
| Plants and mushrooms | A national field guide in the local language | — | Mushroom identification from a book alone is dangerous. Add a clear warning |
| Old practical books | Project Gutenberg parts `lcc-s` (agriculture) and `lcc-t` (technology) | section 28.2 | Historical. Check against modern safety rules |
| Law and rights | The national constitution, the EU Charter of Fundamental Rights, a summary of the Geneva Conventions | national law portal, `https://eur-lex.europa.eu/`, ICRC | Public texts |
| Community organisation | A local plan for a community hub, shared kitchens, fair sharing of food and water | the municipality's crisis plan | Ask the municipality |

**Metric reference tables.** A one-file PDF with screw threads, cable sizes for 230 V, resistor colour codes, wood spans and other workshop tables is useful. Build it only from published sources and name them. Do not compute safety values yourself.

**Seeds.** Open-pollinated seeds can be saved and sown again. Hybrid seeds often cannot. Include a seed-saving guide for the local climate.
