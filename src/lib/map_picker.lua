# Development
# 673c127c-9511-409a-89b8-042da80cbf58
# Production
# 87c896d0-1ba1-47ae-bd93-827da92f78aa

using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    maps = env.get_gvar_id_by_name("maps"),
    random = env.get_gvar_id_by_name("random")
)

def pick_map(seed = None):
    oldSeed = random.getSeed()
    if seed != None:
        random.setSeed(seed)

    map_index = random.get_random_integer(0, maps.map_list_len -1)

    if seed != None:
        random.setSeed(oldSeed)

    return maps.map_list[map_index]
