<drac2>
using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_message = env.get_gvar_id_by_name("get_message"),
    get_dungeon_data = env.get_gvar_id_by_name("get_dungeon_data"),
    get_status = env.get_gvar_id_by_name("get_status")
)

com = combat()

if not com:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

dungeon_data = get_dungeon_data.get_dungeon_data(com)

if not dungeon_data["started"]:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

fields = [get_status.get_status_description(com.round_num, dungeon_data)]
description =  f'You closed the Downtime Dungeon after {dungeon_data["floor_num"]} floors.'

return f'multiline \n{ctx.prefix}i end \n{ctx.prefix}{get_message.get_message(description, fields)}'
</drac2>