<drac2>
using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_message = env.get_gvar_id_by_name("get_message"),
    get_dungeon_data = env.get_gvar_id_by_name("get_dungeon_data"),
    get_status = env.get_gvar_id_by_name("get_status")
)

com = combat()

if not com:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

dungeon_data = get_dungeon_data.get_dungeon_data(com)

if not dungeon_data["started"]:
    return get_message.get_error("Ooops... you're not in a dungeon right now.")

close_images = [
    "https://i.imgur.com/JvZ3Iuj.png",
    "https://i.imgur.com/53zaagy.png",
    "https://i.imgur.com/XmZKqhQ.jpeg",
    "https://i.imgur.com/9lC3fQ5.jpeg",
    "https://i.imgur.com/xBdB1WP.png",
    "https://i.imgur.com/CwxUEj5.jpeg"
]
contributors = [":fox: Dodge :fox:", ":wolf: BrokenTorch :wolf:", ":dragon: Frederic :dragon:", ":unicorn: CJSparkle :unicorn:"]

def format_credits() -> str:
    last_contributor = contributors[-1]
    return f'Credits|Developed by {", ".join(contributors[:-1])}, and {last_contributor}.'

fields = [get_status.get_status_description(com.round_num, dungeon_data), format_credits()]
image = close_images[random.get_random_integer(0, len(close_images) - 1)]
description =  f'You closed the Downtime Dungeon after {dungeon_data["floor_num"]} floors.'

return f'multiline \n{ctx.prefix}i end \n{ctx.prefix}{get_message.get_message(description=description, fields=fields, image=image)}'
</drac2>