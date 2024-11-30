# Development
# 27471f7a-208b-413b-86fe-531050e1e33d
# Production
# abd22d03-21d0-41f5-87a4-74371cd6a22b

# https://github.com/7he4lph4/autom/blob/main/autom.alias

pref, al = ctx.prefix, ctx.alias
cmd = pref+al
null, nl, comma = '', '\n', ','

cname_list, command_list, combatant_mismatch = [],[],[]
multiattack, spell_viable, counter = False, False, 0

using(
    autolib = "40c06ebb-8487-4e0f-8cd5-e38d52364c53",
    core = "49f5f503-1c00-4f24-ba43-92e65c2c2fb6",
    presets = "c14e4526-4acb-4964-8ba9-f6861617ffdf",
    mapl = "4b5633ff-7082-4411-95b3-50970c30e832",
    mobl = "65c27eae-11c3-4b5c-90e5-472bc49f0037",
    targl = "f8369cc0-8ab0-42a5-8dfd-4ab7f34c0e61",
    helpl = "aacef7e2-fb6a-4786-9d26-193ed45e4916"
)
using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_message = env.get_gvar_id_by_name("get_message"),
    map_tools = env.get_gvar_id_by_name("map_tools"),
)

c = combat()

alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
size_map = {'T': 1, 'S': 1, 'M': 1, 'L': 2, 'H': 3, 'G': 4}
size_dict = {"T": "Tiny", "S": "Small", "M": "Medium", "L": "Large", "H": "Huge", "G": "Gargantuan"}

def auto_monster(auto_once=True, auto_react=False):
    combatants = c.combatants
    combatant_list, party_list, monster_list = targl.get_target_lists()

    party_names = [p.name for p in party_list]
    monster_names, monster_types = [], []
    for mon in monster_list:
        monster_names.append(mon.name)
        monster_types.append(mon.monster_name)

    map_base_url = get("otfbm_base_url", "http://otfbm.io/")
    mapsize = get("mapSize", "20x20")

    map_combatant = mapl.mapPresent()
    map_info, map_attach = mapl.get_map_info()

    map_state = {
        "current_map": None, 
        "size": map_info.get("size", [20, 20]),
        "mapoptions": map_info.get("options", ""),
        "bg_image": map_info.get("background", "")
    }
    width, height = mapl.parse_mapsize(map_state.get("size"))
    placed, unplaced = mapl.get_placed_combatants()
    teams = {}
    for co in c.combatants:
        if co.name.lower() in ["dm", "map", "lair"] or autolib.isGhost(c, co):
            continue
        for effect in co.effects:
            if effect.name.startswith("Ally (auto)"):
                teams[1] = teams.get(1, []) + [co.name]
                break
            if all(e in effect.name for e in ["Team", "(auto)"]):
                team = int("".join([e for e in effect.name if e.isdigit()]))
                teams[team] = teams.get(team, []) + [co.name]
                break
        else:
            team = 1 if not autolib.isMonster(co) else max(max(teams, default=2),2)
            teams[team] = teams.get(team, []) + [co.name]
    out = {}

    if not party_names:
        command_list.append(f'{pref}{get_message.get_error("No player characters in initiative.")}')
        return command_list

    if c.current is None:
        map_url = map_tools.generate_map_image()
        command_list.append(f'{pref}{get_message.get_message("Starting combat.", image=map_url)}')
        command_list.append(f'{pref}i next')
        return command_list

    current_init = c.current.name

    # It's a player's turn
    if current_init.casefold() in ['map', 'dm', 'lair'] and c.turn_num == 20:
        title = f'Waiting on Lair Action :dragon:'
        desc_text = f'Use `{pref}i n` if there are no actions to take this round!'
        return [f'{pref}{get_message.get_message(title=title, description=desc_text)}']
    elif autolib.hasMonsterGroup(c) or not c.current.monster_name:
        title = f'It\'s a player turn! :mage:'
        desc_text = f"Waiting on **{current_init}** to play their turn!"
        if not get_uvar('mapStates'):
            desc_text += helpl.move_help
        return [f'{pref}{get_message.get_message(title=title, description=desc_text)}']

    def find_best_aoe_position(monster, aoe_attack, target_names):
        best_position = None
        max_targets = 0
        monster_map_data = mapl.parse_note(monster.note)
        monster_location = monster_map_data.get('location', None)
        if not monster_location:
            return None

        mapX, mapY = width, height

        # Generate positions in the monster's line of sight/direction
        # For simplicity, we'll consider positions in front of the monster
        # Assuming the monster is facing towards the majority of targets

        # Find the center position of all targets to determine general direction
        target_positions = []
        for target_name in target_names:
            target = c.get_combatant(target_name)
            if target:
                target_map_data = mapl.parse_note(target.note)
                target_location = target_map_data.get('location', None)
                if target_location:
                    coords = mapl.loc_to_coords(target_location)
                    target_positions.append(coords)

        if not target_positions:
            return None

        # Calculate average position of targets
        avg_x = sum(pos[0] for pos in target_positions) / len(target_positions)
        avg_y = sum(pos[1] for pos in target_positions) / len(target_positions)
        direction_vector = [avg_x - mapl.loc_to_coords(monster_location)[0], avg_y - mapl.loc_to_coords(monster_location)[1]]

        # Normalize direction vector
        length = sqrt(direction_vector[0] ** 2 + direction_vector[1] ** 2)
        if length == 0:
            direction_vector = [0, 1]  # Default direction
        else:
            direction_vector = [direction_vector[0] / length, direction_vector[1] / length]

        # Check positions in the direction the monster is facing
        for distance in range(1, max(mapX, mapY)):
            x = mapl.loc_to_coords(monster_location)[0] + int(direction_vector[0] * distance)
            y = mapl.loc_to_coords(monster_location)[1] + int(direction_vector[1] * distance)
            if x < 0 or y < 1 or x >= len(alph) or y > mapY:
                break
            position = f"{alph[x]}{y}"
            affected_targets = count_affected_targets(position, aoe_attack, target_names)
            if affected_targets > max_targets:
                max_targets = affected_targets
                best_position = position

        return best_position

    def count_affected_targets(position, aoe_attack, targets):
        affected = 0

        for target in targets:
            target_map_data = mapl.parse_note(c.get_combatant(target).note)
            target_location = target_map_data.get('location', None)
            if target_location and is_in_aoe(position, target_location, aoe_attack):
                affected += 1
        return affected

    def is_in_aoe(origin, target, aoe_attack):
        ox, oy = alph.index(origin[0]), int(origin[1:])
        tx, ty = alph.index(target[0]), int(target[1:])
        dx, dy = abs(tx - ox), abs(ty - oy)
        distance = max(dx, dy) * 5  # Assuming 5ft per square

        if aoe_attack['shape'] in ['cone', 'sphere', 'radius']:
            return distance <= aoe_attack['size']
        elif aoe_attack['shape'] == 'line':
            return (dx == 0 or dy == 0 or dx == dy) and distance <= aoe_attack['size']
        elif aoe_attack['shape'] in ['cube', 'cylinder']:
            return dx <= aoe_attack['size'] // 5 and dy <= aoe_attack['size'] // 5

        return False

    def distance(pos1, pos2):
        x1, y1 = alph.index(pos1[0].upper()), int(pos1[1:])
        x2, y2 = alph.index(pos2[0].upper()), int(pos2[1:])
        dx = abs(x2 - x1)
        dy = abs(y2 - y1)
        
        # D&D 5e uses a simplified diagonal movement rule
        # where every other diagonal counts as 10 feet instead of 5
        diagonals = min(dx, dy)
        straight = abs(dx - dy)
        
        return (diagonals * 5) + (straight * 5)

    distance_function = distance
    def draw_aoe_overlay(monster, aoe_attack, position, targets):

        shapeDict = [{"type": "circle",       "name":"c",  "num": [3], "args": ("size", "color", "loc")},
                {"type": "circletop",    "name":"ct", "num": [3], "args": ("size", "color", "loc")},
                {"type": "circlecorner", "name":"co", "num": [3], "args": ("size", "color", "loc")},
                {"type": "cone",         "name":"t",  "num": [4], "args": ("size", "color", "loc", "eloc")},
                {"type": "line",         "name":"l",  "num": [5], "args": ("size", "width", "color", "loc", "eloc")},
                {"type": "arrow",        "name":"a",  "num": [3], "args": ("color", "loc", "eloc")},
                {"type": "square",       "name":"s",  "num": [3,4], "args": ("size", "color", "loc", "eloc")},
                {"type": "squaretop",    "name":"st", "num": [3,4], "args": ("size", "color", "loc", "eloc")}]

        color = 'r'  # Default color for AoE
        shape = aoe_attack['shape']
        size = aoe_attack.get('size', 10)
        
        # Create a dictionary mapping shape names to their short codes
        shape_to_code = {item['type']: item['name'] for item in shapeDict}
        
        if shape in ['sphere', 'radius', 'cube', 'cylinder']:
            shape_code = shape_to_code['circle' if shape in ['sphere', 'radius'] else 'square']
            return f"{shape_code}{size}{color}{position}"
        
        if shape in ['cone', 'line']:
            nearest_target = min(targets, key=lambda t: distance(position, mapl.parse_note(c.get_combatant(t).note).get('location', 'A1')))
            nearest_pos = mapl.parse_note(c.get_combatant(nearest_target).note).get('location', 'A1')
            shape_code = shape_to_code[shape]
            return f"{shape_code}{size},{aoe_attack.get('width', size) if shape == 'line' else ''}{color}{position}{nearest_pos}".rstrip(',')
        
        return None

    def find_adjacent_position(monster_location, target_position):
        mx, my = alph.index(monster_location[0]), int(monster_location[1:])
        tx, ty = alph.index(target_position[0]), int(target_position[1:])
        
        adjacent_positions = [
            (mx-1, my), (mx+1, my), (mx, my-1), (mx, my+1),
            (mx-1, my-1), (mx-1, my+1), (mx+1, my-1), (mx+1, my+1)
        ]
        
        closest_position = min(adjacent_positions, key=lambda p: ((p[0]-tx)**2 + (p[1]-ty)**2))
        return f"{alph[closest_position[0]]}{closest_position[1]}"

    def find_ranged_adjacent_position(monster_location, target_position, ideal_range):
        ideal_cell_range = floor(ideal_range/5)
        mx, my = alph.index(monster_location[0]), int(monster_location[1:])
        tx, ty = alph.index(target_position[0]), int(target_position[1:])
        
        adjacent_positions = [
            (mx-ideal_cell_range, my), (mx+ideal_cell_range, my), (mx, my-ideal_cell_range), (mx, my+ideal_cell_range),
            (mx-ideal_cell_range, my-ideal_cell_range), (mx-ideal_cell_range, my+ideal_cell_range), (mx+ideal_cell_range, my-ideal_cell_range), (mx+ideal_cell_range, my+ideal_cell_range)
        ]

        mapX, mapY = width, height
        adjacent_positions_filtered = core.filter(lambda coord: coord[0] >= 0 and coord[1] >= 1 and coord[0] < mapX and coord[1] <= mapY, adjacent_positions)
        
        closest_position = min(adjacent_positions, key=lambda p: ((p[0]-tx)**2 + (p[1]-ty)**2))
        return f"{alph[closest_position[0]]}{closest_position[1]}"

    def get_targets_in_aoe(monster_location, aoe_attack, target_names):
        affected_targets = []
        for target_name in target_names:
            target = c.get_combatant(target_name)
            if target:
                target_map_data = mapl.parse_note(target.note)
                target_location = target_map_data.get('location', None)
                if target_location and is_in_aoe(monster_location, target_location, aoe_attack):
                    affected_targets.append(target_name)
        return affected_targets

    def get_attack_reach(attack_str):
        attack_str = attack_str.lower()
        if 'reach' in attack_str:
            words = attack_str.split()
            for i, word in enumerate(words):
                if word == 'reach' and i + 1 < len(words):
                    reach = ''.join(core.filter(str.isdigit, words[i+1]))
                    if reach:
                        return int(reach)
        return 8  # Default melee reach

    def get_max_attack_reach(attacks):
        max_reach = 8
        for attack in attacks:
            reach = get_attack_reach(str(attack))
            if reach > max_reach:
                max_reach = reach
        return max_reach

    def get_spell_range(spell_name):
        spell_data = load_json(get_gvar('00d6334d-af6c-46ac-b810-752465e0ad33'))
        spell_name = spell_name.strip('"')  # Remove quotes if present
        for spell in spell_data:
            if spell['name'].lower() == spell_name.lower():
                range_str = spell['range']
                # Extract the numeric value from the range string
                range_value = ''.join(core.filter(str.isdigit, range_str))
                return int(range_value) if range_value else 30  # Default to 30 if no numeric value found
        return 30  # Default range if spell not found

    def move_towards(start_pos, end_pos, distance, unoccupied, occupied=[]):
        total_distance = mapl.distance(start_pos, end_pos) * 5
        dxy = mapl.subtract_coords(end_pos, start_pos)
        ratio = min(distance / total_distance, 1) if 0 < total_distance else 0
        
        move_pos = mapl.add_coords(start_pos, mapl.scale_coords(dxy, ratio))
        move_pos = (round(move_pos[0]), round(move_pos[1]))
        if move_pos not in occupied:
            return mapl.coords_to_loc(move_pos), None, move_pos
        
        if len(unoccupied) < 1:
            return mapl.coords_to_loc(start_pos), None, start_pos
        
        unocc = list(unoccupied)
        found = []
        move_dist = -1
        for p in unocc:
            if distance < round(mapl.distance(start_pos, p)) * 5:
                continue
            end_dist = mapl.distance(p, end_pos)
            if end_dist <= move_dist or move_dist < 0:
                found.append(p)
                move_pos, move_dist = p, end_dist
        
        # if move_pos in occupied:
        #     return mapl.coords_to_loc(start_pos), None, start_pos
        # command_list.append(f'{pref}echo {move_pos}')
        # goto = list(unoccupied)
        # goto.sort(key=lambda p: mapl.distance(move_pos, p))
        
        # Generate arrow overlay with correct syntax
        distanceT = round(mapl.distance(start_pos, move_pos)) * 5
        color = 'r' # Use red color for the arrow
        start_location = mapl.coords_to_loc(start_pos)
        new_location = mapl.coords_to_loc(move_pos)
        arrow = f"*a{distanceT}{color}{start_location}{new_location}"
        
        return new_location, arrow, move_pos

    def create_arrow_overlay(distance, start_location, end_location):
        colr = 'r' # Use red color for the arrow
        return f"*a{distance}{colr}{start_location}{end_location}"

    def find_best_target(monster, target_names, move_coords=[], distances={}, max_surrounding=2):
        if len(distances) < 1:
            return None, -1, None
        
        if min(distances) <= 5:
            dist = min(distances)
            return randchoice(distances[dist])[0], dist, None
        
        filtered_targets = mapl.filter_occupied(monster.name, placed, distances, move_coords)
        if not filtered_targets:
            dist = min(distances)
            data = randchoice(distances[dist])
            return data[0], dist, {dist: [data[2]]}
        
        for k, v in filtered_targets.items():
            return k, v["distance"], v["melee"]
        
        #if monster.stats.intelligence < 20:
        
        targets = [c.get_combatant(tname) for tname in target_names if c.get_combatant(tname)]
        target_hp = [(t, t.hp) for t in targets if t.hp is not None and 0 < t.hp]    
        if not target_hp:
            return randchoice(distances[min(distances)])
        
        def count_surrounding_monsters(target):
            tname = target.name
            if not tname in placed:
                return 0, False
            adjacent = placed[tname].get("adjacent", [])
            large_monster_present = any(0 < placed[aname]["size_mod"] for aname in adjacent)
            return len(adjacent), large_monster_present
        
        # Sort targets by HP and intelligence level
        if 17 <= monster.stats.intelligence:
            sorted_targets = core.sorted(target_hp, key=lambda x: x[1])
        else:
            # Weighted random selection favoring lower HP targets
            weights = [max(1, 100 - t[1]) for t in target_hp]
            sorted_targets = [t for t, _ in core.sorted(core.zip(target_hp, weights), key=lambda x: x[1], reverse=True)]
        
        for target, _ in sorted_targets:
            monster_count, large_monster_present = count_surrounding_monsters(target)
            if monster_count < max_surrounding and not large_monster_present:
                return target.name
        
        # If all preferred targets are surrounded or near large monsters, choose the least surrounded one without a large monster
        valid_targets = [t for t in sorted_targets if not count_surrounding_monsters(t[0])[1]]
        if valid_targets:
            return min(valid_targets, key=lambda x: count_surrounding_monsters(x[0])[0])[0].name
        
        # If all targets have large monsters nearby, choose a random target from the valid ones (those with HP > 0)
        return randchoice([t.name for t, _ in target_hp]) if target_hp else None

    def process_monster_turn(indexed_combatant, out, overlays, desc, command_list, snippets=""):
        monster = c.get_combatant(indexed_combatant)
        if not monster:
            desc.append(f"Could not find combatant: {indexed_combatant}")
            return
        
        monster_name = monster.monster_name
        curr_hp = monster.hp
        
        # Check if the monster is already dead at the start of its turn
        if monster.hp <= 0:
            remove_dead_monster(c, monster, out, desc)
            map_url = map_tools.generate_map_image(overlays)
            title = f"Skipping dead monster: {monster.name}"
            description = f"{monster.name} has been defeated and removed from the map. Its turn will be skipped."
            command_list.append(f'{pref}{get_message.get_message(title=title, description=description, image=map_url)}')
            command_list.append(f'{pref}i n')
            return

        # Get location from note
        map_data = placed[indexed_combatant]
        location = map_data["location"]
        
        phrase = ""
        team = 1
        for t in teams:
            if indexed_combatant in teams[t]:
                team = t
                break
        targets = [co for t in teams if t != team for co in teams[t]]
        
        # Check if map is present
        if map_attach and location:
            monster_speed = mobl.get_monster_speed(monster_name)[0]
            monster_move_verb = mobl.get_monster_speed(monster_name)[1]

            start_pos, size_m = map_data["pos"], map_data["size_mod"]
            
            # Get occupied positions to avoid collisions
            unoccupied, occupied = mapl.get_move_coords(monster.name, placed, width, height)

            ### AoE ###
            aoe_attacks = mobl.get_aoe_attacks(monster.name)
            if aoe_attacks:
                aoe_attack = randchoice(aoe_attacks)

                # Create a list of all potential targets (excluding the monster itself)
                all_combatants = [c.name for c in c.combatants if c.name.lower() not in ['map', 'dm', 'lair']]
                potential_targets = [name for name in all_combatants if name != monster.name]

                # Find the best position for the AoE attack
                best_position = find_best_aoe_position(monster, aoe_attack, potential_targets)

                if best_position:
                    # Calculate the distance to the best position
                    end_pos = mapl.loc_to_coords(best_position)
                    distance_to_position = mapl.distance(start_pos, end_pos) * 5

                    # Move the monster if needed
                    if distance_to_position > 0:
                        move_distance = min(monster_speed, distance_to_position)
                        new_location, arrow, new_pos = move_towards(start_pos, end_pos, move_distance, unoccupied)
                        mapl.update_position(monster, placed, new_pos, out)
                        if arrow:
                            overlays.append(arrow)
                        location = new_location
                        desc.append(f"{indexed_combatant} uses {int(move_distance)} ft. out of their {monster_speed} ft. to {'move' if monster_move_verb == 'walk' else '*fly*'} towards an optimal position for its AoE attack.")

                        # Display the updated map after movement
                        map_state["combatants"] = out
                        map_url = map_tools.generate_map_image(overlays)
                        title = f"Monster Movement: {monster.name}"
                        command_list.append(f'{pref}{get_message.get_message(title=title, description=desc[-1], image=map_url)}')

                    # Adjust the AoE position for cone and line attacks
                    if aoe_attack['shape'] in ['cone', 'line']:
                        best_position = find_adjacent_position(location, best_position)

                    # Create and add the AoE overlay
                    overlay = draw_aoe_overlay(monster, aoe_attack, best_position, potential_targets)
                    if overlay:
                        overlays.append(f"*{overlay}")
                        desc.append(f"{monster.name} uses {aoe_attack['name']} starting at {location} towards {best_position}")

                        # Display the map with the AoE overlay
                        map_url = map_tools.generate_map_image(overlays)
                        title = f"AoE Attack: {monster.name}"
                        command_list.append(f'{pref}{get_message.get_message(title=title, description=desc[-1], image=map_url)}')
                        # Find targets within the AoE
                        affected_targets = get_targets_in_aoe(location, aoe_attack, potential_targets)

                        # Add the attack command targeting all affected combatants
                        if affected_targets:
                            target_string = " -t ".join(affected_targets)
                            command_list.append(f'{ctx.prefix}i a "{aoe_attack["name"]}" -t {target_string} -phrase ":robot: _Triggered by auto monster AI_"')
                        else:
                            desc.append(f"No targets were caught in the AoE of {aoe_attack['name']}.")

                        command_list.append(f'{ctx.prefix}i n')
                        return
            ### AoE ###

            placed_distances = mapl.get_placed_distances(monster.name, targets, placed)
            chosen_target, distance, melee = find_best_target(monster, targets, unoccupied, placed_distances)
            
            #return command_list.append(f"!echo {chosen_target}")
            target_combatant = c.get_combatant(chosen_target)
            if not target_combatant:
                desc.append(f"Could not find target: {chosen_target}")
                return

            target_location = placed[chosen_target].get('location', None)
            if target_location:
                max_attack_reach = get_max_attack_reach(monster.attacks)
                
                target_pos = placed[chosen_target]['pos']
                target_size_mod = placed[chosen_target]['size_mod']
                # distance = mapl.get_nearest(start_pos, size_m, target_pos, target_size_mod)[0] * 5
                
                map_state["combatants"] = out

                # Spellcasting logic
                spell_monst = monster.spellbook.caster_level
                if spell_monst:
                    spell_data = load_json(get_gvar("a1e23cdf-0510-480d-a616-59e2c46780ac"))
                    spell_list = [spell.name for spell in monster.spellbook.spells]

                    # Create a list of viable spells
                    viable_spells = [
                        (s, spell_data[s])
                        for s in spell_list
                        if s in spell_data and monster.spellbook.can_cast(s, spell_data[s])
                    ]
                    
                    # If there are viable spells, choose one randomly
                    chosen_spell, chosen_spell_level = None, 0
                    if viable_spells:
                        chosen_spell, chosen_spell_level = randchoice(viable_spells)

                    if chosen_spell:
                        # Check if the monster needs to move to cast the spell
                        spell_range = get_spell_range(chosen_spell)
                        ideal_distance = max(30, spell_range - 30)  # Stay 30 ft away from max range if possible
                        
                        if distance != ideal_distance:
                            movement_direction = "towards" if distance > ideal_distance else "away from"
                            target_loc = mapl.coords_to_loc(target_pos)
                            start_loc = mapl.coords_to_loc(start_pos)
                            move_to_loc = find_ranged_adjacent_position(start_loc, target_loc, min(ideal_distance, monster_speed))
                            move_to_pos = mapl.loc_to_coords(move_to_loc)
                            move_distance = distance_function(start_loc, move_to_loc)
                            new_location, arrow, new_pos = move_towards(start_pos, move_to_pos, move_distance, unoccupied)
                            mapl.update_position(monster, placed, new_pos, out)
                            if arrow:
                                overlays.append(arrow)
                            desc.append(f"{indexed_combatant} uses {int(move_distance)} ft. out of their {monster_speed} ft. to {'move' if monster_move_verb == 'walk' else '*fly*'} {movement_direction} {chosen_target} for a better vantage point.")
                            
                            # After movement, display the updated map
                            map_state["combatants"] = out
                            map_url = map_tools.generate_map_image(overlays)
                            title = f"Monster Movement: {monster.name}"
                            command_list.append(f'{pref}{get_message.get_message(title=title, description=desc[-1], image=map_url)}')
                        else:
                            desc.append(f"{indexed_combatant} holds position, already at an ideal vantage point.")
                        
                        # Cast the spell
                        command_list.append(f'{pref}i cast "{chosen_spell}" -t {chosen_target} -l {chosen_spell_level} -phrase ":robot: _Triggered by auto monster AI_"')
                        desc.append(f"{indexed_combatant} casts {chosen_spell} at {chosen_target}.")
                        command_list.append(f'{pref}i n')
                        return

                # Melee combat logic (if not a spellcaster or out of spell slots)
                if max_attack_reach < distance:
                    move_distance = min(monster_speed, distance - max_attack_reach)
                    go_distance = min(melee)
                    go_coords = randchoice(melee[go_distance])
                    
                    # Monster needs to dash   
                    if monster_speed < go_distance: # distance - max_attack_reach:
                        new_location, arrow, new_pos = move_towards(start_pos, go_coords, monster_speed * 2, unoccupied, occupied)
                        mapl.update_position(monster, placed, new_pos, out)
                        if new_pos != start_pos:
                            overlays.append(create_arrow_overlay(go_distance, location, new_location))
                        go_distance = round(mapl.distance(start_pos, new_pos)) * 5
                        desc.append(f"{indexed_combatant} dashes {int(go_distance)} ft. out of their {monster_speed*2} ft. dash distance, towards {chosen_target}.")
                        map_url = map_tools.generate_map_image(overlays)
                        title = f"Monster Dashes: {monster.name}"
                        command_list.append(f'{pref}{get_message.get_message(title=title, description=desc[-1], image=map_url)}')
                        command_list.append(f'{pref}i n')
                        return
                    else: # Monster can reach target  
                        new_location = mapl.coords_to_loc(go_coords)
                        mapl.update_position(monster, placed, go_coords, out)
                        overlays.append(create_arrow_overlay(go_distance, location, new_location))
                        distance = round(mapl.get_nearest(go_coords, size_m, target_pos, target_size_mod)[0])
                        desc.append(f"{indexed_combatant} uses {int(go_distance)} ft. out of their {monster_speed} ft. to {'move' if monster_move_verb == 'walk' else '*fly*'} towards {chosen_target}.")
                        
                    # After movement, display the updated map
                    map_state["combatants"] = out
                    map_url = map_tools.generate_map_image(overlays)
                    title = f"Monster Movement: {monster.name}"
                    command_list.append(f'{pref}{get_message.get_message(title=title, description=desc[-1], image=map_url)}')
                else:
                    phrase = f"\nHolding Position to Attack!"
            else:
                desc.append(f"Could not find location for target: {chosen_target}")

        else:
            chosen_target = targets[randint(len(targets))]
            distance = 8  # Assume adjacent if no map
            desc.append(f"{indexed_combatant} attacks {chosen_target}.")

        # Attack logic
        if distance <= get_max_attack_reach(monster.attacks) and (curr_hp > 0 or autolib.onDeath(indexed_combatant, c.combatants) == "relentless"):
            # Multiattack logic
            mon_actions = autolib.getActions(monster_name)
            multi_atks = autolib.getMultiAttacks(mon_actions)

            if multi_atks:
                for atk, num in multi_atks.items():
                    atkr = autolib.resolveVersatile(atk)
                    command_list.append(f'{pref}i a "{atkr}" {snippets} -rr {num} autoc -t {chosen_target} -phrase ":robot: _Triggered by auto monster AI_ :crossed_swords: Multiattack :crossed_swords:{phrase}"')
                command_list.append(f'{pref}i n')
            else:
                chosen_atk_string = autolib.getAttack(indexed_combatant, c.combatants)
                command_list.append(f'{pref}i a "{chosen_atk_string}" {snippets} -t {chosen_target} autoc -phrase ":robot: _Triggered by auto monster AI_{phrase}"')
                command_list.append(f'{pref}i n')    
        elif curr_hp <= 0:
            on_death = autolib.onDeath(indexed_combatant, c.combatants)
            if on_death:
                target_string = f"-t {chosen_target}" if "death" in on_death else ""
                command_list.append(f'{pref}i a "{on_death}" {snippets} {target_string} -phrase ":robot: _Triggered by auto monster AI_"')
            else:
                desc.append(f"Skipping dead monster: {indexed_combatant}")
                command_list.append(f'{pref}i n')
        else:
            desc.append(f"{indexed_combatant} couldn't reach {chosen_target} to attack.")
            command_list.append(f'{pref}i n')

        if monster.hp <= 0:
            remove_dead_monster(c, monster, out, desc)
            map_url = map_tools.generate_map_image(overlays)
            title = f"Skipping dead monster: {monster_name}" 
            description = f"{monster_name} has been defeated and removed from the map. Its turn will be skipped."
            command_list.append(f'{pref}{get_message.get_message(title=title, description=description, image=map_url)}')
            return

    def remove_dead_monster(combat, monster, out, desc):
        if monster.name in out:
            out.pop(monster.name)
        desc.append(f"{monster.name} has fallen and been removed from the map.")

    def toggle_monster_color(monster, new_color):
        note_dict = mapl.parse_note(monster.note)
        original_color = note_dict.get('color', 'r')
        note_dict['color'] = new_color
        new_note = ' | '.join(f"{k.title()}: {v}" for k, v in note_dict.items())
        monster.set_note(new_note)
        
        if monster.name in out:
            out[monster.name]['color'] = new_color
        
        return original_color

    def process_map_absentee_monster_turn(indexed_combatant, command_list):
        title = f'New monster detected: {indexed_combatant}'
        desc_text = f'This monster is not currently on the map, please place the monster\'s token on the map manually using: ```{pref}map -t {indexed_combatant}|C4```\nReplace `C4` to any location you like.'
        command_list.append(f'{pref}{get_message.get_message(title=title, description=desc_text)}')
        command_list.append(f'{pref}i n')



    overlays = []
    desc = []

    indexed_cname_list = []
    curr_combatant = c.current

    snippets = []
    if auto_once:
        if current_init in monster_names:
            process_monster_turn(current_init, out, overlays, desc, command_list, snippets[1:])
            # Update map_state["combatants"] with 'out'
            map_state["combatants"] = out
            if overlays:
                map_url = map_tools.generate_map_image(overlays)
                title = "Updated Map"
                description = "Monster movements displayed"
                command_list.append(f'{pref}{get_message.get_message(title=title, description=description, image=map_url)}')
            return command_list
        
    # Build the indexed list starting from current initiative
    # Sort the combatants by initiative (descending) and then by name
    combatants_in_order = c.combatants
    cname_list_sorted = [combatant.name for combatant in combatants_in_order]

    indexed_cname_list = cname_list_sorted[cname_list_sorted.index(current_init):] + cname_list_sorted[:cname_list_sorted.index(current_init)]

    if len(indexed_cname_list) > 4:
        indexed_cname_list = indexed_cname_list[:4]

    current_enemy = autolib.isMonster(c.current)
    for indexed_combatant in indexed_cname_list:
        if len(command_list) > 10:
            title = f'Whoa! You\'re pushing the limits of Avrae right now!'
            desc_text = f'Unfortunately, this is the maximum number of attacks you can automate to prevent unnecessarily over-stressing Avrae!\n\n**But no worries, you can simply use `{cmd}` again now to repeat the cycle!**'
            while len(command_list) > 10:
                command_list.reverse()
                last_n = command_list.index(f'{pref}i n')
                command_list = command_list[last_n+1:]
                command_list.reverse()
            command_list.append(f'{pref}i n')
            command_list.append(f'{pref}{get_message.get_message(title=title, description=desc_text)}')
            return command_list
        
        monster = c.get_combatant(indexed_combatant)    
        if monster.monster_name:
            if autolib.isMonster(monster) != current_enemy:
                title = f'''Automation Complete! It\'s the other side's turn now! :mage:'''
                desc_text = f'Waiting on **{indexed_combatant}** to play their turn!'
                command_list.append(f'{pref}{get_message.get_message(title=title, description=desc_text)}')
                return command_list
                
            note = mapl.parse_note(monster.note)
            if not note or not 'location' in note:
                process_map_absentee_monster_turn(indexed_combatant, command_list)
            else:
                process_monster_turn(indexed_combatant, out, overlays, desc, command_list, snippets)
                # toggle_monster_color(monster, 'r' if current_enemy else 'b')
        else: # Handle non-monster combatants
            if indexed_combatant.casefold() in ['map', 'dm', 'lair'] and c.get_combatant(indexed_combatant).init == 20:
                title = f'Automation Complete! Waiting on Lair Action :dragon:'
                desc_text = f'Use `{pref}i n` if there are no actions to take this round!'
            elif auto_react:
                command_list.pop()
                title = f'Automation Complete! Pausing to allow player reaction! :mage:'
                desc_text = f'After taking any reaction use `{pref}i n`'
            else:
                title = f'Automation Complete! It\'s a player turn now! :mage:'
                desc_text = f'Waiting on **{indexed_combatant}** to play their turn!'
            command_list.append(f'{pref}{get_message.get_message(title=title, description=desc_text)}')
            break

    # Update map_state["combatants"] with 'out'
    map_state["combatants"] = out
    title = "Updated Map"
    description = "Monster movements displayed"

    if overlays:
        map_url = map_tools.generate_map_image(overlays)
        map_embed = f'{pref}{get_message.get_message(title=title, description=description, image=map_url)}'
        command_list.append(map_embed)
        return command_list

    return command_list