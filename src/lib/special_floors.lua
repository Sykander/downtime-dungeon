# Development
# 9d986792-ba34-491c-8d26-5191ca05aa5d
# Production
# 14e039a9-8241-464d-9209-23114d166f59

special_floors_list = [
    {
        "name": "Shop",
        "desc": "You come across a small shop run by another adventurer. He's selling 3 health potions for 50 gp each."
    },
    {
        "name": "Expensive Shop",
        "desc": "You come across a small shop run by an opportunistic adventurer. He's selling 3 health potions for 150 gp each."
    },
    {
        "name": "Very Expensive Shop",
        "desc": "You come across a small shop run by a wealthy adventurer. He's selling 3 health potions for 300 gp each."
    },
    {
        "name": "Hidden Room",
        "desc": "This floor has a hidden room which can be opened or closed. A single adventurer can make an Investigation check DC 15 to uncover a place to short rest."
    },
    {
        "name": "Hooded Figure Shortcut 5",
        "desc": "A strange hooded figure greets you from the corner of the room. A single adventurer can make a Persuassion check DC 15 to uncover a secret shortcut passed the next 5 floors. If you attempt to look under the figure's hood ||he instantly vanishes in a cloud of smoke||."
    },
    {
        "name": "Hooded Figure Shortcut 2",
        "desc": "A strange hooded figure greets you from the corner of the room. A single adventurer can make a Persuassion check DC 10 to uncover a secret shortcut passed the next 2 floors. If you attempt to look under the figure's hood ||he instantly vanishes in a cloud of smoke||."
    },
    {
        "name": "Short rest room",
        "desc": "Any adventurer with a Passive Perception of 15 or a Passive Investigation of 13 will notice a secluded spot in the room where the adventurers may short rest."
    },
    {
        "name": "Gold Stockpile",
        "desc": "Any adventurer with a Passive Perception of 16 or a Passive Investigation of 12 will notice a hidden stash of gold in the corner of the room amounting to 100 gp!"
    },
    {
        "name": "Gold Stockpile Badly Hidden",
        "desc": "Any adventurer with a Passive Perception of 12 or a Passive Investigation of 10 will notice a not very well hidden stash of gold in the middle of the room amounting to 25 gp!"
    },
    {
        "name": "Adventurer's Rest",
        "desc": "It seems this floor is well stocked with provisions and offers a safe place to stop and rest. All adventurers present may take a short rest."
    },
    {
        "name": "A Cunning Deal",
        "desc": "An adventurer on this floor offers to show you a place to rest in exchange for 100 gp. The fee may be paid once, and then all adventurers present may take a short rest."
    },
    {
        "name": "A Strange Reward",
        "desc": """A strange hooded figure greets you from the corner of the room.

**Hooded Figure**: "Impressive… you've come far. Few make it this deep." *They tilt their head slightly, the faintest glimmer of teeth beneath the hood.*

**Hooded Figure**: "Rest now. I’ll keep watch. Nothing will harm you… not while I’m here." *The figure lingers in silence, their presence unnervingly still.*

All adventurers present may take a short rest under the watchful gaze of the hooded figure."""
    },
    {
        "name": "Invigorating Surge",
        "desc": f"The air on this floor is awash with humming magical energy. All adventurers present gain 10 temporary hp. ```{ctx.prefix}g thp 10```"
    },
    {
        "name": "Friendly Owl",
        "desc": """A friendly owl with big, warm eyes, soft earthy feathers, and a gentle, curious expression perched in a nook of the room peers over towards the adventurers.

Any adventurer present may cast Speak with Animals to talk with the owl, and read the following spoilered text.

||> **Owl**: "Hooot! Travelers, you look weary. Follow me, and I’ll guide you to a safe hollow where you can rest your wings—or feet, as it may be."
> 
> If any adventurer speaks to the owl with Speak with Animals then all adventurers present may take a short rest.||"""
    },
    {
        "name": "Wise Owl",
        "desc": """A friendly owl with big, warm eyes, soft earthy feathers, and a gentle, curious expression perched in a nook of the room peers over towards the adventurers.

Any adventurer present may cast Speak with Animals to talk with the owl, and read the following spoilered text.

||> **Owl**: "Hoot! Travelers, you look weary. I know where you might find something to help you on your journey. Follow me, and I’ll show you the way." 
> 
> The owl flaps its wings and begins to hop down from its perch, glancing back to make sure the adventurers are following. It leads them to a hidden alcove in the room, where a small, forgotten shelf holds a Potion of Healing, tucked neatly away from view. The owl tilts its head, waiting for the adventurers to retrieve the potion. 
> 
> **Owl**: "Here it is—just what you need. Be careful, though! Not everything is as easy to find as this." ||"""
    },
    {
        "name": "Indecephirable Text",
        "desc": """A weathered stone, etched with ancient script and cryptic symbols, warns of unknown trials and hidden secrets awaiting within the dungeon's depths.

Any adventurer present may cast Comprehend Languages to read the weathered stone, and may read the following spoilered text.

||> **Weathered Stone** *"Seek the hollow echo; beyond the unseen lies solace and safety."*
> 
> After reading this stone with Comprehend Languages and searching for at least 10 minutes, the adventurers find a hidden room behind a false wall. All adventurers present may take a short rest.||"""
    },
    {
        "name": "Thieves' Cache",
        "desc": f"""A stone wall on the dungeon floor is marked with precise, deliberate carvings. The letters are sharp and clean, each line carefully cut into the rough surface. Surrounding the main text are faint, curving scratches, their arrangement subtle but intentional.

**Dungeon Wall:** "Beneath stone and shadow, where silence screams, I have walked the unseen path. Beware the third step at the bridge, for it claims the careless. Trust only the stones unstained by blood. When the corridor splits, follow the whisper, not the wind. Time twists here; what you see may not be, and what you miss may have passed. If you find this, tread softly and swiftly—time runs thin."

Any adventurer who knows Thieves' Cant may interpret a hidden message amongst the carvings, and may read the following spoilered text.

||> **Dungeon Wall:** "There is a hidden stash of gold and potions hidden underneath an unmarked stone three paces from the foot of this wall. Beware, the hidden dart trap." 
> 
> After reading this message, and adventurer present with a set of Thieves Tools may locate the unmarked stone and make a Dexterity Thieves Tool Check DC 10 to disarm the trap and reveal the stash.```{ctx.prefix}tool thieves dex -dc 10```
> After making the Tool Check, pass or fail, you may read the next spoilered text block.||

||> On a pass the trap is disarmed and the stash is revealed, on a failure the trap triggers and the stash is still revealed. The trap inflicts 1 piercing damage and 2d8 poison damage to the adventurer who failed the Thieves Tool Check.
> 
> The stash contains 50 gp and 2 Potions of Healing.||"""
    },
    {
        "name": "Hallowed Fox",
        "desc": """This floor is hallowed. Any creature can communicate with any other creature in the area, even if they don’t share a common language.
        
A small fox steps into view, its russet fur sleek and its eyes bright with curiosity. It tilts its head at the adventurers, then grins and flicks its tail.

**Fox**: "Hey there!" *the fox says in a cheerful voice.* "You look like you could use a good spot to rest. Follow me, I've got just the place—quiet, comfy, and perfect for a quick break."

**Fox**: With a playful bounce, the fox starts off, glancing back to make sure you’re following. "Trust me, you won’t want to miss it. It’s the best place around for a bit of peace and quiet."

The fox moves with a lively, confident pace, clearly enjoying the chance to guide the group. After 1 minutes walk the fox leads the adventurers to a place where they all may short rest."""
    },
    {
        "name": "Goblin Family",
        "desc": f"""Any adventurer with a passive perception of 16 or higher will notice a small opening in the dungeon floor, and may read the following spoilered text.

||> The floor opens up to a small, dimly lit space beneath the dungeon. The stone is rough and uneven, and a faint warmth from a low fire contrasts with the cold, damp air. Goblins—two adults and two young ones—are gathered around a pot, eying the adventurers with wary curiosity. The area is simple, with makeshift bedding and a few scattered belongings, giving the space a humble, lived-in feel. The fire flickers gently, casting shadows as the goblins quietly observe the newcomers, their bright eyes watching every movement.
> 
> A single adventurer present who speaks the Goblin language may attempt a Persuasion check DC 15 to convince the goblins that you aren't a threat. On a success you may read the following spoilered text.||
||> The goblin with broad shoulders grunts and nods toward the cooking pot, his voice rough but not unfriendly. "It's okay," he says, "we share meal." He gestures for the adventurers to approach, his posture easing slightly.
> 
> The other goblin, smaller and with a soft smile, looks up and gives a welcoming nod. "Eat, rest," she says in a gentle tone, motioning toward the fire.
> 
> The two goblin children, full of energy, rush over to the adventurers, their earlier caution forgotten. They begin to play around the group, laughing and darting between the adventurers' legs, eager for attention and companionship.
> 
> All adventurers present may take a short rest in the goblin residence.||"""
    },
    {
        "name": "Sanctuary of the Light",
        "desc": """The floor is bathed in a soft, otherworldly glow. The stone floor is smooth and well-kept, almost as if it has been untouched for centuries. At the center of the room stands an ornate pedestal, atop which rests a simple, yet beautiful golden chalice. The air feels thick with divine energy, as if the very space is a sanctum for the faithful. A faint whisper seems to echo from the walls, speaking in an long forgotton tongue.
      
At the far end of the room, a small altar with a flickering candle sits against the wall, surrounded by the remnants of old, worn offerings. Upon closer inspection, you notice that the air grows heavier around the chalice as you draw near.

Any cleric present may sense the divine power of this room, and if they take the time to pray, the air around them will grow even warmer. The divine energy seems to respond to their faith.

A cleric who offers a prayer (lasting 10 minutes) may attempt a Religion check, DC 15. Upon making a successful Religion check, they may read the following text:

||> The chalice glows brightly for a moment, filling the cleric with a sense of peace and clarity. A gentle warmth spreads through their body, and the divine energy of the room seems to offer a small boon.
> 
> Roll a `1d3` to determine which benefit the cleric gains.
> 1. The chalice, though empty, grants the cleric 1d4+1 temporary hit points.
> 2. The divine power of the room restores one of the cleric's expended 1st level spell slots.
> 3. The altar empowers the cleric's holy symbol allowing them to add +1 to their next Healing Word or Cure Wounds spell cast within the next 24 hours.||

If the prayer is not offered or is failed, the chalice remains dim, but the cleric still feels a sense of calm, as if their devotion has been acknowledged."""
      },
      {
        "name": "Spirit of the Depths",
        "desc": """A being made out of pure light appears in the floor, floating from one end of the room to the other. You get the impression that it is bored. Adventures can make DC 13 performance check to entertain the floating light. On a success, you may read the following spoilered text.
||> The spirit grants each adventurers a blessing of protection, allowing them to use a reaction to gain resistance against once damage type until the start of your next turn. ||"""
      }
]