/obj/item/reagent_containers/spray/waterflower/lube
	name = "water flower"
	desc = "A seemingly innocent sunflower...with a twist. A <i>slippery</i> twist."
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "sunflower"
	item_state = "sunflower"
	amount_per_transfer_from_this = 3
	spray_range = 1
	stream_range = 1
	volume = 30
	list_reagents = list(/datum/reagent/lube = 30)

//BANANIUM SWORD

/obj/item/melee/energy/sword/bananium
	name = "bananium sword"
	desc = "An elegant weapon, for a more civilized age."
	force = 0
	throwforce = 0
	active_force = 0
	active_throwforce = 0
	hitsound = null
	attack_verb_on = list("slipped")
	sharpness = IS_BLUNT
	sword_color = "yellow"
	heat = 0
	light_color = COLOR_YELLOW
	var/next_trombone_allowed = 0

/obj/item/melee/energy/sword/bananium/Initialize()
	. = ..()
	adjust_slipperiness()

/* Adds or removes a slippery component, depending on whether the sword
 * is active or not.
 */
/obj/item/melee/energy/sword/proc/adjust_slipperiness()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		AddComponent(/datum/component/slippery, 60, GALOSHES_DONT_HELP)
	else
		qdel(GetComponent(/datum/component/slippery))

/obj/item/melee/energy/sword/bananium/attack(mob/living/M, mob/living/user)
	..()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		var/datum/component/slippery/slipper = GetComponent(/datum/component/slippery)
		slipper.Slip(src, M)

/obj/item/melee/energy/sword/bananium/throw_impact(atom/hit_atom, throwingdatum)
	. = ..()
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		var/datum/component/slippery/slipper = GetComponent(/datum/component/slippery)
		slipper.Slip(src, hit_atom)

/obj/item/melee/energy/sword/bananium/attackby(obj/item/I, mob/living/user, params)
	if((world.time > next_trombone_allowed) && istype(I, /obj/item/melee/energy/sword/bananium))
		next_trombone_allowed = world.time + 50
		to_chat(user, "<span class='warning'>You slap the two swords together. Sadly, they do not seem to fit!</span>")
		playsound(src, 'sound/misc/sadtrombone.ogg', 50)
		return TRUE
	return ..()

/obj/item/melee/energy/sword/bananium/on_transform(obj/item/source, mob/user, active)
	. = ..()
	adjust_slipperiness()

/obj/item/melee/energy/sword/bananium/ignition_effect(atom/A, mob/user)
	return ""

//BANANIUM SHIELD

/obj/item/shield/energy/bananium
	name = "bananium energy shield"
	desc = "A shield that stops most melee attacks, protects user from almost all energy projectiles, and can be thrown to slip opponents."
	throw_speed = 1
	clumsy_check = 0
	base_icon_state = "bananaeshield"
	force = 0
	throwforce = 0
	throw_range = 5
	on_force = 0
	on_throwforce = 0
	on_throw_speed = 1

/obj/item/shield/energy/bananium/Initialize()
	. = ..()
	adjust_slipperiness()

/* Adds or removes a slippery component, depending on whether the shield
 * is active or not.
 */
/obj/item/shield/energy/bananium/proc/adjust_slipperiness()
	if(active)
		AddComponent(/datum/component/slippery, 60, GALOSHES_DONT_HELP)
	else
		qdel(GetComponent(/datum/component/slippery))

/obj/item/shield/energy/bananium/attack_self(mob/living/carbon/human/user)
	. = ..()
	adjust_slipperiness()

/obj/item/shield/energy/bananium/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force, gentle = FALSE, quickstart = TRUE)
	if(active)
		if(iscarbon(thrower))
			var/mob/living/carbon/C = thrower
			C.throw_mode_on(THROW_MODE_TOGGLE) //so they can catch it on the return.
	return ..()

/obj/item/shield/energy/bananium/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(active)
		var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
		if(iscarbon(hit_atom) && !caught)//if they are a carbon and they didn't catch it
			var/datum/component/slippery/slipper = GetComponent(/datum/component/slippery)
			slipper.Slip(src, hit_atom)
		var/mob/thrown_by = thrownby?.resolve()
		if(thrown_by && !caught)
			addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, throw_at), thrown_by, throw_range+2, throw_speed, null, TRUE), 1)
	else
		return ..()


//BOMBANANA

/obj/item/reagent_containers/food/snacks/grown/banana/bombanana
	trash = /obj/item/grown/bananapeel/bombanana
	bitesize = 1
	customfoodfilling = FALSE
	seed = null
	tastes = list("explosives" = 10)
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 1)

/obj/item/grown/bananapeel/bombanana
	desc = "A peel from a banana. Why is it beeping?"
	seed = null
	var/det_time = 50
	var/obj/item/grenade/syndieminibomb/bomb

/obj/item/grown/bananapeel/bombanana/Initialize()
	. = ..()
	bomb = new /obj/item/grenade/syndieminibomb(src)
	bomb.det_time = det_time
	if(iscarbon(loc))
		to_chat(loc, "<span class='danger'>[src] begins to beep.</span>")
	bomb.preprime(loc, null, FALSE)

/obj/item/grown/bananapeel/bombanana/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/slippery, det_time)

/obj/item/grown/bananapeel/bombanana/Destroy()
	. = ..()
	QDEL_NULL(bomb)

//TEARSTACHE GRENADE

/obj/item/grenade/chem_grenade/teargas/moustache
	name = "tear-stache grenade"
	desc = "A handsomely-attired teargas grenade."
	icon_state = "moustacheg"
	clumsy_check = GRENADE_NONCLUMSY_FUMBLE

/obj/item/grenade/chem_grenade/teargas/moustache/prime()
	var/myloc = get_turf(src)
	. = ..()
	for(var/mob/living/carbon/M in view(6, myloc))
		if(!istype(M.wear_mask, /obj/item/clothing/mask/gas/clown_hat) && !istype(M.wear_mask, /obj/item/clothing/mask/gas/mime))
			if(!M.wear_mask || M.dropItemToGround(M.wear_mask))
				var/obj/item/clothing/mask/fakemoustache/sticky/the_stash = new /obj/item/clothing/mask/fakemoustache/sticky()
				M.equip_to_slot_or_del(the_stash, ITEM_SLOT_MASK, TRUE, TRUE, TRUE, TRUE)

/obj/item/clothing/mask/fakemoustache/sticky
	var/unstick_time = 600

/obj/item/clothing/mask/fakemoustache/sticky/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, STICKY_MOUSTACHE_TRAIT)
	addtimer(CALLBACK(src, PROC_REF(unstick)), unstick_time)

/obj/item/clothing/mask/fakemoustache/sticky/proc/unstick()
	REMOVE_TRAIT(src, TRAIT_NODROP, STICKY_MOUSTACHE_TRAIT)
