// what a corpse spawner dresses its corpse in, worked out from its type without making one

// the spawner's own slot vars are -1 when it leaves that slot to the outfit
#define SPAWNER_SLOT(spawner, outfit, slot) (initial(spawner.slot) == -1 && ispath(outfit) ? initial(outfit.slot) : initial(spawner.slot))

/proc/get_spawner_clothing(spawner_type)
	var/static/list/clothing_by_spawner = list()
	if(!isnull(clothing_by_spawner[spawner_type]))
		return clothing_by_spawner[spawner_type]
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/datum/outfit/outfit = initial(spawner.outfit)
	var/list/slots = list(
		SPAWNER_SLOT(spawner, outfit, uniform),
		SPAWNER_SLOT(spawner, outfit, suit),
		SPAWNER_SLOT(spawner, outfit, head),
		SPAWNER_SLOT(spawner, outfit, mask),
		SPAWNER_SLOT(spawner, outfit, gloves),
		SPAWNER_SLOT(spawner, outfit, shoes),
		SPAWNER_SLOT(spawner, outfit, neck),
		SPAWNER_SLOT(spawner, outfit, belt),
		SPAWNER_SLOT(spawner, outfit, back),
	)
	var/list/clothing = list()
	for(var/item_type in slots)
		if(ispath(item_type, /obj/item/clothing))
			clothing += item_type
	clothing_by_spawner[spawner_type] = clothing
	return clothing

/proc/spawner_has_jetpack(spawner_type)
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/datum/outfit/outfit = initial(spawner.outfit)
	var/back = SPAWNER_SLOT(spawner, outfit, back)
	return ispath(back, /obj/item/tank/jetpack)

/proc/spawner_is_pressure_sealed(spawner_type)
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/datum/outfit/outfit = initial(spawner.outfit)
	var/obj/item/clothing/suit = SPAWNER_SLOT(spawner, outfit, suit)
	var/obj/item/clothing/head = SPAWNER_SLOT(spawner, outfit, head)
	if(!ispath(suit, /obj/item/clothing) || !ispath(head, /obj/item/clothing))
		return FALSE
	return (initial(suit.clothing_flags) & STOPSPRESSUREDAMAGE) && (initial(head.clothing_flags) & STOPSPRESSUREDAMAGE)

/proc/spawner_is_pepper_proof(spawner_type)
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/datum/outfit/outfit = initial(spawner.outfit)
	var/obj/item/clothing/mask = SPAWNER_SLOT(spawner, outfit, mask)
	var/obj/item/clothing/head = SPAWNER_SLOT(spawner, outfit, head)
	return (ispath(mask, /obj/item/clothing) && (initial(mask.flags_cover) & PEPPERPROOF)) || (ispath(head, /obj/item/clothing) && (initial(head.flags_cover) & PEPPERPROOF))

/proc/get_spawner_flash_protection(spawner_type)
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/datum/outfit/outfit = initial(spawner.outfit)
	. = hardsuit_helmet_flash_protection(SPAWNER_SLOT(spawner, outfit, suit)) // a hardsuit's helmet isn't in the head slot, as it comes out of the suit
	for(var/obj/item/clothing/worn as anything in list(SPAWNER_SLOT(spawner, outfit, head), SPAWNER_SLOT(spawner, outfit, glasses), SPAWNER_SLOT(spawner, outfit, mask)))
		if(ispath(worn, /obj/item/clothing))
			. += initial(worn.flash_protect)

/proc/hardsuit_helmet_flash_protection(suit_type)
	var/obj/item/clothing/suit/space/hardsuit/hardsuit = suit_type
	if(!ispath(hardsuit, /obj/item/clothing/suit/space/hardsuit))
		return 0
	var/obj/item/clothing/helmet = initial(hardsuit.helmettype)
	return ispath(helmet, /obj/item/clothing) ? initial(helmet.flash_protect) : 0

// how much a corpse spawner's outfit slows whoever wears it, all its clothes together
/proc/get_spawner_slowdown(spawner_type)
	var/static/list/slowdown_by_spawner = list()
	if(!isnull(slowdown_by_spawner[spawner_type]))
		return slowdown_by_spawner[spawner_type]
	var/total = 0
	for(var/obj/item/clothing/worn as anything in get_spawner_clothing(spawner_type))
		total += initial(worn.slowdown)
	slowdown_by_spawner[spawner_type] = total
	return total

/proc/spawner_has_flashlight(spawner_type)
	var/static/list/flashlight_by_spawner = list()
	if(!isnull(flashlight_by_spawner[spawner_type]))
		return flashlight_by_spawner[spawner_type]
	var/obj/effect/mob_spawn/human/spawner = spawner_type
	var/outfit_type = initial(spawner.outfit)
	var/datum/outfit/outfit = ispath(outfit_type, /datum/outfit) ? new outfit_type : null
	var/list/carried = list(
		initial(spawner.belt) == -1 ? outfit?.belt : initial(spawner.belt),
		initial(spawner.r_pocket) == -1 ? outfit?.r_pocket : initial(spawner.r_pocket),
		initial(spawner.l_pocket) == -1 ? outfit?.l_pocket : initial(spawner.l_pocket),
		initial(spawner.suit_store) == -1 ? outfit?.suit_store : initial(spawner.suit_store),
	)
	if(islist(outfit?.backpack_contents))
		carried += outfit.backpack_contents
	qdel(outfit)
	var/found = FALSE
	for(var/item_type in carried)
		if(ispath(item_type, /obj/item/flashlight) || ispath(item_type, /obj/item/attachment/rail_light))
			found = TRUE
			break
	flashlight_by_spawner[spawner_type] = found
	return found

#undef SPAWNER_SLOT
