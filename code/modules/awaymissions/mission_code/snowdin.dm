//liquid plasma!!!!!!//

/turf/open/floor/plasteel/dark/snowdin
	initial_gas_mix = FROZEN_ATMOS
	planetary_atmos = 1

/turf/open/lava/plasma
	name = "liquid plasma"
	desc = "A flowing stream of chilled liquid plasma. You probably shouldn't get in."
	icon_state = "liquidplasma"
	initial_gas_mix = "o2=0;n2=82;plasma=24;TEMP=120"
	baseturfs = /turf/open/lava/plasma
	slowdown = 2

	light_range = 3
	light_power = 0.75
	light_color = LIGHT_COLOR_PURPLE
	particle_emitter = null

/turf/open/lava/plasma/attackby(obj/item/I, mob/user, params)
	var/obj/item/reagent_containers/glass/C = I
	if(C.reagents.total_volume >= C.volume)
		to_chat(user, span_danger("[C] is full."))
		return
	C.reagents.add_reagent(/datum/reagent/toxin/plasma, rand(5, 10))
	user.visible_message(span_notice("[user] scoops some plasma from the [src] with \the [C]."), span_notice("You scoop out some plasma from the [src] using \the [C]."))
	return TRUE

/turf/open/lava/plasma/burn_stuff(AM)
	. = 0

	if(is_safe())
		return FALSE

	var/thing_to_check = src
	if (AM)
		thing_to_check = list(AM)
	for(var/thing in thing_to_check)
		if(isobj(thing))
			var/obj/O = thing
			if((O.resistance_flags & (FREEZE_PROOF)) || O.throwing)
				continue

		else if (isliving(thing))
			. = 1
			var/mob/living/L = thing
			if(L.movement_type & FLYING)
				continue	//YOU'RE FLYING OVER IT
			if("snow" in L.weather_immunities)
				continue

			var/buckle_check = L.buckling
			if(!buckle_check)
				buckle_check = L.buckled
			if(isobj(buckle_check))
				var/obj/O = buckle_check
				if(O.resistance_flags & FREEZE_PROOF)
					continue

			else if(isliving(buckle_check))
				var/mob/living/live = buckle_check
				if("snow" in live.weather_immunities)
					continue

			L.adjustFireLoss(2)
			if(L)
				L.adjust_fire_stacks(20) //dipping into a stream of plasma would probably make you more flammable than usual
				L.adjust_bodytemperature(-rand(10,20)) //its cold, man
				if(ishuman(L))//are they a carbon?
					var/list/plasma_parts = list()//a list of the organic parts to be turned into plasma limbs
					var/list/robo_parts = list()//keep a reference of robotic parts so we know if we can turn them into a plasmaman
					var/mob/living/carbon/human/PP = L
					var/S = PP.dna.species
					if(istype(S, /datum/species/plasmaman) || istype(S, /datum/species/android)) //ignore plasmamen/robotic species
						continue

					var/obj/item/bodypart/limb
					for(var/zone in PP.bodyparts)
						limb = PP.bodyparts[zone]
						if(!limb)
							continue
						if(IS_ORGANIC_LIMB(limb) && limb.limb_id != "plasmaman") //getting every organic, non-plasmaman limb (augments/androids are immune to this)
							plasma_parts += limb
						if(!IS_ORGANIC_LIMB(limb))
							robo_parts += limb

					if(prob(35)) //checking if the delay is over & if the victim actually has any parts to nom
						PP.adjustToxLoss(15)
						PP.adjustFireLoss(25)
						if(plasma_parts.len)
							var/obj/item/bodypart/NB = pick(plasma_parts) //using the above-mentioned list to get a choice of limbs for dismember() to use
							NB.limb_id = "plasmaman" //change the species_id of the limb to that of a plasmaman
							NB.static_icon = 'icons/mob/species/plasmaman/bodyparts.dmi'
							NB.no_update = TRUE
							NB.change_bodypart_status()
							PP.force_scream()
							if(!HAS_TRAIT(PP, TRAIT_ANALGESIA))
								PP.visible_message(
									span_warning("[L] screams in pain as [L.p_their()] [NB] melts down to the bone!"),
									span_userdanger("You scream out in pain as your [NB] melts down to the bone, leaving an eerie plasma-like glow where flesh used to be!"))
							else
								PP.visible_message(
									span_warning("[L] lets out panicked gasps as [L.p_their()] [NB] melts down to the bone!"),
									span_userdanger("You gasp in shock as your [NB] melts down to the bone, leaving an eerie plasma-like glow where flesh used to be!"))
						if(!plasma_parts.len && !robo_parts.len) //a person with no potential organic limbs left AND no robotic limbs, time to turn them into a plasmaman
							PP.ignite_mob()
							PP.set_species(/datum/species/plasmaman)
							PP.visible_message(
								span_warning("[L] bursts into a brilliant purple flame as [L.p_their()] entire body is that of a skeleton!"),
								span_userdanger("Your senses numb as all of your remaining flesh is turned into a purple slurry, sloshing off your body and leaving only your bones to show in a vibrant purple!"))


/obj/vehicle/ridden/lavaboat/plasma
	name = "plasma boat"
	desc = "A boat used for traversing the streams of plasma without turning into an icecube."
	icon_state = "goliath_boat"
	icon = 'icons/obj/lavaland/dragonboat.dmi'
	resistance_flags = FREEZE_PROOF
	can_buckle = TRUE
///////////	papers


/obj/item/paper/crumpled/ruins/snowdin/foreshadowing
	name = "scribbled note"
	default_raw_text = {"Something's gone VERY wrong here. Jouslen has been mumbling about some weird shit in his cabin during the night and he seems always tired when we're working. I tried to confront him about it and he blew up on me,
	telling me to mind my own business. I reported him to the officer, said he'd look into it. We only got another 2 months here before we're pulled for another assignment, so this shit can't go any quicker..."}

/obj/item/paper/crumpled/ruins/snowdin/misc1
	name = "Mission Prologue"
	default_raw_text = {"Holy shit, what a rush! Those Nanotrasen bastards didn't even know what hit 'em! All five of us dropped in right on the captain, didn't even have time to yell! We were in and out with that disk in mere minutes!
	Crew didn't even know what was happening till the delta alert went down and by then we were already gone. We got a case to drink on the way home to celebrate, fuckin' job well done!"}

/obj/item/paper/crumpled/ruins/snowdin/dontdeadopeninside
	name = "scribbled note"
	default_raw_text = {"If you're reading this: GET OUT! The mining go on here has unearthed something that was once-trapped by the layers of ice on this hell-hole. The overseer and Jouslen have gone missing. The officer is
	keeping the rest of us on lockdown and I swear to god I keep hearing strange noises outside the walls at night. The gateway link has gone dead and without a supply of resources from Central, we're left
	for dead here. We haven't heard anything back from the mining squad either, so I can only assume whatever the fuck they unearthed got them first before coming for us. I don't want to die here..."}

/obj/item/paper/crumpled/ruins/snowdin/lootstructures
	name = "scribbled note"
	default_raw_text = {"There's some ruins scattered along the cavern, their walls seem to be made of some sort of super-condensed mixture of ice and snow. We've already barricaded up the ones we've found so far,
	since we keep hearing some strange noises from inside. Besides, what sort of fool would wrecklessly run into ancient ruins full of monsters for some old gear, anyway?"}

/obj/item/paper/crumpled/ruins/snowdin/shovel
	name = "shoveling duties"
	default_raw_text = {"Snow piles up bad here all-year round, even worse during the winter months. Keeping a constant rotation of shoveling that shit out of the way of the airlocks and keeping the paths decently clear
	is a good step towards not getting stuck walking through knee-deep snow."}

//holo disk recording//--

/obj/item/disk/holodisk/snowdin/weregettingpaidright
	name = "Conversation #AOP#23"
	preset_image_type = /datum/preset_holoimage/researcher
	preset_record_text = {"
	NAME Jacob Ullman
	DELAY 10
	SAY Have you gotten anything interesting on the scanners yet? The deep-drilling from the plasma is making it difficult to get anything that isn't useless noise.
	DELAY 45
	NAME Elizabeth Queef
	DELAY 10
	SAY Nah. I've been feeding the AI the results for the past 2 weeks to sift through the garbage and haven't seen anything out of the usual, at least whatever Nanotrasen is looking for.
	DELAY 45
	NAME Jacob Ullman
	DELAY 10
	SAY Figured as much. Dunno what Nanotrasen expects to find out here past the plasma. At least we're getting paid to fuck around for a couple months while the AI does the hard work.
	DELAY 45
	NAME Elizabeth Queef
	DELAY 10
	SAY . . .
	DELAY 10
	SAY ..We're getting paid?
	DELAY 20
	NAME Jacob Ullman
	DELAY 10
	SAY ..We are getting paid, aren't we..?
	DELAY 15
	PRESET /datum/preset_holoimage/captain
	NAME Caleb Reed
	DELAY 10
	SAY Paid in experience! That's the Nanotrasen Motto!
	DELAY 30;"}

/obj/item/disk/holodisk/snowdin/welcometodie
	name = "Conversation #AOP#1"
	preset_image_type = /datum/preset_holoimage/corgi
	preset_record_text = {"
	NAME Friendly AI Unit
	DELAY 10
	SAY Hello! Welcome to the Arctic Post *338-3**$$!
	DELAY 30
	SAY You have been selected out of $)@! potential candidates for this post!
	DELAY 30
	SAY Nanotrasen is pleased to have you working in one of the many top-of-the-line research posts within the $%@!! sector!
	DELAY 30
	SAY Further job assignment information can be found at your local security post! Have a secure day!
	DELAY 20;"}

/obj/item/disk/holodisk/snowdin/overrun
	name = "Conversation #AOP#55"
	preset_image_type = /datum/preset_holoimage/nanotrasenprivatesecurity
	preset_record_text = {"
	NAME James Reed
	DELAY 10
	SAY Jesus christ, what is that thing??
	DELAY 30
	PRESET /datum/preset_holoimage/researcher
	NAME Elizabeth Queef
	DELAY 10
	SAY Hell if I know! Just shoot it already!
	DELAY 30
	PRESET /datum/preset_holoimage/nanotrasenprivatesecurity
	NAME James Reed
	DELAY 10
	SOUND sound/weapons/laser.ogg
	DELAY 10
	SOUND sound/weapons/laser.ogg
	DELAY 10
	SOUND sound/weapons/laser.ogg
	DELAY 10
	SOUND sound/weapons/laser.ogg
	DELAY 15
	SAY Just go! I'll keep it busy, there's an outpost south of here with an elevator to the surface.
	NAME Jacob Ullman
	PRESET /datum/preset_holoimage/researcher.
	DELAY 15
	Say I don't have to be told twice! Let's get the fuck out of here.
	DELAY 20;"}

/obj/item/disk/holodisk/snowdin/ripjacob
	name = "Conversation #AOP#62"
	preset_image_type = /datum/preset_holoimage/researcher
	preset_record_text = {"
	NAME Jacob Ullman
	DELAY 10
	SAY Get the elevator called. We got no idea how many of those fuckers are down here and I'd rather get off this planet as soon as possible.
	DELAY 45
	NAME Elizabeth Queef
	DELAY 10
	SAY You don't need to tell me twice, I just need to swipe access and then..
	DELAY 15
	SOUND sound/effects/glassbr1.ogg
	DELAY 10
	SOUND sound/effects/glassbr2.ogg
	DELAY 15
	NAME Jacob Ullman
	DELAY 10
	SAY What the FUCK was that?
	DELAY 20
	SAY OH FUCK THERE'S MORE OF THEM. CALL FASTER JESUS CHRIST.
	DELAY 20
	NAME Elizabeth Queef
	DELAY 10
	SAY DON'T FUCKING RUSH ME ALRIGHT IT'S BEING CALLED.
	DELAY 15
	SOUND sound/effects/huuu.ogg
	DELAY 5
	SOUND sound/effects/huuu.ogg
	DELAY 15
	SOUND sound/effects/woodhit.ogg
	DELAY 2
	SOUND sound/effects/bodyfall3.ogg
	DELAY 5
	SOUND sound/effects/meow1.ogg
	DELAY 15
	NAME Jacob Ullman
	DELAY 15
	SAY OH FUCK IT'S GOT ME JESUS CHRIIIiiii-
	NAME Elizabeth Queef
	SAY AAAAAAAAAAAAAAAA FUCK THAT
	DELAY 15;"}

//special items//--

/obj/structure/barricade/wooden/snowed
	name = "crude plank barricade"
	desc = "This space is blocked off by a wooden barricade. It seems to be covered in a layer of snow."
	icon_state = "woodenbarricade-snow"
	max_integrity = 125

/obj/item/clothing/under/syndicate/coldres
	name = "insulated tactical turtleneck"
	desc = "A nondescript and slightly suspicious-looking turtleneck with digital camouflage cargo pants. The interior has been padded with special insulation for both warmth and protection."
	armor = list("melee" = 20, "bullet" = 10, "laser" = 0,"energy" = 5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)
	cold_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/shoes/combat/coldres
	name = "insulated combat boots"
	desc = "High speed, low drag combat boots, now with an added layer of insulation."
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/effect/mob_spawn/human/syndicatesoldier/coldres
	name = "Syndicate Snow Operative"
	outfit = /datum/outfit/snowsyndie/corpse

/datum/outfit/snowsyndie/corpse
	name = "Syndicate Snow Operative Corpse"
	implants = null

/obj/effect/mob_spawn/human/syndicatesoldier/coldres/alive
	name = "sleeper"
	mob_name = "Syndicate Snow Operative"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	faction = ROLE_SYNDICATE
	outfit = /datum/outfit/snowsyndie
	short_desc = "You are a syndicate operative recently awoken from cryostasis in an underground outpost."
	flavour_text = "You are a syndicate operative recently awoken from cryostasis in an underground outpost. Monitor Nanotrasen communications and record information. All intruders should be \
	disposed of swiftly to assure no gathered information is stolen or lost. Try not to wander too far from the outpost as the caves can be a deadly place even for a trained operative such as yourself."

/datum/outfit/snowsyndie
	name = "Syndicate Snow Operative"
	uniform = /obj/item/clothing/under/syndicate/coldres
	shoes = /obj/item/clothing/shoes/combat/coldres
	ears = /obj/item/radio/headset/syndicate/alt
	r_pocket = /obj/item/gun/ballistic/automatic/pistol/ringneck
	id = /obj/item/card/id/syndicate
	implants = list(/obj/item/implant/exile)


/obj/effect/mob_spawn/human/syndicatesoldier/coldres/alive/female
	mob_gender = FEMALE

//mobs//--

//ice spiders moved to giant_spiders.dm

//objs//--

/obj/structure/flora/rock/icy
	name = "icy rock"
	icon_state = "snowrock_1"

/obj/structure/flora/rock/icy/Initialize()
	. = ..()
	icon_state = "snowrock_[rand(1,4)]"

/obj/structure/flora/rock/pile/icy
	name = "icey rocks"
	icon_state = "snowrock_4"

/obj/structure/flora/rock/pile/icy/Initialize()
	. = ..()
	icon_state = "snowrock_4"

//decals//--
/obj/effect/turf_decal/snowdin_station_sign
	icon_state = "AOP1"

/obj/effect/turf_decal/snowdin_station_sign/two
	icon_state = "AOP2"

/obj/effect/turf_decal/snowdin_station_sign/three
	icon_state = "AOP3"

/obj/effect/turf_decal/snowdin_station_sign/four
	icon_state = "AOP4"

/obj/effect/turf_decal/snowdin_station_sign/five
	icon_state = "AOP5"

/obj/effect/turf_decal/snowdin_station_sign/six
	icon_state = "AOP6"

/obj/effect/turf_decal/snowdin_station_sign/seven
	icon_state = "AOP7"

/obj/effect/turf_decal/snowdin_station_sign/up
	icon_state = "AOPU1"

/obj/effect/turf_decal/snowdin_station_sign/up/two
	icon_state = "AOPU2"

/obj/effect/turf_decal/snowdin_station_sign/up/three
	icon_state = "AOPU3"

/obj/effect/turf_decal/snowdin_station_sign/up/four
	icon_state = "AOPU4"

/obj/effect/turf_decal/snowdin_station_sign/up/five
	icon_state = "AOPU5"

/obj/effect/turf_decal/snowdin_station_sign/up/six
	icon_state = "AOPU6"

/obj/effect/turf_decal/snowdin_station_sign/up/seven
	icon_state = "AOPU7"
