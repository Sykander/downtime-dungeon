<drac2>
using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_message = env.get_gvar_id_by_name("get_message"),
    get_floor_data = env.get_gvar_id_by_name("get_floor_data"),
    get_dungeon_data = env.get_gvar_id_by_name("get_dungeon_data"),
    monster_tools = env.get_gvar_id_by_name("monster_tools"),
)

com = combat()

if not com:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

dungeon_data = get_dungeon_data.get_dungeon_data(com)

if not dungeon_data["started"]:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

floor_data = get_floor_data.get_floor_data(dungeon_data)

if not floor_data["encountered_monsters"]:
    return get_message.get_error("There are no monsters on this floor.")

output = f'multiline {ctx.prefix}{get_message.get_message("Adding monsters to initiative.")}'

monster_commands = monster_tools.get_add_monster_commands(dungeon_data, floor_data)

for command in monster_commands:
    output += f'\n{command}'

message = f"All monsters added to initiative. Please run the following command to begin combat.```{ctx.prefix}dungeon auto```"
output += f'\n{ctx.prefix}{get_message.get_message(description=message)}'

return output
</drac2>