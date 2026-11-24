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
