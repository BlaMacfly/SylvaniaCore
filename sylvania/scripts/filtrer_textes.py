#!/usr/bin/env python3
# Retire d'un portage les creature_text des PNJ a script C++ (numerotation des groupes differente de LegionCore).
import re
import subprocess
import sys

port, scripts = sys.argv[1], sys.argv[2:]
scripted = set()
for f in scripts:
    for l in open(f, encoding="utf-8"):
        m = re.search(r"SET `?ScriptName`?\s*=\s*'([^']+)'.* WHERE `?entry`?\s*(?:=\s*(\d+)|IN \(([\d, ]+)\))", l)
        if m:
            scripted |= {int(x) for x in re.findall(r"\d+", m.group(2) or m.group(3))}
out = subprocess.run(["mysql", "-N", "dc_world", "-e", "SELECT entry FROM creature_template WHERE ScriptName<>''"], capture_output=True, text=True).stdout
scripted |= {int(x) for x in out.split()}
keep, drop = [], 0
for l in open(port, encoding="utf-8").read().split("\n"):
    m = re.match(r"INSERT INTO `creature_text` .*? VALUES \((\d+),", l)
    if m and int(m.group(1)) in scripted:
        drop += 1
        continue
    keep.append(l)
open(port, "w", encoding="utf-8").write("\n".join(keep))
print("textes ecartes (PNJ a script C++) :", drop)
