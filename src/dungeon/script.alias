<drac2>
using(env="0836565c-d03d-4f1f-9306-5e210c69b3d1")
using(
    get_message = env.get_gvar_id_by_name("get_message"),
    script = env.get_gvar_id_by_name("script")
)

args = argparse(&ARGS&)
search = args.last("search", None)

filtered_script = script.get_script(search)
filtered_script_len = len(filtered_script)

script_output = ""

if filtered_script_len == 0:
    return get_message.get_message(f"No script sections matched the search {search}.")

for index, section in enumerate(filtered_script):
    script_output += f'**{section.title}**'
    script_output += f'\n{section.body}'
    if index != filtered_script_len-1:
        script_output += f'\n'

return get_message.get_message(script_output, footer="Try running !help dungeon script -here")
</drac2>