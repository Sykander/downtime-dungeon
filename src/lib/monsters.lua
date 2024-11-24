# Development
# b0967794-7146-4503-ba0c-b94aa539b321
# Production
# c1a83721-ba23-43e6-992d-3c5c3f56c93b

# https://www.dndbeyond.com/sources/dnd/basic-rules-2014/monsters#MonsterStatBlocks

def configure_monster(
    name: str,
    size: str,
    cr: float,
    image_url: str = "",
    token: str = "",
    type_str: str = "",
    pp: int = 10,
    legendary_actions: bool = False,
    legendary_resistance: bool = False,
):
    return {
        "name": name,
        "size": size,
        "image_url": image_url,
        "token": token,
        "type": type_str,
        "cr": cr,
        "pp": pp,
        "legendary_actions": legendary_actions,
        "legendary_resistance": legendary_resistance
    }

monster_list = [
    configure_monster(
        name = "Kobold",
        size = "S",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30832/207/1000/1000/638063832924455756.png",
        token = "9wp52",
        type_str = "Humanoid",
        cr = 0.125,
        pp = 8
    ),
    configure_monster(
        name = "Bandit",
        size = "Medium",
        token = "jen83",
        type_str = "Humanoid",
        cr = 0.125,
        pp = 10
    ),
    configure_monster(
        name = "Goblin",
        size = "Small",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30783/955/1000/1000/638062024584880857.png",
        token = "2ftz7",
        type_str = "Humanoid (goblinoid)",
        cr = 0.25,
        pp = 9
    ),
    configure_monster(
        name = "Aboleth",
        size = "L",
        token = "v5gn3",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30761/774/1000/1000/638061093283829548.png",
        type_str = "Aberration",
        cr = 10,
        pp = 10,
        legendary_actions = True
    ),
    configure_monster(
        name = "Adult Black Dragon",
        size = "H",
        token = "ymjq9",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/337/1000/1000/638061959000854245.png",
        type_str = "Dragon",
        cr = 14,
        pp = 21,
        legendary_actions = True,
        legendary_resistance = True
    ),
    configure_monster(
        name = "Adult Blue Dragon",
        size = "H",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/21222/259/1000/1000/637708181891538923.jpeg",
        token = "ptvyz",
        type_str = "Dragon",
        cr = 16,
        pp = 22,
        legendary_actions = True,
        legendary_resistance = True
    ),
    configure_monster(
        name = "Adult Brass Dragon",
        size = "H",
        token = "rrwkg",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/464/1000/1000/638061963274504288.png",
        type_str = "Dragon",
        cr = 13,
        pp = 21,
        legendary_actions = True,
        legendary_resistance = True
    ),
    configure_monster(
        name = "Adult Bronze Dragon",
        size = "H",
        token = "5bn3d",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/507/1000/1000/638061964555495008.png",
        type_str = "Dragon",
        cr = 15,
        pp = 22,
        legendary_actions = True,
        legendary_resistance = True
    ),
    configure_monster(
        name = "Adult Copper Dragon",
        size = "H",
        token = "nz9rv",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/529/1000/1000/638061965375855497.png",
        type_str = "Dragon",
        cr = 14,
        pp = 22,
        legendary_actions = True,
        legendary_resistance = True
    ),
    configure_monster(
        name = "Adult Gold Dragon",
        size = "H",
        token = "bs6v5",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/552/1000/1000/638061966174935960.png",
        type_str = "Dragon",
        cr = 17,
        pp = 24,
        legendary_actions = True,
        legendary_resistance = True
    ),
    configure_monster(
        name = "Adult Green Dragon",
        size = "H",
        token = "4jvey",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/384/1000/1000/638061960603885350.png",
        type_str = "Dragon",
        cr = 15,
        pp = 22,
        legendary_actions = True,
        legendary_resistance = True
    ),
    configure_monster(
        name = "Adult Red Dragon",
        size = "H",
        token = "m573u",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/23375/69/1000/1000/637791959730543418.jpeg",
        type_str = "Dragon",
        cr = 17,
        pp = 23,
        legendary_actions = True,
        legendary_resistance = True
    ),
    configure_monster(
        name = "Baboon",
        size = "S",
        token = "gnd6n",
        type_str = "Beast",
        cr = 0,
        pp = 11
    ),
    configure_monster(
        name = "Badger",
        size = "T",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43938/902/1000/1000/638607409157242443.png",
        token = "n2j44",
        type_str = "Beast",
        cr = 0,
        pp = 11
    ),
    configure_monster(
        name = "Balor",
        size = "H",
        token = "n2j44",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30781/600/1000/1000/638061930825811285.png",
        type_str = "Fiend (demon)",
        cr = 13,
        pp = 19
    ),
    configure_monster(
        name = "Barbed Devil",
        size = "M",
        token = "9cuts",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30781/992/1000/1000/638061947419365746.png",
        type_str = "Fiend (devil)",
        cr = 5,
        pp = 18
    ),
    configure_monster(
        name = "Banshee",
        size = "M",
        token = "nzq2a",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30761/972/1000/1000/638061101973584758.png",
        type_str = "Undead",
        cr = 4,
        pp = 10
    ),
    configure_monster(
        name = "Basilisk",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30761/974/1000/1000/638061102119934833.png",
        type_str = "Monstrosity",
        cr = 3,
        pp = 9,
        token = "jxk9b",
    ),
    configure_monster(
        name = "Bat",
        size = "T",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43938/918/1000/1000/638607409599142805.png",
        type_str = "Beast",
        cr = 0,
        pp = 11,
        token = "z7w7c",
    ),
    configure_monster(
        name = "Bearded Devil",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30781/994/1000/1000/638061947703806001.png",
        type_str = "Fiend (devil)",
        cr = 3,
        pp = 10,
        token = "y3w57",
    ),
    configure_monster(
        name = "Behir",
        size = "H",
        type_str = "Monstrosity",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30761/978/1000/1000/638061102241924981.png",
        cr = 11,
        pp = 16,
        token = "vpdmw",
    ),
    configure_monster(
        name = "Black Bear",
        size = "M",
        type_str = "Beast",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43938/930/1000/1000/638607409968563176.png",
        cr = 0.5,
        pp = 13,
        token = "zwvna",
    ),
    configure_monster(
        name = "Black Dragon Wyrmling",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/16/496/1000/1000/636376308217017511.jpeg",
        size = "M",
        type_str = "Dragon",
        cr = 2,
        pp = 14,
        token = "mqkse",
    ),
    configure_monster(
        name = "Black Pudding",
        size = "L",
        type_str = "Ooze",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30834/144/1000/1000/638063882400735307.png",
        cr = 4,
        pp = 8,
        token = "b6wam",
    ),
    configure_monster(
        name = "Blink Dog",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30849/285/1000/1000/638064498679906765.png",
        type_str = "Fey",
        cr = 0.25,
        pp = 13,
        token = "c5dck",
    ),
    configure_monster(
        name = "Blood Hawk",
        size = "S",
        type_str = "Beast",
        cr = 0.125,
        pp = 14,
        token = "whvr2",
    ),
    configure_monster(
        name = "Blue Dragon Wyrmling",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/21222/242/1000/1000/637708181281501343.jpeg",
        type_str = "Dragon",
        cr = 3,
        pp = 14,
        token = "jvv3x",
    ),
    configure_monster(
        name = "Boar",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43938/952/1000/1000/638607410436443314.png",
        type_str = "Beast",
        cr = 0.25,
        pp = 9,
        token = "ybuq6",
    ),
    configure_monster(
        name = "Bone Devil",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30781/997/1000/1000/638061947836745919.png",
        type_str = "Fiend (devil)",
        cr = 9,
        pp = 12,
        token = "2dacm",
    ),
    configure_monster(
        name = "Brass Dragon Wyrmling",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/475/1000/1000/638061963543984454.png",
        type_str = "Dragon",
        cr = 1,
        pp = 14,
        token = "jd4ng",
    ),
    configure_monster(
        name = "Bronze Dragon Wyrmling",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/16/492/1000/1000/636376306909593829.jpeg",
        type_str = "Dragon",
        cr = 2,
        pp = 14,
        token = "7neu7",
    ),
    configure_monster(
        name = "Brown Bear",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/60/1000/1000/638607413478213174.png",
        type_str = "Beast",
        cr = 1,
        pp = 13,
        token = "rx6gf",
    ),
    configure_monster(
        name = "Bugbear",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/31312/871/1000/1000/638084425511165687.png",
        type_str = "Humanoid (goblinoid)",
        cr = 1,
        pp = 10,
        token = "yet6d",
    ),
    configure_monster(
        name = "Bulette",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30762/8/1000/1000/638061103017271419.png",
        type_str = "Monstrosity",
        cr = 5,
        pp = 16,
        token = "5ks94",
    ),
    configure_monster(
        name = "Camel",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/74/1000/1000/638607413887821584.png",
        token = "9qnfp",
        type_str = "Beast",
        cr = 0,
        pp = 9
    ),
    configure_monster(
        name = "Cat",
        size = "T",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/81/1000/1000/638607414147450285.png",
        token = "b4drw",
        type_str = "Beast",
        cr = 0,
        pp = 13
    ),
    configure_monster(
        name = "Centaur",
        size = "L",
        token = "n49rf",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30762/233/1000/1000/638061114013567234.png",
        type_str = "Monstrosity",
        cr = 2,
        pp = 13
    ),
    configure_monster(
        name = "Chain Devil",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/3/1000/1000/638061947960875906.png",
        token = "b8684",
        type_str = "Fiend",
        cr = 8,
        pp = 11
    ),
    configure_monster(
        name = "Chimera",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30762/236/1000/1000/638061114170787382.png",
        token = "vy9na",
        type_str = "Monstrosity",
        cr = 6,
        pp = 18
    ),
    configure_monster(
        name = "Chuul",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30762/240/1000/1000/638061114295167448.png",
        size = "L",
        token = "cevt6",
        type_str = "Aberration",
        cr = 4,
        pp = 14
    ),
    configure_monster(
        name = "Clay Golem",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30783/964/1000/1000/638062024732910911.png",
        token = "wxuxb",
        type_str = "Construct",
        cr = 9,
        pp = 9
    ),
    configure_monster(
        name = "Cloaker",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30767/348/1000/1000/638061293461506894.png",
        token = "jwk5m",
        type_str = "Aberration",
        cr = 8,
        pp = 11
    ),
    configure_monster(
        name = "Cloud Giant",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30783/921/1000/1000/638062023711980751.png",
        size = "H",
        token = "yzwzv",
        type_str = "Giant",
        cr = 9,
        pp = 17
    ),
    configure_monster(
        name = "Cockatrice",
        size = "S",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30762/246/1000/1000/638061114558227584.png",
        token = "9czak",
        type_str = "Monstrosity",
        cr = 0.5,
        pp = 11
    ),
    configure_monster(
        name = "Constrictor Snake",
        size = "L",
        token = "vmdn2",
        type_str = "Beast",
        cr = 0.25,
        pp = 10
    ),
    configure_monster(
        name = "Copper Dragon Wyrmling",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/536/1000/1000/638061965633505640.png",
        token = "v4qzz",
        type_str = "Dragon",
        cr = 1,
        pp = 14
    ),
    configure_monster(
        name = "Couatl",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30763/227/1000/1000/638061153443493893.png",
        token = "zjv6y",
        type_str = "Celestial",
        cr = 4,
        pp = 15
    ),
    configure_monster(
        name = "Crab",
        size = "T",
        token = "mhkdg",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/116/1000/1000/638607415125489733.png",
        type_str = "Beast",
        cr = 0,
        pp = 9
    ),
    configure_monster(
        name = "Crocodile",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/131/1000/1000/638607415525020149.png",
        token = "8awad",
        type_str = "Beast",
        cr = 0.5,
        pp = 10
    ),
    configure_monster(
        name = "Cyclops",
        size = "H",
        token = "ccd4z",
        type_str = "Giant",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30762/257/1000/1000/638061114971477789.png",
        cr = 6,
        pp = 8
    ),
    configure_monster(
        name = "Darkmantle",
        size = "S", 
        cr = 0.5,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30781/549/1000/1000/638061928264742735.png",
        token = "vhgxe",
        type_str = "Monstrosity",
        pp = 10
    ),
    configure_monster(
        name = "Death Dog",
        size = "M",
        cr = 1,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30849/289/1000/1000/638064498770586789.png",
        token = "8gwma",
        type_str = "Monstrosity",
        pp = 15
    ),
    configure_monster(
        name = "Deer",
        size = "M", 
        cr = 0,
        type_str = "Beast",
        pp = 12
    ),
    configure_monster(
        name = "Deep Gnome (Svirfneblin)",
        size = "S",
        cr = 0.5,
        type_str = "Humanoid (gnome)",
        pp = 12,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/9/112/1000/1000/636323610009818415.jpeg",
        token = "5dn3m",
    ),
    configure_monster(
        name = "Deva",
        pp = 19,
        cr = 10,
        size = "M",
        type_str = "Celestial",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30761/784/1000/1000/638061093601900776.png",
        token = "n3947",
    ),
    configure_monster(
        name = "Djinni",
        size = "L", 
        cr = 11,
        image_url ="https://www.dndbeyond.com/avatars/thumbnails/30783/897/1000/1000/638062023191330690.png",
        token = "95ueq",
        type_str = "Elemental",
        pp = 13
    ),
    configure_monster(
        name = "Dire Wolf",
        cr = 1,
        pp = 13,
        type_str = "Beast",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/148/1000/1000/638607415935380377.png",
        token = "pm6ru",
    ),
    configure_monster(
        name = "Doppelganger",
        cr = 3,
        size = "M",
        pp = 11,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/216/1000/1000/638061954905389630.png",
        token = "4wvaa",
        type_str = "Monstrosity (shapechanger)",
    ),
    configure_monster(
        name = "Draft Horse",
        cr = 0.25,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/172/1000/1000/638607416542360472.png",
        token = "2ckws",
        size = "L",
        type_str = "Beast",
        pp = 10
    ),
    configure_monster(
        name = "Dragon Turtle",
        size = "G", 
        cr = 17,
        image_url="https://www.dndbeyond.com/avatars/thumbnails/0/291/1000/1000/636252771128151641.jpeg",
        token = "gvw93",
        type_str = "Dragon",
        pp = 11
    ),
    configure_monster(
        name = "Dretch",
        pp = 9,
        cr = 0.25,
        type_str = "Fiend (demon)",
        size = "S",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30781/610/1000/1000/638061931201709292.png",
        token = "yshna",
    ),
    configure_monster(
        name = "Drider",
        type_str = "Monstrosity",
        cr = 6,
        pp = 15,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/751/1000/1000/638061974723624008.png",
        token = "2vpa9",
        size = "L",
    ),
    configure_monster(
        name = "Drow",
        size = "M",
        cr = 0.25,
        image_url="https://www.dndbeyond.com/avatars/thumbnails/16/501/1000/1000/636376310726273495.jpeg",
        token = "vasqt",
        type_str = "Humanoid (elf)",
        pp = 12, 
    ),
    configure_monster(
        name = "Dryad",
        type_str = "Fey",
        size = "M",
        cr = 1,
        pp = 14,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/916/1000/1000/638061981460060607.png",
        token = "zxvnn",
    ),
    configure_monster(
        name = "Duergar",
        type_str = "Humanoid (dwarf)",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/763/1000/1000/638061975214164210.png",
        token = "rt3s8",
        cr = 1,
        pp = 10
    ),
    configure_monster(
        name = "Dust Mephit",
        size = "S",
        cr = 0.5,
        image_url="https://www.dndbeyond.com/avatars/thumbnails/34175/931/1000/1000/638190241938100148.png",
        token = "m9988",
        type_str = "Elemental",
       pp = 12, 
    ),
    configure_monster(
        name = "Eagle",
        type_str = "Beast",
        size = "S",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30849/292/1000/1000/638064498871776868.png",
        token = "rbanw",
        cr = 0,
        pp = 14
    ),
    configure_monster(
        name = "Earth Elemental",
        size = "L",
        cr = 5,
        image_url="https://www.dndbeyond.com/avatars/thumbnails/30783/692/1000/1000/638062015664899420.png",
        token = "bnu5g",
        type_str = "Elemental",
        pp = 10, 
    ),
    configure_monster(
        name = "Efreeti",
        type_str = "Elemental",
        size = "L",
        cr = 11,
        pp = 12,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30784/76/1000/1000/638062028391329539.png",
        token = "876bz",
    ),
    configure_monster(
        name = "Elephant",
        size = "H",
        cr = 4,
        type_str = "Beast",
        pp = 10
      ),
    configure_monster(
        name = "Elk",
        type_str = "Beast",
        size = "L",
        cr = 0.25,
        pp = 10
    ),
    configure_monster(
        name = "Erinyes",
        size = "M",
        cr = 12,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/8/1000/1000/638061948096035985.png",
        token= "wjuud",
        type_str = "Fiend",
        pp = 12, 
      ),
    configure_monster(
        name = "Ettercap",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30783/716/1000/1000/638062016297389481.png",
        token = "cnvxg",
        type_str = "Monstrosity",
        size = "M",
        cr = 2,
        pp = 13
    ),
    configure_monster(
        name = "Ettin",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30783/726/1000/1000/638062016402079484.png",
        token = "6ekzp",
        size = "L",
        type_str = "Giant",
        cr = 4,
        pp = 14
    ),
    configure_monster(
        name = "Gargoyle",
        size = "M",
        type_str = "Elemental",
        pp = 10,
        cr = 2,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30783/892/1000/1000/638062022959460682.png",
        token = "6gqd6"
    ),
    configure_monster(
        name = "Gelatinous Cube",
        type_str = "Ooze",
        size = "L",
        cr = 2,
        pp = 8,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30834/149/1000/1000/638063882505895317.png",
        token = "5w85c"
    ),
    configure_monster(
        name = "Ghast",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/0/411/1000/1000/636252786516023032.jpeg",
        token = "msyys",
        cr = 2,
        pp = 10,
        size = "M",
        type_str = "Undead",
    ),
    configure_monster(
        name = "Ghost",
        type_str = "Undead",
        size = "M",
        cr = 4,
        pp 11,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30783/917/1000/1000/638062023593120762.png",
        token = "mz6u8"
    ),
    configure_monster(
        name = "Ghoul",
        type_str = "Undead",
        size = "M",
        cr = 1,
        pp = 10,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/14/483/1000/1000/636364323937041514.png",
        token = "jrgme"
    ),
    configure_monster(
        name = "Giant Ape",
        type_str = "Beast",
        size = "H",
        cr = 7,
        pp = 14,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43938/889/1000/1000/638607408673681530.png",
        token = "vjqbr"
    ),
    configure_monster(
        name = "Giant Badger",
        type_str = "Beast",
        size = "M",
        cr = 0.25,
        pp = 11,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43938/902/1000/1000/638607409157242443.png",
        token = "z4zp9"
    ),
    configure_monster(
        name = "Giant Bat",
        type_str = "Beast",
        size = "L",
        cr = 0.25,
        pp = 11,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43938/918/1000/1000/638607409599142805.png",
        token = "mecq5"
    ),
    configure_monster(
        name = "Giant Boar",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43938/952/1000/1000/638607410436443314.png",
        token = "ybuq6",
        size = "L",
        pp = 8,
        cr = 2,
        type_str = "Beast"
    ),
    configure_monster(
        name = "Giant Centipede",
        size = "S",
        cr = 0.25,
        pp = 8,
        type_str = "Beast"
    ),
    configure_monster(
        name = "Giant Constrictor Snake",
        size = "H",
        cr = 2,
        pp = 12,
        type_str = "Beast"
    ),
    configure_monster(
        name = "Giant Crab",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/240/1000/1000/638607418422171721.png",
        token = "8xtmt",
        cr = 0.125,
        pp = 9,
        type_str = "Beast",
        size = "M"
    ),
    configure_monster(
        name = "Giant Crocodile",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/131/1000/1000/638607415525020149.png",
        token = "8awad",
        size = "H",
        type_str = "Beast",
        cr = 5,
        pp = 10
    ),
    configure_monster(
        name = "Giant Eagle",
        size = "L",
        type_str = "Beast",
        cr = 1,
        pp = 14,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30849/296/1000/1000/638064498953526929.png",
        token = "cvq9s"
    ),
    configure_monster(
        name = "Giant Elk",
        type_str = "Beast",
        size = "H",
        pp = 14,
        cr = 2
    ),
    configure_monster(
        name = "Giant Fire Beetle",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/9/896/1000/1000/636334287498492864.jpeg",
        token = "wpz53",
        cr = 0,
        pp = 8,
        size = "S"
    ),
    configure_monster(
        name = "Giant Frog",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/16/521/1000/1000/636376321052503535.jpeg",
        token = "rsstz",
        cr = 0.25,
        pp = 12
    ),
    configure_monster(
        name = "Giant Goat",
        cr = 0.5,
        pp = 11,
        type_str = "Beast",
        size = "L"
    ),
    configure_monster(
        name = "Giant Hyena",
        cr = 1,
        type_str = "Beast",
        size = "L",
        pp = 13,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/9/902/1000/1000/636334288674955736.jpeg",
        token = "jm7r7"
    ),
    configure_monster(
        name = "Giant Lizard",
        type_str = "Beast",
        size = "L",
        pp = 10,
        cr = 0.25
    ),
    configure_monster(
        name = "Giant Octopus",
        type_str = "Beast",
        cr = 1,
        pp = 14,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/9/898/1000/1000/636334288003435302.jpeg",
        size = "L",
        token = "gj8yx"
    ),
    configure_monster(
        name = "Giant Owl",
        type_str = "Beast",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/16/535/1000/1000/636376331788287090.jpeg",
        token = "rzpea",
        cr = 0.25,
        pp = 15
    ),
    configure_monster(
        name = "Giant Poisonous Snake",
        type_str = "Beast",
        size = "M",
        cr = 0.25,
        pp = 12
    ),
    configure_monster(
        name = "Giant Rat",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/16/538/1000/1000/636376332197953299.jpeg",
        token = "b9q4g",
        cr = 0.125,
        size = "S",
        pp = 10,
        type_str = "Beast"
    ),
    configure_monster(
        name = "Giant Scorpion",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/816/1000/1000/638607431888752085.png",
        size = "L",
        token = "nkyjz",
        cr = 3,
        pp 9,
        type_str = "Beast"
    ),
    configure_monster(
        name = "Giant Sea Horse",
        type_str = "Beast",
        size = "L",
        cr = 0.5,
        pp = 11
    ),
    configure_monster(
        name = "Giant Shark",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/787/1000/1000/638607431063881100.png",
        token = "bfq2x",
        cr = 5,
        pp = 13,
        type_str = "Beast",
        size = "L"
    ),
    configure_monster(
        name = "Giant Spider",
        type_str = "Beast",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/570/1000/1000/638607426460275494.png",
        token = "4gchd",
        size = "L",
        cr = 1,
        pp = 10
    ),
    configure_monster(
        name = "Giant Toad",
        type_str = "Beast",
        cr = 1,
        pp = 10,
        size = "L"
    ),
    configure_monster(
        name = "Giant Vulture",
        type_str = "Beast",
        size = "L",
        pp = 13,
        cr = 1
    ),
    configure_monster(
        name = "Giant Wasp",
        type_str = "Beast",
        size = "M",
        cr = 0.5,
        pp = 10
    ),
    configure_monster(
        name = "Giant Weasel",
        type_str = "Beast",
        cr = 0.125,
        size = "M",
        pp = 10,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/43939/590/1000/1000/638607426813965799.png",
        token = "99esf"
    ),
    configure_monster(
        name = "Giant Wolf Spider",
        type_str = "Beast",
        cr = 0.25,
        pp = 13,
        size = "M"
    ),
    configure_monster(
        name = "Glabrezu",
        size = "L",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30781/613/1000/1000/638061931338828581.png",
        token = "22tph",
        cr = 9,
        pp = 13
    ),
    configure_monster(
        name = "Gibbering Mouther",
        size = "M",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30784/554/1000/1000/638062046140139699.png",
        token = "5uy75",
        cr = 2,
        pp = 10,
        type_str = "Aberration"
    ),
    configure_monster(
        name = "Gnoll",
        size = "M",
        type_str = "Humanoid (gnoll)",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30784/505/1000/1000/638062044385041691.png",
        token = "wfm8t",
        cr = 0.5,
        pp = 10
    ),
    configure_monster(
        name = "Goat",
        size = "M",
        type_str = "Beast",
        cr = 0,
        pp = 10
    ),
    configure_monster(
        name = "Goblin",
        size = "S",
        type_str = "Humanoid (goblinoid)",
        cr = 0.25,
        pp = 9,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30783/955/1000/1000/638062024584880857.png",
        token = "z8hak"
    ),
    configure_monster(
        name = "Gold Dragon Wyrmling",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/562/1000/1000/638061966416208867.png",
        token = "vdzke",
        size = "M",
        type_str = "Dragon",
        pp 14,
        cr 3
    ),
    configure_monster(
        name = "Gorgon",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30784/711/1000/1000/638062051514524448.png",
        token = "85qr5",
        size = "L",
        type_str = "Monstrosity",
        cr = 5,
        pp = 14
    ),
    configure_monster(
        name = "Gray Ooze",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30834/153/1000/1000/638063882595415196.png",
        token = "cmcay",
        type_str = "Ooze",
        size = "M",
        cr = 0.5,
        pp 8
    ),
    configure_monster(
        name = "Green Dragon Wyrmling",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30782/393/1000/1000/638061960809474996.png",
        token = "w6ees",
        size = "M",
        type_str = "Dragon",
        cr = 2,
        pp = 14
    ),
    configure_monster(
        name = "Green Hag",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30788/618/1000/1000/638062177566175594.png",
        token = "6atwb",
        size = "M",
        type_str = "Fey",
        cr = 3,
        pp = 14
    ),
    configure_monster(
        name = "Grick",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30784/267/1000/1000/638062035101336042.png",
        token = "pxp97",
        cr = 2,
        pp = 12,
        size = "M",
        type_str = "Monstrosity"
    ),
    configure_monster(
        name = "Griffon",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30784/568/1000/1000/638062046654629903.png",
        token = "rvzqw",
        cr = 2,
        pp = 15,
        size = "Large",
        type_str = "Monstrosity"
    ),
    configure_monster(
        name = "Grimlock",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30784/270/1000/1000/638062035227436078.png",
        token = "5pcma",
        cr = 0.25,
        pp = 13,
        size = "M",
        type_str = "Humanoid (grimlock)"
    ),
    configure_monster(
        name = "Guardian Naga",
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30833/678/1000/1000/638063870254701844.png",
        token = "n77b8",
        cr = 10,
        pp = 14,
        size = "L",
        type_str = "Monstrosity"
    ),
    configure_monster(
        name = "Gynosphinx",
        legendary_actions = True,
        size = "L",
        type_str = "Monstrosity",
        cr = 11,
        pp = 18,
        image_url = "https://www.dndbeyond.com/avatars/thumbnails/30835/919/1000/1000/638063924067395675.png",
        token = "42pug"
    )
]

def get_monsters_in_cr_range(cr_min, cr_max):
    monsters_in_range = []

    for monster in monster_list:
        if monster.cr >= cr_min and monster.cr <= cr_max:
            monsters_in_range.append(monster)

    return monsters_in_range
