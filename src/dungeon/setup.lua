<drac2>
using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_message = env.get_gvar_id_by_name("get_message")
)

if combat():
    return get_message.get_error(f"This channel is already in initiative, please close it with `{ctx.prefix}i end` before starting a dungeon.")

messageOpen = get_message.get_message(f'{name} opens the Downtime Dungeon!')

# convert to multiline
output = f'multiline {ctx.prefix}{messageOpen}\n'

# Create Combat
output += f'{ctx.prefix}i begin -name "Downtime Dungeon"\n'

# Add Dungeon Welcome Message
title = "The Dungeon welcomes you!"
description = f"Please can all adventurers join initiative, long rest, and do any other necessary preparations. Make sure not to end initiative as this will close the dungeon. If you have any allies add them as allies with ```{ctx.prefix}team 1 <name>```"
fields = [f"Ready?|When you are ready to continue please run: ```{ctx.prefix}dungeon begin```"]
messageWelcome = get_message.get_banner(description, fields, title)
output += f'{ctx.prefix}{messageWelcome}'
return output
</drac2>