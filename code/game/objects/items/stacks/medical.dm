/obj/item/stack/medical
	name = "medical pack"
	singular_name = "medical pack"
	icon = 'icons/obj/stack_objects.dmi'
	amount = 6
	max_amount = 6
	w_class = WEIGHT_CLASS_SMALL
	full_w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 7
	resistance_flags = FLAMMABLE
	max_integrity = 40
	novariants = FALSE
	item_flags = NOBLUDGEON
	var/heals_organic = TRUE
	var/heals_inorganic = FALSE
	var/splint_fracture = FALSE
	var/restore_integrity = 0
	var/failure_chance
	var/self_delay = 50
	var/other_delay = 0
	var/repeating = FALSE
	var/experience_given = 1
	///Sound/Sounds to play when this is applied
	var/apply_sounds

/obj/item/stack/medical/attack(mob/living/target, mob/user)
	. = ..()
	try_heal(target, user)


/obj/item/stack/medical/proc/try_heal(mob/living/target, mob/user, silent = FALSE)
	if(!target.can_inject(user, TRUE))
		return
	if(target == user)
		playsound(src, islist(apply_sounds) ? pick(apply_sounds) : apply_sounds, 25)
		if(!silent)
			user.visible_message(span_notice("[user] starts to apply \the [src] on [user.p_them()]self..."), span_notice("You begin applying \the [src] on yourself..."))
		if(!do_after(user, self_delay, target, extra_checks=CALLBACK(target, TYPE_PROC_REF(/mob/living, can_inject), user, TRUE)))
			return

	else if(other_delay)
		playsound(src, islist(apply_sounds) ? pick(apply_sounds) : apply_sounds, 25)
		if(!silent)
			user.visible_message(span_notice("[user] starts to apply \the [src] on [target]."), span_notice("You begin applying \the [src] on [target]..."))
		if(!do_after(user, other_delay, target, extra_checks=CALLBACK(target, TYPE_PROC_REF(/mob/living, can_inject), user, TRUE)))
			return


	if(heal(target, user))
		playsound(src, islist(apply_sounds) ? pick(apply_sounds) : apply_sounds, 25)
		user?.mind.adjust_experience(/datum/skill/healing, experience_given)
		log_combat(user, target, "healed", src.name)
		use(1)
		if(repeating && amount > 0)
			try_heal(target, user, TRUE)

/obj/item/stack/medical/proc/heal(mob/living/target, mob/user)
	return

/obj/item/stack/medical/proc/heal_carbon(mob/living/carbon/C, mob/user, brute, burn, integrity = 0)
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(user.zone_selected))
	if(!affecting) //Missing limb?
		to_chat(user, span_warning("[C] doesn't have \a [parse_zone(user.zone_selected)]!"))
		return
	if(!heals_inorganic && !IS_ORGANIC_LIMB(affecting))
		to_chat(user, span_warning("\The [src] won't work on a robotic limb!"))
		return
	if(!heals_organic && IS_ORGANIC_LIMB(affecting))
		to_chat(user, span_warning("\The [src] won't work on an organic limb!"))
		return

	//WS begin - failure chance
	if(prob(failure_chance))
		user.visible_message(span_warning("[user] tries to apply \the [src] on [C]'s [affecting.name], but fails!"), "<span class='warning'>You try to apply \the [src] on  on [C]'s [affecting.name], but fail!")
		return
	//WS end
	var/successful_heal = FALSE //Has this item healed anywhere it could?

	if(affecting.brute_dam && brute || affecting.burn_dam && burn)
		var/brute2heal = brute
		var/burn2heal = burn
		var/skill_mod = user?.mind?.get_skill_modifier(/datum/skill/healing, SKILL_SPEED_MODIFIER)
		if(skill_mod)
			brute2heal *= (2-skill_mod)
			burn2heal *= (2-skill_mod)
		if(affecting.heal_damage(brute2heal, burn2heal))
			C.update_damage_overlays()
		successful_heal = TRUE


	//WS Begin - Splints
	if(splint_fracture) //Check if it's a splint and the bone is broken
		if(affecting.bone_status == BONE_FLAG_SPLINTED) // Check if it isn't already splinted
			to_chat(user, span_warning("[C]'s [affecting.name] is already splinted!"))
		else if(!(affecting.bone_status == BONE_FLAG_BROKEN)) // Check if it's actually broken
			to_chat(user, span_warning("[C]'s [affecting.name] isn't broken!"))
		else
			affecting.bone_status = BONE_FLAG_SPLINTED
			// C.update_inv_splints() something breaks
			successful_heal = TRUE
	//WS End

	if (restore_integrity)
		if(affecting.integrity_loss == 0)
			to_chat(user, span_warning("[C]'s [affecting.name] has no integrity damage!"))
		else
			var/integ_healed = min(integrity, affecting.integrity_loss)
			//check how much limb health we've lost to integrity_loss
			var/integ_damage_removed = max(integ_healed, affecting.integrity_loss-affecting.integrity_ignored)
			var/brute_heal = min(affecting.brute_dam,integ_damage_removed)
			var/burn_heal = max(0,integ_damage_removed-brute_heal)
			affecting.integrity_loss -= integ_healed
			affecting.heal_damage(brute_heal,burn_heal,0,null,BODYTYPE_ROBOTIC)
			// C.update_inv_splints() something breaks
			successful_heal = TRUE


	if (successful_heal)
		user.visible_message(span_green("[user] applies \the [src] on [C]'s [affecting.name]."), span_green("You apply \the [src] on [C]'s [affecting.name]."))
		return TRUE
	to_chat(user, span_warning("[C]'s [affecting.name] can not be healed with \the [src]!"))


/obj/item/stack/medical/bruise_pack
	name = "bruise pack"
	singular_name = "bruise pack"
	desc = "A therapeutic gel pack and bandages designed to treat blunt-force trauma."
	icon_state = "brutepack"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	apply_sounds = list('sound/effects/rip1.ogg', 'sound/effects/rip2.ogg')
	var/heal_brute = 40
	self_delay = 20
	grind_results = list(/datum/reagent/medicine/styptic_powder = 10)

/obj/item/stack/medical/bruise_pack/heal(mob/living/target, mob/user)
	if(isanimal(target))
		var/mob/living/simple_animal/critter = target
		if (!(critter.healable))
			to_chat(user, span_warning("You cannot use \the [src] on [target]!"))
			return FALSE
		else if (critter.health == critter.maxHealth)
			to_chat(user, span_notice("[target] is at full health."))
			return FALSE
		user.visible_message(span_green("[user] applies \the [src] on [target]."), span_green("You apply \the [src] on [target]."))
		target.heal_bodypart_damage((heal_brute/2))
		return TRUE
	if(iscarbon(target))
		return heal_carbon(target, user, heal_brute, 0)
	to_chat(user, span_warning("You can't heal [target] with the \the [src]!"))

/obj/item/stack/medical/gauze
	name = "medical gauze"
	desc = "A roll of elastic cloth that is extremely effective at stopping bleeding and slowly heals wounds."
	gender = PLURAL
	singular_name = "medical gauze"
	icon_state = "gauze"
	apply_sounds = list('sound/effects/rip1.ogg', 'sound/effects/rip2.ogg')
	var/bleed_reduction = 0.02
	var/lifespan = 150
	self_delay = 20
	max_amount = 12
	grind_results = list(/datum/reagent/cellulose = 2)
	custom_price = 50

/obj/item/stack/medical/gauze/twelve
	amount = 12

/obj/item/stack/medical/gauze/five
	amount = 5

/obj/item/stack/medical/gauze/heal(mob/living/target, mob/user)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		var/obj/item/bodypart/BP = C.get_bodypart(check_zone(user.zone_selected))
		if(!BP)
			to_chat(user, span_warning("[C] doesn't have \a [parse_zone(user.zone_selected)]!"))
			return
		if(BP.can_bandage(user))
			BP.apply_bandage(bleed_reduction, lifespan, name)
			user.visible_message(span_notice("[user] wraps [C]'s [parse_zone(BP.body_zone)] with [src]."), span_notice("You wrap [C]'s [parse_zone(check_zone(user.zone_selected))] with [src]."), span_hear("You hear ruffling cloth."))
			return TRUE

/obj/item/stack/medical/gauze/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER || I.get_sharpness())
		if(get_amount() < 2)
			to_chat(user, span_warning("You need at least two gauzes to do this!"))
			return
		new /obj/item/stack/sheet/cotton/cloth(user.drop_location())
		user.visible_message(
			span_notice("[user] cuts [src] into pieces of cloth with [I]."),
			span_notice("You cut [src] into pieces of cloth with [I]."),
			span_hear("You hear cutting.")
		)
		use(2)
	else
		return ..()

/obj/item/stack/medical/gauze/improvised
	name = "improvised gauze"
	singular_name = "improvised gauze"
	desc = "A roll of cloth roughly cut from something that can stop bleeding and slowly heal wounds."
	bleed_reduction = 0.005

/obj/item/stack/medical/gauze/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250

/obj/item/stack/medical/ointment
	name = "ointment"
	desc = "Used to treat those nasty burn wounds."
	gender = PLURAL
	singular_name = "ointment"
	icon_state = "ointment"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	apply_sounds = 'sound/effects/ointment.ogg'
	var/heal_burn = 40
	self_delay = 20
	grind_results = list(/datum/reagent/medicine/silver_sulfadiazine = 10)

/obj/item/stack/medical/ointment/heal(mob/living/target, mob/user)
	if(iscarbon(target))
		return heal_carbon(target, user, 0, heal_burn)
	to_chat(user, span_warning("You can't heal [target] with the \the [src]!"))

/obj/item/stack/medical/suture
	name = "suture"
	desc = "Sterile sutures used to seal up cuts and lacerations."
	gender = PLURAL
	singular_name = "suture"
	icon_state = "suture"
	self_delay = 30
	other_delay = 10
	amount = 15
	max_amount = 15
	repeating = TRUE
	var/heal_brute = 10
	grind_results = list(/datum/reagent/medicine/spaceacillin = 2)

/obj/item/stack/medical/suture/five
	amount = 5

/obj/item/stack/medical/suture/medicated
	name = "medicated suture"
	icon_state = "suture_purp"
	desc = "A suture infused with drugs that speed up wound healing of the treated laceration."
	heal_brute = 15
	grind_results = list(/datum/reagent/medicine/polypyr = 2)

/obj/item/stack/medical/suture/heal(mob/living/target, mob/user)
	. = ..()
	if(iscarbon(target))
		return heal_carbon(target, user, heal_brute, 0)
	if(isanimal(target))
		var/mob/living/simple_animal/critter = target
		if (!(critter.healable))
			to_chat(user, span_warning("You cannot use \the [src] on [target]!"))
			return FALSE
		else if (critter.health == critter.maxHealth)
			to_chat(user, span_notice("[target] is at full health."))
			return FALSE
		user.visible_message(span_green("[user] applies \the [src] on [target]."), span_green("You apply \the [src] on [target]."))
		target.heal_bodypart_damage(heal_brute)
		return TRUE

	to_chat(user, span_warning("You can't heal [target] with the \the [src]!"))

/obj/item/stack/medical/mesh
	name = "regenerative mesh"
	desc = "A bacteriostatic mesh used to dress burns."
	gender = PLURAL
	singular_name = "regenerative mesh"
	icon_state = "regen_mesh"
	self_delay = 30
	other_delay = 10
	amount = 15
	max_amount = 15
	repeating = TRUE
	var/heal_burn = 10
	var/is_open = TRUE ///This var determines if the sterile packaging of the mesh has been opened.
	grind_results = list(/datum/reagent/medicine/spaceacillin = 2)

/obj/item/stack/medical/mesh/Initialize()
	. = ..()
	if(amount == max_amount)	 //only seal full mesh packs
		is_open = FALSE
		update_appearance()

/obj/item/stack/medical/mesh/five
	amount = 5

/obj/item/stack/medical/mesh/update_icon_state()
	if(is_open)
		return ..()
	icon_state = "regen_mesh_closed"

/obj/item/stack/medical/mesh/heal(mob/living/target, mob/user)
	. = ..()
	if(iscarbon(target))
		return heal_carbon(target, user, 0, heal_burn)
	to_chat(user, span_warning("You can't heal [target] with the \the [src]!"))


/obj/item/stack/medical/mesh/try_heal(mob/living/target, mob/user, silent = FALSE)
	if(!is_open)
		to_chat(user, span_warning("You need to open [src] first."))
		return
	. = ..()

/obj/item/stack/medical/mesh/AltClick(mob/living/user)
	if(!is_open)
		to_chat(user, span_warning("You need to open [src] first."))
		return
	. = ..()

/obj/item/stack/medical/mesh/attack_hand(mob/user)
	if(!is_open && user.get_inactive_held_item() == src)
		to_chat(user, span_warning("You need to open [src] first."))
		return
	. = ..()

/obj/item/stack/medical/mesh/attack_self(mob/user)
	if(!is_open)
		is_open = TRUE
		to_chat(user, span_notice("You open the sterile mesh package."))
		update_appearance()
		playsound(src, 'sound/items/poster_ripped.ogg', 20, TRUE)
		return
	. = ..()

/obj/item/stack/medical/mesh/advanced
	name = "advanced regenerative mesh"
	desc = "An advanced mesh made with aloe extracts and sterilizing chemicals, used to treat burns."

	gender = PLURAL
	singular_name = "advanced regenerative mesh"
	icon_state = "aloe_mesh"
	heal_burn = 15
	grind_results = list(/datum/reagent/consumable/aloejuice = 1)

/obj/item/stack/medical/mesh/advanced/update_icon_state()
	if(is_open)
		return ..()
	icon_state = "aloe_mesh_closed"

/obj/item/stack/medical/aloe
	name = "aloe cream"
	desc = "A healing paste you can apply on wounds."

	icon_state = "aloe_paste"
	apply_sounds = 'sound/effects/ointment.ogg'
	self_delay = 20
	other_delay = 10
	novariants = TRUE
	amount = 20
	max_amount = 20
	var/heal = 3
	grind_results = list(/datum/reagent/consumable/aloejuice = 1)

/obj/item/stack/medical/aloe/heal(mob/living/target, mob/user)
	. = ..()
	if(iscarbon(target))
		return heal_carbon(target, user, heal, heal)
	if(isanimal(target))
		var/mob/living/simple_animal/critter = target
		if (!(critter.healable))
			to_chat(user, span_warning("You cannot use \the [src] on [target]!"))
			return FALSE
		else if (critter.health == critter.maxHealth)
			to_chat(user, span_notice("[target] is at full health."))
			return FALSE
		user.visible_message(span_green("[user] applies \the [src] on [target]."), span_green("You apply \the [src] on [target]."))
		target.heal_bodypart_damage(heal, heal)
		return TRUE

	to_chat(user, span_warning("You can't heal [target] with the \the [src]!"))


	/*
	The idea is for these medical devices to work like a hybrid of the old brute packs and tend wounds,
	they heal a little at a time, have reduced healing density and does not allow for rapid healing while in combat.
	However they provice graunular control of where the healing is directed, this makes them better for curing work-related cuts and scrapes.

	The interesting limb targeting mechanic is retained and i still believe they will be a viable choice, especially when healing others in the field.
	*/

// SPLINTS
/obj/item/stack/medical/splint
	amount = 4
	name = "splints"
	desc = "Used to secure limbs following a fracture."
	gender = PLURAL
	singular_name = "splint"
	icon = 'icons/obj/items.dmi'
	icon_state = "splint"
	apply_sounds = list('sound/effects/rip1.ogg', 'sound/effects/rip2.ogg')
	self_delay = 40
	other_delay = 15
	splint_fracture = TRUE
	custom_price = 50

/obj/item/stack/medical/splint/heal(mob/living/target, mob/user)
	. = ..()
	if(iscarbon(target))
		return heal_carbon(target, user)
	to_chat(user, span_warning("You can't splint [target]'s limb' with the \the [src]!"))

/obj/item/stack/medical/splint/ghetto //slightly shittier, but gets the job done
	name = "makeshift splints"
	desc = "Used to secure limbs following a fracture. This one is made out of simple materials."
	amount = 2
	self_delay = 50
	other_delay = 20
	failure_chance = 20

/obj/item/stack/medical/bruise_pack/herb
	name = "ashen herbal pack"
	singular_name = "ashen herbal pack"
	icon_state = "hbrutepack"
	desc = "Thereputic herbs designed to treat bruises."
	heal_brute = 15

/obj/item/stack/medical/ointment/herb
	name = "burn ointment slurry"
	singular_name = "burn ointment slurry"
	icon_state = "hointment"
	desc = "Herb slurry meant to treat burns."
	heal_burn = 15


/obj/item/stack/medical/structure
	name = "replacement structural rods"
	desc = "Steel rods and cable with adjustable titanium fasteners, for quickly repairing structural damage to robotic limbs."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "ipc_splint"
	amount = 2
	max_amount = 3
	novariants = FALSE
	self_delay = 50
	other_delay = 20
	heals_inorganic = TRUE
	heals_organic = FALSE
	restore_integrity = TRUE


/obj/item/stack/medical/structure/heal(mob/living/target, mob/user)
	. = ..()
	if(iscarbon(target))
		return heal_carbon(target, user, integrity = 150)
	to_chat(user, span_warning("You can't repair [target]'s limb' with the \the [src]!"))


