# Development
# 2513d58e-ef40-498d-9f0d-ef35ef480436
# Production
# 2d3e8126-cd02-4554-98f9-0a8dff98a09f

# Use these special quote marks to wrap the final content - so that " and ' don't break strings
EMBED_LEFT_QUOTE="《"
EMBED_RIGHT_QUOTE="》"

DUNGEON_LOGO_URL = "https://i.imgur.com/TH9C6ti.png"
DUNGEON_BANNER_URL = "https://i.imgur.com/7roeQ9T.png"
DUNGEON_COLOUR = "#776472"

title_base = "Downtime Dungeon"
footer_base = f"Try running {ctx.prefix}help dungeon -here"
embed_base = f'embed -thumb {DUNGEON_LOGO_URL} -color {DUNGEON_COLOUR}'
banner_base = f'embed -thumb {DUNGEON_LOGO_URL} -image {DUNGEON_BANNER_URL} -color {DUNGEON_COLOUR}'

def format_to_length(content, length):
    if len(content) < length:
        return content
    
    return f'{content[0:length - 3]}...'

def get_banner(description, fields, title = title_base, footer = footer_base):
    fields_strings = [f'-f {EMBED_LEFT_QUOTE}{format_to_length(field, 1020)}{EMBED_RIGHT_QUOTE}' for field in fields]
    fields_output = ''.join(fields_strings)
    return f'{banner_base} -title {EMBED_LEFT_QUOTE}{title}{EMBED_RIGHT_QUOTE} -desc {EMBED_LEFT_QUOTE}{format_to_length(description, 4020)}{EMBED_RIGHT_QUOTE} {fields_output} -footer {EMBED_LEFT_QUOTE}{footer}{EMBED_RIGHT_QUOTE}'

def get_error(description: str) -> str:
    return f'{embed_base} -title {EMBED_LEFT_QUOTE}Error{EMBED_RIGHT_QUOTE} -desc {EMBED_LEFT_QUOTE}{format_to_length(description, 4020)}{EMBED_RIGHT_QUOTE}'

def get_message(description: str, fields: list[str] = [], title = title_base, footer = footer_base, image = None) -> str: 
    fields_strings = [f'-f {EMBED_LEFT_QUOTE}{format_to_length(field, 1020)}{EMBED_RIGHT_QUOTE} ' for field in fields]
    fields_output = ''.join(fields_strings)
    image_output = f'-image {image}' if image != None else ""
    return f'{embed_base} -title {EMBED_LEFT_QUOTE}{title}{EMBED_RIGHT_QUOTE} -desc {EMBED_LEFT_QUOTE}{format_to_length(description, 4020)}{EMBED_RIGHT_QUOTE} {fields_output} -footer {EMBED_LEFT_QUOTE}{footer}{EMBED_RIGHT_QUOTE} {image_output}'