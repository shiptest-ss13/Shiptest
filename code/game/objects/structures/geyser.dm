//If you look at the "geyser_soup" overlay icon_state, you'll see that the first frame has 25 ticks.
//That's because the first 18~ ticks are completely skipped for some ungodly weird fucking byond reason

/obj/structure/geyser
	name = "geyser"
	icon = 'icons/obj/lavaland/terrain.dmi'
	icon_state = "geyser"
	anchored = TRUE

	var/erupting_state = null //set to null to get it greyscaled from "[icon_state]_soup". Not very usable with the whole random thing, but more types can be added if you change the spawn prob
	var/activated = FALSE //whether we are active and generating chems
	var/reagent_id = /datum/reagent/fuel/oil
	var/potency = 2 //how much reagents we add every process (2 seconds)
	var/max_volume = 500
	var/start_volume = 50

/obj/structure/geyser/proc/start_chemming()
	activated = TRUE
	create_reagents(max_volume, DRAINABLE)
	reagents.add_reagent(reagent_id, start_volume)
	START_PROCESSING(SSfluids, src) //It's main function is to be plumbed, so use SSfluids
	if(erupting_state)
		icon_state = erupting_state
	else
		var/mutable_appearance/I = mutable_appearance('icons/obj/lavaland/terrain.dmi', "[icon_state]_soup")
		I.color = mix_color_from_reagents(reagents.reagent_list)
		add_overlay(I)

/obj/structure/geyser/process()
	if(activated && reagents.total_volume <= reagents.maximum_volume) //this is also evaluated in add_reagent, but from my understanding proc calls are expensive
		reagents.add_reagent(reagent_id, potency)

/obj/structure/geyser/plunger_act(obj/item/plunger/P, mob/living/user)
	if(activated)
		to_chat(user, "<span class'warning'>The [name] is already active!</span>")
		return

	to_chat(user, span_notice("You start vigorously plunging [src]!"))
	if(do_after(user, 50 * P.plunge_mod, target = src) && !activated)
		start_chemming()

/obj/structure/geyser/random
	erupting_state = null
	var/list/options = list(/datum/reagent/clf3 = 10, /datum/reagent/water/hollowwater = 10, /datum/reagent/medicine/omnizine/protozine = 6, /datum/reagent/wittel = 1)

/obj/structure/geyser/random/Initialize()
	. = ..()
	reagent_id = pick_weight(options)

/obj/item/plunger
	name = "plunger"
	desc = "It's a plunger for plunging."
	icon = 'icons/obj/watercloset.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	icon_state = "plunger"

	slot_flags = ITEM_SLOT_MASK

	custom_materials = list(/datum/material/iron = 150) // WS Edit - Item Materials

	var/plunge_mod = 1 //time*plunge_mod = total time we take to plunge an object


/obj/item/plunger/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!. && user.zone_selected == BODY_ZONE_HEAD && iscarbon(target))
		var/mob/living/carbon/H = target
		if(!H.wear_mask)
			H.equip_to_slot_if_possible(src, ITEM_SLOT_MASK)
			H.visible_message(span_warning("[user] slaps [src] onto [H]'s face!"), span_warning("[user] slaps [src] onto your face!"), span_hear("You hear violent plumbing."))

/obj/item/plunger/attack_obj(obj/O, mob/living/user)
	if(!O.plunger_act(src, user))
		return ..()

/obj/item/plunger/throw_impact(atom/hit_atom, datum/thrownthing/tt)
	. = ..()
	if(tt.target_zone != BODY_ZONE_HEAD)
		return
	if(iscarbon(hit_atom))
		var/mob/living/carbon/H = hit_atom
		if(!H.wear_mask)
			H.equip_to_slot_if_possible(src, ITEM_SLOT_MASK)
			H.visible_message(span_warning("[src] slams into [H]'s face!"), span_warning("[src] suctions to your face!"), span_hear("You hear violent plumbing."))

