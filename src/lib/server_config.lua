# Development
# d83b0d37-56e1-416f-91a7-8a8b90bcd5bb
# Production
# 7c518500-8f21-4188-b61a-14195865169f

using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    random = env.get_gvar_id_by_name("random")
)

server_gold_override = get_svar("DowntimeDungeon_gold", None)
server_special_floor_chance_override = get_svar("DowntimeDungeon_special_floor_chance", None)
server_primary_npc_chance_override = get_svar("DowntimeDungeon_primary_npc_chance", None)
server_secondary_npc_chance_override = get_svar("DowntimeDungeon_secondary_npc_chance", None)
server_cr_calculator_override = get_svar("DowntimeDungeon_cr_calculator", None)
server_special_floors_override = get_svar("DowntimeDungeon_special_floors", None)

def get_gold_for_floor(floor_data, dungeon_data):
    if server_gold_override != None:
        using(server_gold_module=server_gold_override)
        return server_gold_module.get_gold_for_floor(floor_data, dungeon_data)

    return floor_data["floor_num"]

def get_is_special_floor(dungeon_data):
    if server_special_floor_chance_override != None:
        using(server_floor_chance_module=server_special_floor_chance_override)
        return server_floor_chance_module.get_is_special_floor(dungeon_data)

    return random.get_random_integer(0, 100, dungeon_data["floor_seed"] + 113) > 80

def get_has_primary_npc(dungeon_data):
    if server_primary_npc_chance_override != None:
        using(server_primary_npc_chance_module=server_primary_npc_chance_override)
        return server_primary_npc_chance_module.get_has_primary_npc(dungeon_data)

    return random.get_random_integer(0, 100, dungeon_data["floor_seed"]) > 80

def get_has_secondary_npc(dungeon_data):
    if server_secondary_npc_chance_override != None:
        using(server_secondary_npc_chance_module=server_secondary_npc_chance_override)
        return server_secondary_npc_chance_module.get_has_secondary_npc(dungeon_data)

    return random.get_random_integer(0, 100, dungeon_data["floor_seed"] - 31982) > 90

def get_cr(dungeon_data):
    if server_cr_calculator_override != None:
        using(server_cr_calculator_module=server_cr_calculator_override)
        server_cr = server_cr_calculator_module.get_cr(dungeon_data)
        if server_cr >= 0:
            return server_cr

    MIN_CR = 0.5
    MAX_CR = 30.0
    DIFFICULTY_TRANSITION = 1/50

    transition_var = ((1-DIFFICULTY_TRANSITION)**dungeon_data["floor_num"]) if dungeon_data["floor_num"] < 1000 else 0

    return MAX_CR - (MAX_CR - MIN_CR)*transition_var

def get_special_floors_list(default_list):
    if server_special_floors_override != None:
        using(server_special_floors_module=server_special_floors_override)
        return server_special_floors_module.get_special_floors_list(default_list)

    return default_list
