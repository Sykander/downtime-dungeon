# Development
# c8d78194-0128-4429-a253-e6a2df36caf2
# Production
# 468bce27-653b-47aa-b8ed-9357196459df

def set_combatant_square(combatant, square):
    note = combatant.note or ""
    note_sections = note.split(" | ")

    new_note_sections = []

    if len(note_sections) > 1:
        for note_section in note_sections:
            if not note_section.startswith("Location"):
                new_note_sections.append(note_section)

    new_note_sections.append(f"Location: {square}")

    if len(new_note_sections) == 1:
        new_note = new_note_sections[0]
        combatant.set_note(new_note)
        return new_note

    new_note = new_note_sections[0]
    for new_note_section in new_note_sections[1:]:
        new_note += " | " + new_note_section
    
    combatant.set_note(new_note)
    return new_note