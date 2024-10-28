/datum/mood_event/handcuffed
	description = span_warning("I guess my antics have finally caught up with me.")
	mood_change = -1

/datum/mood_event/broken_vow //Used for when mimes break their vow of silence
	description = span_boldwarning("I have brought shame upon my name, and betrayed my fellow mimes by breaking our sacred vow...")
	mood_change = -8

/datum/mood_event/on_fire
	description = span_boldwarning("I'M ON FIRE!!!")
	mood_change = -12

/datum/mood_event/suffocation
	description = span_boldwarning("CAN'T... BREATHE...")
	mood_change = -12

/datum/mood_event/burnt_thumb
	description = span_warning("I shouldn't play with lighters...")
	mood_change = -1
	timeout = 2 MINUTES

/datum/mood_event/cold
	description = span_warning("It's way too cold in here.")
	mood_change = -5

/datum/mood_event/hot
	description = span_warning("It's getting hot in here.")
	mood_change = -5

/datum/mood_event/creampie
	description = span_warning("I've been creamed. Tastes like pie flavor.")
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/slipped
	description = span_warning("I slipped. I should be more careful next time...")
	mood_change = -2
	timeout = 3 MINUTES

/datum/mood_event/eye_stab
	description = span_boldwarning("I used to be an adventurer like you, until I took a screwdriver to the eye.")
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/delam //SM delamination
	description = span_boldwarning("Those God damn engineers can't do anything right...")
	mood_change = -2
	timeout = 4 MINUTES

/datum/mood_event/depression_minimal
	description = span_warning("I feel a bit down.")
	mood_change = -10
	timeout = 2 MINUTES

/datum/mood_event/depression_mild
	description = span_warning("I feel sad for no particular reason.")
	mood_change = -12
	timeout = 2 MINUTES

/datum/mood_event/depression_moderate
	description = span_warning("I feel miserable.")
	mood_change = -14
	timeout = 2 MINUTES

/datum/mood_event/depression_severe
	description = span_warning("I've lost all hope.")
	mood_change = -16
	timeout = 2 MINUTES

/datum/mood_event/dismembered
	description = span_boldwarning("AHH! I WAS USING THAT LIMB!")
	mood_change = -10
	timeout = 8 MINUTES

/datum/mood_event/tased
	description = span_warning("There's no \"z\" in \"taser\". It's in the zap.")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/embedded
	description = span_boldwarning("Pull it out!")
	mood_change = -7

/datum/mood_event/table
	description = span_warning("Someone threw me on a table!")
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/table_headsmash
	description = span_warning("My fucking head, that hurts...")
	mood_change = -3
	timeout = 3 MINUTES

/datum/mood_event/brain_damage
	mood_change = -3

/datum/mood_event/brain_damage/add_effects()
	var/damage_message = pick_list_replacements(BRAIN_DAMAGE_FILE, "brain_damage")
	description = span_warning("Hurr durr... [damage_message]")

/datum/mood_event/hulk //Entire duration of having the hulk mutation
	description = span_warning("HULK SMASH!")
	mood_change = -4

/datum/mood_event/epilepsy //Only when the mutation causes a seizure
	description = span_warning("I should have paid attention to the epilepsy warning.")
	mood_change = -3
	timeout = 5 MINUTES

/datum/mood_event/nyctophobia
	description = span_warning("It sure is dark around here...")
	mood_change = -3

/datum/mood_event/family_heirloom_missing
	description = span_warning("I'm missing my family heirloom...")
	mood_change = -4

/datum/mood_event/healsbadman
	description = span_warning("I feel like I'm held together by flimsy string, and could fall apart at any moment!")
	mood_change = -4
	timeout = 2 MINUTES

/datum/mood_event/jittery
	description = span_warning("I'm nervous and on edge and I can't stand still!!")
	mood_change = -2

/datum/mood_event/vomit
	description = span_warning("I just threw up. Gross.")
	mood_change = -2
	timeout = 2 MINUTES

/datum/mood_event/vomitself
	description = span_warning("I just threw up all over myself. This is disgusting.")
	mood_change = -4
	timeout = 3 MINUTES

/datum/mood_event/painful_medicine
	description = span_warning("Medicine may be good for me but right now it stings like hell.")
	mood_change = -5
	timeout = 60 SECONDS

/datum/mood_event/spooked
	description = span_warning("The rattling of those bones...It still haunts me.")
	mood_change = -4
	timeout = 4 MINUTES

/datum/mood_event/loud_gong
	description = span_warning("That loud gong noise really hurt my ears!")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/notcreeping
	description = span_warning("The voices are not happy, and they painfully contort my thoughts into getting back on task.")
	mood_change = -6
	timeout = 30
	hidden = TRUE

/datum/mood_event/notcreepingsevere//not hidden since it's so severe
	description = span_boldwarning("THEY NEEEEEEED OBSESSIONNNN!!")
	mood_change = -30
	timeout = 30

/datum/mood_event/notcreepingsevere/add_effects(name)
	var/list/unstable = list(name)
	for(var/i in 1 to rand(3,5))
		unstable += copytext_char(name, -1)
	var/unhinged = uppertext(unstable.Join(""))//example Tinea Luxor > TINEA LUXORRRR (with randomness in how long that slur is)
	description = span_boldwarning("THEY NEEEEEEED [unhinged]!!")

/datum/mood_event/sapped
	description = span_boldwarning("Some unexplainable sadness is consuming me...")
	mood_change = -15
	timeout = 90 SECONDS

/datum/mood_event/back_pain
	description = span_boldwarning("Bags never sit right on my back, this hurts like hell!")
	mood_change = -15

/datum/mood_event/sad_empath
	description = span_warning("Someone seems upset...")
	mood_change = -2
	timeout = 60 SECONDS

/datum/mood_event/sad_empath/add_effects(mob/sadtarget)
	description = span_warning("[sadtarget.name] seems upset...")

/datum/mood_event/sacrifice_bad
	description =span_warning("Those darn savages!")
	mood_change = -5
	timeout = 2 MINUTES

/datum/mood_event/artbad
	description = span_warning("I've produced better art than that from my ass.")
	mood_change = -2
	timeout = 1200

/datum/mood_event/graverobbing
	description =span_boldwarning("I just desecrated someone's grave... I can't believe I did that...")
	mood_change = -8
	timeout = 3 MINUTES

/datum/mood_event/deaths_door
	description = span_boldwarning("This is it... I'm really going to die.")
	mood_change = -20

/datum/mood_event/gunpoint
	description = span_boldwarning("This guy is insane! I better be careful....")
	mood_change = -10

/datum/mood_event/tripped
	description = span_boldwarning("I can't believe I fell for the oldest trick in the book!")
	mood_change = -5
	timeout = 2 MINUTES

/datum/mood_event/untied
	description = span_boldwarning("I hate when my shoes come untied!")
	mood_change = -3
	timeout = 1 MINUTES

/datum/mood_event/high_five_alone
	description = span_boldwarning("I tried getting a high-five with no one around, how embarassing!")
	mood_change = -2
	timeout = 1 MINUTES

/datum/mood_event/high_five_full_hand
	description = span_boldwarning("Oh God, I don't even know how to high-five correctly...")
	mood_change = -1
	timeout = 45 SECONDS

/datum/mood_event/left_hanging
	description = span_boldwarning("But everyone loves high fives! Maybe people just... hate me?")
	mood_change = -2
	timeout = 1.5 MINUTES

/datum/mood_event/too_slow
	description = span_boldwarning("NO! HOW COULD I BE.... TOO SLOW???")
	mood_change = -2 // multiplied by how many people saw it happen, up to 8, so potentially massive. the ULTIMATE prank carries a lot of weight
	timeout = 2 MINUTES

/datum/mood_event/too_slow/add_effects(param)
	var/people_laughing_at_you = 1 // start with 1 in case they're on the same tile or something
	for(var/mob/living/carbon/iter_carbon in oview(owner, 7))
		if(iter_carbon.stat == CONSCIOUS)
			people_laughing_at_you++
			if(people_laughing_at_you > 7)
				break

	mood_change *= people_laughing_at_you
	return ..()

//These are unused so far but I want to remember them to use them later
/datum/mood_event/surgery
	description = span_boldwarning("HE'S CUTTING ME OPEN!!")
	mood_change = -8

/datum/mood_event/nanite_sadness
	description = span_warning_robot("+++++++HAPPINESS SUPPRESSION+++++++")
	mood_change = -7

/datum/mood_event/nanite_sadness/add_effects(message)
	description = span_warning_robot("+++++++[message]+++++++")

/datum/mood_event/bald
	description = span_warning("I need something to cover my head...")
	mood_change = -3

/datum/mood_event/bad_touch
	description = span_warning("I don't like when people touch me.")
	mood_change = -3
	timeout = 4 MINUTES

/datum/mood_event/very_bad_touch
	description = span_warning("I really don't like when people touch me.")
	mood_change = -5
	timeout = 4 MINUTES

/datum/mood_event/noogie
	description = span_warning("Ow! This is like space high school all over again...")
	mood_change = -2
	timeout = 1 MINUTES

/datum/mood_event/noogie_harsh
	description = span_warning("OW!! That was even worse than a regular noogie!")
	mood_change = -4
	timeout = 1 MINUTES

/datum/mood_event/irritate
	description = span_warning("It feels like I'm itching all over!")
	mood_change = -2

/datum/mood_event/cement
	description = span_warning("I was forced to eat cement...")
	mood_change = -6
	timeout = 4 MINUTES

/datum/mood_event/joywire_emp
	description = span_boldwarning("IT'S GONE!! IT'S GONE!!")
	mood_change = -30
	timeout = 5 MINUTES

/datum/mood_event/mindscrew
	description = span_boldwarning("It isn't ending... it isn't ending, come on...")
	mood_change = -18
	timeout = 3 MINUTES

/datum/mood_event/bad_touch_bear_hug
	description = span_warning("I just got squeezed way too hard.")
	mood_change = -3
	timeout = 2 MINUTES

/datum/mood_event/rippedtail
	description = span_boldwarning("I ripped their tail right off, what have I done!")
	mood_change = -5
	timeout = 30 SECONDS

/datum/mood_event/bad_boop
	description = span_warning("Someone booped my nose... ACK!")
	mood_change = -3
	timeout = 4 MINUTES
