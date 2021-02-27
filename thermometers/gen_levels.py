import json
from pathlib import Path

final_file = Path("levels.p8")
ffw = final_file.open("wt")
ffw.write("""-- levels: auto generated, do not edit
LEFT = 0
RIGHT = 1
DOWN = 2
UP = 3

levels = {}
""")

for f, istart, nb in [
    ("A", 0, 10),
    ("A", 20, 5),
    ("A", 80, 5),
    ("B", 0, 5)]:
    fname = Path("f:\\tmp\\classic-" + f + ".infos")
    count = 0
    for fline in fname.open('rt'):
        if fline[0] == '{':
            json_data = json.loads(fline)
            width = 4
            height = 5
            show_rows_nbs = "true"
            show_cols_nbs = "true"
            thermos_str = ",".join([thermo_str(t) for t in thermos])

            lstr = f"""
    l = \{w={width}, h={height}, show_rows_nbs={show_rows_nbs}, show_cols_nbs={show_cols_nbs},
        thermos=\{{thermos_str}\}
    \}
    add(levels, l)"""

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