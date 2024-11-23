# Development
# 9d62fab6-eff1-4f53-a24a-38ea4fc99713
# Production
# d62a1569-c48b-4e80-8702-96d05ffaacb9

using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    random = env.get_gvar_id_by_name("random")
)

size_table = {
    "S": "Small",
    "T": "Tiny",
    "M": "Medium",
    "L": "Large",
    "H": "Huge",
    "G": "Gargantuan"
}

def get_add_monster_commands(dungeon_data, floor_data):
    monster_list = floor_data["monsters"]
    starting_squares = floor_data["map"]["monsters_start"]
    command_list = []
    starting_squares_len = len(starting_squares)

    for name, monster in monster_list.items():
        square_index = random.get_random_integer(0, starting_squares_len - 1)
        start_square = starting_squares[square_index]
        size_part = size_table[monster["size"]] if monster["size"] in size_table else monster["size"]
        type_part = monster["type"]
        description_part = f'{"A" if monster["count"] == 1 else monster["count"]} {size_part} {type_part}{"s" if monster["count"] > 1 else ""}'
        image_part = f'-image {monster["image_url"]}' if monster["image_url"] else ""

        command_list.append(f'{ctx.prefix}embed -title "{name}" -desc "*{description_part}*" {image_part}')
        command_list.append(f'{ctx.prefix}i madd "{name}" -name "{"#-" if monster["count"] > 1 else ""}{name}" -n {monster["count"]} -rollhp -note "Location: {start_square} | Note: PP {monster.pp} | Size: {monster.size} | Token: {monster.token}"')

    return command_list