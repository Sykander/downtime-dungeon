# Development
# cf0a6486-b429-49fe-95b8-0dec6187a95d
# Production
# 37def108-11f5-45aa-a000-f8c68ff72207

seconds_in_a_round = 6
minute_in_rounds = 10
hour_in_rounds = 60 * minute_in_rounds
day_in_rounds = 24 * hour_in_rounds

def convert_rounds_to_time(round_num):
    days = floor((round_num) / day_in_rounds)
    hours = floor((round_num % day_in_rounds) / hour_in_rounds)
    minutes = floor((round_num % hour_in_rounds) / minute_in_rounds)
    seconds = (round_num % minute_in_rounds) * seconds_in_a_round

    return {
        "days": days,
        "hours": hours,
        "minutes": minutes,
        "seconds": seconds
    }

def get_status_description(round_num, dungeon_data):
    output = "Status|"

    output += f'**Floor:** {dungeon_data["floor_num"]}'
    output += f'\n**Gold:** {dungeon_data["gold"]} gp'

    time_data = convert_rounds_to_time(round_num)
    output += f'\n**Time:** '

    if time_data["days"] > 0:
        output += f'{time_data["days"]} days '

    if time_data["hours"] > 0:
        output += f'{time_data["hours"]} hours '

    if time_data["minutes"] > 0:
        output += f'{time_data["minutes"]} minutes '

    if (time_data["minutes"] == 0 and time_data["hours"] == 0 and time_data["days"] == 0) or time_data["seconds"] > 0:
        output += f'{time_data["seconds"]} seconds'

    return output
