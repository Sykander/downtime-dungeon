![banner](/public/img/banner.png)

# Downtime Dungeon

This is a collection of aliases for avrae, to be used to run an automated downtime dungeon.

# Setup

## Quick Start

Copy the following avrae commands to add the downtime dungeon aliases.

```sh
!multiline
!alias sub https://avrae.io/dashboard/workshop/617805d1137cd863517bc42c
!alias sub https://avrae.io/dashboard/workshop/5f6a4623f4c89c324d6a5cd3
!alias sub https://avrae.io/dashboard/workshop/5f88d637f2d59b2718721a9a
!alias sub https://avrae.io/dashboard/workshop/63fe7c97caaad20bc4903309
!alias sub https://avrae.io/dashboard/workshop/630b0e39b85ea38890666c08
!alias sub https://avrae.io/dashboard/workshop/672e0ad6edc17a92c4ddbfae
```

# Dependencies

## Required Workshops

The following workshops are required to work alongside the downtime dungeon commands.

* Auto Monster AI https://avrae.io/dashboard/workshop/617805d1137cd863517bc42c
* Map Utilities https://avrae.io/dashboard/workshop/5f6a4623f4c89c324d6a5cd3
* Initiative Utilities https://avrae.io/dashboard/workshop/5f88d637f2d59b2718721a9a
* Targetting Assist https://avrae.io/dashboard/workshop/63fe7c97caaad20bc4903309
* Tool Checks https://avrae.io/dashboard/workshop/630b0e39b85ea38890666c08

## Optional Workshops

The following are not required but work well alongside the downtime dungeon:

* Riptide Shortcuts https://avrae.io/dashboard/workshop/60069282052554a14d397617
* Bard SFX https://avrae.io/dashboard/workshop/638f5e434dbab671607f33a5
  * Get the Discord Bot https://discorddungeon.com/

# How does the Dungeon work?

The dungeon descends downwards with an uncountable number of floors, each connected to the last by a set of stairs.

On each dungeon floor is an encounter, either with hostile creatures which must be defeated to progress, or a special encounter such as a shop, a rest stop, some treasure or a fellow adventurer.

The higher floors are more well traveled, and have fewer enemies and less treasure, whereas the deeper levels are still unexplored and filled with mystery.

Adventurers can enter the dungeon either solo or with a group of up to three others; starting at the 1st floor they must work their way down overcoming each encounter as they go. At any point whilst not in combat an adventurer can choose to return to the surface, at which point they leave the dungeon taking all that they found with them. Additionally, adventurers can attempt to retreat during combat by making their way back to the stairs to the previous floor, at which point they leave the dungeon taking all they found with them.

# Dying within the Dungeon

The dungeon is a special area protected by powerful magic protecting the souls of lost adventurers. Any adventurer who dies within the dungeon is transported to the entrance of the dungeon, leaving **all** of the gear they took with them or found within the dungeon at the location they died.

Gear lost to death can be retrieved by reaching the floor you previously died upon and sucesfully clearing the encounter on that floor.

# How to run a dungeon?

First run the `!dungeon setup` command, this will open an initiative called "Downtime Dungeon". All the adventurers should join combat and do their preparations.

When ready run `!dungeon begin` which will bring the adventurers to the first floor.

From here, run the `!dungeon floor` command to learn information about your current floor and `!dungeon next` to progress to the next floor.

At any point you may run the `!dungeon script` command to check the dungeon rules, eg. if you wanted to check the rules on hiding `!dungeon script -search "hiding"`.

When everyone has retreated run `!dungeon end`.

# Script

There is no DM so players must assist an automated tool to run the monsters. Players should follow the rules from `!dungeon script`.

# Development

[Link to workshop](https://avrae.io/dashboard/workshop/6724c0c5cf218c9fbfeada12)

We have a development alias workshop which can be used to test commands. It contains the most recent version of the code on main branch.

You can copy the following avrae commands to subscribe to the the Development aliases and use them under the command `!devDungeon`.

```sh
!multiline
!alias sub https://avrae.io/dashboard/workshop/6724c0c5cf218c9fbfeada12
!alias rename dungeon devDungeon
```

# Production

[Link to workshop](https://avrae.io/dashboard/workshop/672e0ad6edc17a92c4ddbfae)

We have a production alias workshop. It contains the latest release version of the code on main branch.

You can copy the following avrae commands to subscribe the Downtime Dungeon aliases.

```sh
!alias sub https://avrae.io/dashboard/workshop/672e0ad6edc17a92c4ddbfae
```

# Server Vars

The Downtime Dungeon can be configured to run differently based on the svars in the server.

These configurations **must** be deterministic, meaning the same input **always** gives the same output, even if called multiple times.

We use a custom written `random` module which is intended to be used in conjunction with the configuration to give deterministic results.

```py
using(random="a1cd80b3-772b-49b7-8bf0-c743cd380ccb")
```

## Gold
`DowntimeDungeon_gold` - gvar_id
Configures how much gold is earnt per floor.

The corresponding gvar if set should contain a function called `get_gold_for_floor` which takes the arguments `floor_data` and `dungeon_data` and returns and `int`.

```py
def get_gold_for_floor(floor_data, dungeon_data):
    return floor_data["floor_num"]
```

## Special Floor Chance
`DowntimeDungeon_special_floor_chance` - gvar_id
Configures the chance of a special floor appearing on a floor.

The corresponding gvar if set should contain a function called `get_is_special_floor` which takes the argument `dungeon_data` and returns a `bool` corresponding to whether a floor is special or not.

```py
def get_is_special_floor(dungeon_data):
  return dungeon_data["floor_num"] % 5 == 0
```

## Primary NPC Chance
`DowntimeDungeon_primary_npc_chance` - gvar_id
Configures the chance of the primary npc showing up on a floor.

The corresponding gvar if set should contain a function called `get_has_primary_npc` which takes the argument `dungeon_data` and returns a `bool` corresponding to if the npc shows up on that floor or not.

```py
using(random="a1cd80b3-772b-49b7-8bf0-c743cd380ccb")

def get_has_primary_npc(dungeon_data):
  return random.get_random_integer(0, 100, dungeon_data["floor_seed"] + 99) > 80
```

## Secondary NPC Chance
`DowntimeDungeon_secondary_npc_chance` - gvar_id
Configures the chance of the secondary npc showing up on a floor.

The corresponding gvar if set should contain a function called `get_has_secondary_npc` which takes the argument `dungeon_data` and returns a `bool` corresponding to if the npc shows up on that floor or not.

```py
using(random="a1cd80b3-772b-49b7-8bf0-c743cd380ccb")

def get_has_secondary_npc(dungeon_data):
  return random.get_random_integer(0, 100, dungeon_data["floor_seed"] + 929) > 90
```

## CR
`DowntimeDungeon_cr_calculator` - gvar_id
Configures the CR for each floor.

The corresponding gvar if set should contain a function called `get_cr` which takes the argument `dungeon_data` and returns a `float` corresponding to the CR.

Do not return negative CRs!

```py
using(random="a1cd80b3-772b-49b7-8bf0-c743cd380ccb")

def get_cr(dungeon_data):
  min_cr = 5
  cr_range = 5
  return random.get_random_integer(min_cr, min_cr + cr_range, dungeon_data["floor_seed"])
```

## Special Floors
`DowntimeDungeon_special_floors` - gvar_id
Configures the list of potential special floors

The corresponding gvar if set should contain a function called `get_special_floors_list` which takes the argument `default_list` and returns a `list` to use on the server.

```py
def get_special_floors_list(default_list):
  default_list.append({
    "name": "Mid Dungeon Bar",
    "desc": """Buy a drink for 1 gp each or rest for a couple of hours for 25 gp!
    
  Each adventurer may pay 25 gp to short rest on this floor."""
  })
  return default_list
```

`DowntimeDungeon_pick_special_floor` - gvar_id
Specifies what special floor should be chosen from the list dependent on the floor number.

The corresponding gvar if set should contain a function called `pick_special_floor` which takes the arguments `floor_list` and `floor_num`, and returns the list entry to use.

```py
def pick_special_floor(floor_list: list[Object], floor_num: int):
    return floor_list[5]
```

## Monsters
`DowntimeDungeon_monsters` - gvar_id
Configures the list of potential monsters

The corresponding gvar if set should contain a function called `get_monster_list` which takes the argument `default_list` and returns a `list` to use on the server.

The configure_monster() function takes the list of arguments shown below.
It creates the monster in the format the alias expects.

```py
using(
    monsters = "c1a83721-ba23-43e6-992d-3c5c3f56c93b"
)

extra_monsters = [monsters.configure_monster(
    name = "Lich",
    image_url = "https://www.dndbeyond.com/avatars/thumbnails/30832/378/1000/1000/638063837085902470.png",
    token = "mjy4f",
    size = "M",
    type_str = "Undead",
    cr = 21,
    pp = 19,
    legendary_actions = True,
    legendary_resistance = True
  ),
]

def get_monster_list(default_list):
  default_list.extend(extra_monsters)
  return default_list
```

# Environmemt Variables

We have environment variables for deploying the workshop and gvars.

```sh
ENV=Development
AVRAE_TOKEN=***
```

## ENV

A string representing the environment.
* `Development`
* `Production`

## AVRAE_TOKEN

A string authentication token, used when publishing new versions of the workshop or gvars.

You can get an AVRAE_TOKEN by:
1. Go to [Avrae](https://avrae.io/) and log in to the dashboard
2. Open the Developer Tools
3. Go to the `Application` tab
4. On the left, select `https://avrae.io` under `Local Storage`
5. Copy the `Value` next to the `avrae-token` key
