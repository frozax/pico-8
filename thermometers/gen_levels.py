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

LEFT, RIGHT, DOWN, UP = range(4)

for f, istart, nb in [
    ("A", 0, 10),
    ("A", 20, 5),
    ("A", 80, 5),
    ("B", 0, 5)]:
    fname = Path("C:\\gamedev\\games\\swg26\\LevelGenerator\\data\\levels_def\\classic-" + f + ".infos")
    count = 0
    for fline in fname.open('rt'):
        if fline[0] == '{':
            json_data = json.loads(fline)

            max_x, max_y = 0, 0
            thermos = []
            th_data = json_data.get("thermos", json_data.get("cells", ""))
            th_data = [int(i) for i in th_data.split()]
            for ithermo in range(th_data[0]):
                x, y, direction, size, fill = th_data[1+ithermo*5:1+ithermo*5+5]
                print(x, y, size, fill, direction)
                thermos.append(f"{{{x}, {y}, {direction}, {size}, {fill}}}")
                max_tx, max_ty = x, y
                if direction == RIGHT:
                    max_tx += size-1
                if direction == DOWN:
                    max_ty += size-1
                max_x = max(max_x, max_tx)
                max_y = max(max_y, max_ty)

            thermos_str = ",".join(thermos)
            lstr = f"""
l = {{w={max_x+1}, h={max_y+1}, hide_rows_nbs={th_data[-2]}, hide_cols_nbs={th_data[-1]},
    thermos={{{thermos_str}}}
}}
add(levels, l)"""

            ffw.write(lstr)
            count += 1
            if count >= nb:
                break

ffw.close()