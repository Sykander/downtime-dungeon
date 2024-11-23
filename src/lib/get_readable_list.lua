# fbdefe43-b658-482b-82ec-d77be042b98c

def get_readable_list(items):
    if len(items) == 1:
        items_str = items[0]
    else:
        items_str = " and ".join([", ".join(items[:-1]), items[-1]])

    return items_str