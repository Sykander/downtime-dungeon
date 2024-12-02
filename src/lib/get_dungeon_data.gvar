# Development
# c6aa3456-83ac-4777-9e5c-524d337f67eb
# Production
# 4091e5d2-6f37-4302-a90b-27065ab989e1

STARTED_KEY = "DowntimeDungeon"
GOLD_KEY = "DowntimeDungeon_gold"
INV_KEY = "DowntimeDungeon_inventory"
FLOOR_KEY = "DowntimeDungeon_floor_num"
SEED_KEY = "DowntimeDungeon_seed"
ADVENTURERS_KEY = "DowntimeDungeon_adventurers"
NPCS_KEY = "DowntimeDungeon_npcs"

def get_dungeon_data(com):
    dungeon_data = {
        "started": False,
        "gold": None,
        "inventory": {},
        "floor_num": None,
        "seed": None,
        "floor_seed": None,
        "adventurers": None,
        "npcs": None
    }

    started = com.get_metadata(STARTED_KEY)

    dungeon_data["started"] = started

    if not started:
        return dungeon_data

    gold = int(com.get_metadata(GOLD_KEY))
    inventory = load_json(com.get_metadata(INV_KEY, "{}"))
    floor_num = int(com.get_metadata(FLOOR_KEY))
    seed = int(com.get_metadata(SEED_KEY))
    floor_seed = seed + floor_num
    adventurers = load_json(com.get_metadata(ADVENTURERS_KEY))
    npcs = load_json(com.get_metadata(NPCS_KEY))

    dungeon_data["gold"] = gold
    dungeon_data["inventory"] = inventory
    dungeon_data["floor_num"] = floor_num
    dungeon_data["seed"] = seed
    dungeon_data["floor_seed"] = floor_seed
    dungeon_data["adventurers"] = adventurers
    dungeon_data["npcs"] = npcs

    return dungeon_data

def set_dungeon_data(com, started = None, gold = None, inventory = None, floor_num = None, seed = None, adventurers = None, npcs = None):
    if started != None:
        com.set_metadata(STARTED_KEY, started)
    
    if gold != None:
        com.set_metadata(GOLD_KEY, gold)

    if inventory != None:
        com.set_metadata(INV_KEY, dump_json(inventory))
    
    if seed != None:
        com.set_metadata(SEED_KEY, seed)
    
    if floor_num != None:
        com.set_metadata(FLOOR_KEY, floor_num)
    
    if adventurers != None:
        com.set_metadata(ADVENTURERS_KEY, dump_json(adventurers))

    if npcs != None:
        com.set_metadata(NPCS_KEY, dump_json(npcs))

    return None
    