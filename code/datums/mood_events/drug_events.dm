/datum/mood_event/high
	mood_change = 6
	description = span_nicegreen("Woooow duudeeeeee...I'm tripping baaalls...")

/datum/mood_event/smoked
	description = span_nicegreen("I have had a smoke recently.")
	mood_change = 1
	timeout = 6 MINUTES

/datum/mood_event/wrong_brand
	description = span_warning("That brand of cigarette just doesn't hit right.")
	mood_change = -1
	timeout = 6 MINUTES

/datum/mood_event/overdose
	mood_change = -8
	timeout = 5 MINUTES

/datum/mood_event/overdose/add_effects(drug_name)
	description = span_warning("I think I took a bit too much of that [drug_name]")

/datum/mood_event/withdrawal_light
	mood_change = -2

/datum/mood_event/withdrawal_light/add_effects(drug_name)
	description = span_warning("I could use some [drug_name]")

/datum/mood_event/withdrawal_medium
	mood_change = -5

/datum/mood_event/withdrawal_medium/add_effects(drug_name)
	description = span_warning("I really need [drug_name]")

/datum/mood_event/withdrawal_severe
	mood_change = -8

/datum/mood_event/withdrawal_severe/add_effects(drug_name)
	description = span_boldwarning("Oh god I need some of that [drug_name]")

/datum/mood_event/withdrawal_critical
	mood_change = -10

/datum/mood_event/withdrawal_critical/add_effects(drug_name)
	description = span_boldwarning("[drug_name]! [drug_name]! [drug_name]!")

/datum/mood_event/happiness_drug
	description = span_nicegreen("Can't feel a thing...")
	mood_change = 50

/datum/mood_event/happiness_drug_good_od
	description = span_nicegreen("YES! YES!! YES!!!")
	mood_change = 100
	timeout = 30 SECONDS
	special_screen_obj = "mood_happiness_good"

/datum/mood_event/happiness_drug_bad_od
	description = span_boldwarning("NO! NO!! NO!!!")
	mood_change = -100
	timeout = 30 SECONDS
	special_screen_obj = "mood_happiness_bad"

/datum/mood_event/narcotic_light
	description = span_nicegreen("I feel so soft.")
	mood_change = 2
	timeout = 3 MINUTES

/datum/mood_event/narcotic_medium
	description = span_nicegreen("I feel comfortably numb.")
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/narcotic_heavy
	description = span_nicegreen("I feel like I'm wrapped up in cotton!")
	mood_change = 9
	timeout = 3 MINUTES

/datum/mood_event/stimulant_medium
	description = span_nicegreen("I have so much energy! I feel like I could do anything!")
	mood_change = 4
	timeout = 3 MINUTES

/datum/mood_event/stimulant_heavy
	description = span_nicegreen("Eh ah AAAAH! HA HA HA HA HAA! Uuuh.")
	mood_change = 6
	timeout = 3 MINUTES

/datum/mood_event/legion_good
	mood_change = 5
	description = span_nicegreen("Everything feels so light! I'm strong! Unstoppable!")

/datum/mood_event/legion_bad
	mood_change = -4
	description = span_warning("Something is slithering through my veins")

/datum/mood_event/stoned
	mood_change = 6
	description = span_nicegreen("The world is so comfortable...")

/datum/mood_event/nicotine_withdrawal_moderate
	description = "<span class='warning'>Haven't had a smoke in a while. Feeling a little on edge... </span>\n"
	mood_change = -5

/datum/mood_event/nicotine_withdrawal_severe
	description = "<span class='boldwarning'>Head pounding. Cold sweating. Feeling anxious. Need a smoke to calm down!</span>\n"
	mood_change = -8
