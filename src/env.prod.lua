# ea6bd498-5320-410d-8501-28e119857f17

ENV = "Production"

gvars = {
    "describe_floor": "6ee6493d-8028-46d3-b4d9-3ce7b06c6ef4",
    "encounters": "b902325d-07e4-4082-8635-5e38443f29f9",
    "get_dungeon_data": "4091e5d2-6f37-4302-a90b-27065ab989e1",
    "get_floor_data": "c7a510b3-3bf4-47f4-b6fa-3f12416284b7",
    "get_message": "2d3e8126-cd02-4554-98f9-0a8dff98a09f",
    "get_readable_list": "fbdefe43-b658-482b-82ec-d77be042b98c",
    "get_Status": "37def108-11f5-45aa-a000-f8c68ff72207",
    "map_picker": "87c896d0-1ba1-47ae-bd93-827da92f78aa",
    "map_tools": "468bce27-653b-47aa-b8ed-9357196459df",
    "maps": "5290d47a-086f-4d56-8cb2-91a62976f365",
    "monster_tools": "d62a1569-c48b-4e80-8702-96d05ffaacb9",
    "monsters": "c1a83721-ba23-43e6-992d-3c5c3f56c93b",
    "npc_tools": "521ded99-888c-4765-ba6b-f833d66ced27",
    "npcs": "3dc472d1-b166-49a5-a801-ead859547152",
    "random": "a1cd80b3-772b-49b7-8bf0-c743cd380ccb",
    "script": "ed8121b6-8534-42cf-84f0-1e46269ed9c8",
    "server_config": "7c518500-8f21-4188-b61a-14195865169f",
    "special_floors": "14e039a9-8241-464d-9209-23114d166f59"
}

def get_gvar_id_by_name(name):
    if name in gvars:
        return gvars[name]

    return f"Didn't find GVAR for name {name}!"