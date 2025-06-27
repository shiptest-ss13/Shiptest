/obj/mecha/proc/get_armour_facing(attack_dir)
	switch(abs(dir2angle(attack_dir) - dir2angle(dir)))
		if(180) // BACKSTAB!
			return facing_modifiers[MECHA_BACK_ARMOUR]
		if(90, 135, 225, 270)
			return facing_modifiers[MECHA_SIDE_ARMOUR]
		if(0, 45, 315)
			return facing_modifiers[MECHA_FRONT_ARMOUR]
	return 1 //always return non-0

/obj/mecha/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	var/damage_taken = ..()
	if(damage_taken && obj_integrity > 0)
		if(obj_integrity / max_integrity < STRUCTURAL_DAMAGE_THRESHOLD)
			structural_damage += min(damage_taken, max_integrity * STRUCTURAL_DAMAGE_THRESHOLD - obj_integrity) * STRUCTURAL_DAMAGE_RATIO
		spark_system.start()
		switch(damage_flag)
			if("fire")
				check_for_internal_damage(list(MECHA_INT_FIRE,MECHA_INT_TEMP_CONTROL))
			if("melee")
				check_for_internal_damage(list(MECHA_INT_TEMP_CONTROL,MECHA_INT_TANK_BREACH,MECHA_INT_CONTROL_LOST))
			else
				check_for_internal_damage(list(MECHA_INT_FIRE,MECHA_INT_TEMP_CONTROL,MECHA_INT_TANK_BREACH,MECHA_INT_CONTROL_LOST,MECHA_INT_SHORT_CIRCUIT))
		if(damage_taken >= 5 || prob(33))
			occupant_message(span_userdanger("Taking damage!"))
		log_message("Took [damage_amount] points of damage. Damage type: [damage_type]", LOG_MECHA)
		diag_hud_set_mechhealth()
	return damage_taken

/obj/mecha/run_obj_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	. = ..()
	if(!damage_amount)
		return 0
	var/deflection_modifier = 1
	var/damage_modifier = 1
	if(attack_dir)
		var/facing_modifier = get_armour_facing(attack_dir)
		damage_modifier /= facing_modifier
		deflection_modifier *= facing_modifier
	if(prob(deflect_chance * deflection_modifier))
		visible_message(span_danger("[src]'s armour deflects the attack!"))
		log_message("Armor saved.", LOG_MECHA)
		return 0
	if(.)
		. *= damage_modifier

/obj/mecha/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE) // Ugh. Ideally we shouldn't be setting cooldowns outside of click code.
	user.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
	playsound(loc, 'sound/weapons/tap.ogg', 40, TRUE, -1)
	user.visible_message(span_danger("[user] hits [name]. Nothing happens."), null, null, COMBAT_MESSAGE_RANGE)
	log_message("Attack by hand/paw. Attacker - [user].", LOG_MECHA, color="red")

/obj/mecha/attack_paw(mob/user as mob)
	return attack_hand(user)

/obj/mecha/attack_alien(mob/living/user)
	log_message("Attack by alien. Attacker - [user].", LOG_MECHA, color="red")
	playsound(src.loc, 'sound/weapons/slash.ogg', 100, TRUE)
	attack_generic(user, 15, BRUTE, "melee", 0)

/obj/mecha/attack_animal(mob/living/simple_animal/user)
	log_message("Attack by simple animal. Attacker - [user].", LOG_MECHA, color="red")
	if(!user.melee_damage_upper && !user.obj_damage)
		user.emote("custom", message = "[user.friendly_verb_continuous] [src].")
		return 0
	else
		var/play_soundeffect = 1
		if(user.environment_smash)
			play_soundeffect = 0
			playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
		var/animal_damage = rand(user.melee_damage_lower,user.melee_damage_upper)
		if(user.obj_damage)
			animal_damage = user.obj_damage
		animal_damage = min(animal_damage, 20*user.environment_smash)
		log_combat(user, src, "attacked")
		attack_generic(user, animal_damage, user.melee_damage_type, "melee", play_soundeffect)
		return 1


/obj/mecha/hulk_damage()
	return 15

/obj/mecha/attack_hulk(mob/living/carbon/human/user)
	. = ..()
	if(.)
		log_message("Attack by hulk. Attacker - [user].", LOG_MECHA, color="red")
		log_combat(user, src, "punched", "hulk powers")

/obj/mecha/attack_tk()
	return

/obj/mecha/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum) //wrapper
	log_message("Hit by [AM].", LOG_MECHA, color="red")
	. = ..()

/obj/mecha/bullet_act(obj/projectile/incoming) //wrapper
	if (!enclosed && occupant && !silicon_pilot && !incoming.force_hit && (incoming.def_zone == BODY_ZONE_HEAD || incoming.def_zone == BODY_ZONE_CHEST)) //allows bullets to hit the pilot of open-canopy mechs
		occupant.bullet_act(incoming) //If the sides are open, the occupant can be hit
		return BULLET_ACT_HIT
	log_message("Hit by projectile. Type: [incoming.name]([incoming.flag]).", LOG_MECHA, color="red")
	var/prev_integrity = obj_integrity
	. = ..()
	if(obj_integrity == prev_integrity) // DEFLECTED
		playsound(src, incoming.ricochet_sound, 75, TRUE)
		incoming.firer = src
		incoming.setAngle(incoming.Angle + rand(30, 120) * pick(1, -1))
		return BULLET_ACT_FORCE_PIERCE

/obj/mecha/ex_act(severity, target)
	log_message("Affected by explosion of severity: [severity].", LOG_MECHA, color="red")
	if(prob(deflect_chance))
		severity++
		log_message("Armor saved, changing severity to [severity]", LOG_MECHA)
	. = ..()

/obj/mecha/contents_explosion(severity, target)
	severity++
	for(var/X in equipment)
		var/obj/item/mecha_parts/mecha_equipment/ME = X
		switch(severity)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highobj += ME
			if(EXPLODE_HEAVY)
				SSexplosions.medobj += ME
			if(EXPLODE_LIGHT)
				SSexplosions.lowobj += ME
	for(var/Y in trackers)
		var/obj/item/mecha_parts/mecha_tracking/MT = Y
		switch(severity)
			if(EXPLODE_DEVASTATE)
				SSexplosions.highobj += MT
			if(EXPLODE_HEAVY)
				SSexplosions.medobj += MT
			if(EXPLODE_LIGHT)
				SSexplosions.lowobj += MT
	if(occupant)
		occupant.ex_act(severity,target)

/obj/mecha/handle_atom_del(atom/A)
	if(A == occupant)
		occupant = null
		icon_state = initial(icon_state)+"-open"
		setDir(dir_in)

/obj/mecha/emp_act(severity)
	. = ..()
	if (. & EMP_PROTECT_SELF)
		return
	if(get_charge())
		use_power(cell.charge / (severity * 6))
		take_damage(30 / severity, BURN, ENERGY, TRUE)
	adjust_overheat(30 / severity)
	log_message("EMP detected", LOG_MECHA, color="red")

	if(istype(src, /obj/mecha/combat))
		mouse_pointer = 'icons/effects/mouse_pointers/mecha_mouse-disable.dmi'
		occupant?.update_mouse_pointer()
	if(!equipment_disabled && occupant) //prevent spamming this message with back-to-back EMPs
		to_chat(occupant, span_danger("Error -- Connection to equipment control unit has been lost."))
	if(leg_overload_mode)
		overload_action.Activate(FALSE)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/mecha, restore_equipment)), 3 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)
	equipment_disabled = TRUE

/obj/mecha/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature>max_temperature)
		log_message("Exposed to dangerous temperature.", LOG_MECHA, color="red")
		take_damage(5, BURN, 0, 1)

/obj/mecha/attackby(obj/item/W as obj, mob/user as mob, params)

	if(istype(W, /obj/item/mmi))
		if(mmi_move_inside(W,user))
			to_chat(user, span_notice("[src]-[W] interface initialized successfully."))
		else
			to_chat(user, span_warning("[src]-[W] interface initialization failed."))
		return

	if(istype(W, /obj/item/mecha_ammo))
		ammo_resupply(W, user)
		return

	if(W.GetID())
		if(add_req_access || maint_access)
			if(internals_access_allowed(user))
				var/obj/item/card/id/id_card
				if(istype(W, /obj/item/card/id))
					id_card = W
				else
					var/obj/item/pda/pda = W
					id_card = pda.id
				output_maintenance_dialog(id_card, user)
				return
			to_chat(user, span_warning("Invalid ID: Access denied."))
			return
		to_chat(user, span_warning("Maintenance protocols disabled by operator."))
		return

	if(istype(W, /obj/item/stock_parts/cell))
		if(construction_state == MECHA_OPEN_HATCH)
			if(!cell)
				if(!user.transferItemToLoc(W, src, silent = FALSE))
					return
				var/obj/item/stock_parts/cell/C = W
				to_chat(user, span_notice("You install the power cell."))
				playsound(src, 'sound/items/screwdriver2.ogg', 50, FALSE)
				cell = C
				log_message("Powercell installed", LOG_MECHA)
			else
				to_chat(user, span_warning("There's already a power cell installed!"))
		return

	if(istype(W, /obj/item/stock_parts/scanning_module))
		if(construction_state == MECHA_OPEN_HATCH)
			if(!scanmod)
				if(!user.transferItemToLoc(W, src))
					return
				to_chat(user, span_notice("You install the scanning module."))
				playsound(src, 'sound/items/screwdriver2.ogg', 50, FALSE)
				scanmod = W
				log_message("[W] installed", LOG_MECHA)
				update_part_values()
			else
				to_chat(user, span_warning("There's already a scanning module installed!"))
		return

	if(istype(W, /obj/item/stock_parts/capacitor))
		if(construction_state == MECHA_OPEN_HATCH)
			if(!capacitor)
				if(!user.transferItemToLoc(W, src))
					return
				to_chat(user, span_notice("You install the capacitor."))
				playsound(src, 'sound/items/screwdriver2.ogg', 50, FALSE)
				capacitor = W
				log_message("[W] installed", LOG_MECHA)
				update_part_values()
			else
				to_chat(user, span_warning("There's already a capacitor installed!"))
		return

	if(istype(W, /obj/item/stack/cable_coil))
		if(construction_state == MECHA_OPEN_HATCH && (internal_damage & MECHA_INT_SHORT_CIRCUIT))
			var/obj/item/stack/cable_coil/CC = W
			if(CC.use(2))
				clearInternalDamage(MECHA_INT_SHORT_CIRCUIT)
				to_chat(user, span_notice("You replace the fused wires."))
			else
				to_chat(user, span_warning("You need two lengths of cable to fix this exosuit!"))
		return

	if(istype(W, structural_repair_type))
		if(!structural_damage)
			to_chat(user, span_warning("[src] has no structural damage!"))
			return TRUE
		while(structural_damage && W.use_tool(src, user, 4 SECONDS, 1))
			var/damage_repaired = min(INTEGRITY_REPAIR_PER_SHEET, structural_damage, max_integrity - obj_integrity)
			structural_damage -= damage_repaired
			obj_integrity += damage_repaired
			to_chat(user, span_notice("You repair some of the structural damage."))
			if(obj_integrity == max_integrity)
				structural_damage = 0
				stack_trace("[type] had structural damage while being at full integrity!")
				break
		return TRUE

	if(istype(W, /obj/item/stack/tape/industrial))
		if(obj_integrity >= max_integrity - structural_damage)
			to_chat(user, span_warning("There are some things even [W.name] can't fix. [src] is one of them."))
			return TRUE
		while(obj_integrity < max_integrity - structural_damage && W.use_tool(src, user, 4 SECONDS, 1))
			var/damage_repaired = min(INTEGRITY_REPAIR_PER_SHEET, (max_integrity - structural_damage) - obj_integrity)
			structural_damage += damage_repaired
			obj_integrity += damage_repaired
			to_chat(user, span_notice("You hastily patch some of the plating back together."))
		return TRUE

	if(istype(W, /obj/item/mecha_parts))
		var/obj/item/mecha_parts/P = W
		P.try_attach_part(user, src)
		return
	log_message("Attacked by [W]. Attacker - [user]", LOG_MECHA)
	return ..()

/obj/mecha/wrench_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(construction_state == MECHA_SECURE_BOLTS)
		construction_state = MECHA_LOOSE_BOLTS
		to_chat(user, span_notice("You undo the securing bolts."))
		return
	if(construction_state == MECHA_LOOSE_BOLTS)
		construction_state = MECHA_SECURE_BOLTS
		to_chat(user, span_notice("You tighten the securing bolts."))

/obj/mecha/crowbar_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(construction_state == MECHA_LOOSE_BOLTS)
		construction_state = MECHA_OPEN_HATCH
		to_chat(user, span_notice("You open the hatch to the power unit."))
		return
	if(construction_state == MECHA_OPEN_HATCH)
		construction_state = MECHA_LOOSE_BOLTS
		to_chat(user, span_notice("You close the hatch to the power unit."))

/obj/mecha/screwdriver_act(mob/living/user, obj/item/I)
	..()
	. = TRUE
	if(internal_damage & MECHA_INT_TEMP_CONTROL)
		clearInternalDamage(MECHA_INT_TEMP_CONTROL)
		to_chat(user, span_notice("You repair the damaged temperature controller."))
		return

/obj/mecha/welder_act(mob/living/user, obj/item/W)
	. = ..()
	if(user.a_intent == INTENT_HARM)
		return
	. = TRUE
	if(internal_damage & MECHA_INT_TANK_BREACH)
		if(!W.use_tool(src, user, 0, volume=50, amount=1))
			return
		clearInternalDamage(MECHA_INT_TANK_BREACH)
		to_chat(user, span_notice("You repair the damaged gas tank."))
		return
	while(obj_integrity < max_integrity - structural_damage)
		if(!W.use_tool(src, user, 2 SECONDS, volume=50, amount=1))
			return
		user.visible_message(span_notice("[user] repairs some damage to [name]."), span_notice("You repair some damage to [src]."))
		obj_integrity += min(10 * repair_multiplier, (max_integrity - structural_damage) - obj_integrity)
		if(obj_integrity == max_integrity)
			to_chat(user, span_notice("It looks to be fully repaired now."))
			return TRUE
	if(obj_integrity >= max_integrity - structural_damage)
		to_chat(user, span_warning("Its structure is too damaged to be repaired this way, use [initial(structural_repair_type.name)]!"))
	else
		to_chat(user, span_warning("The [name] is at full integrity!"))
	return TRUE

/obj/mecha/proc/mech_toxin_damage(mob/living/target)
	playsound(src, 'sound/effects/spray2.ogg', 50, TRUE)
	if(target.reagents)
		if(target.reagents.get_reagent_amount(/datum/reagent/cryptobiolin) + force < force*2)
			target.reagents.add_reagent(/datum/reagent/cryptobiolin, force/2)
		if(target.reagents.get_reagent_amount(/datum/reagent/toxin) + force < force*2)
			target.reagents.add_reagent(/datum/reagent/toxin, force/2.5)


/obj/mecha/mech_melee_attack(obj/mecha/M)
	if(!has_charge(melee_energy_drain))
		return 0
	use_power(melee_energy_drain)
	if(M.damtype == BRUTE || M.damtype == BURN)
		log_combat(M.occupant, src, "attacked", M, "(INTENT: [uppertext(M.occupant.a_intent)]) (DAMTYPE: [uppertext(M.damtype)])")
		. = ..()

/obj/mecha/proc/full_repair(charge_cell)
	obj_integrity = max_integrity
	adjust_overheat(-overheat)
	if(cell && charge_cell)
		cell.charge = cell.maxcharge
	if(internal_damage & MECHA_INT_FIRE)
		clearInternalDamage(MECHA_INT_FIRE)
	if(internal_damage & MECHA_INT_TEMP_CONTROL)
		clearInternalDamage(MECHA_INT_TEMP_CONTROL)
	if(internal_damage & MECHA_INT_SHORT_CIRCUIT)
		clearInternalDamage(MECHA_INT_SHORT_CIRCUIT)
	if(internal_damage & MECHA_INT_TANK_BREACH)
		clearInternalDamage(MECHA_INT_TANK_BREACH)
	if(internal_damage & MECHA_INT_CONTROL_LOST)
		clearInternalDamage(MECHA_INT_CONTROL_LOST)

/obj/mecha/narsie_act()
	emp_act(EMP_HEAVY)

/obj/mecha/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!no_effect)
		if(selected)
			used_item = selected
		else if(!visual_effect_icon)
			visual_effect_icon = ATTACK_EFFECT_SMASH
			if(damtype == BURN)
				visual_effect_icon = ATTACK_EFFECT_MECHFIRE
			else if(damtype == TOX)
				visual_effect_icon = ATTACK_EFFECT_MECHTOXIN
	..()

/obj/mecha/obj_destruction()
	if(wreckage)
		var/mob/living/silicon/ai/AI
		if(isAI(occupant))
			AI = occupant
			occupant = null
		var/obj/structure/mecha_wreckage/WR = new wreckage(loc, AI)
		for(var/obj/item/mecha_parts/mecha_equipment/E in equipment)
			if(E.salvageable && prob(30))
				WR.crowbar_salvage += E
				E.detach(WR) //detaches from src into WR
				E.equip_ready = 1
			else
				E.detach(loc)
				qdel(E)
		if(cell)
			WR.crowbar_salvage += cell
			cell.forceMove(WR)
			cell.charge = rand(0, cell.charge)
			cell = null
		if(internal_tank)
			WR.crowbar_salvage += internal_tank
			internal_tank.forceMove(WR)
			cell = null
	. = ..()
