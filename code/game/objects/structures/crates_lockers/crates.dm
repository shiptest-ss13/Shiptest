/obj/structure/closet/crate
	name = "crate"
	desc = "A rectangular steel crate."
	icon = 'icons/obj/crates.dmi'
	icon_state = "crate"
	req_access = null
	can_weld_shut = FALSE
	horizontal = TRUE
	allow_objects = TRUE
	allow_dense = TRUE
	dense_when_open = TRUE
	climbable = TRUE
	mouse_drag_pointer = TRUE
	climb_time = 10 //real fast, because let's be honest stepping into or onto a crate is easy
	delivery_icon = "deliverycrate"
	open_sound = 'sound/machines/crate_open.ogg'
	close_sound = 'sound/machines/crate_close.ogg'
	open_sound_volume = 35
	close_sound_volume = 50
	//half as much as a closet
	drag_slowdown = 0.75
	pass_flags_self = LETPASSCLICKS
	var/manifest_id = null
	var/shelve = FALSE
	var/shelve_range = 0

/obj/structure/closet/crate/Initialize()
	. = ..()
	if(icon_state == "[initial(icon_state)]open")
		opened = TRUE
	update_appearance()

/obj/structure/closet/crate/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(!istype(mover, /obj/structure/closet))
		var/obj/structure/closet/crate/locatedcrate = locate(/obj/structure/closet/crate) in get_turf(mover)
		if(locatedcrate) //you can walk on it like tables, if you're not in an open crate trying to move to a closed crate
			if(opened) //if we're open, allow entering regardless of located crate openness
				return TRUE
			if(!locatedcrate.opened) //otherwise, if the located crate is closed, allow entering
				return TRUE

/obj/structure/closet/crate/update_icon_state()
	icon_state = "[initial(icon_state)][opened ? "open" : ""]"
	return ..()

/obj/structure/closet/crate/closet_update_overlays(list/new_overlays)
	. = new_overlays
	if(GetComponent(/datum/component/writing))
		. += "manifest"

/obj/structure/closet/crate/attack_hand(mob/user)
	if(istype(src.loc, /obj/structure/crate_shelf))
		return FALSE // No opening crates in shelves!!
	var/datum/component/writing/manifest = GetComponent(/datum/component/writing)
	if(manifest)
		tear_manifest(user, manifest)
	return ..()

/obj/structure/closet/crate/MouseDrop(atom/drop_atom, src_location, over_location)
	. = ..()
	var/mob/living/user = usr
	if(!isliving(user))
		return // Ghosts busted.
	if(!isturf(user.loc) || user.incapacitated() || user.body_position == LYING_DOWN)
		return // If the user is in a weird state, don't bother trying.
	if(get_dist(drop_atom, src) != 1 || get_dist(drop_atom, user) != 1)
		return // Check whether the crate is exactly 1 tile from the shelf and the user.
	if(istype(drop_atom, /turf/open) && istype(loc, /obj/structure/crate_shelf) && user.Adjacent(drop_atom))
		var/obj/structure/crate_shelf/shelf = loc
		return shelf.unload(src, user, drop_atom) // If we're being dropped onto a turf, and we're inside of a crate shelf, unload.
	if(istype(drop_atom, /obj/structure) && istype(loc, /obj/structure/crate_shelf) && user.Adjacent(drop_atom) && !drop_atom.density)
		var/obj/structure/crate_shelf/shelf = loc
		return shelf.unload(src, user, drop_atom.loc) // If we're being dropped onto a turf, and we're inside of a crate shelf, unload.
	if(istype(drop_atom, /obj/structure/crate_shelf) && isturf(loc) && user.Adjacent(src))
		var/obj/structure/crate_shelf/shelf = drop_atom
		return shelf.load(src, user) // If we're being dropped onto a crate shelf, and we're in a turf, load.

/obj/structure/closet/crate/open(mob/living/user, force = FALSE)
	. = ..()
	if(!.)
		return
	var/datum/component/writing/manifest = GetComponent(/datum/component/writing)
	if(!manifest)
		return
	to_chat(user, span_notice("The manifest is torn off [src]."))
	playsound(src, 'sound/items/poster_ripped.ogg', 75, TRUE)
	paperize_manifest(get_turf(src), manifest)

/obj/structure/closet/crate/proc/tear_manifest(mob/user, datum/component/writing/manifest)
	to_chat(user, span_notice("You tear the manifest off of [src]."))
	playsound(src, 'sound/items/poster_ripped.ogg', 75, TRUE)

	var/obj/item/paper/manifest_paper = paperize_manifest(loc, manifest)
	if(ishuman(user))
		user.put_in_hands(manifest_paper)

/// Turns a writing component into a paper and returns the paper. Warning: this also destroys the component datum!
/obj/structure/closet/crate/proc/paperize_manifest(atom/paper_location, datum/component/writing/manifest)
	var/obj/item/paper/manifest/manifest_paper = new(paper_location, manifest_id, 0)
	var/datum/component/writing/paper_text = manifest_paper.GetComponent(/datum/component/writing)
	if(!paper_text)
		CRASH("[manifest_paper.type] somehow had no writing component!")
	manifest_paper.name = "shipping manifest - #[manifest_id]"
	manifest.copy_to(paper_text)
	manifest_paper.update_appearance()
	qdel(manifest)
	update_appearance()
	return manifest_paper

/obj/structure/closet/crate/coffin
	name = "coffin"
	desc = "It's a burial receptacle for the dearly departed."
	icon_state = "coffin"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	material_drop = /obj/item/stack/sheet/mineral/wood
	material_drop_amount = 5
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50

/obj/structure/closet/crate/internals
	desc = "An internals crate."
	name = "internals crate"
	icon_state = "o2crate"

/obj/structure/closet/crate/trashcart //please make this a generic cart path later after things calm down a little
	desc = "A heavy, metal trashcart with wheels."
	name = "trash cart"
	icon_state = "trashcart"

/obj/structure/closet/crate/trashcart/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, TRUE)

/obj/structure/closet/crate/trashcart/laundry
	name = "laundry cart"
	desc = "A large cart for hauling around large amounts of laundry."
	icon_state = "laundry"

/obj/structure/closet/crate/medical
	desc = "A medical crate."
	name = "medical crate"
	icon_state = "medicalcrate"

/obj/structure/closet/crate/freezer
	desc = "A freezer."
	name = "freezer"
	icon_state = "freezer"

//Snowflake organ freezer code
//Order is important, since we check source, we need to do the check whenever we have all the organs in the crate

/obj/structure/closet/crate/freezer/open(mob/living/user, force = FALSE)
	recursive_organ_check(src)
	..()

/obj/structure/closet/crate/freezer/close()
	..()
	recursive_organ_check(src)

/obj/structure/closet/crate/freezer/Destroy()
	recursive_organ_check(src)
	return ..()

/obj/structure/closet/crate/freezer/Initialize()
	. = ..()
	recursive_organ_check(src)



/obj/structure/closet/crate/freezer/blood
	name = "blood freezer"
	desc = "A freezer containing packs of blood."

/obj/structure/closet/crate/freezer/blood/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/blood(src)
	new /obj/item/reagent_containers/blood(src)
	new /obj/item/reagent_containers/blood/AMinus(src)
	new /obj/item/reagent_containers/blood/BMinus(src)
	new /obj/item/reagent_containers/blood/BPlus(src)
	new /obj/item/reagent_containers/blood/OMinus(src)
	new /obj/item/reagent_containers/blood/OPlus(src)
	new /obj/item/reagent_containers/blood/lizard(src)
	new /obj/item/reagent_containers/blood/elzuose(src)
	new /obj/item/reagent_containers/blood/synthetic(src)
	for(var/i in 1 to 3)
		new /obj/item/reagent_containers/blood/random(src)

/obj/structure/closet/crate/freezer/surplus_limbs
	name = "surplus prosthetic limbs"
	desc = "A crate containing an assortment of cheap prosthetic limbs."

/obj/structure/closet/crate/freezer/surplus_limbs/PopulateContents()
	. = ..()
	new /obj/item/bodypart/l_arm/robot/surplus(src)
	new /obj/item/bodypart/l_arm/robot/surplus(src)
	new /obj/item/bodypart/r_arm/robot/surplus(src)
	new /obj/item/bodypart/r_arm/robot/surplus(src)
	new /obj/item/bodypart/leg/left/robot/surplus(src)
	new /obj/item/bodypart/leg/left/robot/surplus(src)
	new /obj/item/bodypart/leg/right/robot/surplus(src)
	new /obj/item/bodypart/leg/right/robot/surplus(src)
	new /obj/item/bodypart/l_arm/robot/surplus/kepori(src)
	new /obj/item/bodypart/r_arm/robot/surplus/kepori(src)
	new /obj/item/bodypart/leg/left/robot/surplus/kepori(src)
	new /obj/item/bodypart/leg/right/robot/surplus/kepori(src)
	new /obj/item/bodypart/l_arm/robot/surplus/vox(src)
	new /obj/item/bodypart/r_arm/robot/surplus/vox(src)
	new /obj/item/bodypart/leg/left/robot/surplus/vox(src)
	new /obj/item/bodypart/leg/right/robot/surplus/vox(src)

/obj/structure/closet/crate/freezer/surplus_limbs/organs
	name = "organ freezer"
	desc = "A crate containing a variety of spare limbs and organs."

/obj/structure/closet/crate/freezer/surplus_limbs/organs/PopulateContents()
	. = ..()
	new /obj/item/organ/stomach(src)
	new /obj/item/organ/stomach(src)
	new /obj/item/organ/lungs(src)
	new /obj/item/organ/liver(src)
	new /obj/item/organ/liver(src)
	new /obj/item/organ/eyes(src)
	new /obj/item/organ/eyes(src)
	new /obj/item/organ/heart(src)
	new /obj/item/organ/heart(src)
	new /obj/item/organ/ears(src)
	new /obj/item/organ/ears(src)

/obj/structure/closet/crate/radiation
	desc = "A crate with a radiation sign on it."
	name = "radiation crate"
	icon_state = "radiation"

/obj/structure/closet/crate/hydroponics
	name = "hydroponics crate"
	desc = "All you need to destroy those pesky weeds and pests."
	icon_state = "hydrocrate"

/obj/structure/closet/crate/engineering
	name = "engineering crate"
	icon_state = "engi_crate"

/obj/structure/closet/crate/engineering/electrical
	icon_state = "engi_e_crate"

/obj/structure/closet/crate/rcd
	desc = "A crate for the storage of an RCD."
	name = "\improper RCD crate"
	icon_state = "engi_crate"

/obj/structure/closet/crate/rcd/PopulateContents()
	..()
	for(var/i in 1 to 4)
		new /obj/item/rcd_ammo(src)
	new /obj/item/construction/rcd(src)

/obj/structure/closet/crate/science
	name = "science crate"
	desc = "A science crate."
	icon_state = "scicrate"

/obj/structure/closet/crate/solarpanel_small
	name = "budget solar panel crate"
	icon_state = "engi_e_crate"

/obj/structure/closet/crate/solarpanel_small/PopulateContents()
	..()
	for(var/i in 1 to 13)
		new /obj/item/solar_assembly(src)
	new /obj/item/circuitboard/computer/solar_control(src)
	new /obj/item/paper/guides/jobs/engi/solars(src)
	new /obj/item/electronics/tracker(src)

/obj/structure/closet/crate/goldcrate
	name = "gold crate"

/obj/structure/closet/crate/goldcrate/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/stack/sheet/mineral/gold(src, 1, FALSE)
	new /obj/item/storage/belt/champion(src)

/obj/structure/closet/crate/silvercrate
	name = "silver crate"

/obj/structure/closet/crate/silvercrate/PopulateContents()
	..()
	for(var/i in 1 to 5)
		new /obj/item/coin/silver(src)

/obj/structure/closet/crate/chem
	desc = "A small crate for the storage and transportation of chemicals."
	name = "chemical crate"
	icon_state = "chemcrate"
	material_drop = /obj/item/stack/sheet/mineral/gold
	material_drop_amount = 1

/obj/structure/closet/crate/eva
	name = "EVA crate"

/obj/structure/closet/crate/eva/PopulateContents()
	..()
	for(var/i in 1 to 3)
		new /obj/item/clothing/suit/space/eva(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/head/helmet/space/eva(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/mask/breath(src)
	for(var/i in 1 to 3)
		new /obj/item/tank/internals/oxygen(src)

/obj/structure/closet/crate/cyborg
	name = "Cyborg Construction Crate"
	desc = "A crate containing the parts to build a cyborg frame."
	icon_state = "scicrate"

/obj/structure/closet/crate/cyborg/PopulateContents()
	. = ..()
	new /obj/item/bodypart/l_arm/robot(src)
	new /obj/item/bodypart/r_arm/robot(src)
	new /obj/item/bodypart/leg/left/robot(src)
	new /obj/item/bodypart/leg/right/robot(src)
	new /obj/item/bodypart/chest/robot(src)
	new /obj/item/bodypart/head/robot(src)
	new /obj/item/robot_suit(src)
	new /obj/item/stock_parts/cell/high(src)
	for(var/i in 1 to 2)
		new /obj/item/assembly/flash/handheld(src)
