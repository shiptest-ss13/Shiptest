//******Decoration objects
//***Bone statues and giant skeleton parts.
/obj/structure/statue/bone
	anchored = TRUE
	max_integrity = 120
	material_drop_type = /obj/item/stack/sheet/bone
	impressiveness = 18 // Carved from the bones of a massive creature, it's going to be a specticle to say the least
	layer = ABOVE_ALL_MOB_LAYER

/obj/structure/statue/bone/rib
	name = "collosal rib"
	desc = "It's staggering to think that something this big could have lived, let alone died."
	oreAmount = 4
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "rib"

/obj/structure/statue/bone/skull
	name = "collosal skull"
	desc = "The gaping maw of a dead, titanic monster."
	oreAmount = 12
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "skull"

/obj/structure/statue/bone/skull/half
	desc = "The gaping maw of a dead, titanic monster. This one is cracked in half."
	oreAmount = 6
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "skull-half"

//***Wasteland floor and rock turfs here.
/turf/open/floor/plating/asteroid/basalt/wasteland //Like a more fun version of living in Arizona.
	name = "cracked earth"
	icon = 'icons/turf/floors.dmi'
	icon_state = "wasteland"
	base_icon_state = "wasteland"
	baseturfs = /turf/open/floor/plating/asteroid/basalt/wasteland
	digResult = /obj/item/stack/ore/glass/basalt
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	slowdown = 0.5
	floor_variance = 30
	max_icon_states = 6

/turf/closed/mineral/strong/wasteland
	name = "ancient dry rock"
	color = "#B5651D"
	environment_type = "wasteland"
	turf_type = /turf/open/floor/plating/asteroid/basalt/wasteland
	baseturfs = /turf/open/floor/plating/asteroid/basalt/wasteland
	smooth_icon = 'icons/turf/walls/rock_wall.dmi'
	base_icon_state = "rock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER

/turf/closed/mineral/strong/wasteland/drop_ores()
	if(prob(10))
		new /obj/item/stack/ore/iron(src, 1)
		new /obj/item/stack/ore/glass(src, 1)
		new /obj/effect/decal/remains/human/grave(src, 1)
	else
		new /obj/item/stack/sheet/bone(src, 1)

//***Oil well puddles.
/obj/structure/sink/oil_well	//You're not going to enjoy bathing in this...
	name = "oil well"
	desc = "A bubbling pool of oil.This would probably be valuable, had bluespace technology not destroyed the need for fossil fuels 200 years ago."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "puddle-oil"
	dispensedreagent = /datum/reagent/fuel/oil

/obj/structure/sink/oil_well/Initialize()
	.=..()
	create_reagents(20)
	reagents.add_reagent(dispensedreagent, 20)

/obj/structure/sink/oil_well/attack_hand(mob/M)
	flick("puddle-oil-splash",src)
	reagents.expose(M, TOUCH, 20) //Covers target in 20u of oil.
	to_chat(M, "<span class='notice'>You touch the pool of oil, only to get oil all over yourself. It would be wise to wash this off with water.</span>")

/obj/structure/sink/oil_well/attackby(obj/item/O, mob/user, params)
	flick("puddle-oil-splash",src)
	if(O.tool_behaviour == TOOL_SHOVEL && !(flags_1&NODECONSTRUCT_1)) //attempt to deconstruct the puddle with a shovel
		to_chat(user, "You fill in the oil well with soil.")
		O.play_tool_sound(src)
		deconstruct()
		return 1
	if(istype(O, /obj/item/reagent_containers)) //Refilling bottles with oil
		var/obj/item/reagent_containers/RG = O
		if(RG.is_refillable())
			if(!RG.reagents.holder_full())
				RG.reagents.add_reagent(dispensedreagent, min(RG.volume - RG.reagents.total_volume, RG.amount_per_transfer_from_this))
				to_chat(user, "<span class='notice'>You fill [RG] from [src].</span>")
				return TRUE
			to_chat(user, "<span class='notice'>\The [RG] is full.</span>")
			return FALSE
	if(user.a_intent != INTENT_HARM)
		to_chat(user, "<span class='notice'>You won't have any luck getting \the [O] out if you drop it in the oil.</span>")
		return 1
	else
		return ..()

/obj/structure/sink/oil_well/drop_materials()
	new /obj/effect/decal/cleanable/oil(loc)

//***Grave mounds.
/obj/structure/closet/crate/grave
	name = "burial mound"
	desc = "A marked patch of soil, adorned with a wooden cross"
	icon_state = "grave"
	dense_when_open = TRUE
	material_drop = /obj/item/stack/ore/glass/basalt
	material_drop_amount = 5
	opened = TRUE
	anchorable = FALSE
	anchored = TRUE
	locked = TRUE
	breakout_time = 900
	cutting_tool = TOOL_SHOVEL
	var/lead_tomb = FALSE
	var/first_open = FALSE

/obj/structure/closet/crate/grave/attackby(obj/item/W, mob/user, params)
	.=..()
	if(istype(W, /obj/item/screwdriver))
		if(!user.is_literate())
			to_chat(user, "<span class='notice'>You scratch illegibly on [src]!</span>")
			return
		var/t = stripped_input(user, "What would you like the inscription to be?", name, null, 53)
		if(user.get_active_held_item() != W)
			return
		if(!user.canUseTopic(src, BE_CLOSE))
			return
		if(t)
			desc = "[t]"
		return

/obj/structure/closet/crate/grave/open(mob/living/user, obj/item/S, force = FALSE)
	if(!opened)
		to_chat(user, "<span class='notice'>The ground here is too hard to dig up with your bare hands. You'll need a shovel.</span>")
	else
		to_chat(user, "<span class='notice'>The grave has already been dug up.</span>")

/obj/structure/closet/crate/grave/tool_interact(obj/item/S, mob/living/carbon/user)
	if(user.a_intent == INTENT_HELP) //checks to attempt to dig the grave, must be done on help intent only.
		if(!opened)
			if(S.tool_behaviour == cutting_tool)
				to_chat(user, "<span class='notice'>You start start to dig open \the [src]  with \the [S]...</span>")
				if (do_after(user,20, target = src))
					opened = TRUE
					locked = TRUE
					dump_contents()
					update_appearance()
					SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "graverobbing", /datum/mood_event/graverobbing)
					if(lead_tomb == TRUE && first_open == TRUE)
						user.gain_trauma(/datum/brain_trauma/magic/stalker)
						to_chat(user, "<span class='boldwarning'>Oh no, no no no, THEY'RE EVERYWHERE! EVERY ONE OF THEM IS EVERYWHERE!</span>")
						first_open = FALSE
					return 1
				return 1
			else
				to_chat(user, "<span class='notice'>You can't dig up a grave with \the [S.name].</span>")
				return 1
		else
			to_chat(user, "<span class='notice'>The grave has already been dug up.</span>")
			return 1

	else if((user.a_intent != INTENT_HELP) && opened) //checks to attempt to remove the grave entirely.
		if(S.tool_behaviour == cutting_tool)
			to_chat(user, "<span class='notice'>You start to remove \the [src]  with \the [S].</span>")
			if (do_after(user,15, target = src))
				to_chat(user, "<span class='notice'>You remove \the [src]  completely.</span>")
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "graverobbing", /datum/mood_event/graverobbing)
				deconstruct(TRUE)
				return 1
	return

/obj/structure/closet/crate/grave/bust_open()
	..()
	opened = TRUE
	update_appearance()
	dump_contents()
	return

/obj/structure/closet/crate/grave/stone
	name = "burial mound"
	desc = "A marked patch of soil, adorned with a sandstone slab"
	icon_state = "grave_lead"

/obj/structure/closet/crate/grave/loot
	name = "burial mound"
	desc = "A marked patch of soil, showing signs of a burial long ago. You wouldn't disturb a grave... right?"
	opened = FALSE

/obj/structure/closet/crate/grave/loot/PopulateContents()  //GRAVEROBBING IS NOW A FEATURE
	..()
	new /obj/effect/decal/remains/human/grave(src)
	switch(rand(1,7))
		if(1)
			new /obj/item/coin/gold(src)
			new /obj/item/storage/wallet(src)
		if(2)
			new /obj/item/clothing/glasses/meson(src)
		if(3)
			new /obj/item/coin/silver(src)
			new /obj/item/shovel/spade(src)
		if(4)
			new /obj/item/storage/book/bible/booze(src)
		if(5)
			new /obj/item/clothing/neck/stethoscope(src)
			new	/obj/item/scalpel(src)
			new /obj/item/hemostat(src)

		if(6)
			new /obj/item/reagent_containers/glass/beaker(src)
			new /obj/item/clothing/glasses/science(src)
		if(7)
			new /obj/item/clothing/glasses/sunglasses(src)
			new /obj/item/clothing/mask/cigarette/rollie(src)

/obj/structure/closet/crate/grave/loot/lead_researcher
	name = "ominous burial mound"
	desc = "Even in a place filled to the brim with graves, this one shows a level of preperation and planning that fills you with dread."
	icon_state = "grave_lead"
	lead_tomb = TRUE
	first_open = TRUE

/obj/structure/closet/crate/grave/loot/lead_researcher/PopulateContents()  //ADVANCED GRAVEROBBING
	..()
	new /obj/effect/decal/cleanable/blood/gibs/old(src)

/obj/effect/decal/remains/human/grave
	turf_loc_check = FALSE
