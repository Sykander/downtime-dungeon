# Development
# d2ad1c71-0e1d-464c-b90f-761405cd249b
# Production
# 3dc472d1-b166-49a5-a801-ead859547152

using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    random = env.get_gvar_id_by_name("random"),
)

first_names = [
    "Alex",
    "Ben",
    "Caira",
    "Derrick",
    "Edward",
    "Fiona",
    "George",
    "Henry",
    "Ingrid",
    "Jane",
    "Kenneth",
    "Luna",
    "Munne",
    "Nile",
    "Orchid",
    "Peter",
    "Quark",
    "Rufus",
    "Sarah",
    "Timmy",
    "Una",
    "Vera",
    "Ward",
    "Xavier",
    "Yenna",
    "Zeek",
    "Alden",
    "Brina",
    "Caelum",
    "Daria",
    "Elric",
    "Fiora",
    "Garrick",
    "Haleth",
    "Ilyra",
    "Joren",
    "Kaela",
    "Lorien",
    "Marek",
    "Nerys",
    "Oryn",
    "Prynn",
    "Quinn",
    "Rellan",
    "Sylas",
    "Taryn",
    "Ulric",
    "Vaela",
    "Weylin",
    "Xander",
    "Yara",
    "Zarek"
]
first_names_len = len(first_names)

last_names = [
    "Ashford",
    "Briar",
    "Caldwell",
    "Darrow",
    "Everhart",
    "Fletcher",
    "Graves",
    "Hawke",
    "Ivers",
    "Jasper",
    "Kingsley",
    "Lennox",
    "Marsden",
    "North",
    "Oakwood",
    "Pryor",
    "Quill",
    "Rook",
    "Storm",
    "Thorne",
    "Underwood",
    "Voss",
    "Winslow",
    "Xander",
    "York",
    "Zephyr",
    "Ash",
    "Briarcrest",
    "Cliff",
    "Drakefell",
    "Elder",
    "Farsong",
    "Glimmer",
    "Hollow",
    "Ironbrand",
    "Kindle",
    "Lark",
    "Mist",
    "Nether",
    "Oath",
    "Pyre",
    "Quarrydeep",
    "Ridge",
    "Shadowthorn",
    "Thorn",
    "Umber",
    "Vyrnshade",
    "Wraith",
    "Silver",
    "Stone",
    "Wolf"
]
last_names_len = len(last_names)

gifts = [
    "Blue Potion of Healing",
    "Purple Potion of Growth",
    "Lilac Elixir of Health",
    "Green Potion of Advantage",
    "Opalescent Potion of Polychromy"
]

goals = [
    {
        "name": "Lost Relic",
        "desc": "The adventurer is searching the dungeon for an ancient and long lost relic.",
        "explanation_dialogue": "I once sought to uncover the secrets hidden in these halls. But what I found here was a trap. A curse perhaps, or worse I fear. Every time I think I’ve found a way out, the maze shifts, and I’m back where I started.",
        "gift_dialogue": "Here, take this. I found it buried beneath a pile of rubble. It’s not the relic I seek, but perhaps it will aid you in your own journey.",
        "joins_combat_dialogue_list": [
            '"Ahhh, more adventurers here to find treasure I presume? Quick, help me with these monsters!" *The adventurer gestures frantically at the approaching creatures, raising their weapon.*',
            '"Blast it all, I had almost uncovered the secret behind this place when these monsters attacked me! Help me with them please?" *They clutch the relic fragments they were holding, eyes filled with frustration.*',
            '"Arrhhhhhhh...." *The adventurer screams in pain as one of the monsters gets him, staggering back and raising his weapon weakly in defense.*'
        ]
    },
    {
        "name": "Prestige",
        "desc": "The adventurer is looking to make a name for themselves as a famous and skilled dungeon delver.",
        "explanation_dialogue": "I've heard stories, you know... tales of those who entered these halls and came out legends. I've always wanted more than just gold or treasure. I want prestige—the kind that makes my name known in every tavern and on every street. I want to carve my place into the history of this dungeon, to be remembered as the one who conquered its greatest horrors.",
        "gift_dialogue": "This isn’t much, but it’s something I came across during my search. A token, perhaps, to remember me by when tales of our deeds are told.",
        "joins_combat_dialogue_list": [
            '"Ha! A perfect opportunity to showcase my skill! Watch and learn as I take them down!" *The adventurer strikes with flair, clearly attempting to impress those around them.*',
            '"Do you see this? This is how legends are made! Come, fight alongside me!" *They leap into battle with a wide grin, eager to show their worth.*',
            '"Finally, a chance to prove my worth! Together, we’ll make history!" *They shout as they rush forward with dramatic gusto, sword gleaming.*'
        ]
    },
    {
        "name": "Lost and Confused",
        "desc": "The adventurer entered the dungeon with a larger party but somewhere along the way they were separated from the others. Now they seek to catch up to their lost group.",
        "explanation_dialogue": "I—I’m not supposed to be here alone. There were others, a larger group... but somewhere down here, we got separated. It’s all a blur. We were fighting off creatures, and then the tunnel collapsed, and when I came to, everyone was gone. I’ve been searching for hours—days, maybe?—but this dungeon... it’s like it shifts, changes. It’s hard to keep track of anything.",
        "gift_dialogue": "I stumbled across this while searching for my friends. Maybe it will help you find your way, even if I haven’t found mine yet.",
        "joins_combat_dialogue_list": [
            '"Not again! These monsters won’t stop coming! Help me fight them off, please!" *The adventurer glances nervously over their shoulder, eyes wide as they scramble to prepare for the incoming battle.*',
            '"I can’t do this alone—there’s no way I’ll survive without your help!" *They shout, looking around in confusion, clutching their weapon tightly.*',
            '"I thought I heard my group ahead, but it was just..." *They freeze as the creatures approach before shouting,* "These things! Defend yourselves!" *They raise their shield defensively, face pale.*'
        ]
    },
    {
        "name": "Forgotten Vows",
        "desc": "The adventurer has come to fulfill a promise made long ago to a friend or loved one who perished in the dungeon.",
        "explanation_dialogue": "I swore an oath, a long time ago. To them. To make sure their story didn’t end here, in the cold and the dark. They came here chasing a dream, and all they found was an end they didn’t deserve. I’ve carried that weight with me ever since. I have to find their remains—or the treasure they sought—and bring it back to the surface. For them. For me.",
        "gift_dialogue": "I found this near where they fell. I think it’s meant to help someone. Maybe that someone is you.",
        "joins_combat_dialogue_list": [
            '"For the vow I made! I won’t let these monsters stop me now—fight by my side!" *The adventurer grips a locket tightly, eyes burning with resolve.*',
            '"These beasts think they can keep me from honoring their memory? I’ll destroy them!" *They strike with purpose, each blow carrying the weight of their oath.*',
            '"Stay with me! Together, we’ll make sure this place doesn’t claim any more lives!" *The adventurer moves protectively in front of you, their voice full of determination.*'
        ]
    },
    {
        "name": "Ancient Rivalry",
        "desc": "The adventurer is determined to settle a score with an old enemy who has also entered the dungeon.",
        "explanation_dialogue": "It's not about treasure for me. No. It’s *him*. He’s always one step ahead, mocking me, taunting me. If he’s in here, then I’ll find him. And this time, I’ll finish it. This dungeon may be the end of one of us, but it won’t be me.",
        "gift_dialogue": "This isn’t the prize I’m after, but it could still prove useful to you. Take it—before he finds a way to use it against us.",
        "joins_combat_dialogue_list": [
            '"He’s probably watching, laughing. Let’s show him what I’m made of! Help me end this!" *They charge into the fray with wild fervor, eyes scanning for their rival.*',
            '"Do you see him? He’s here somewhere! We’ll fight him together—he won’t win!" *The adventurer charges ahead, voice full of fury.*',
            '"I won’t let him outshine me—not here, not ever! Fight!" *They shout with conviction as they swing their weapon with renewed energy.*'
        ]
    },
    {
        "name": "Cursed Redemption",
        "desc": "The adventurer is seeking a way to lift a curse that has plagued them since their last ill-fated venture into a dungeon.",
        "explanation_dialogue": "It’s been years since I’ve felt whole. This curse... it clings to me, draining my strength, my will. The last time I entered a place like this, I was foolish, reckless. And I paid the price. They said the cure might be here, buried deep in these forgotten halls. I don’t know if I’ll make it out, but if I don’t try, this curse will kill me—or worse.",
        "gift_dialogue": "I came across this while seeking my cure. It’s no help to me, but perhaps it can be to you. Use it well.",
        "joins_combat_dialogue_list": [
            '"I can feel it... the curse pulling me down! Help me, or it will claim us both!" *The adventurer staggers slightly, gasping for breath as they struggle to move.*',
            '"This curse... it weakens me with every step. I need your help to survive this!" *They wince as they fight, their body aching from the curse’s toll.*',
            '"I won’t let this curse stop me from finding the cure. Together, we’ll make it!" *They brace themselves, determined to push through the pain and continue the fight.*'
        ]
    },
    {
        "name": "Debt of Blood",
        "desc": "The adventurer owes a life debt to someone who disappeared into the dungeon, and they’ve vowed to bring them back—or die trying.",
        "explanation_dialogue": "They saved me, once. Pulled me out of the jaws of death when no one else would. Now it’s my turn. They came here, chasing glory, gold—who knows? But they never came back. I owe them my life. So I’ll find them, or what’s left of them. And if the dungeon takes me, at least I’ll have paid my debt.",
        "gift_dialogue": "This belonged to someone who came before me. I owe them everything. They would've wanted you to have it.",
        "joins_combat_dialogue_list": [
            '"I won’t let them die in vain! Help me finish this!" *The adventurer grits their teeth, face set in grim determination.*',
            '"They saved me... Now it’s my turn to save them! Help me!" *They charge forward with a battle cry, eyes filled with resolve.*',
            '"I owe them everything. We’ll fight together, and we’ll make sure they’re never forgotten!" *The adventurer strikes hard, moving as though every blow is a tribute.*'
        ]
    },
    {
        "name": "Unfinished Research",
        "desc": "The adventurer is a scholar or mage searching for forbidden knowledge hidden within the dungeon.",
        "explanation_dialogue": "This dungeon is more than just stone and traps. It’s a vault of secrets—magic, history, things forgotten by the world above. My colleagues called me mad to come here, but they don’t understand. The answers to my questions lie in these depths. I can feel it. If I can survive long enough to uncover them, the world will know my name for centuries.",
        "gift_dialogue": "Ah, take this! I’ve cataloged its properties, and it no longer serves my work. But in your hands, it might just save your life.",
        "joins_combat_dialogue_list": [
            '"This is fascinating! Look at the architecture here—how did they build this? Wait... the monsters! Fight them off!" *The adventurer scribbles notes as they fumble for their weapon.*',
            '"Ah! A breakthrough! Now, let’s deal with these creatures before they ruin my discovery!" *They leap into combat, completely absorbed in their research.*',
            '"I must find more information—there’s so much to learn down here! But first, these monsters!" *They shout as they rush forward, swiping their staff at the enemies.*'
        ]
    },
    {
        "name": "Lost Love",
        "desc": "The adventurer is desperately searching for their lost lover, who disappeared into the dungeon on a previous expedition.",
        "explanation_dialogue": "They came here, against my wishes. Said they had to prove themselves, had to bring something back that would make everything better. That was months ago. Everyone says they’re gone, that I should move on. But I know they’re still in here. I feel it. And I’ll keep searching until I find them, no matter what stands in my way.",
        "gift_dialogue": "I found this during my search for them. It feels wrong to keep it, like it’s meant for someone else. Maybe it’s meant for you.",
        "joins_combat_dialogue_list": [
            '"Where are you? Please, if you’re alive, call out! I’ll find you!" *The adventurer’s voice cracks with desperation, eyes scanning every shadow.*',
            '"I won’t stop searching! Not until I find them!" *They fight with a frenzied urgency, always glancing around, hoping to catch a glimpse of their loved one.*',
            '"Stay with me... We’ll make it through together, no matter what." *They rally themselves, their voice full of determination and longing.*'
        ]
    },
    {
        "name": "Test of Worth",
        "desc": "The adventurer is here as part of a rite of passage or sacred trial to prove their worth to their people or a secret order.",
        "explanation_dialogue": "This is the test. The trial. The elders said I wouldn’t survive, that no one ever does. But if I do, if I make it out alive, I’ll be more than just another apprentice or outcast. I’ll be worthy—of respect, of power, of the name they said I could never claim.",
        "gift_dialogue": "This is something I discovered along my trial. Take it—you’ll need all the help you can get.",
        "joins_combat_dialogue_list": [
            '"This is the moment! My test begins now!" *The adventurer stands tall, their eyes fierce with focus.*',
            '"I won’t fail! Not here, not after everything I’ve been through!" *They grip their weapon tightly, face flushed with determination.*',
            '"Watch and learn—this trial will be mine to conquer!" *The adventurer charges in, clearly eager to prove themselves.*'
        ]
    }
]
goals_len = len(goals)

def leadership_action(npc, floor_data, dungeon_data):
    return f"""{ctx.prefix}i aoo "{npc["full_name"]}" leadership"""

def invisibility_action(npc, floor_data, dungeon_data):
    adventurers = dungeon_data["adventurers"]
    adventurers_len = len(adventurers)
    adventurer_index = random.get_random_integer(0, adventurers_len - 1)
    adventurer = adventurers[adventurer_index]
    return f"""{ctx.prefix}i rc "{npc["full_name"]}" "Greater Invisibility" -t "{adventurer}" """

def cure_wounds_action(npc, floor_data, dungeon_data):
    adventurers = dungeon_data["adventurers"]
    adventurers_len = len(adventurers)
    adventurer_index = random.get_random_integer(0, adventurers_len - 1)
    adventurer = adventurers[adventurer_index]
    return f"""{ctx.prefix}i rc "{npc["full_name"]}" "Cure Wounds" -t "{adventurer}" """

actions = {
    "leadership": leadership_action,
    "invisibility": invisibility_action,
    "cure_wounds": cure_wounds_action
}

npc_sheets = [
    {
        "name": "Fighter",
        "monster": "Knight",
        "has_special_actions": True,
        "special_actions": ["leadership"]
    },
    {
        "name": "Wizard",
        "monster": "Mage",
        "has_special_actions": True,
        "special_actions": ["invisibility"]
    },
    {
        "name": "Cleric",
        "monster": "Priest",
        "has_special_actions": True,
        "special_actions": ["cure_wounds"]
    },
    {
        "name": "Rogue",
        "monster": "Assassin",
        "has_special_actions": False,
        "special_actions": []
    }
]
npc_sheets_len = len(npc_sheets)

def gift_dialogue(npc, floor_data, dungeon_data):
    descriptive_text = """The sound of the adventurers footsteps echoes softly against the damp stone walls. In the center of the chamber sits a solitary figure—another adventurer. They're tending to a small, flickering campfire, their eyes, despite their weariness, are alert and sharp.

They look up slowly as the adventurers approach, sizing them up with a mixture of curiosity and caution."""

    line1 = "Hmm... didn’t expect to find anyone alive down here. Not often do people make it this far... Not many make it back from the deeper parts of this place. The dungeon changes, you see. Always shifts, always moves. It can get... personal, real quick."
    gift_index = random.get_random_integer(0, len(gifts) - 1, floor_data["seed"] + 27382)
    gift = gifts[gift_index]

    return f"""{descriptive_text}

**{npc["full_name"]}**: "{line1}"

**{npc["full_name"]}**: "{npc["goal"]["gift_dialogue"]}"

{npc["first_name"]} hands over a {gift}."""

def surprised_dialogue(npc, floor_data, dungeon_data):
    line1_variant1 = "I didn’t expect to find anyone still breathing down here. Most adventurers lose their way, or worse, they end up as little more than bones or shadows in this forsaken place."
    line1_variant2 = "You’re alive? That’s... unexpected. This place doesn’t let many leave with their wits or their lives intact."
    line1_variant3 = "It’s rare to meet another soul down here, let alone one still clinging to life. Most who come lose more than just their way."
    line1_variant4 = "Well, you're a rare sight. Most who tread these halls don’t last long—either the traps take them, or the monsters do."
    line1_variant5 = "It’s good to see another friendly face down here. Most days, it feels like I’m the only one left alive in this place."
    line1_variant6 = "You’re alive? That’s wonderful! It’s been far too long since I’ve seen someone who isn’t a threat in these halls."
    line2_variant1 = "Tell me, how did you come to wander so deep into this accursed dungeon? Few even dare, and fewer still return. Are you seeking treasure or something more?"
    line2_variant2 = "What could drive someone to venture so far into the heart of this cursed labyrinth? Gold, glory, or something far darker?"
    line2_variant3 = "What brings you here, so deep beneath the surface? Are you chasing riches, revenge, or perhaps just a death wish?"
    line2_variant4 = "Tell me, what led you here? A bit of adventure, or perhaps you’re searching for something precious?"
    line2_variant5 = "So, what’s your story? What’s got you exploring a place like this? Looking for fame, fortune, or something more personal?"

    line1_variants = [
        line1_variant1,
        line1_variant2,
        line1_variant3,
        line1_variant4,
        line1_variant5,
        line1_variant6
    ]
    line1_index = random.get_random_integer(0, len(line1_variants) - 1, floor_data["seed"] + 9752)
    line1 = line1_variants[line1_index]

    line2_variants = [
        line2_variant1,
        line2_variant2,
        line2_variant3,
        line2_variant4,
        line2_variant5
    ]
    line2_index = random.get_random_integer(0, len(line2_variants) - 1, floor_data["seed"] + 63782)
    line2 = line2_variants[line2_index]

    return f"""The party hear the faintest sounds of footsteps approaching, echoing from the distance-- soft at first, then growing louder as the individual approaches. The {npc["sheet"]["name"].lower()} {npc["first_name"]} emerges from around a corner appearing startled but curious upon seeing the adventurers.

**{npc["full_name"]}** "{line1}"

**{npc["full_name"]}** "{line2}"

Any adventurer present may respond to {npc["first_name"]}, answering their questions, and after doing so a single adventurer may make a DC 10 persuassion check to ask the same of {npc["first_name"]}, and read the following spoilered text. On a failure, {npc["first_name"]} changes the subject.

||> **{npc["full_name"]}** "{npc["goal"]["explanation_dialogue"]}"
> 
> All adventurers present have learnt more about the nature of the dungeon from {npc["first_name"]}, the dungeon changes- its walls shifting and rearranging to mislead those who entered. The cryptic symbols were not mere decoration, but warnings, left by those who had failed before. With this newfound understanding, the adventurers could now anticipate the dungeon's tricks, using its patterns to their advantage and gaining the upper hand on the next floor.
> 
> Any monsters encountered on the next floor are surprised on the first round of combat.||"""

non_combat_events = [
    {
        "name": "Surprised",
        "dialogue": surprised_dialogue
    },
    {
        "name": "Gift",
        "dialogue": gift_dialogue
    }
]
def get_random_npc(seed = None):
    if seed != None:
        random.setSeed(seed)

    first_name_index = random.get_random_integer(0, first_names_len - 1)
    first_name = first_names[first_name_index]
    goal_index = random.get_random_integer(0, goals_len - 1)
    goal = goals[goal_index]
    last_name_index = random.get_random_integer(0, last_names_len - 1)
    last_name = last_names[last_name_index]
    npc_sheet_index = random.get_random_integer(0, npc_sheets_len - 1)
    npc_sheet = npc_sheets[npc_sheet_index]

    return {
        "first_name": first_name,
        "last_name": last_name,
        "full_name": f"""{first_name} {last_name}""",
        "goal": goal,
        "sheet": npc_sheet,
        "dead": False
    }