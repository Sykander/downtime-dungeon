# Development
# a117e4f1-951f-4f6c-bf4a-c8eb948d1ad0
# Production
# c7a510b3-3bf4-47f4-b6fa-3f12416284b7

using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    encounters = env.get_gvar_id_by_name("encounters"),
    random = env.get_gvar_id_by_name("random"),
    map_picker = env.get_gvar_id_by_name("map_picker"),
    special_floors = env.get_gvar_id_by_name("special_floors"),
    server_config = env.get_gvar_id_by_name("server_config"),
    npcs = env.get_gvar_id_by_name("npcs")
)

SPECIAL_FLOOR_LIST = server_config.get_special_floors_list(special_floors.special_floors_list)

def get_available_special_floors(floors: list[object], dungeon_data: object) -> list[object]:
    return [floor for floor in floors if floor["requirement"](dungeon_data)]

def get_floor_data(dungeon_data) -> dict:
    oldState = random.getState()
    random.setSeed(dungeon_data["floor_seed"])
    floor_num = dungeon_data["floor_num"]
    seed = dungeon_data["floor_seed"]

    floor_data = {
        "floor_num": floor_num,
        "seed": seed,
        "encountered_monsters": False,
        "monsters": None,
        "encountered_special_floor": False,
        "special_floor": False,
        "encountered_npc": False,
        "npc_events": [],
        "cr": None,
        "map": None
    }

    cr = floor(server_config.get_cr(dungeon_data))
    floor_data["cr"] = cr

    encountered_special_floor = server_config.get_is_special_floor(dungeon_data)
    encountered_monsters = not encountered_special_floor
    encountered_primary_npc = server_config.get_has_primary_npc(dungeon_data)
    encountered_secondary_npc = server_config.get_has_secondary_npc(dungeon_data)

    map = map_picker.pick_map(seed)
    floor_data["map"] = map

    if encountered_special_floor:
        available_special_floors = get_available_special_floors(SPECIAL_FLOOR_LIST, dungeon_data)
        special_floor_index = random.get_random_integer(0, len(available_special_floors) - 1)
        floor_data["special_floor"] = available_special_floors[special_floor_index]
        floor_data['encountered_special_floor'] = True
    elif encountered_monsters:
        monsters = encounters.generate_encounter(cr, seed)
        floor_data["monsters"] = monsters
        floor_data["encountered_monsters"] = True

    if encountered_primary_npc and encountered_monsters:
        npc = dungeon_data["npcs"]["primary"]
        if not npc["dead"]:
            joins_combat_dialogue_list = npc["goal"]["joins_combat_dialogue_list"]
            combat_dialogue_index = random.get_random_integer(0, len(joins_combat_dialogue_list) - 1)
            floor_data["encountered_npc"] = True
            floor_data["npc_events"].append({
                "name": "NPC joins combat",
                "desc": f"""**{npc["full_name"]}** {joins_combat_dialogue_list[combat_dialogue_index]}""",
                "does_special_action": True,
                "npc": npc
            })

    if encountered_secondary_npc and encountered_monsters:
        npc = dungeon_data["npcs"]["secondary"]
        if not npc["dead"]:
            joins_combat_dialogue_list = npc["goal"]["joins_combat_dialogue_list"]
            combat_dialogue_index = random.get_random_integer(0, len(joins_combat_dialogue_list) - 1)
            floor_data["encountered_npc"] = True
            floor_data["npc_events"].append({
                "name": "NPC joins combat",
                "desc": f"""**{npc["full_name"]}** {joins_combat_dialogue_list[combat_dialogue_index]}""",
                "does_special_action": True,
                "npc": npc
            })

    if (encountered_primary_npc or encountered_secondary_npc) and encountered_special_floor:
        non_combat_events = npcs.non_combat_events
        non_combat_events_len = len(non_combat_events)
        non_combat_events_index = random.get_random_integer(0, non_combat_events_len - 1)
        event = non_combat_events[non_combat_events_index]

        npc = dungeon_data["npcs"]["primary"] if encountered_primary_npc else dungeon_data["npcs"]["secondary"]
        if not npc["dead"]:
            floor_data["encountered_npc"] = True
            floor_data["npc_events"].append({
                "name": "NPC shares their story",
                "desc": event["dialogue"](npc, floor_data, dungeon_data),
                "does_special_action": False,
                "npc": npc
            })

    random.setState(oldState)
    return floor_data