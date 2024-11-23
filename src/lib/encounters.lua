# Development
# a003f531-851f-4a1d-859e-a2766b5dbce1
# Production
# b902325d-07e4-4082-8635-5e38443f29f9

using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    random = env.get_gvar_id_by_name("random"),
    monster_tools = env.get_gvar_id_by_name("monsters")
)

# Never go over the monster limit
MONSTER_LIMIT = 12

def generate_encounter(target_cr: int, seed: int):
    oldState = random.getState()
    random.setSeed(seed)

    cr_min = None
    cr_max = None
    difficulty = random.get_random_integer(0, 5)
    
    if difficulty == 0:
        cr_min = max(floor(target_cr ** 0.5) - 2, 0)
        cr_max = min(cr_min + 4, target_cr)
    elif difficulty == 1:
        cr_min = floor(target_cr / 2)
        cr_max = min(cr_min + 4, target_cr)
    elif difficulty == 3:
        cr_min = max(target_cr - 5, 0)
        cr_max = max(target_cr - 1, 0)
    elif difficulty == 4:
        cr_min = max(target_cr - 4, 0)
        cr_max = target_cr
    else:
        cr_min = max(target_cr - 3, 0)
        cr_max = target_cr

    monsters = monster_tools.get_monsters_in_cr_range(cr_min, cr_max)

    # if there's no monsters in that cr range search lower
    while len(monsters) == 0 and cr_min >= 0:
        cr_min = floor(cr_min - 1)
        monsters = monster_tools.get_monsters_in_cr_range(cr_min, cr_max)

    cr_min = max(cr_min, 0)

    monsters_len = len(monsters)
    cr_budget = target_cr
    final_list = []

    if difficulty > 3:
        highest_cr_mon = monsters[0]

        for mon in monsters[1:]:
            if mon.cr > highest_cr_mon.cr:
                highest_cr_mon = mon

        final_list.append(highest_cr_mon)
        cr_budget -= highest_cr_mon.cr
    
    while cr_budget > 0 and len(final_list) < MONSTER_LIMIT:
        index = random.get_random_integer(0, monsters_len - 1)
        mon = monsters[index]
        cr_budget -= mon.cr
        final_list.append(mon)

    final_dict = dict()

    for mon in final_list:
        if mon.name not in final_dict:
            final_dict[mon.name] = mon
            final_dict[mon.name]["count"] = 0
        final_dict[mon.name]["count"] += 1

    random.setState(oldState)
    return final_dict
