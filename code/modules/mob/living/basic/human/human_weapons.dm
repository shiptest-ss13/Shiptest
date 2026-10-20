// What human NPCs fight with: setting up their gun or melee weapon, how they fire it, and what they drop

/mob/living/basic/human/proc/has_heavy_melee_weapon(obj/item/weapon)
	var/static/list/heavy_weapons = typecacheof(list(/obj/item/melee/sledgehammer, /obj/item/melee/axe, /obj/item/melee/boarding_axe, /obj/item/melee/trench_club))
	if(isnull(weapon))
		weapon = get_melee_weapon()
	return ispath(weapon, /obj/item) && heavy_weapons[weapon]

/mob/living/basic/human/proc/setup_melee()
	var/obj/item/weapon = get_melee_weapon()
	if(!weapon)
		return // our fists, then
	var/weapon_sharpness = initial(weapon.sharpness)
	if(sharpness == SHARP_NONE)
		sharpness = weapon_sharpness
	if(!wound_bonus)
		wound_bonus = initial(weapon.wound_bonus)
	if(!bare_wound_bonus)
		bare_wound_bonus = initial(weapon.bare_wound_bonus)
	if(attack_sound == /mob/living/basic/human::attack_sound) // the root's, so a subtype's own sound stays
		if(initial(weapon.hitsound))
			attack_sound = initial(weapon.hitsound)
		else if(ispath(weapon, /obj/item/gun))
			attack_sound = 'sound/weapons/genhit1.ogg' // bashing them with it
	if(attack_verb_continuous != /mob/living/basic/human::attack_verb_continuous)
		return
	switch(weapon_sharpness)
		if(SHARP_POINTY)
			attack_verb_continuous = "stabs"
			attack_verb_simple = "stab"
		if(SHARP_EDGED)
			attack_verb_continuous = "slashes"
			attack_verb_simple = "slash"
		else
			attack_verb_continuous = "bashes"
			attack_verb_simple = "bash"

/mob/living/basic/human/proc/get_melee_weapon()
	for(var/obj/item/held as anything in list(l_hand, r_hand))
		if(ispath(held, /obj/item) && !ispath(held, /obj/item/gun) && !ispath(held, /obj/item/shield)) // a shield's for blocking, not hitting with
			return held
	var/obj/item/gun/gun_type = get_gun_type()
	if(!gun_type)
		return null
	for(var/attachment in get_gun_default_attachments(gun_type))
		if(ispath(attachment, /obj/item/attachment/bayonet))
			return attachment
	return gun_type

/mob/living/basic/human/proc/setup_weapon()
	if(fires_flames)
		AddComponent(/datum/component/ranged_attacks/flamethrower, projectile_sound = projectile_sound, cooldown_time = ranged_cooldown)
		return
	if(!casing_type && !projectile_type)
		return
	var/obj/item/gun/gun_type = get_gun_type()
	var/shot_spread = spread
	if(isnull(shot_spread))
		shot_spread = gun_type ? initial(gun_type.spread) : 2
		var/obj/item/attachment/foldable_stock/stock = get_gun_folding_stock(gun_type)
		if(stock)
			shot_spread += initial(stock.toggled_spread_bonus) // use stock if available
	shot_spread = max(shot_spread, 0) + aim_spread
	var/volley_shots = burst_shots
	var/volley_interval = burst_interval
	var/list/fire_pattern = get_gun_fire_pattern(gun_type)
	if(fire_pattern)
		volley_interval = max(fire_pattern[2] * AI_VOLLEY_INTERVAL_MULTIPLIER, AI_MINIMUM_VOLLEY_INTERVAL)
		var/obj/item/ammo_casing/casing = casing_type
		if(!ispath(casing) || initial(casing.pellets) <= 1)
			volley_shots = max(volley_shots, fire_pattern[1]) // not for shotguns, bursting would be horrifying

	AddComponent(/datum/component/ranged_attacks, casing_type, projectile_type, projectile_sound, volley_shots, volley_interval, ranged_cooldown, shot_spread, first_contact_spread)
	if(gun_type && get_gun_capacity(gun_type))
		AddComponent(/datum/component/ai_magazine, gun_type) // for reloading, if it's got rounds or charge to count

// mobility based on weapon type
/mob/living/basic/human/proc/pick_mobility()
	var/obj/item/gun/gun_type = get_gun_type()
	if(!gun_type)
		return AI_MOBILITY_NORMAL
	if(initial(gun_type.weapon_weight) >= WEAPON_HEAVY)
		return AI_MOBILITY_LOW
	if(initial(gun_type.weapon_weight) == WEAPON_LIGHT && initial(gun_type.w_class) <= WEIGHT_CLASS_NORMAL)
		return AI_MOBILITY_HIGH
	return AI_MOBILITY_NORMAL

/mob/living/basic/human/proc/get_gun_type()
	if(ispath(r_hand, /obj/item/gun))
		return r_hand
	if(ispath(l_hand, /obj/item/gun))
		return l_hand
	return null

// handles behavior for either dropping the held item or damaging it
/mob/living/basic/human/proc/handle_hand_item_destruction(obj/hand)
	if(!hand) // wow look nothing
		return
	if(ispath(hand, /obj/item/gun)) // we always drop guns, the drop chance just makes them functional
		var/obj/item/gun/dropped_gun = new hand(loc)
		modify_dropped_gun(dropped_gun)
	else if(prob(weapon_drop_chance)) // for melee weapons and stuff they just explode into dust
		new hand(loc)
	else
		visible_message(span_danger("[src]'s [initial(hand.name)] is destroyed as they collapse!"))

// applies special stuff to guns that are dropped, which are very special indeed
/mob/living/basic/human/proc/modify_dropped_gun(obj/item/gun/dropped_gun)
	var/good = TRUE
	// break gun and apply broken overlay
	if(!prob(weapon_drop_chance)) // you got the dud!
		good = FALSE
		visible_message(span_danger("[src]'s [dropped_gun.name] is destroyed as they collapse!"))
		dropped_gun.actually_shoots = FALSE
		dropped_gun.desc += span_warning("\nIt appears to be irreparably broken.")
		dropped_gun.glunkify() // broken overlay

	// BALLISTICS - apply wear, mag drop chance, and empty the mag partially
	if(istype(dropped_gun, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/cosmetic_damage = dropped_gun
		cosmetic_damage.gun_wear = rand(cosmetic_damage.wear_minor_threshold, cosmetic_damage.wear_maximum) //my free gun... it's bowowken...
		if(!prob(weapon_drop_chance) && !cosmetic_damage.internal_magazine)
			qdel(cosmetic_damage.magazine)
			cosmetic_damage.magazine = null
		if(cosmetic_damage.magazine)
			for(var/i in 1 to rand(0, cosmetic_damage.magazine.max_ammo))
				qdel(cosmetic_damage.magazine.get_round()) // feels kludgy but like. how else
			cosmetic_damage.magazine.update_ammo_count()
		cosmetic_damage.update_appearance()

	// ENERGY - drain cell a random amount, cell drop chance
	if(istype(dropped_gun, /obj/item/gun/energy))
		var/obj/item/gun/energy/lazor = dropped_gun
		if(lazor.cell)
			lazor.cell.charge = rand(0, lazor.cell.maxcharge)
			lazor.update_appearance()
			if(!good) // undamaged guns never have dud cells
				lazor.cell.name = "dented [lazor.cell.name]"
				lazor.cell.desc += " It doesn't seem to be in the greatest condition..."
				if(!prob(weapon_drop_chance))
					lazor.cell.rigged = TRUE // smiles warmly
					lazor.cell.show_rigged = FALSE

/mob/living/basic/human/do_attack_animation(atom/A, visual_effect_icon, used_item, no_effect)
	if(!visual_effect_icon && !used_item)
		var/obj/item/weapon_type = get_melee_weapon()
		if(ispath(weapon_type, /obj/item))
			used_item = get_ai_item_template(weapon_type)
	return ..()

// One of item_type to copy the look of, for the AI to use for icons, cached
/proc/get_ai_item_template(item_type)
	var/static/list/templates = list()
	var/obj/item/template = templates[item_type]
	if(QDELETED(template))
		template = new item_type
		templates[item_type] = template
	return template

/mob/living/basic/human/melee_attack(atom/target)
	. = ..()
	if(!melee_knockback || !isliving(target))
		return
	var/mob/living/knocked = target
	if(!knocked.anchored)
		knocked.throw_at(get_edge_target_turf(knocked, dir), rand(1, melee_knockback), 2, src, gentle = gentle_knockback)

// How a gun of this type fires in a burst, as list(shots, time between them) or null
/proc/get_gun_fire_pattern(gun_type)
	var/static/list/pattern_by_type = list()
	if(!ispath(gun_type, /obj/item/gun))
		return null
	if(gun_type in pattern_by_type)
		return pattern_by_type[gun_type]
	var/obj/item/gun/gun = new gun_type
	var/list/pattern
	var/list/modes = gun.gun_firemodes
	// a gun that never set its own modes has every one of them, which isn't it being automatic
	if(!(FIREMODE_OTHER_TWO in modes))
		if(FIREMODE_FULLAUTO in modes)
			pattern = list(AI_AUTOMATIC_BURST_SHOTS, gun.fire_delay)
		else if(FIREMODE_BURST in modes)
			pattern = list(gun.burst_size, gun.burst_delay)
	if(!pattern && (istype(gun, /obj/item/gun/ballistic/automatic/pistol) || istype(gun, /obj/item/gun/ballistic/revolver) || (istype(gun, /obj/item/gun/energy) && gun.w_class <= WEIGHT_CLASS_SMALL)))
		pattern = list(AI_HANDGUN_VOLLEY_SHOTS, gun.fire_delay) // a single-shot handgun, fired as quick as its trigger allows
	qdel(gun)
	pattern_by_type[gun_type] = pattern
	return pattern


// The type of folding stock a gun of gun_type comes with, or null
/proc/get_gun_folding_stock(gun_type)
	for(var/attachment in get_gun_default_attachments(gun_type))
		if(ispath(attachment, /obj/item/attachment/foldable_stock))
			return attachment
	return null

// The attachments a gun of this type spawns with, worked out by making one, once per type, and remembered
/proc/get_gun_default_attachments(gun_type)
	var/static/list/attachments_by_type = list()
	if(!ispath(gun_type, /obj/item/gun))
		return list()
	if(!isnull(attachments_by_type[gun_type]))
		return attachments_by_type[gun_type]
	var/obj/item/gun/gun = new gun_type
	var/list/attachments = gun.default_attachments ? gun.default_attachments.Copy() : list()
	qdel(gun)
	attachments_by_type[gun_type] = attachments
	return attachments
