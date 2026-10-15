/mob/living/basic/human/warra
	name = "\improper Vigilitas Security Officer"
	desc = "A member of Vigilitas Interstellar, vacantly staring into the distance, hands near their weapons."
	icon_state = "warra"
	icon_living = "warra"
	stat_attack = HARD_CRIT
	melee_damage_lower = 15
	melee_damage_upper = 15
	habitable_atmos = IMMUNE_ATMOS_REQS
	faction = list(ROLE_DEATHSQUAD)
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_private
	armor_base = /obj/item/clothing/suit/armor/warra
	dodging = TRUE
	callout_set = /datum/ai_callout_set/human/vigilitas

/* ranged guys */

/mob/living/basic/human/warra/ranged
	desc = "A member of Vigilitas Interstellar, vacantly staring into the distance. Their hands are wrapped around the familiarity of a Commander."
	icon_state = "warraranged"
	icon_living = "warraranged"
	retreat_distance = 3
	engage_distance = 5
	casing_type = /obj/item/ammo_casing/c9mm
	burst_shots = 2
	r_hand = /obj/item/gun/ballistic/automatic/pistol/challenger
	projectile_sound = 'sound/weapons/gun/pistol/rattlesnake.ogg'

/mob/living/basic/human/warra/ranged/smg
	name = "\improper Vigilitas Watch"
	desc = "A member of Vigilitas Interstellar, their eyes scan the horizon for motion, tracking flutters of the world with a Resolution PDW."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	burst_shots = 3
	casing_type = /obj/item/ammo_casing/c46x30mm
	r_hand = /obj/item/gun/ballistic/automatic/smg/resolution
	projectile_sound = 'sound/weapons/gun/smg/resolution.ogg'

/mob/living/basic/human/warra/ranged/shotgun
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, posture low to the ground. Their palms tightly grip onto the body of a Negotiator shotgun, ready to fire."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	casing_type = /obj/item/ammo_casing/shotgun/buckshot
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/negotiator
	burst_shots = 1
	projectile_sound = 'sound/weapons/gun/shotgun/shot.ogg'

/mob/living/basic/human/warra/ranged/laser
	name = "\improper Vigilitas Defender"
	desc = "A member of Vigilitas Interstellar, their hands are locked around a laser rifle, actively aiming it at potential threats."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	burst_shots = 2
	burst_interval = 0.7 SECONDS
	casing_type = null
	projectile_type = /obj/projectile/beam/laser/sharplite
	r_hand = /obj/item/gun/energy/sharplite/surge/resistor
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'

/mob/living/basic/human/warra/ranged/laser/space
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	icon_state = "warra_laserspace"
	armor_base = /obj/item/clothing/suit/space/hardsuit/security
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_space
	in_hardsuit = TRUE

/* Assault trooper guys */

/mob/living/basic/human/warra/ranged/trooper
	name = "Vigilitas Trooper"
	desc = "A Vigilitas Assault Officer. Their hands are cradled around a Commander Pistol, ready to bring their aim onto a target."
	icon_state = "warrarangedassault"
	icon_living = "warrarangedassault"
	rapid_melee = 2
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_trooper
	callout_set = /datum/ai_callout_set/human/vigilitas/crisis

/mob/living/basic/human/warra/ranged/trooper/smg
	name = "Vigilitas SMG Trooper"
	desc = "A member of Vigilitas Interstellar. Eyes track motion as they saunter confidently, energy SMG at alert."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	burst_shots = 5
	burst_interval = 0.2 SECONDS
	casing_type = null
	projectile_type = /obj/projectile/beam/weak/sharplite
	r_hand = /obj/item/gun/energy/sharplite/rush
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'

/mob/living/basic/human/warra/ranged/trooper/smg/space
	armor_base = /obj/item/clothing/suit/space/hardsuit/security
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	icon_state = "warra_etar"
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_space
	in_hardsuit = TRUE

/mob/living/basic/human/warra/ranged/trooper/shotgun
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, with their chin high up. They confidently aim around their shotgun, ready to burn away any trespassers."
	icon_state = "warrarangedsmg"
	icon_living = "warrarangedsmg"
	casing_type = /obj/item/ammo_casing/energy/laser/shotgun/sharplite
	r_hand = /obj/item/gun/energy/sharplite/amperage
	burst_shots = 2
	burst_interval = 0.5 SECONDS
	retreat_distance = 0
	engage_distance = 1
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire.ogg'

/mob/living/basic/human/warra/ranged/trooper/shotgun/space
	name = "\improper Vigilitas Pointman"
	desc = "A member of Vigilitas Interstellar, clad in white-striped hardsuit. They confidently aim around their shotgun, ready to burn away any trespassers."
	icon_state = "warra_shotgun"
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/hos
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_hos
	in_hardsuit = TRUE

/mob/living/basic/human/warra/ranged/trooper/rifle
	name = "\improper Vigilitas Rifleman"
	desc = "A well-armed member of Vigilitas Interstellar. They stand at the ready with a Hades energy rifle, smirking underneath their gas mask."
	burst_shots = 4
	burst_interval = 0.4 SECONDS
	casing_type = null
	projectile_type = /obj/projectile/beam/laser/assault/sharplite
	r_hand = /obj/item/gun/energy/sharplite/hades
	projectile_sound = 'sound/weapons/gun/laser/e40_las.ogg'

/mob/living/basic/human/warra/ranged/trooper/rifle/space
	name = "Vigilitas Trooper"
	desc = "A member of Vigilitas Interstellar. White stripes painted red with every shot of their rifle, they aim around cautiously."
	icon_state = "warra_hades"
	icon_living = "warra_hades"
	armor_base = /obj/item/clothing/suit/space/hardsuit/security/hos
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = 1000
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_hos
	in_hardsuit = TRUE

/* the elite guy */

/mob/living/basic/human/warra/elite
	name = "Vigilitas Response Team"
	desc = "A hardened member of Vigilitas Interstellar, clad in well made alloys slathered in red. Their helmet turns, their rifle raises, and they start to move with practiced precision."
	burst_shots = 3
	burst_interval = 0.4 SECONDS
	rapid_melee = 3
	retreat_distance = 0
	engage_distance = 1
	minimum_survivable_temperature = 0
	projectile_type = /obj/projectile/beam/laser/assault/sharplite
	projectile_sound = 'sound/weapons/gun/laser/e40_las.ogg'
	mob_spawner = /obj/effect/mob_spawn/human/corpse/vigilitas_elite
	armor_base = /obj/item/clothing/suit/space/hardsuit/ert/sec
	r_hand = /obj/item/gun/energy/sharplite/hades
	ai_controller = /datum/ai_controller/basic_controller/human/ranged/rusher // response teams push right in on whoever they're sent after
	morale_breaks = FALSE // professionals, paid to see it through
	callout_set = /datum/ai_callout_set/human/vigilitas/intervention

/mob/living/basic/human/warra/elite/shotgun
	desc = "A hardened member of Vigilitas Interstellar, clad in well made alloys slathered in red. Their helmet turns, Their shotgun blinks, and they glare coldly into your eyes."
	burst_shots = 2
	casing_type = /obj/item/ammo_casing/energy/laser/shotgun/sharplite
	projectile_type = null
	projectile_sound = 'sound/weapons/gun/laser/sharplite-fire_light.ogg'
	r_hand = /obj/item/gun/energy/sharplite/amperage


// VI Security: guards, mall cops and armored delivery. By the book, mostly, and not paid enough for this
/datum/ai_callout_set/human/vigilitas
	lines = list(
		AI_CALLOUT_SPOTTED = list("Halt! Vigilitas Security!", "Unauthorized personnel on site!", "This is a restricted area!"),
		AI_CALLOUT_TAKING_FIRE = list("Shots fired! Shots fired!", "Taking fire, requesting backup!"),
		AI_CALLOUT_HURT = list("I'm hit!", "Agh! That's coming out of my hazard pay!"),
		AI_CALLOUT_TARGET_DOWN = list("Suspect down!", "Suspect is down, keep them covered!"),
		AI_CALLOUT_TARGET_KILLED = list("Hostile neutralized.", "Threat eliminated. I'll file the report."),
		AI_CALLOUT_ALLY_DOWN = list("Man down!", "We've got one down!"),
		AI_CALLOUT_LOST_THEM = list("Lost visual on the suspect!", "Where'd they go?"),
		AI_CALLOUT_FLANKING = list("Moving to cut them off!", "Going around, keep them busy!"),
		AI_CALLOUT_HOLDING = list("Hold the line!", "Stay in cover, wait for backup!"),
		AI_CALLOUT_SUPPRESSING = list("Covering fire!", "Keep them pinned!"),
		AI_CALLOUT_DEATH_RATTLE = list("They don't... pay me enough for this...", "Should've stayed... on the desk...", "Tell the client... I..."),
		AI_CALLOUT_RELOADING = list("Reloading!", "Changing mags!"),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots fired nearby, moving to investigate!", "Did you hear that? Checking it out."),
		AI_CALLOUT_PUSHING = list("Moving in!", "Advancing on the suspect!"),
		AI_CALLOUT_FALLING_BACK = list("Falling back!", "Too close, give me room!"),
		AI_CALLOUT_WARY = list("We lost one, nobody be a hero!", "Stay behind cover, they're dangerous!"),
		AI_CALLOUT_EMBOLDENED = list("We've got them, close in!", "They're outnumbered, move in!"),
		AI_CALLOUT_TAUNT = list("Drop your weapon!", "This is private property!", "Stop resisting!"),
		AI_CALLOUT_MELEE = list("Stop resisting!", "Down! Get down!", "Hands where I can see them!"),
		AI_CALLOUT_BROKEN = list("This isn't worth it! Fall back!", "We're outgunned! Pull back!", "Retreat! Wait for backup!", "Forget this, let's get out of here!"),
		AI_CALLOUT_RALLIED = list("Okay, okay... regroup, by the book!", "Pull it together, hold the line!"),
	)
	morale_lines = list(
		AI_MORALE_BROKEN = list(
			AI_CALLOUT_HURT = list("I'm hit! I need a medic!", "Agh! Get me out of here!"),
			AI_CALLOUT_RELOADING = list("I'm dry! I'm dry!"),
			AI_CALLOUT_ALLY_DOWN = list("Another one down! Get out of here!", "We're losing people!"),
		),
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("Surrender now and this goes easier!", "Give it up, you're done!"),
		),
		AI_MORALE_WARY = list(
			AI_CALLOUT_TAUNT = list("Just drop it, nobody else needs to get hurt!"),
		),
	)

// VI Crisis Reaction Units: a tactical response team, part SWAT and part well-armed firefighters
/datum/ai_callout_set/human/vigilitas/crisis
	lines = list(
		AI_CALLOUT_SPOTTED = list("Contact! Hostile in sight!", "Crisis Reaction, show me your hands!", "Hostile on site, engaging!"),
		AI_CALLOUT_TARGET_DOWN = list("Hostile down, keep them covered!", "One down, stay sharp!"),
		AI_CALLOUT_TARGET_KILLED = list("Threat neutralized.", "Hostile neutralized, moving on."),
		AI_CALLOUT_ALLY_DOWN = list("Responder down!", "We've got a casualty!"),
		AI_CALLOUT_FLANKING = list("Flanking, cover me!", "Taking the side!"),
		AI_CALLOUT_HOLDING = list("Hold position!", "Stack up and hold!"),
		AI_CALLOUT_DEATH_RATTLE = list("Tell the... others...", "Mark... my position...", "Not... how this drill went..."),
		AI_CALLOUT_PUSHING = list("Breaching! Move, move!", "Pushing up!"),
		AI_CALLOUT_TAUNT = list("Weapons down, now!", "You're not leaving this site!", "Get on the ground!"),
		AI_CALLOUT_BROKEN = list("Abort! Abort! Fall back!", "Too many hostiles, pull out!", "Fall back to the rally point!"),
		AI_CALLOUT_RALLIED = list("Regroup and reset!", "Rally up, we go again!"),
	)

// VI Intervention Services: paramilitary, well-paid professionals for clients with exacting needs and substantial opposition
/datum/ai_callout_set/human/vigilitas/intervention
	lines = list(
		AI_CALLOUT_SPOTTED = list("Contact.", "Hostile in sector. Engaging.", "Target acquired."),
		AI_CALLOUT_TAKING_FIRE = list("Under fire. Locating shooter.", "Incoming."),
		AI_CALLOUT_HURT = list("Hit. Still in it.", "Armor's holding."),
		AI_CALLOUT_TARGET_DOWN = list("Target down.", "Hostile incapacitated."),
		AI_CALLOUT_TARGET_KILLED = list("Liability removed.", "Target eliminated.", "That's billable."),
		AI_CALLOUT_ALLY_DOWN = list("Operator down.", "We've lost one. Adjust."),
		AI_CALLOUT_LOST_THEM = list("Lost line of sight.", "Target's broken contact."),
		AI_CALLOUT_FLANKING = list("Repositioning.", "Moving to their flank."),
		AI_CALLOUT_HOLDING = list("Holding.", "Hold and observe."),
		AI_CALLOUT_SUPPRESSING = list("Suppressing.", "Fire on their position."),
		AI_CALLOUT_DEATH_RATTLE = list("Contract's... not done...", "Mission... compromised...", "Worth... every credit..."),
		AI_CALLOUT_RELOADING = list("Reloading.", "Mag change."),
		AI_CALLOUT_HEARD_GUNFIRE = list("Shots nearby. Investigating.", "Gunfire. Moving to check."),
		AI_CALLOUT_PUSHING = list("Advancing.", "Closing in."),
		AI_CALLOUT_FALLING_BACK = list("Making distance.", "Backing off."),
		AI_CALLOUT_WARY = list("They're competent. Tighten up.", "Slow down. They've got teeth."),
		AI_CALLOUT_EMBOLDENED = list("They're folding. Finish it.", "Press them."),
		AI_CALLOUT_TAUNT = list("Nothing personal.", "You're not on the contract.", "You should have stayed home."),
		AI_CALLOUT_MELEE = list("Close quarters.", "Engaging hand to hand."),
	)
	morale_lines = list(
		AI_MORALE_EMBOLDENED = list(
			AI_CALLOUT_TAUNT = list("This won't take long.", "Clean this up."),
		),
	)
