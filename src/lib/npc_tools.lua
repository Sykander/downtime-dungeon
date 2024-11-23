# Development
# 50ca7e2f-4ac7-438f-bf6a-859233d50b23
# Production
# 521ded99-888c-4765-ba6b-f833d66ced27

using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    random = env.get_gvar_id_by_name("random"),
    get_dungeon_data = env.get_gvar_id_by_name("get_dungeon_data"),
    npcs = env.get_gvar_id_by_name("npcs")
)

c = combat()

def check_and_update_is_dead(npc, dungeon_data):
    npc_in_combat = c.get_combatant(npc["full_name"])
    npcs = dungeon_data["npcs"]

    if (not npc_in_combat) or (npc_in_combat.hp <= 0):
        for priority, data_npc in npcs.items():
            if data_npc["full_name"] == npc["full_name"]:
                npcs[priority]["dead"] = True

    get_dungeon_data.set_dungeon_data(c, npcs = npcs)

def get_remove_npcs_commands(dungeon_data, floor_data):
    npc_commands = []
    npcs = dungeon_data["npcs"]

    for priority, npc in npcs.items():
        npc_in_combat = c.get_combatant(npc["full_name"])

        if npc_in_combat:
            npc_commands.append(f'{ctx.prefix}i remove "{npc["full_name"]}"')

    return npc_commands

def get_add_npcs_commands(dungeon_data, floor_data):
    oldState = random.getState()
    random.setSeed(dungeon_data["floor_seed"] + 98723)

    npc_events = floor_data["npc_events"]
    starting_squares = floor_data["map"]["adventurers_start"]
    starting_squares_len = len(starting_squares)
    npc_commands = []

    for npc_event in npc_events:
        npc = npc_event["npc"]
        npc_in_combat = c.get_combatant(npc["full_name"])

        if not npc_in_combat:
            square_index = random.get_random_integer(0, starting_squares_len - 1)
            start_square = starting_squares[square_index]
            npc_commands.append(f'{ctx.prefix}i madd "{npc["sheet"]["monster"]}" -name "{npc["full_name"]}" -note "Location: {start_square} | Color: b | Note: {npc["sheet"]["name"]}"')
            npc_commands.append(f'{ctx.prefix}i effect "{npc["full_name"]}" "(Ally (auto))"')

        if npc_event["does_special_action"] and npc["sheet"]["has_special_actions"]:
            special_actions = npc["sheet"]["special_actions"]
            special_actions_len = len(special_actions)
            if special_actions_len > 0:
                special_action_index = random.get_random_integer(0, special_actions_len - 1)
                action_to_take = npcs.actions[special_actions[special_action_index]]
                npc_commands.append(f'{action_to_take(npc, floor_data, dungeon_data)}')

    random.setState(oldState)
    return npc_commands