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

#returns a random entry of a dict.
def getRandomFromDict(dictionary: dict) -> object:
    dict_index = random.get_random_integer(0, len(dictionary) - 1)
    return dictionary[list(dictionary.keys())[dict_index]]

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
        
    cr_min = max(ceil(cr_min), 0)
    cr_max = max(cr_max, 0.125)

    monsters = monster_tools.get_monsters_in_cr_range(cr_min, cr_max)

    # if there's no monsters in that cr range, expand range
    while len(monsters) == 0 and cr_min > 0:
        cr_min = cr_min - 1
        monsters = monster_tools.get_monsters_in_cr_range(cr_min, cr_max)

    # if there is still no monsters, throw exception
    if len(monsters) == 0:
        {}[f"No monsters found in cr range {cr_min} to {cr_max}, please check if your server config has any monsters in this range."]

    cr_budget = target_cr
    final_list = []

    if difficulty > 3:
        highest_cr = max(monsters.keys())
        highest_cr_mon_list = monsters[highest_cr]

        highest_cr_mon_index = random.get_random_integer(0, len(highest_cr_mon_list) - 1)
        highest_cr_mon = highest_cr_mon_list[highest_cr_mon_index]

        final_list.append(highest_cr_mon)
        cr_budget -= highest_cr_mon.cr
    
    while cr_budget > 0 and len(final_list) < MONSTER_LIMIT and len(monsters) > 0:
        cr_list = getRandomFromDict(monsters)
        mon = cr_list[random.get_random_integer(0, len(cr_list) - 1)]
        cr_budget -= mon.cr
        final_list.append(mon)

        # remove any monster lists with cr above the budget
        for key in list(monsters.keys()):
            if key > cr_budget:
                monsters.pop(key)

    final_dict = dict()

    for mon in final_list:
        if mon.name not in final_dict:
            final_dict[mon.name] = mon
            final_dict[mon.name]["count"] = 0
        final_dict[mon.name]["count"] += 1

    random.setState(oldState)
    return final_dict
