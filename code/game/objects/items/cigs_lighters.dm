//cleansed 9/15/2012 17:48

/*
CONTAINS:
MATCHES
CIGARETTES
CIGARS
SMOKING PIPES
CHEAP LIGHTERS
ZIPPO

CIGARETTE PACKETS ARE IN FANCY.DM
*/

///////////
//MATCHES//
///////////
/obj/item/match
	name = "match"
	desc = "A simple match stick, used for lighting fine smokables."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "match_unlit"
	var/lit = FALSE
	var/burnt = FALSE
	/// How long the match lasts in seconds
	var/smoketime = 10
	w_class = WEIGHT_CLASS_TINY
	heat = 1000
	grind_results = list(/datum/reagent/phosphorus = 2)

/obj/item/match/process(seconds_per_tick)
	smoketime -= seconds_per_tick
	if(smoketime <= 0)
		matchburnout()
	else
		open_flame(heat)

/obj/item/match/fire_act(exposed_temperature, exposed_volume)
	matchignite()

/obj/item/match/proc/matchignite()
	if(!lit && !burnt)
		playsound(src, 'sound/items/match_strike.ogg', 15, TRUE)
		lit = TRUE
		icon_state = "match_lit"
		damtype = "fire"
		force = 3
		hitsound = 'sound/items/welder.ogg'
		name = "lit [initial(name)]"
		desc = "A [initial(name)]. This one is lit."
		attack_verb = list("burnt","singed")
		START_PROCESSING(SSobj, src)
		update_appearance()

/obj/item/match/proc/matchburnout()
	if(lit)
		lit = FALSE
		burnt = TRUE
		damtype = "brute"
		force = initial(force)
		icon_state = "match_burnt"
		name = "burnt [initial(name)]"
		desc = "A [initial(name)]. This one has seen better days."
		attack_verb = list("flicked")
		STOP_PROCESSING(SSobj, src)

/obj/item/match/extinguish()
	matchburnout()

/obj/item/match/dropped(mob/user)
	matchburnout()
	. = ..()

/obj/item/match/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!isliving(M))
		return
	if(lit && M.ignite_mob())
		message_admins("[ADMIN_LOOKUPFLW(user)] set [key_name_admin(M)] on fire with [src] at [AREACOORD(user)]")
		log_game("[key_name(user)] set [key_name(M)] on fire with [src] at [AREACOORD(user)]")
	var/obj/item/clothing/mask/cigarette/cig = help_light_cig(M)
	if(lit && cig && user.a_intent == INTENT_HELP)
		if(cig.lit)
			to_chat(user, span_warning("[cig] is already lit!"))
		if(M == user)
			cig.attackby(src, user)
		else
			cig.light(span_notice("[user] holds [src] out for [M], and lights [cig]."))
	else
		..()

/obj/item/proc/help_light_cig(mob/living/M)
	var/mask_item = M.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(mask_item, /obj/item/clothing/mask/cigarette))
		return mask_item

/obj/item/match/get_temperature()
	return lit * heat

/obj/item/match/firebrand
	name = "firebrand"
	desc = "An unlit firebrand. It makes you wonder why it's not just called a stick."
	smoketime = 40
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT)
	grind_results = list(/datum/reagent/carbon = 2)

/obj/item/match/firebrand/Initialize()
	. = ..()
	matchignite()

//////////////////
//FINE SMOKABLES//
//////////////////
/obj/item/clothing/mask/cigarette
	name = "cigarette"
	desc = "A roll of tobacco and nicotine."
	icon_state = "cigoff"
	throw_speed = 0.5
	w_class = WEIGHT_CLASS_TINY
	body_parts_covered = null
	grind_results = list()
	heat = 1000
	var/dragtime = 10
	var/nextdragtime = 0
	var/lit = FALSE
	var/starts_lit = FALSE
	var/icon_on = "cigon"  //Note - these are in masks.dmi not in cigarette.dmi
	var/icon_off = "cigoff"
	var/type_butt = /obj/item/cigbutt
	var/lastHolder = null
	/// How long the cigarette lasts in seconds
	var/smoketime = 360
	var/chem_volume = 30
	var/smoke_all = FALSE /// Should we smoke all of the chems in the cig before it runs out. Splits each puff to take a portion of the overall chems so by the end you'll always have consumed all of the chems inside.
	var/list/list_reagents = list(/datum/reagent/drug/nicotine = 15)
	var/lung_harm = 0.1 //How bad it is for you

/obj/item/clothing/mask/cigarette/Initialize()
	. = ..()
	create_reagents(chem_volume, INJECTABLE | NO_REACT)
	if(list_reagents)
		reagents.add_reagent_list(list_reagents)
	if(starts_lit)
		light()
	AddComponent(/datum/component/knockoff,90,list(BODY_ZONE_PRECISE_MOUTH),list(ITEM_SLOT_MASK))//90% to knock off when wearing a mask

/obj/item/clothing/mask/cigarette/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/mask/cigarette/attackby(obj/item/W, mob/user, params)
	if(!lit && smoketime > 0)
		var/lighting_text = W.ignition_effect(src, user)
		if(lighting_text)
			light(lighting_text)
	else
		return ..()

/obj/item/clothing/mask/cigarette/afterattack(obj/item/reagent_containers/glass/glass, mob/user, proximity)
	. = ..()
	if(!proximity || lit) //can't dip if cigarette is lit (it will heat the reagents in the glass instead)
		return
	if(istype(glass))	//you can dip cigarettes into beakers
		if(glass.reagents.trans_to(src, chem_volume, transfered_by = user))	//if reagents were transfered, show the message
			to_chat(user, span_notice("You dip \the [src] into \the [glass]."))
		else			//if not, either the beaker was empty, or the cigarette was full
			if(!glass.reagents.total_volume)
				to_chat(user, span_warning("[glass] is empty!"))
			else
				to_chat(user, span_warning("[src] is full!"))


/obj/item/clothing/mask/cigarette/proc/light(flavor_text = null)
	if(lit)
		return
	if(!(flags_1 & INITIALIZED_1))
		icon_state = icon_on
		item_state = icon_on
		return

	lit = TRUE
	name = "lit [name]"
	attack_verb = list("burnt", "singed")
	hitsound = 'sound/items/welder.ogg'
	damtype = "fire"
	force = 4
	if(reagents.get_reagent_amount(/datum/reagent/toxin/plasma)) // the plasma explodes when exposed to fire
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round(reagents.get_reagent_amount(/datum/reagent/toxin/plasma) / 2.5, 1), get_turf(src), 0, 0)
		e.start()
		qdel(src)
		return
	if(reagents.get_reagent_amount(/datum/reagent/fuel)) // the fuel explodes, too, but much less violently
		var/datum/effect_system/reagents_explosion/e = new()
		e.set_up(round(reagents.get_reagent_amount(/datum/reagent/fuel) / 5, 1), get_turf(src), 0, 0)
		e.start()
		qdel(src)
		return
	// allowing reagents to react after being lit
	reagents.flags &= ~(NO_REACT)
	reagents.handle_reactions()
	icon_state = icon_on
	item_state = icon_on
	if(flavor_text)
		var/turf/T = get_turf(src)
		T.visible_message(flavor_text)
	START_PROCESSING(SSobj, src)

	//can't think of any other way to update the overlays :<
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_mask()
		M.update_inv_hands()

	playsound(src, 'sound/items/cig_light.ogg', 25, 1)

/obj/item/clothing/mask/cigarette/extinguish()
	if(!lit)
		return
	name = copytext_char(name, 5) //5 == length_char("lit ") + 1
	attack_verb = null
	hitsound = null
	damtype = BRUTE
	force = 0
	icon_state = icon_off
	item_state = icon_off
	STOP_PROCESSING(SSobj, src)
	reagents.flags |= NO_REACT
	lit = FALSE
	if(ismob(loc))
		var/mob/living/M = loc
		to_chat(M, span_notice("Your [name] goes out."))
		M.update_inv_wear_mask()
		M.update_inv_hands()

/obj/item/clothing/mask/cigarette/proc/handle_reagents()
	if(reagents.total_volume)
		var/to_smoke = REAGENTS_METABOLISM
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			if (src == C.wear_mask) // if it's in the human/monkey mouth, transfer reagents to the mob
				var/fraction = min(REAGENTS_METABOLISM/reagents.total_volume, 1)
				/*
				* Given the amount of time the cig will last, and how often we take a hit, find the number
				* of chems to give them each time so they'll have smoked it all by the end.
				*/
				if (smoke_all)
					to_smoke = reagents.total_volume / (smoketime / dragtime)

				reagents.expose(C, INGEST, fraction)
				var/obj/item/organ/lungs/L = C.getorganslot(ORGAN_SLOT_LUNGS)
				if(L && !(L.organ_flags & ORGAN_SYNTHETIC))
					C.adjustOrganLoss(ORGAN_SLOT_LUNGS, lung_harm)
				if(!reagents.trans_to(C, to_smoke))
					reagents.remove_any(to_smoke)
				return
		reagents.remove_any(to_smoke)

/obj/item/clothing/mask/cigarette/process(seconds_per_tick)
	var/turf/location = get_turf(src)
	var/mob/living/M = loc
	if(isliving(loc))
		M.ignite_mob()
	smoketime -= seconds_per_tick
	if(smoketime <= 0)
		new type_butt(location)
		if(ismob(loc))
			to_chat(M, span_notice("Your [name] goes out."))
			playsound(src, 'sound/items/cig_snuff.ogg', 25, 1)
		qdel(src)
		return
	open_flame()
	if((reagents && reagents.total_volume) && (nextdragtime <= world.time))
		nextdragtime = world.time + dragtime SECONDS
		handle_reagents()

/obj/item/clothing/mask/cigarette/attack_self(mob/user)
	if(lit)
		user.visible_message(span_notice("[user] calmly drops and treads on \the [src], putting it out instantly."))
		playsound(src, 'sound/items/cig_snuff.ogg', 25, 1)
		new type_butt(user.loc)
		new /obj/effect/decal/cleanable/ash(user.loc)
		qdel(src)
	. = ..()

/obj/item/clothing/mask/cigarette/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!istype(M))
		return ..()
	if(M.on_fire && !lit)
		light(span_notice("[user] lights [src] with [M]'s burning body. What a cold-blooded badass."))
		return
	var/obj/item/clothing/mask/cigarette/cig = help_light_cig(M)
	if(lit && cig && user.a_intent == INTENT_HELP)
		if(cig.lit)
			to_chat(user, span_warning("The [cig.name] is already lit!"))
		if(M == user)
			cig.attackby(src, user)
		else
			cig.light(span_notice("[user] holds the [name] out for [M], and lights [M.p_their()] [cig.name]."))
	else
		return ..()

/obj/item/clothing/mask/cigarette/fire_act(exposed_temperature, exposed_volume)
	light()

/obj/item/clothing/mask/cigarette/get_temperature()
	return lit * heat

// Cigarette brands.

/obj/item/clothing/mask/cigarette/space_cigarette
	desc = "A Space Cigarette brand cigarette."

/obj/item/clothing/mask/cigarette/dromedary
	desc = "A DromedaryCo brand cigarette. Contrary to popular belief, does not contain Calomel, but is reported to have a watery taste."
	list_reagents = list(/datum/reagent/drug/nicotine = 13, /datum/reagent/water = 5) //camel has water

/obj/item/clothing/mask/cigarette/uplift
	desc = "An Uplift Smooth brand cigarette. Smells refreshing."
	list_reagents = list(/datum/reagent/drug/nicotine = 13, /datum/reagent/consumable/menthol = 5)

/obj/item/clothing/mask/cigarette/robust
	desc = "A Robust brand cigarette."

/obj/item/clothing/mask/cigarette/robustgold
	desc = "A Robust Gold brand cigarette."
	list_reagents = list(/datum/reagent/drug/nicotine = 15, /datum/reagent/gold = 3) // Just enough to taste a hint of expensive metal.

/obj/item/clothing/mask/cigarette/carp
	desc = "A Carp Classic brand cigarette. A small label on its side indicates that it does NOT contain carpotoxin."

/obj/item/clothing/mask/cigarette/carp/Initialize()
	. = ..()
	if(!prob(5))
		return
	reagents?.add_reagent(/datum/reagent/toxin/carpotoxin , 3) // They lied

/obj/item/clothing/mask/cigarette/syndicate
	desc = "An unknown brand cigarette."
	chem_volume = 60
	smoketime = 2 * 60
	smoke_all = TRUE
	list_reagents = list(/datum/reagent/drug/nicotine = 10, /datum/reagent/medicine/panacea = 15)

// Rollies.

/obj/item/clothing/mask/cigarette/rollie
	name = "rollie"
	desc = "A roll of dried plant matter wrapped in thin paper."
	icon_state = "spliffoff"
	icon_on = "spliffon"
	icon_off = "spliffoff"
	type_butt = /obj/item/cigbutt/roach
	throw_speed = 0.5
	item_state = "spliffoff"
	smoketime = 4 * 60
	chem_volume = 50
	list_reagents = null

/obj/item/clothing/mask/cigarette/rollie/Initialize()
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

/obj/item/clothing/mask/cigarette/rollie/nicotine
	list_reagents = list(/datum/reagent/drug/nicotine = 15)

/obj/item/clothing/mask/cigarette/rollie/trippy
	list_reagents = list(/datum/reagent/drug/nicotine = 15, /datum/reagent/drug/mushroomhallucinogen = 35)
	starts_lit = TRUE

/obj/item/clothing/mask/cigarette/rollie/cannabis
	list_reagents = list(/datum/reagent/drug/retukemi = 50)

/obj/item/clothing/mask/cigarette/rollie/mindbreaker
	list_reagents = list(/datum/reagent/toxin/mindbreaker = 35, /datum/reagent/drug/retukemi = 15)

/obj/item/clothing/mask/cigarette/candy
	name = "Little Timmy's candy cigarette"
	desc = "For all ages*! Doesn't contain any amount of nicotine. Health and safety risks can be read on the tip of the cigarette."
	smoketime = 120
	icon_on = "candyon"
	icon_off = "candyoff" //make sure to add positional sprites in icons/obj/cigarettes.dmi if you add more.
	item_state = "candyoff"
	icon_state = "candyoff"
	list_reagents = list(/datum/reagent/consumable/sugar = 10, /datum/reagent/consumable/caramel = 10)

/obj/item/clothing/mask/cigarette/candy/nicotine
	desc = "For all ages*! Doesn't contain any* amount of nicotine. Health and safety risks can be read on the tip of the cigarette."
	list_reagents = list(/datum/reagent/consumable/sugar = 10, /datum/reagent/consumable/caramel = 10, /datum/reagent/drug/nicotine = 20) //oh no!
	smoke_all = TRUE //timmy's not getting out of this one

/obj/item/cigbutt/roach
	name = "roach"
	desc = "A manky old roach, or for non-stoners, a used rollup."
	icon_state = "roach"

/obj/item/cigbutt/roach/Initialize()
	. = ..()
	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)


////////////
// CIGARS //
////////////
/obj/item/clothing/mask/cigarette/cigar
	name = "premium cigar"
	desc = "A brown roll of tobacco and... well, you're not quite sure. This thing's huge!"
	icon_state = "cigaroff"
	icon_on = "cigaron"
	icon_off = "cigaroff" //make sure to add positional sprites in icons/obj/cigarettes.dmi if you add more.
	type_butt = /obj/item/cigbutt/cigarbutt
	throw_speed = 0.5
	smoketime = 300 // 11 minutes
	chem_volume = 40
	list_reagents = list(/datum/reagent/drug/nicotine = 25)

/obj/item/clothing/mask/cigarette/cigar/cohiba
	name = "\improper Cohiba Robusto cigar"
	desc = "There's little more you could want from a cigar."
	icon_state = "cigar2off"
	icon_on = "cigar2on"
	icon_off = "cigar2off"
	smoketime = 20 * 60
	chem_volume = 80
	list_reagents =list(/datum/reagent/drug/nicotine = 40)

/obj/item/clothing/mask/cigarette/cigar/havana
	name = "premium Havanian cigar"
	desc = "A cigar fit for only the best of the best."
	icon_state = "cigar2off"
	icon_on = "cigar2on"
	icon_off = "cigar2off"
	smoketime = 30 * 60
	chem_volume = 50
	list_reagents =list(/datum/reagent/drug/nicotine = 15)

/obj/item/cigbutt
	name = "cigarette butt"
	desc = "A manky old cigarette butt."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "cigbutt"
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	grind_results = list(/datum/reagent/carbon = 2)

/obj/item/cigbutt/cigarbutt
	name = "cigar butt"
	desc = "A manky old cigar butt."
	icon_state = "cigarbutt"

/////////////////
//SMOKING PIPES//
/////////////////
/obj/item/clothing/mask/cigarette/pipe
	name = "smoking pipe"
	desc = "A pipe, for smoking. Probably made of meerschaum or something."
	icon_state = "pipeoff"
	item_state = "pipeoff"
	icon_on = "pipeon"  //Note - these are in masks.dmi
	icon_off = "pipeoff"
	smoketime = 0
	chem_volume = 100
	list_reagents = null
	var/packeditem = 0

/obj/item/clothing/mask/cigarette/pipe/Initialize()
	. = ..()
	name = "empty [initial(name)]"

/obj/item/clothing/mask/cigarette/pipe/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/clothing/mask/cigarette/pipe/process(seconds_per_tick)
	var/turf/location = get_turf(src)
	smoketime -= seconds_per_tick
	if(smoketime <= 0)
		new /obj/effect/decal/cleanable/ash(location)
		if(ismob(loc))
			var/mob/living/M = loc
			to_chat(M, span_notice("Your [name] goes out."))
			lit = 0
			icon_state = icon_off
			item_state = icon_off
			M.update_inv_wear_mask()
			packeditem = 0
			name = "empty [initial(name)]"
		STOP_PROCESSING(SSobj, src)
		return
	open_flame()
	if(reagents && reagents.total_volume)	//	check if it has any reagents at all
		handle_reagents()


/obj/item/clothing/mask/cigarette/pipe/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/food/grown))
		var/obj/item/food/grown/G = O
		if(!packeditem)
			if(HAS_TRAIT(G, TRAIT_DRIED))
				to_chat(user, span_notice("You stuff [O] into [src]."))
				smoketime = 400
				packeditem = 1
				name = "[O.name]-packed [initial(name)]"
				if(O.reagents)
					O.reagents.trans_to(src, O.reagents.total_volume, transfered_by = user)
				qdel(O)
			else
				to_chat(user, span_warning("It has to be dried first!"))
		else
			to_chat(user, span_warning("It is already packed!"))
	else
		var/lighting_text = O.ignition_effect(src,user)
		if(lighting_text)
			if(smoketime > 0)
				light(lighting_text)
			else
				to_chat(user, span_warning("There is nothing to smoke!"))
		else
			return ..()

/obj/item/clothing/mask/cigarette/pipe/attack_self(mob/user)
	var/turf/location = get_turf(user)
	if(lit)
		user.visible_message(span_notice("[user] puts out [src]."), span_notice("You put out [src]."))
		lit = 0
		icon_state = icon_off
		item_state = icon_off
		STOP_PROCESSING(SSobj, src)
		return
	if(!lit && smoketime > 0)
		to_chat(user, span_notice("You empty [src] onto [location]."))
		new /obj/effect/decal/cleanable/ash(location)
		packeditem = 0
		smoketime = 0
		reagents.clear_reagents()
		name = "empty [initial(name)]"
	return

/obj/item/clothing/mask/cigarette/pipe/cobpipe
	name = "corn cob pipe"
	desc = "A nicotine delivery system popularized by folksy backwoodsmen and kept popular in the modern age and beyond by space hipsters. Can be loaded with objects."
	icon_state = "cobpipeoff"
	item_state = "cobpipeoff"
	icon_on = "cobpipeon"  //Note - these are in masks.dmi
	icon_off = "cobpipeoff"
	smoketime = 0


/////////
//ZIPPO//
/////////
/obj/item/lighter
	name = "\improper Zippo lighter"
	desc = "The zippo."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "zippo"
	item_state = "zippo"
	w_class = WEIGHT_CLASS_TINY
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	heat = 1500
	resistance_flags = FIRE_PROOF
	grind_results = list(/datum/reagent/iron = 1, /datum/reagent/fuel = 5, /datum/reagent/fuel/oil = 5)
	custom_price = 5
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.6
	light_color = LIGHT_COLOR_FIRE
	light_on = FALSE
	var/lit = 0
	var/fancy = TRUE
	var/overlay_state
	var/overlay_list = list(
		"plain",
		"dame",
		"thirteen",
		"snake"
		)

/obj/item/lighter/Initialize()
	. = ..()
	if(!overlay_state)
		overlay_state = pick(overlay_list)
	update_appearance()

/obj/item/lighter/cyborg_unequip(mob/user)
	if(!lit)
		return
	set_lit(FALSE)

/obj/item/lighter/update_overlays()
	. = ..()
	. += create_lighter_overlay()

/obj/item/lighter/update_icon_state()
	icon_state = "[initial(icon_state)][lit ? "-on" : ""]"
	return ..()

/obj/item/lighter/proc/create_lighter_overlay()
	return mutable_appearance(icon, "lighter_overlay_[overlay_state][lit ? "-on" : ""]")

/obj/item/lighter/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_rose("With a single flick of [user.p_their()] wrist, [user] smoothly lights [A] with [src]. Damn [user.p_theyre()] cool.")

/obj/item/lighter/proc/set_lit(new_lit)
	if(lit == new_lit)
		return
	lit = new_lit
	if(lit)
		force = 5
		damtype = "fire"
		hitsound = 'sound/items/welder.ogg'
		attack_verb = list("burnt", "singed")
	else
		hitsound = "swing_hit"
		force = 0
		attack_verb = null //human_defense.dm takes care of it
	set_light_on(lit)
	update_appearance()

/obj/item/lighter/extinguish()
	set_lit(FALSE)

/obj/item/lighter/attack_self(mob/living/user)
	if(user.is_holding(src))
		if(!lit)
			set_lit(TRUE)
			if(fancy)
				user.visible_message(span_notice("Without even breaking stride, [user] flips open and lights [src] in one smooth movement."), span_notice("Without even breaking stride, you flip open and light [src] in one smooth movement."))
				playsound(src.loc, 'sound/items/zippo_on.ogg', 100, 1)
			else
				var/prot = FALSE
				var/mob/living/carbon/human/H = user

				if(istype(H) && H.gloves)
					var/obj/item/clothing/gloves/G = H.gloves
					if(G.max_heat_protection_temperature)
						prot = (G.max_heat_protection_temperature > 360)
				else
					prot = TRUE

				if(prot || prob(75))
					user.visible_message(span_notice("After a few attempts, [user] manages to light [src]."), span_notice("After a few attempts, you manage to light [src]."))
				else
					var/hitzone = user.held_index_to_dir(user.active_hand_index) == "r" ? BODY_ZONE_PRECISE_R_HAND : BODY_ZONE_PRECISE_L_HAND
					user.apply_damage(5, BURN, hitzone)
					user.visible_message(span_warning("After a few attempts, [user] manages to light [src] - however, [user.p_they()] burn [user.p_their()] finger in the process."), span_warning("You burn yourself while lighting the lighter!"))
					SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "burnt_thumb", /datum/mood_event/burnt_thumb)
				playsound(src.loc, 'sound/items/lighter_on.ogg', 100, 1)

		else
			set_lit(FALSE)
			if(fancy)
				user.visible_message(span_notice("You hear a quiet click, as [user] shuts off [src] without even looking at what [user.p_theyre()] doing. Wow."), span_notice("You quietly shut off [src] without even looking at what you're doing. Wow."))
				playsound(src.loc, 'sound/items/zippo_off.ogg', 100, 1)
			else
				user.visible_message(span_notice("[user] quietly shuts off [src]."), span_notice("You quietly shut off [src]."))
				playsound(src.loc, 'sound/items/lighter_off.ogg', 100, 1)
	else
		. = ..()

/obj/item/lighter/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(lit && M.ignite_mob())
		message_admins("[ADMIN_LOOKUPFLW(user)] set [key_name_admin(M)] on fire with [src] at [AREACOORD(user)]")
		log_game("[key_name(user)] set [key_name(M)] on fire with [src] at [AREACOORD(user)]")
	var/obj/item/clothing/mask/cigarette/cig = help_light_cig(M)
	if(lit && cig && user.a_intent == INTENT_HELP)
		if(cig.lit)
			to_chat(user, span_warning("The [cig.name] is already lit!"))
		if(M == user)
			cig.attackby(src, user)
		else
			if(fancy)
				cig.light(span_rose("[user] whips the [name] out and holds it for [M]. [user.p_their(TRUE)] arm is as steady as the unflickering flame [user.p_they()] light[user.p_s()] \the [cig] with."))
			else
				cig.light(span_notice("[user] holds the [name] out for [M], and lights [M.p_their()] [cig.name]."))
	else
		..()

/obj/item/lighter/process(seconds_per_tick)
	open_flame()

/obj/item/lighter/get_temperature()
	return lit * heat


/obj/item/lighter/greyscale
	name = "cheap lighter"
	desc = "A cheap lighter."
	icon_state = "lighter"
	fancy = FALSE
	overlay_list = list(
		"transp",
		"tall",
		"matte",
		"zoppo" //u cant stoppo th zoppo
		)
	var/lighter_color
	var/list/color_list = list( //Same 16 color selection as electronic assemblies
		COLOR_ASSEMBLY_BLACK,
		COLOR_FLOORTILE_GRAY,
		COLOR_ASSEMBLY_BGRAY,
		COLOR_ASSEMBLY_WHITE,
		COLOR_ASSEMBLY_RED,
		COLOR_ASSEMBLY_ORANGE,
		COLOR_ASSEMBLY_BEIGE,
		COLOR_ASSEMBLY_BROWN,
		COLOR_ASSEMBLY_GOLD,
		COLOR_ASSEMBLY_YELLOW,
		COLOR_ASSEMBLY_GURKHA,
		COLOR_ASSEMBLY_LGREEN,
		COLOR_ASSEMBLY_GREEN,
		COLOR_ASSEMBLY_LBLUE,
		COLOR_ASSEMBLY_BLUE,
		COLOR_ASSEMBLY_PURPLE
		)

/obj/item/lighter/greyscale/Initialize()
	. = ..()
	if(!lighter_color)
		lighter_color = pick(color_list)
	update_appearance()

/obj/item/lighter/greyscale/create_lighter_overlay()
	var/mutable_appearance/lighter_overlay = ..()
	lighter_overlay.color = lighter_color
	return lighter_overlay

/obj/item/lighter/greyscale/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_notice("After some fiddling, [user] manages to light [A] with [src].")


/obj/item/lighter/slime
	name = "slime zippo"
	desc = "A specialty zippo made from slimes and industry. Has a much hotter flame than normal."
	icon_state = "slighter"
	heat = 3000 //Blue flame!
	light_color = LIGHT_COLOR_CYAN
	overlay_state = "slime"
	grind_results = list(/datum/reagent/iron = 1, /datum/reagent/fuel = 5)

/obj/item/lighter/clockwork
	name = "bronze zippo"
	desc = "A zippo plated with brass. I mean bronze. Has a neat red flame!"
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "clockworklighter"
	heat = 2000 //??????????????????
	light_color = LIGHT_COLOR_BLOOD_MAGIC
	overlay_state = "clockwork"
	grind_results = list(/datum/reagent/iron = 1, /datum/reagent/fuel = 5, /datum/reagent/copper = 1)

/obj/item/lighter/liz
	name = "small blaze"
	desc = "A little flame of your own, currently located dangerously in your mouth."
	icon_state = "fire"
	item_state = "fire"
	overlay_state = "fire"
	grind_results = null
	lefthand_file = null
	righthand_file = null
	item_flags = DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 0                       //if you want to attack someone with that fire you gotta spit it out first
	throwforce = 0
	throw_range = 0
	throw_speed = 0

/obj/item/lighter/liz/Initialize()
	. = ..()
	set_lit(TRUE)
	force = 0

/obj/item/lighter/liz/attack_self(mob/user)
	qdel(src)

/obj/item/lighter/liz/ignition_effect(atom/A, mob/user)
	if(get_temperature())
		. = span_rose("[user] spits fire at [A], igniting it.")
		playsound(src, 'sound/voice/lizard/firespit.ogg', 20, TRUE)

/obj/item/lighter/enigma
	name = "\improper Enigma Shipworks Lighter"
	desc = "A lighter from a now defunct company. Feels nice to hold."
	icon_state = "enigmaburner"
	heat = 1500
	overlay_state = "enigma2"

///////////
//ROLLING//
///////////
/obj/item/rollingpaper
	name = "rolling paper"
	desc = "A thin piece of paper used to make fine smokeables."
	icon = 'icons/obj/cigarettes.dmi'
	icon_state = "cig_paper"
	w_class = WEIGHT_CLASS_TINY

/obj/item/rollingpaper/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return

	if(istype(target, /obj/item/food/grown))
		var/obj/item/food/grown/O = target
		if(HAS_TRAIT(O, TRAIT_DRIED))
			var/obj/item/clothing/mask/cigarette/rollie/R = new /obj/item/clothing/mask/cigarette/rollie(user.loc)
			R.chem_volume = target.reagents.total_volume
			target.reagents.trans_to(R, R.chem_volume, transfered_by = user)
			qdel(target)
			qdel(src)
			user.put_in_active_hand(R)
			to_chat(user, span_notice("You roll the [target.name] into a rolling paper."))
			R.desc = "Dried [target.name] rolled up in a thin piece of paper."
		else
			to_chat(user, span_warning("You need to dry this first!"))

///////////////
//VAPE NATION//
///////////////
/obj/item/clothing/mask/vape
	name = "\improper E-Cigarette"
	desc = "A classy and highly sophisticated electronic cigarette, for classy and dignified gentlemen. A warning label reads \"Warning: Do not fill with flammable materials.\" Can be lit via interfacing with a PDA, tablet computer, or an APC."//<<< i'd vape to that.
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "red_vapeoff"
	item_state = "red_vapeoff"
	w_class = WEIGHT_CLASS_TINY
	var/on = FALSE
	var/chem_volume = 100
	var/vapetime = 0 //this so it won't puff out clouds every tick
	/// How often we take a drag in seconds
	var/vapedelay = 8
	var/screw = 0 // kinky
	var/super = 0 //for the fattest vapes dude.
	var/vapecolor //What color the vape should be. If this is not filled out it will automatically be set on Initialize()
	var/overlayname = "vape" //Used to decide what overlay sprites to use

/obj/item/clothing/mask/vape/Initialize(mapload, param_color)
	. = ..()
	create_reagents(chem_volume, NO_REACT)
	reagents.add_reagent(/datum/reagent/drug/nicotine, 50)
	if(!vapecolor)
		if(!param_color)
			param_color = pick("red","blue","black","white","green","purple","yellow","orange")
		vapecolor = param_color
	icon_state = "[vapecolor]_vapeoff"
	item_state = "[vapecolor]_vapeoff"

/obj/item/clothing/mask/vape/attackby(obj/item/O, mob/user, params)
	if(O.tool_behaviour == TOOL_SCREWDRIVER)
		if(on)
			to_chat(user, span_warning("You need to turn \the [src] off first!"))
			return
		if(!screw)
			screw = TRUE
			to_chat(user, span_notice("You open the cap on [src]."))
			reagents.flags |= OPENCONTAINER
			if(obj_flags & EMAGGED)
				add_overlay("[overlayname]open_high")
			else if(super)
				add_overlay("[overlayname]open_med")
			else
				add_overlay("[overlayname]open_low")
		else
			screw = FALSE
			to_chat(user, span_notice("You close the cap on [src]."))
			reagents.flags &= ~(OPENCONTAINER)
			cut_overlays()

	if(O.tool_behaviour == TOOL_MULTITOOL)
		if(screw && !(obj_flags & EMAGGED))//also kinky
			if(!super)
				cut_overlays()
				super = 1
				to_chat(user, span_notice("You increase the voltage of [src]."))
				add_overlay("[overlayname]open_med")
			else
				cut_overlays()
				super = 0
				to_chat(user, span_notice("You decrease the voltage of [src]."))
				add_overlay("[overlayname]open_low")

		if(screw && (obj_flags & EMAGGED))
			to_chat(user, span_warning("[src] can't be modified!"))
		else
			..()
	if(istype(O, /obj/item/pda) || istype(O, /obj/item/modular_computer/tablet))
		if(screw)
			to_chat(user, span_notice("You need to close the cap first!"))
			return
		on = !on
		if(on)
			user.visible_message(
				span_notice("[user] turns on [user.p_their()] [src] with a holographic flame from [user.p_their()] [O]."),
				span_notice("You turn on your [src] with a holographic flame from your [O].")
			)
			reagents.flags |= NO_REACT
			icon_state = "[vapecolor]_vape"
			item_state = "[vapecolor]_vape"
			if(user.get_item_by_slot(ITEM_SLOT_MASK) == src)
				START_PROCESSING(SSobj, src)

		else
			user.visible_message(
				span_notice("[user] turns off [user.p_their()] [src] with a holographic gust from [user.p_their()] [O]."),
				span_notice("You turn off your [src] with a holographic gust from your [O].")
			)
			reagents.flags &= NO_REACT
			icon_state = "[vapecolor]_vapeoff"
			item_state = "[vapecolor]_vapeoff"
			STOP_PROCESSING(SSobj, src)
		src.update_icon_state()
		user.update_inv_wear_mask()
		user.update_inv_hands()

/obj/item/clothing/mask/vape/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if((!istype(target, /obj/machinery/power/apc)) || !ishuman(user) || !proximity_flag)
		return ..()
	if(screw)
		to_chat(user, span_notice("You need to close the cap first!"))
		return
	on = !on
	if(on)
		user.visible_message(
			span_notice("[user] turns on [user.p_their()] [src] with a holographic flame from the APC."),
			span_notice("You turn on your [src] with a holographic flame from the APC.")
		)
		reagents.flags |= NO_REACT
		icon_state = "[vapecolor]_vape"
		item_state = "[vapecolor]_vape"
	else
		user.visible_message(
			span_notice("[user] turns off [user.p_their()] [src] with a holographic gust from the APC."),
			span_notice("You turn off your [src] with a holographic gust from the APC.")
		)
		reagents.flags &= NO_REACT
		icon_state = "[vapecolor]_vapeoff"
		item_state = "[vapecolor]_vapeoff"
	src.update_icon_state()

/obj/item/clothing/mask/vape/emag_act(mob/user)// I WON'T REGRET WRITTING THIS, SURLY.
	if(screw)
		if(!(obj_flags & EMAGGED))
			cut_overlays()
			obj_flags |= EMAGGED
			super = 0
			to_chat(user, span_warning("You maximize the voltage of [src]."))
			add_overlay("[overlayname]open_high")
			var/datum/effect_system/spark_spread/sp = new /datum/effect_system/spark_spread //for effect
			sp.set_up(5, 1, src)
			sp.start()
		else
			to_chat(user, span_warning("[src] is already emagged!"))
	else
		to_chat(user, span_warning("You need to open the cap to do that!"))

/obj/item/clothing/mask/vape/attack_self(mob/user)
	if(reagents.total_volume > 0)
		to_chat(user, span_notice("You empty [src] of all reagents."))
		reagents.clear_reagents()

/obj/item/clothing/mask/vape/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_MASK)
		if(on)
			if(!screw)
				to_chat(user, span_notice("You start puffing on \the [src]."))
				START_PROCESSING(SSobj, src)
			else //it will not start if the vape is opened.
				to_chat(user, span_warning("You need to close the cap first!"))
		else
			to_chat(user, "<span class='notice'>You need to turn on \the [src] first!")

/obj/item/clothing/mask/vape/dropped(mob/user)
	. = ..()
	if(user.get_item_by_slot(ITEM_SLOT_MASK) == src)
		reagents.flags |= NO_REACT
		STOP_PROCESSING(SSobj, src)

/obj/item/clothing/mask/vape/proc/hand_reagents()//had to rename to avoid duplicate error
	if(reagents.total_volume)
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			if (src == C.wear_mask) // if it's in the human/monkey mouth, transfer reagents to the mob
				var/fraction = min(REAGENTS_METABOLISM/reagents.total_volume, 1) //this will react instantly, making them a little more dangerous than cigarettes
				reagents.expose(C, INGEST, fraction)
				if(!reagents.trans_to(C, REAGENTS_METABOLISM))
					reagents.remove_any(REAGENTS_METABOLISM)
				if(reagents.get_reagent_amount(/datum/reagent/fuel))
					//HOT STUFF
					C.adjust_fire_stacks(2)
					C.ignite_mob()

				if(reagents.get_reagent_amount(/datum/reagent/toxin/plasma)) // the plasma explodes when exposed to fire
					var/datum/effect_system/reagents_explosion/e = new()
					e.set_up(round(reagents.get_reagent_amount(/datum/reagent/toxin/plasma) / 2.5, 1), get_turf(src), 0, 0)
					e.start()
					qdel(src)
				return
		reagents.remove_any(REAGENTS_METABOLISM)

/obj/item/clothing/mask/vape/process(seconds_per_tick)
	var/mob/living/M = loc

	if(isliving(loc))
		M.ignite_mob()

	vapetime += seconds_per_tick

	if(!reagents.total_volume)
		if(ismob(loc))
			to_chat(M, span_warning("[src] is empty!"))
			STOP_PROCESSING(SSobj, src)
			//it's reusable so it won't unequip when empty
		return
	//open flame removed because vapes are a closed system, they wont light anything on fire

	if(super && vapetime >= vapedelay)//Time to start puffing those fat vapes, yo.
		var/datum/effect_system/smoke_spread/chem/smoke_machine/s = new
		var/datum/reagents/smokereagents = new
		reagents.trans_to(smokereagents, reagents.total_volume / 10, 0.65)
		s.set_up(smokereagents, 1, 24, loc)
		s.start()
		vapetime = 0

	if((obj_flags & EMAGGED) && vapetime >= vapedelay)
		var/datum/effect_system/smoke_spread/chem/smoke_machine/s = new
		var/datum/reagents/smokereagents = new
		reagents.trans_to(smokereagents, reagents.total_volume / 5, 0.75)
		s.set_up(smokereagents, 4, 24, loc)
		s.start()
		vapetime -= vapedelay
		if(prob(5))//small chance for the vape to break and deal damage if it's emagged
			playsound(get_turf(src), 'sound/effects/pop_expl.ogg', 50, FALSE)
			M.apply_damage(20, BURN, BODY_ZONE_HEAD)
			M.Paralyze(300)
			var/datum/effect_system/spark_spread/sp = new /datum/effect_system/spark_spread
			sp.set_up(5, 1, src)
			sp.start()
			to_chat(M, span_userdanger("[src] suddenly explodes in your mouth!"))
			qdel(src)
			return

	if(reagents && reagents.total_volume)
		hand_reagents()

/obj/item/clothing/mask/vape/examine(mob/user)
	. = ..()
	to_chat(user, "<span class='notice>It is currently [on ? "on" : "off"].</span>")

/obj/item/clothing/mask/vape/cigar
	name = "\improper E-Cigar"
	desc = "The latest recreational device developed by a small tech startup, Shadow Tech, the E-Cigar has all the uses of a normal E-Cigarette, with the classiness of short fat cigar. Can be lit via interfacing with a PDA, tablet computer, or an APC."
	icon_state = "ecigar_vapeoff"
	item_state = "ecigar_vapeoff"
	vapecolor = "ecigar"
	overlayname = "ecigar"
	chem_volume = 150
	custom_premium_price = 10
