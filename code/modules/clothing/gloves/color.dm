/obj/item/clothing/gloves/color
	name = "recolorable gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "black"
	dying_key = DYE_REGISTRY_GLOVES
	supports_variations = VOX_VARIATION
	unique_reskin = list("black gloves" = "black",
						"grey gloves" = "grey",
						"blue gloves" = "blue",
						"green gloves" = "green",
						"orange gloves" = "orange",
						"pink gloves" = "pink",
						"red gloves" = "red",
						"white gloves" = "white",
						"yellow gloves" = "yellow",
						"dark blue gloves" = "darkblue",
						"teal gloves" = "teal",
						"light purple gloves" = "lightpurple",
						"dark green gloves" = "darkgreen",
						"light brown gloves" = "lightbrown",
						"brown gloves" = "brown",
						"maroon gloves" = "maroon"
						)
	unique_reskin_changes_name = TRUE

/obj/item/clothing/gloves/insulated
	desc = "These gloves provide protection against electric shock."
	name = "insulated gloves"
	icon_state = "insulated"
	item_state = "ygloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	resistance_flags = NONE
	custom_price = 1200
	custom_premium_price = 1200
	supports_variations = VOX_VARIATION

/obj/item/toy/sprayoncan
	name = "spray-on insulation applicator"
	desc = "What is the number one problem facing our society today?"
	icon = 'icons/obj/clothing/gloves.dmi'
	icon_state = "sprayoncan"

/obj/item/toy/sprayoncan/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(iscarbon(target) && proximity)
		var/mob/living/carbon/C = target
		var/mob/living/carbon/U = user
		var/success = C.equip_to_slot_if_possible(new /obj/item/clothing/gloves/insulated/sprayon, ITEM_SLOT_GLOVES, TRUE, TRUE)
		if(success)
			if(C == user)
				C.visible_message(span_notice("[U] sprays their hands with glittery rubber!"))
			else
				C.visible_message(span_warning("[U] sprays glittery rubber on the hands of [C]!"))
		else
			C.visible_message(span_warning("The rubber fails to stick to [C]'s hands!"))

		qdel(src)

/obj/item/clothing/gloves/insulated/sprayon
	desc = "How're you gonna get 'em off, nerd?"
	name = "spray-on insulated gloves"
	icon_state = "sprayon"
	permeability_coefficient = 0
	resistance_flags = ACID_PROOF
	var/shocks_remaining = 10

/obj/item/clothing/gloves/insulated/sprayon/Initialize()
	.=..()
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/obj/item/clothing/gloves/insulated/sprayon/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(user, COMSIG_LIVING_SHOCK_PREVENTED, PROC_REF(Shocked))

/obj/item/clothing/gloves/insulated/sprayon/proc/Shocked()
	shocks_remaining--
	if(shocks_remaining < 0)
		qdel(src) //if we run out of uses, the gloves crumble away into nothing, just like my dreams after working with .dm

/obj/item/clothing/gloves/insulated/sprayon/dropped()
	.=..()
	qdel(src) //loose nodrop items bad

/obj/item/clothing/gloves/insulated/sprayon/tape
	name = "taped-on insulated gloves"
	desc = "This is a totally safe idea."
	icon_state = "yellowtape"
	mob_overlay_state = "sprayon"
	shocks_remaining = 3

/obj/item/clothing/gloves/insulated/sprayon/tape/Initialize()
	.=..()
	ADD_TRAIT(src, TRAIT_NODROP, CLOTHING_TRAIT)

/obj/item/clothing/gloves/insulated/sprayon/tape/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(user, COMSIG_LIVING_SHOCK_PREVENTED, PROC_REF(Shocked))

/obj/item/clothing/gloves/insulated/sprayon/tape/Shocked(mob/user)
	if(prob(50)) //Fear the unpredictable
		shocks_remaining--
	if(shocks_remaining <= 0)
		playsound(user, 'sound/items/poster_ripped.ogg', 30)
		to_chat(user, span_danger("\The [src] fall apart into useless scraps!"))
		qdel(src)


/obj/item/clothing/gloves/color/fyellow
	desc = "These gloves are cheap knockoffs of the coveted ones - no way this can end badly."
	name = "budget insulated gloves"
	icon_state = "insulated"
	item_state = "ygloves"
	siemens_coefficient = 1	//Set to a default of 1, gets overridden in Initialize()
	permeability_coefficient = 0.05
	resistance_flags = NONE
	unique_reskin = null

/obj/item/clothing/gloves/color/fyellow/Initialize()
	. = ..()
	siemens_coefficient = pick(0,0.5,0.5,0.5,0.5,0.75,1.5)

/obj/item/clothing/gloves/color/fyellow/old
	desc = "Old and worn out insulated gloves, hopefully they still work."
	name = "worn out insulated gloves"

/obj/item/clothing/gloves/color/fyellow/old/Initialize()
	. = ..()
	siemens_coefficient = pick(0,0,0,0.5,0.5,0.5,0.75)

/obj/item/clothing/gloves/color/black
	desc = "These gloves are fire-resistant."
	name = "black gloves"
	icon_state = "black"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	var/can_be_cut = TRUE
	unique_reskin = null

/obj/item/clothing/gloves/color/black/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER)
		if(can_be_cut && icon_state == initial(icon_state))//only if not dyed
			to_chat(user, span_notice("You snip the fingertips off of [src]."))
			I.play_tool_sound(src)
			new /obj/item/clothing/gloves/fingerless(drop_location())
			qdel(src)
	..()

/obj/item/clothing/gloves/color/orange
	name = "orange gloves"
	icon_state = "orange"

/obj/item/clothing/gloves/color/red
	name = "red gloves"
	icon_state = "red"

/obj/item/clothing/gloves/color/maroon
	name = "maroon gloves"
	icon_state = "maroon"

/obj/item/clothing/gloves/color/yellow
	name = "yellow gloves"
	icon_state = "yellow"

/obj/item/clothing/gloves/color/teal
	name = "teal gloves"
	icon_state = "teal"

/obj/item/clothing/gloves/color/blue
	name = "blue gloves"
	icon_state = "blue"

/obj/item/clothing/gloves/color/darkblue
	name = "dark blue gloves"
	icon_state = "darkblue"

/obj/item/clothing/gloves/color/lightpurple
	name = "purple gloves"
	icon_state = "lightpurple"

/obj/item/clothing/gloves/color/pink
	name = "pink gloves"
	icon_state = "pink"

/obj/item/clothing/gloves/color/green
	name = "green gloves"
	icon_state = "green"

/obj/item/clothing/gloves/color/darkgreen
	name = "dark green gloves"
	icon_state = "darkgreen"

/obj/item/clothing/gloves/color/grey
	name = "grey gloves"
	icon_state = "grey"

/obj/item/clothing/gloves/color/light_brown
	name = "light brown gloves"
	icon_state = "lightbrown"

/obj/item/clothing/gloves/color/brown
	name = "brown gloves"
	icon_state = "brown"

/obj/item/clothing/gloves/color/captain
	desc = "Regal white gloves, with a nice gold trim, an integrated thermal barrier, and armoured bracers. Swanky."
	name = "captain's gloves"
	icon_state = "captain"
	siemens_coefficient = 0.5
	permeability_coefficient = 0.05
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	strip_delay = 60
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 50)
	unique_reskin = null

/obj/item/clothing/gloves/color/captain/warra
	desc = "Regal blue gloves with gold trim and a fire and acid-resistant coating. Swanky."
	name = "captain's gloves"
	icon_state = "captainwarra"

/obj/item/clothing/gloves/nitrile
	name = "nitrile gloves"
	desc = "Thick sterile gloves that reach up to the elbows. The material makes it easier to pick up patients."
	icon_state = "nitrile_white"
	siemens_coefficient = 0.3
	permeability_coefficient = 0.01
	transfer_prints = FALSE
	resistance_flags = NONE
	var/carrytrait = TRAIT_QUICKER_CARRY
	//supports_variations = KEPORI_VARIATION
	supports_variations = VOX_VARIATION
	unique_reskin = null

/obj/item/clothing/gloves/nitrile/equipped(mob/user, slot)
	..()
	if(slot == ITEM_SLOT_GLOVES)
		ADD_TRAIT(user, carrytrait, CLOTHING_TRAIT)

/obj/item/clothing/gloves/nitrile/dropped(mob/user)
	..()
	REMOVE_TRAIT(user, carrytrait, CLOTHING_TRAIT)

/obj/item/clothing/gloves/nitrile/blue
	///come to think about it, a lot of gloves that don't need to be pathed under color could be moved to something else
	icon_state = "nitrile_blue"


/obj/item/clothing/gloves/nitrile/pink
	icon_state = "nitrile_pink"


/obj/item/clothing/gloves/nitrile/green
	icon_state = "nitrile_green"

/obj/item/clothing/gloves/nitrile/evil
	name = "red nitrile gloves"
	desc = "Thick sterile gloves that reach up to the elbows, in exactly the same color as fresh blood. The material makes it easier to pick up patients."
	icon_state = "nitrile_evil"

/obj/item/clothing/gloves/nitrile/infiltrator
	name = "infiltrator gloves"
	desc = "Specialized combat gloves for carrying people around. The material makes it easier to pick up people."
	icon_state = "infiltrator"
	siemens_coefficient = 0.5
	permeability_coefficient = 0.3
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/gloves/nitrile/engineering
	name = "tinker's gloves"
	desc = "Overdesigned engineering gloves that have automated construction subrutines dialed in, allowing for faster construction while worn."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_gauntlets"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	carrytrait = TRAIT_QUICK_BUILD
	custom_materials = list(/datum/material/iron=2000, /datum/material/silver=1500, /datum/material/gold = 1000)

/obj/item/clothing/gloves/color/white
	name = "white gloves"
	icon_state = "white"

/obj/item/clothing/gloves/maid
	name = "maid arm covers"
	desc = "Cylindrical looking tubes that go over your arm, weird."
	icon_state = "maid_arms"
	item_state = "lgloves"
	supports_variations = VOX_VARIATION

//long gloves

/obj/item/clothing/gloves/long
	name = "long gloves"
	desc = "Stylish, elbow-length gloves."
	icon = 'icons/obj/clothing/gloves.dmi'
	mob_overlay_icon = 'icons/mob/clothing/hands.dmi'
	icon_state = "longgloveswhite"
	item_state = "longgloveswhite"
	unique_reskin = list(
		"white long gloves" = "longgloveswhite",
		"black long gloves" = "longglovesblack",
	)
	unique_reskin_changes_name = TRUE

/obj/item/clothing/gloves/long/white
	name = "white long gloves"
	icon_state = "longgloveswhite"
	current_skin = "white long gloves"

/obj/item/clothing/gloves/long/black
	name = "black long gloves"
	icon_state = "longglovesblack"
	current_skin = "black long gloves"
