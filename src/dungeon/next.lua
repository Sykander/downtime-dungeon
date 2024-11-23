<drac2>
using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_message = env.get_gvar_id_by_name("get_message"),
    get_floor_data = env.get_gvar_id_by_name("get_floor_data"),
    describe_floor = env.get_gvar_id_by_name("describe_floor"),
    server_config = env.get_gvar_id_by_name("server_config"),
    get_dungeon_data = env.get_gvar_id_by_name("get_dungeon_data"),
    get_status = env.get_gvar_id_by_name("get_status"),
    map_tools = env.get_gvar_id_by_name("map_tools"),
    random = env.get_gvar_id_by_name("random"),
    npc_tools = env.get_gvar_id_by_name("npc_tools")
)

com = combat()

if not com:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

last_dungeon_data = get_dungeon_data.get_dungeon_data(com)

if not last_dungeon_data["started"]:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

com.end_round()

args = argparse(&ARGS&)
floorsToSkip = max(int(args.last("floors", 1)), 1)

floor_num = last_dungeon_data["floor_num"]
gold = last_dungeon_data["gold"]

last_floor_data = get_floor_data.get_floor_data(dungeon_data = last_dungeon_data)

gold += server_config.get_gold_for_floor(floor_data = last_floor_data, dungeon_data = last_dungeon_data)
floor_num += floorsToSkip

if last_floor_data["encountered_npc"]:
    for npc_event in last_floor_data["npc_events"]:
        npc_tools.check_and_update_is_dead(npc_event["npc"], last_dungeon_data)

get_dungeon_data.set_dungeon_data(com = com, gold = gold, floor_num = floor_num)
dungeon_data = get_dungeon_data.get_dungeon_data(com)

floor_data = get_floor_data.get_floor_data(dungeon_data)
floor_description = describe_floor.describe_floor(floor_data)

map = floor_data["map"]
starting_squares = map["adventurers_start"]
starting_squares_len = len(starting_squares)

for adventurer in com.combatants:
    square_index = random.get_random_integer(0, starting_squares_len - 1)
    start_square = starting_squares[square_index]
    if adventurer:
        map_tools.set_combatant_square(adventurer, start_square)

map_command = f"""{ctx.prefix}auto map '{map["auto_map_name"]}' """ if map["auto_map"] else f'{ctx.prefix}map {map["options"]}'
map_command_description = f'Please run the following command set the map for the encounter:```{map_command}```'

fields = [
    get_status.get_status_description(com.round_num + floorsToSkip, dungeon_data),
    f'Map|{map_command_description}'
]
messageEmbeded = get_message.get_message(floor_description, fields)

output = f'multiline {ctx.prefix}{messageEmbeded}'

remove_npcs = npc_tools.get_remove_npcs_commands(dungeon_data, floor_data)

for remove_command in remove_npcs:
    output += f'\n{remove_command}'

output += f'\n{ctx.prefix}i round {floorsToSkip}'
output += f'\n{ctx.prefix}i reroll'

add_npcs = npc_tools.get_add_npcs_commands(dungeon_data, floor_data)

for add_command in add_npcs:
    output += f'\n{add_command}'

return output
</drac2>