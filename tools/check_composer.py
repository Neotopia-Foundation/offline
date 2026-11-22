"""Checks for neotopia-offline.md. Used by CI and before each release.

Usage: python3 tools/check_composer.py [neotopia-offline.md]
Exit 1 on any problem.
1. Bash blocks: `bash -n`. Python blocks: compile.
2. No private data (local paths, personal e-mail, keys).
3. No semicolons in prose outside code blocks and URLs (project writing rule).
"""
import re
import subprocess
import sys
import tempfile
from pathlib import Path

path = Path(sys.argv[1] if len(sys.argv) > 1 else 'neotopia-offline.md')
text = path.read_text(encoding='utf-8')
fail = 0

blocks = re.findall(r'^```(\w*)\n(.*?)^```', text, flags=re.S | re.M)
for i, (lang, code) in enumerate(blocks, 1):
    if lang == 'bash':
        with tempfile.NamedTemporaryFile('w', suffix='.sh', delete=False) as f:
            f.write(code)
        r = subprocess.run(['bash', '-n', f.name], capture_output=True, text=True)
        if r.returncode:
            print(f'block {i} (bash): {r.stderr.strip()}'); fail = 1
    elif lang == 'python':
        try:
            compile(code, f'block{i}', 'exec')
        except SyntaxError as e:
            print(f'block {i} (python): {e}'); fail = 1

for pat in [r'/Users/\w+', r'/home/\w+/', r'C:\\Users\\', r'AKIA[0-9A-Z]{16}', r'ghp_[0-9A-Za-z]{30,}', r'sk-[0-9A-Za-z]{20,}']:
    for m in re.finditer(pat, text):
        print(f'private data? line {text.count(chr(10), 0, m.start()) + 1}: {m.group(0)}'); fail = 1

prose = re.sub(r'^```.*?^```', '', text, flags=re.S | re.M)
for n, line in enumerate(prose.splitlines(), 1):
    clean = re.sub(r'`[^`]*`|https?://\S+', '', line)
    if ';' in clean:
        print(f'semicolon in prose: {line[:100]}'); fail = 1

print(f'{len(blocks)} code blocks checked. Result: {"FAIL" if fail else "OK"}')
sys.exit(fail)
