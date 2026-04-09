import re
import os
from pathlib import Path

root = Path('.')
tex_files = list(root.rglob('*.tex'))
bib_file = root / 'referencias.bib'

cite_pattern = re.compile(r"\\(?:cite|parencite|textcite|autocite|citep|citet|footcite)[^\{]*\{([^}]*)\}")
entry_pattern = re.compile(r"@\w+\{\s*([^,\s]+)\s*,")

used_keys = set()
found_nocite_all = False

for tf in tex_files:
    try:
        text = tf.read_text(encoding='utf8')
    except Exception:
        text = tf.read_text(encoding='latin1')
    # detect \nocite{*}
    if re.search(r"\\nocite\s*\{\s*\*\s*\}", text):
        found_nocite_all = True
    for m in cite_pattern.finditer(text):
        keys = m.group(1)
        for k in keys.split(','):
            k = k.strip()
            if k:
                used_keys.add(k)

# Also capture any explicit \nocite{key1,key2}
nocite_pattern = re.compile(r"\\nocite\s*\{([^}]*)\}")
for tf in tex_files:
    try:
        text = tf.read_text(encoding='utf8')
    except Exception:
        text = tf.read_text(encoding='latin1')
    for m in nocite_pattern.finditer(text):
        keys = m.group(1)
        for k in keys.split(','):
            k = k.strip()
            if k and k != '*':
                used_keys.add(k)

# Read bib keys
bib_keys = []
if bib_file.exists():
    txt = bib_file.read_text(encoding='utf8')
    for m in entry_pattern.finditer(txt):
        bib_keys.append(m.group(1).strip())
else:
    print('referencias.bib not found')
    exit(1)

bib_keys_set = set(bib_keys)
unused = sorted(list(bib_keys_set - used_keys))

report = []
report.append(f"Total .bib entries: {len(bib_keys)}")
report.append(f"Citation commands found (unique keys): {len(used_keys)}")
report.append(f"Detected \\nocite{*}: {'Yes' if found_nocite_all else 'No'}")
report.append('')
report.append('Unused .bib entries (present in referencias.bib but not cited in .tex files):')
for k in unused:
    report.append(k)

out = '\n'.join(report)
print(out)
# save report
(Path('scripts') / 'unused_bib_report.txt').write_text(out, encoding='utf8')

# exit code
if unused:
    exit(2)
else:
    exit(0)
