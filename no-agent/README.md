# Without an agent: Poland, 32 GB drive

[Polska wersja](README.pl.md)

This folder lets you build a basic offline drive for Poland without an AI agent. You run one script. It downloads a fixed list of files.

## What you get

- 51 files, about 15 GB.
- Polish Wikipedia (mini edition), Polish Wiktionary and Polish Wikivoyage.
- English medical and practical libraries: WikiProject Medicine, Wikipedia medicine, Appropedia, and the zimgit water, medicine, food, knots and post-disaster sets.
- Phone maps of Poland for OsmAnd, 16 regions.
- Hospitals (Eurostat GISCO), shelters (dane.gov.pl) and place names (GeoNames).
- The Polish government guide "Bądź gotowy", its English handbook and the EU 72-hour guidelines.
- The smallest local AI model, Gemma 4 E2B. It needs about 4–6 GB RAM.
- Readers for macOS, Windows, Linux and Android: Kiwix, kiwix-serve, llama.cpp, OsmAnd and VLC.

## What you do not get

The agent writes these files. The script does not:

- `START-HERE.html` and the step-by-step runbooks.
- Launchers that pick the AI model by memory.
- The print pack and the offline test.

You do these steps by hand. They are below.

## What you need

- macOS or Linux with `bash` and `curl`. On Windows, use WSL. We have not tested a Windows build.
- Recommended: `aria2c` (`brew install aria2` or `apt install aria2`). With it, Kiwix files of 1 GB or more come over BitTorrent. A BitTorrent client also sends pieces to other people while it downloads.
- A drive with at least 32 GB, formatted as exFAT.

## Steps

1. Download `fetch.sh` and `manifest-pl.tsv` from the [release page](https://github.com/Neotopia-Foundation/offline/releases).
2. Connect the drive. Run the script with the target folder on that drive:

   ```bash
   bash fetch.sh /Volumes/YOUR_DRIVE/NeotopiaOffline manifest-pl.tsv
   ```

   On Linux the drive is usually under `/media/<user>/`.
3. When the script stops, read `_log/failed.tsv` in the target folder. An empty file means that all files arrived. If it has rows, run the same command again. The script skips finished files and resumes broken ones.
4. Unzip the phone maps:

   ```bash
   cd /Volumes/YOUR_DRIVE/NeotopiaOffline/04_maps/osmand_phone
   for f in *.zip; do unzip -o "$f"; done
   ```

5. Check the drive. No output means that all files are good:

   ```bash
   cd /Volumes/YOUR_DRIVE/NeotopiaOffline
   shasum -a 256 -c SHA256SUMS.txt | grep -v ': OK$'
   ```

## How to use the drive

- **Wikipedia and guides.** Install Kiwix for your system from `08_software/Kiwix/`. Open the `.zim` files in `03_zim/`. The PDF guides are in `01_guides/`.
- **Share with phones.** Unpack kiwix-tools for your system. Run `kiwix-serve --port 8080 /path/to/03_zim/*.zim`. Phones on the same Wi-Fi open `http://<laptop-ip>:8080`.
- **Maps.** On Android, install OsmAnd from `08_software/Android/`. Copy the `.obf` files to the phone and open them in OsmAnd. On an iPhone, install OsmAnd from the App Store while you still have internet.
- **AI chat (optional).** Unpack llama.cpp for your system from `08_software/llama.cpp/`. On a Mac, first run `xattr -dr com.apple.quarantine <unpacked folder>`. Then start the chat:

  ```bash
  ./llama-server -m /path/to/05_ai_model/gemma-4-E2B-it-Q4_K_M.gguf -c 2048 --port 8081
  ```

  Open `http://127.0.0.1:8081` in a browser. Loading can take several minutes. The model can be wrong. For first aid, medicines and water, follow the guides on the drive.

## Bigger drive

On a drive of 64 GB or more, add the English Wikipedia (mini edition, about 13 GB). Add this line at the end of `manifest-pl.tsv`. Use a tab between the columns:

```text
03_zim/wikipedia_en_all_mini_2026-09.zim	https://download.kiwix.org/zim/wikipedia/wikipedia_en_all_mini_2026-09.zim	CC BY-SA	
```

For a larger AI model, more countries or other languages, use the agent path in [neotopia-offline.md](../neotopia-offline.md).

## Limits

- The links were checked on 2026-11-24. Publishers replace files often. If a file returns 404, open its folder in a browser and take the newest file with the same name stem. Then change the line in the manifest.
- The script ends with status 0 even when some files failed. Always read `_log/failed.tsv`.
- Private use of all files is allowed. Before you copy the drive for other people, read section 13 of the guide.
