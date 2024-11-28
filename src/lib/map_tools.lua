# Development
# c8d78194-0128-4429-a253-e6a2df36caf2
# Production
# 468bce27-653b-47aa-b8ed-9357196459df

def set_combatant_square(combatant, square):
    update_combatant_note(combatant, location=square)

def parse_map_info(info):
    return {
        f[0].lower(): f[1]
        for f in [i.split(": ") for i in [r for r in info.split(" ~ ")]]
        if len(f) == 2
    }

def get_map_info():
    c = combat()
    for combatant in c.combatants:
        for effect in combatant.effects:
            if effect.name == "map":
                map_info = parse_map_info(effect.attacks[0].attack.automation[0].text)
                return map_info, combatant
    return {}, None

def attach_map_to_combatant(map_state, default_map_combatant = None):
    map_info, map_combatant = get_map_info()

    if not map_combatant:
        map_info, map_combatant = map_state, default_map_combatant

    if not map_combatant:
        missing_map_warning = f"No valid map combatant."
        return False, missing_map_warning

    map_info.update(map_state)
    info_str = " ~ ".join(f"{k.capitalize()}: {v}" for k, v in map_info.items() if v)

    map_combatant.add_effect(
        "map",
        attacks=[
            {
                "attack": {
                    "name": "map",
                    "automation": [{"type": "text", "text": info_str}],
                    "_v": 2,
                }
            }
        ],
    )

    return True, f"Map information attached to {map_combatant.name}"

def parse_note(note):
    if not note:
        return {}
    return {
        item.split(":")[0].lower().strip(): item.split(":")[1].strip()
        for item in note.split("|")
        if ":" in item
    }

def update_combatant_note(combatant, **kwargs):
    note = parse_note(combatant.note)
    note.update(kwargs)
    new_note = " | ".join(f"{k.title()}: {v.strip()}" for k, v in note.items())
    combatant.set_note(new_note)

def generate_map_image(overlays=None, from_state=None):
    c = combat()
    map_url = f"{get('otfbm_base_url', 'http://otfbm.io/')}"

    map_info, map_combatant = get_map_info()

    if from_state != None:
        map_info.update(from_state)

    cell_size = map_info.get("options", get("mapOptions", ""))
    if cell_size:
        map_url += f"@{cell_size}/"

    mapsize = map_info.get("size", get("mapSize", "10x10"))
    map_url += f"{mapsize}"

    combatant_str = ""
    for combatant in c.combatants:
        if combatant.name.lower() not in ["map", "dm", "lair"]:
            note = parse_note(combatant.note)
            location = note.get("location")
            if location:
                size = note.get("size", "M")
                size_letter = size[0].upper()

                color = note.get("color", "b" if "/" in combatant.hp_str() else "r")
                if len(color) in (3, 6) and color.isalnum():
                    color = f"~{color.upper()}"
                else:
                    color = color[0]
                name = combatant.name.replace(" ", "_")

                combatant_str += f"/{location}{size_letter}{color}"
                combatant_str += f"-{name}"

                token = note.get("token")
                if token != None and token != "":
                    combatant_str += f'~{token}'
    if combatant_str:
        map_url += combatant_str

    if overlays:
        # Ensure overlays are prefixed with '*'
        processed_overlays = [f"*{overlay.lstrip('*')}" for overlay in overlays]
        overlays_str = "/".join(processed_overlays)
        map_url += f"/{overlays_str}"

    walls = map_info.get("walls", "").split(", ") if map_info.get("walls") else []
    walls_str = "_".join(walls)
    if walls_str:
        map_url += f"_{walls_str}/"

    objects = map_info.get("objects", "").split("/") if map_info.get("objects") else []
    if objects:
        map_url += "/".join(objects) + "/"

    fow = map_info.get("fow", "").split(", ") if map_info.get("fow") else []
    if fow:
        map_url += "*f" + "/*f".join(fow).replace(":", "") + "/"

    bg_image = map_info.get("background", get("mapBg", ""))
    if bg_image:
        map_url += f"?bg={bg_image.split('?')[0]}"

    loadedjson = map_info.get("json", "").split(", ") if map_info.get("json") else []
    if loadedjson:
        map_url += f"{'&' if '?' in map_url else '?'}load={'&load='.join(loadedjson)}"

    return map_url