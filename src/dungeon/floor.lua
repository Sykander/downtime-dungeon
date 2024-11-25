<drac2>
using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_message = env.get_gvar_id_by_name("get_message"),
    get_floor_data = env.get_gvar_id_by_name("get_floor_data"),
    describe_floor = env.get_gvar_id_by_name("describe_floor"),
    get_dungeon_data = env.get_gvar_id_by_name("get_dungeon_data"),
    get_status = env.get_gvar_id_by_name("get_status")
)

com = combat()

if not com:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

dungeon_data = get_dungeon_data.get_dungeon_data(com)

if not dungeon_data["started"]:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

floor_data = get_floor_data.get_floor_data(dungeon_data)
floor_description = describe_floor.describe_floor(floor_data)

map = floor_data["map"]
map_url = map_tools.generate_map_image()

fields = [
    get_status.get_status_description(com.round_num, dungeon_data)
]
outputEmbeded = get_message.get_message(floor_description, fields, image=map_url)

return outputEmbeded
</drac2>