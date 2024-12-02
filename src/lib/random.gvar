# Development
# e0665619-4690-4724-875a-b6779e88a7f9
# Production
# a1cd80b3-772b-49b7-8bf0-c743cd380ccb	

SEED_KEY = "DowntimeDungeon_SeedData"
SEED_CURRENT = "current"
SEED_INITIAL = "initial"

value = {}
value[SEED_CURRENT] = int(314159265 + time())
value[SEED_INITIAL] = value[SEED_CURRENT]

def setSeed(newSeed: int):
    value[SEED_INITIAL] = newSeed
    value[SEED_CURRENT] = newSeed

def getState() -> dict[str, int]:
    return value

def setState(newState: dict[str, int]):
    value[SEED_INITIAL] = newState[SEED_INITIAL]
    value[SEED_CURRENT] = newState[SEED_CURRENT]

def getSeed() -> int:
    return value[SEED_INITIAL]

def xorShift(seed: int) -> int:
    seed ^= seed << 13
    seed ^= seed >> 17
    seed ^= seed << 5
    seed %= 2**31
    return int(seed)

# Generates number based off seed, inclusive of both endpoints
# If a seed is given, that is used instead, and the current seed is not changed.
def get_random_integer(start, stop, seed = None):
    if start == stop:
        return start
    if(start > stop):
        stop, start = start, stop

    updateSeed = False
    if(seed == None):
        updateSeed = True
        seed = value[SEED_CURRENT]

    range_length = stop - start + 1
    val = xorShift(int(seed))

    if(updateSeed):
        value[SEED_CURRENT] = val

    return round(val % range_length) + start