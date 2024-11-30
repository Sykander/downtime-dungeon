<drac2>
using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_floor_data = env.get_gvar_id_by_name("get_floor_data"),
    describe_floor = env.get_gvar_id_by_name("describe_floor"),
    get_readable_list = env.get_gvar_id_by_name("get_readable_list"),
    get_status = env.get_gvar_id_by_name("get_status"),
    get_message = env.get_gvar_id_by_name("get_message"),
    get_dungeon_data = env.get_gvar_id_by_name("get_dungeon_data"),
    random = env.get_gvar_id_by_name("random"),
    map_tools = env.get_gvar_id_by_name("map_tools"),
    npc_tools = env.get_gvar_id_by_name("npc_tools"),
    npcs = env.get_gvar_id_by_name("npcs")
)

args = argparse(&ARGS&)
seed = int(args.last("seed", randint(0, 1000000)))
difficulty_slug = args.last("difficulty", "easy")

difficulty_to_start_floor = {
    "easy": 1,
    "medium": 11,
    "hard": 21,
    "deadly": 31
}

com = combat()

if not com:
    return get_message.get_error(f"Please run {ctx.prefix}dungeon setup")

dungeon_data = get_dungeon_data.get_dungeon_data(com)

if dungeon_data["started"]:
    return get_message.get_error("Ooops... the dungeon has already started.")

adventurers = []
for combatant in com.combatants:
    if(combatant.creature_type == None):
        adventurers.append(combatant.name)

if len(adventurers) <= 0:
    return get_message.get_error(f"At least one adventurer is required to play a dungeon. Please make sure all adventurers have joined initiative with `{ctx.prefix}i join`.")

if len(adventurers) > 4:
    return get_message.get_error("Too many adventurers tried to enter the dungeon all at once.")

adventurers_list_str = get_readable_list.get_readable_list(adventurers)
starting_floor = difficulty_to_start_floor[difficulty_slug] if difficulty_slug in difficulty_to_start_floor else 1

npcs = {
    "primary": npcs.get_random_npc(seed),
    "secondary": npcs.get_random_npc(seed - 1),
    "shopkeeper": npcs.get_random_npc(seed - 2)
}

get_dungeon_data.set_dungeon_data(
    com = com,
    started = True,
    floor_num = starting_floor,
    gold = 0,
    seed = seed,
    adventurers = adventurers,
    npcs = npcs
)

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

map_tools.attach_map_to_combatant(map["map_state"], com.get_combatant(adventurers[0]))
map_url = map_tools.generate_map_image(from_state=map["map_state"])

fields = [
    get_status.get_status_description(com.round_num, dungeon_data),
    f'Seed|{dungeon_data["seed"]}'
]
description = f'''{adventurers_list_str} enter{"s" if len(adventurers) == 1 else ""} the Downtime Dungeon!

{floor_description}
'''

output = get_message.get_message(description, fields, image=map_url)

npc_commands = npc_tools.get_add_npcs_commands(dungeon_data, floor_data)

if len(npc_commands) > 0:
    output = f'multiline {ctx.prefix}{output}'
    for npc_command in npc_commands:
        output += f'\n{npc_command}'

return output
</drac2>