# Development
# 85ef7be4-7af3-4a07-ac57-db9fc47fcb7c
# Production
# 6ee6493d-8028-46d3-b4d9-3ce7b06c6ef4

using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_readable_list = env.get_gvar_id_by_name("get_readable_list")
)

# Creates a description for each floor
def describe_floor(floor_data):
    output = ""

    output += f'{floor_data["map"]["desc"]}\n\n'

    if floor_data["encountered_monsters"]:
        monsters = floor_data["monsters"].items()

        monsters_list = ""
        for name, monster in monsters:
            monsters_list += f"""\n- {(str(monster["count"]) + "x " if monster["count"] > 1 else "")} {monster.name} (PP {monster.pp})"""

        output += f'You encounter some CR {floor_data["cr"]} monsters:{monsters_list}'
    elif floor_data["encountered_special_floor"]:
        output += f'{floor_data["special_floor"]["desc"]}'

    if floor_data["encountered_npc"]:
        for npc_event in floor_data["npc_events"]:
            output += f'\n\n{npc_event["desc"]}'

    if floor_data["encountered_monsters"]:
        output += f'\n\nPlease run the following command to add monsters to initiative. ```{ctx.prefix}dungeon monsters```'

    return output