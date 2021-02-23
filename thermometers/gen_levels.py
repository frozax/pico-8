import json
from pathlib import Path

final_file = Path("levels.p8")
ffw = final_file.open("wt")
ffw.write("levels = {}\n")

for f, nb in [
    ("5x5_A", 4),
    ("6x6_A", 4),
    ("7x7_A", 4),
    ("8x8_B", 4),
    ("9x9_C", 4)]:
    fname = Path("f:\\tmp\\classic-" + f + ".infos")
    count = 0
    for fline in fname.open('rt'):
        if fline[0] == '{':
            json_data = json.loads(fline)
            lstr = "l = {\n"
            cells = json_data["cells"].split(' ')

            for row in cells:
                lstr += "{"
                for col in row:
                    if col == "G":
                        lstr += "GR"
                    elif col == "T":
                        lstr += "TR"
                    elif col == "Q":
                        lstr += "TE"
                    else:
                        assert False, f"unknown col {col}"
                    lstr += ","
                lstr += "},\n"
            lstr += "}\nadd(levels, l)\n"
            ffw.write(lstr)
            count += 1
            if count >= nb:
                break

ffw.close()