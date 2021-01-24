from pathlib import Path
import subprocess

print("How to use:")
print(" - Export from within pico-8 with 'export index'")
print(" - Call update_html5.py")

js_to_find = "var key = SDL.lookupKeyCodeForEvent(event);"

js_file = Path("index.js")
js_data = js_file.open("rt").read()
found = js_data.find(js_to_find)
assert found != -1, f"could not find {js_to_find} in {js_file}"
insertion_index = found + len(js_to_find)

js_insertion = """
    // BEGIN FROZAX GAMES CHANGES
    b1 = 99;
    b2 = 118;
    left = 1104;
    right = 1103;
    up = 1106;
    down = 1105;
    menu = 13; // enter
    if (key == 13) key = b1;
    if (key == 32) key = b1;
    // END FROZAX GAMES CHANGES
"""
js_data = js_data[:insertion_index] + js_insertion + js_data[insertion_index:]

new_js_data = js_data.replace("95, 87, 79, ", "/*FROZAX*/67, 82, 61, ", 1)
assert new_js_data != js_data, "could not replace the colors"

js_data = new_js_data.replace("194, 195, 199", "/*FROZAX*/199, 240, 216", 1)
assert new_js_data != js_data, "could not replace the colors"

js_file.open("wt").write(js_data)

subprocess.open("index.html", shell=True)


#rem 95, 87, 79 is fg => 67, 82, 61
#rem 194, 195, 199 is bg => 199, 240, 216
