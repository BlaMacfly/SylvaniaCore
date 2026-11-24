#!/usr/bin/env python3
"""IDs d'une DB2 (table d'IDs + table de copies). Usage : db2ids.py fichier.db2 > ids.txt"""
import struct
import sys
sys.path.insert(0, "/home/ubuntu")
from db2read import DB2

d = DB2(sys.argv[1], [], [], -1, -1)
ids = set(d.idTable)
# table de copies : juste apres la table d'IDs
p = 84 + d.fieldCount * 4 + d.recSize * d.recCount + d.strSize + d.idTableSize
for k in range(d.copySize // 8):
    new, old = struct.unpack_from("<II", d.buf, p + k * 8)
    ids.add(new)
print("\n".join(map(str, sorted(ids))))
