
//Hydraulic clamp, Kill clamp, Extinguisher, RCD, Cable layer.


/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp
	name = "hydraulic clamp"
	desc = "Equipment for engineering exosuits. Lifts objects and loads them into cargo."
	icon_state = "mecha_clamp"
	equip_cooldown = 15
	energy_drain = 10
	tool_behaviour = TOOL_RETRACTOR
	toolspeed = 0.8
	var/dam_force = 20
	var/obj/mecha/working/ripley/cargo_holder
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/can_attach(obj/mecha/working/ripley/M as obj)
	if(..())
		if(istype(M))
			return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/attach(obj/mecha/M as obj)
	..()
	cargo_holder = M
	return

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/detach(atom/moveto = null)
	..()
	cargo_holder = null

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/action(atom/target)
	if(!action_checks(target))
		return
	if(!cargo_holder)
		return
	if(ismecha(target))
		var/obj/mecha/M = target
		var/have_ammo
		for(var/obj/item/mecha_ammo/box in cargo_holder.cargo)
			if(istype(box, /obj/item/mecha_ammo) && box.rounds)
				have_ammo = TRUE
				if(M.ammo_resupply(box, chassis.occupant, TRUE))
					return
		if(have_ammo)
			to_chat(chassis.occupant, "No further supplies can be provided to [M].")
		else
			to_chat(chassis.occupant, "No providable supplies found in cargo hold")
		return
	if(isobj(target))
		var/obj/O = target
		if(istype(O, /obj/machinery/door/firedoor))
			var/obj/machinery/door/firedoor/D = O
			D.try_to_crowbar(src,chassis.occupant)
			return
		if(istype(O, /obj/machinery/door/airlock/))
			var/obj/machinery/door/airlock/D = O
			D.try_to_crowbar(src,chassis.occupant)
			return
		if(!O.anchored)
			if(cargo_holder.cargo.len < cargo_holder.cargo_capacity)
				chassis.visible_message("<span class='notice'>[chassis] lifts [target] and starts to load it into cargo compartment.</span>")
				O.set_anchored(TRUE)
				if(do_after_cooldown(target))
					cargo_holder.cargo += O
					O.forceMove(chassis)
					O.set_anchored(FALSE)
					occupant_message("<span class='notice'>[target] successfully loaded.</span>")
					log_message("Loaded [O]. Cargo compartment capacity: [cargo_holder.cargo_capacity - cargo_holder.cargo.len]", LOG_MECHA)
				else
					O.set_anchored(initial(O.anchored))
			else
				occupant_message("<span class='warning'>Not enough room in cargo compartment!</span>")
		else
			occupant_message("<span class='warning'>[target] is firmly secured!</span>")

	else if(isliving(target))
		var/mob/living/M = target
		if(M.stat == DEAD)
			return
		if(chassis.occupant.a_intent == INTENT_HARM)
			M.take_overall_damage(dam_force)
			if(!M)
				return
			M.adjustOxyLoss(round(dam_force/2))
			M.updatehealth()
			target.visible_message("<span class='danger'>[chassis] squeezes [target]!</span>", \
								"<span class='userdanger'>[chassis] squeezes you!</span>",\
								"<span class='hear'>You hear something crack.</span>")
			log_combat(chassis.occupant, M, "attacked", "[name]", "(INTENT: [uppertext(chassis.occupant.a_intent)]) (DAMTYPE: [uppertext(damtype)])")
		else
			step_away(M,chassis)
			occupant_message("<span class='notice'>You push [target] out of the way.</span>")
			chassis.visible_message("<span class='notice'>[chassis] pushes [target] out of the way.</span>")
		return 1



//This is pretty much just for the death-ripley
/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill
	name = "\improper KILL CLAMP"
	desc = "They won't know what clamped them!"
	energy_drain = 0
	dam_force = 0
	var/real_clamp = FALSE

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill/real
	desc = "They won't know what clamped them! This time for real!"
	energy_drain = 10
	dam_force = 20
	real_clamp = TRUE

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill/action(atom/target)
	if(!action_checks(target))
		return
	if(!cargo_holder)
		return
	if(isobj(target))
		var/obj/O = target
		if(!O.anchored)
			if(cargo_holder.cargo.len < cargo_holder.cargo_capacity)
				chassis.visible_message("<span class='notice'>[chassis] lifts [target] and starts to load it into cargo compartment.</span>")
				O.set_anchored(TRUE)
				if(do_after_cooldown(target))
					cargo_holder.cargo += O
					O.forceMove(chassis)
					O.set_anchored(FALSE)
					occupant_message("<span class='notice'>[target] successfully loaded.</span>")
					log_message("Loaded [O]. Cargo compartment capacity: [cargo_holder.cargo_capacity - cargo_holder.cargo.len]", LOG_MECHA)
				else
					O.set_anchored(initial(O.anchored))
			else
				occupant_message("<span class='warning'>Not enough room in cargo compartment!</span>")
		else
			occupant_message("<span class='warning'>[target] is firmly secured!</span>")

	else if(isliving(target))
		var/mob/living/M = target
		if(M.stat == DEAD)
			return
		if(chassis.occupant.a_intent == INTENT_HARM)
			if(real_clamp)
				M.take_overall_damage(dam_force)
				if(!M)
					return
				M.adjustOxyLoss(round(dam_force/2))
				M.updatehealth()
				target.visible_message("<span class='danger'>[chassis] destroys [target] in an unholy fury!</span>", \
									"<span class='userdanger'>[chassis] destroys you in an unholy fury!</span>")
				log_combat(chassis.occupant, M, "attacked", "[name]", "(INTENT: [uppertext(chassis.occupant.a_intent)]) (DAMTYPE: [uppertext(damtype)])")
			else
				target.visible_message("<span class='danger'>[chassis] destroys [target] in an unholy fury!</span>", \
									"<span class='userdanger'>[chassis] destroys you in an unholy fury!</span>")
		else if(chassis.occupant.a_intent == INTENT_DISARM)
			if(real_clamp)
				var/mob/living/carbon/C = target
				var/play_sound = FALSE
				var/limbs_gone = ""
				var/obj/item/bodypart/affected = C.get_bodypart(BODY_ZONE_L_ARM)
				if(affected != null)
					affected.dismember(damtype)
					play_sound = TRUE
					limbs_gone = ", [affected]"
				affected = C.get_bodypart(BODY_ZONE_R_ARM)
				if(affected != null)
					affected.dismember(damtype)
					play_sound = TRUE
					limbs_gone = "[limbs_gone], [affected]"
				if(play_sound)
					playsound(src, get_dismember_sound(), 80, TRUE)
					target.visible_message(
						"<span class='danger'>[chassis] rips [target]'s arms off!</span>",
						"<span class='userdanger'>[chassis] rips your arms off!</span>"
					)
					log_combat(chassis.occupant, M, "dismembered of[limbs_gone],", "[name]", "(INTENT: [uppertext(chassis.occupant.a_intent)]) (DAMTYPE: [uppertext(damtype)])")
			else
				target.visible_message(
					"<span class='danger'>[chassis] rips [target]'s arms off!</span>",
					"<span class='userdanger'>[chassis] rips your arms off!</span>"
				)
		else
			step_away(M,chassis)
			target.visible_message(
				"<span class='danger'>[chassis] tosses [target] like a piece of paper!</span>",
				"<span class='userdanger'>[chassis] tosses you like a piece of paper!</span>"
			)
		return 1



/obj/item/mecha_parts/mecha_equipment/extinguisher
	name = "exosuit extinguisher"
	desc = "Equipment for engineering exosuits. A rapid-firing high capacity fire extinguisher."
	icon_state = "mecha_exting"
	equip_cooldown = 5
	energy_drain = 0
	range = MECHA_MELEE|MECHA_RANGED

/obj/item/mecha_parts/mecha_equipment/extinguisher/Initialize()
	. = ..()
	create_reagents(1000)
	reagents.add_reagent(/datum/reagent/water, 1000)

/obj/item/mecha_parts/mecha_equipment/extinguisher/action(atom/target) //copypasted from extinguisher. TODO: Rewrite from scratch.
	if(!action_checks(target) || get_dist(chassis, target)>3)
		return

	if(istype(target, /obj/structure/reagent_dispensers/watertank) && get_dist(chassis,target) <= 1)
		var/obj/structure/reagent_dispensers/watertank/WT = target
		WT.reagents.trans_to(src, 1000)
		occupant_message("<span class='notice'>Extinguisher refilled.</span>")
		playsound(chassis, 'sound/effects/refill.ogg', 50, TRUE, -6)
	else
		if(reagents.total_volume > 0)
			playsound(chassis, 'sound/effects/extinguish.ogg', 75, TRUE, -3)
			var/direction = get_dir(chassis,target)
			var/turf/T = get_turf(target)
			var/turf/T1 = get_step(T,turn(direction, 90))
			var/turf/T2 = get_step(T,turn(direction, -90))

			var/list/the_targets = list(T,T1,T2)
			spawn(0)
				for(var/a=0, a<5, a++)
					var/obj/effect/particle_effect/water/W = new /obj/effect/particle_effect/water(get_turf(chassis))
					if(!W)
						return
					var/turf/my_target = pick(the_targets)
					var/datum/reagents/R = new/datum/reagents(5)
					W.reagents = R
					R.my_atom = W
					reagents.trans_to(W,1, transfered_by = chassis.occupant)
					for(var/b=0, b<4, b++)
						if(!W)
							return
						step_towards(W,my_target)
						if(!W)
							return
						var/turf/W_turf = get_turf(W)
						W.reagents.expose(W_turf)
						for(var/atom/atm in W_turf)
							W.reagents.expose(atm)
						if(W.loc == my_target)
							break
						sleep(2)
		return 1

/obj/item/mecha_parts/mecha_equipment/extinguisher/get_equip_info()
	return "[..()] \[[src.reagents.total_volume]\]"

/obj/item/mecha_parts/mecha_equipment/extinguisher/can_attach(obj/mecha/working/M as obj)
	if(..())
		if(istype(M))
			return 1
	return 0



/obj/item/mecha_parts/mecha_equipment/rcd
	name = "mounted RCD"
	desc = "An exosuit-mounted Rapid Construction Device."
	icon_state = "mecha_rcd"
	equip_cooldown = 10
	energy_drain = 250
	range = MECHA_MELEE|MECHA_RANGED
	item_flags = NO_MAT_REDEMPTION
	var/mode = 0 //0 - deconstruct, 1 - wall or floor, 2 - airlock.

/obj/item/mecha_parts/mecha_equipment/rcd/Initialize()
	. = ..()
	GLOB.rcd_list += src

/obj/item/mecha_parts/mecha_equipment/rcd/Destroy()
	GLOB.rcd_list -= src
	return ..()

/obj/item/mecha_parts/mecha_equipment/rcd/action(atom/target)
	if(istype(target, /turf/open/space/transit))//>implying these are ever made -Sieve
		return

	if(!isturf(target) && !istype(target, /obj/machinery/door/airlock))
		target = get_turf(target)
	if(!action_checks(target) || get_dist(chassis, target)>3)
		return
	playsound(chassis, 'sound/machines/click.ogg', 50, TRUE)

	switch(mode)
		if(0)
			if(iswallturf(target))
				var/turf/closed/wall/W = target
				occupant_message("<span class='notice'>Deconstructing [W]...</span>")
				if(do_after_cooldown(W))
					chassis.spark_system.start()
					W.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
					playsound(W, 'sound/items/deconstruct.ogg', 50, TRUE)
			else if(isfloorturf(target))
				var/turf/open/floor/F = target
				occupant_message("<span class='notice'>Deconstructing [F]...</span>")
				if(do_after_cooldown(target))
					chassis.spark_system.start()
					F.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
					playsound(F, 'sound/items/deconstruct.ogg', 50, TRUE)
			else if (istype(target, /obj/machinery/door/airlock))
				occupant_message("<span class='notice'>Deconstructing [target]...</span>")
				if(do_after_cooldown(target))
					chassis.spark_system.start()
					qdel(target)
					playsound(target, 'sound/items/deconstruct.ogg', 50, TRUE)
		if(1)
			if(isspaceturf(target))
				var/turf/open/space/S = target
				occupant_message("<span class='notice'>Building Floor...</span>")
				if(do_after_cooldown(S))
					S.PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
					playsound(S, 'sound/items/deconstruct.ogg', 50, TRUE)
					chassis.spark_system.start()
			else if(isfloorturf(target))
				var/turf/open/floor/F = target
				occupant_message("<span class='notice'>Building Wall...</span>")
				if(do_after_cooldown(F))
					F.PlaceOnTop(/turf/closed/wall)
					playsound(F, 'sound/items/deconstruct.ogg', 50, TRUE)
					chassis.spark_system.start()
		if(2)
			if(isfloorturf(target))
				occupant_message("<span class='notice'>Building Airlock...</span>")
				if(do_after_cooldown(target))
					chassis.spark_system.start()
					var/obj/machinery/door/airlock/T = new /obj/machinery/door/airlock(target)
					T.autoclose = TRUE
					playsound(target, 'sound/items/deconstruct.ogg', 50, TRUE)
					playsound(target, 'sound/effects/sparks2.ogg', 50, TRUE)



/obj/item/mecha_parts/mecha_equipment/rcd/do_after_cooldown(atom/target)
	. = ..()

/obj/item/mecha_parts/mecha_equipment/rcd/Topic(href,href_list)
	..()
	if(href_list["mode"])
		mode = text2num(href_list["mode"])
		switch(mode)
			if(0)
				occupant_message("<span class='notice'>Switched RCD to Deconstruct.</span>")
				energy_drain = initial(energy_drain)
			if(1)
				occupant_message("<span class='notice'>Switched RCD to Construct.</span>")
				energy_drain = 2*initial(energy_drain)
			if(2)
				occupant_message("<span class='notice'>Switched RCD to Construct Airlock.</span>")
				energy_drain = 2*initial(energy_drain)
	return

/obj/item/mecha_parts/mecha_equipment/rcd/get_equip_info()
	return "[..()] \[<a href='?src=[REF(src)];mode=0'>D</a>|<a href='?src=[REF(src)];mode=1'>C</a>|<a href='?src=[REF(src)];mode=2'>A</a>\]"

//WS Edit Begin - Readded from Smartwire Revert
/obj/item/mecha_parts/mecha_equipment/cable_layer
	name = "cable layer"
	desc = "Equipment for engineering exosuits. Lays cable along the exosuit's path."
	icon_state = "mecha_wire"
	var/datum/callback/event
	var/turf/old_turf
	var/obj/structure/cable/last_piece
	var/obj/item/stack/cable_coil/cable
	var/max_cable = 1000

/obj/item/mecha_parts/mecha_equipment/cable_layer/Initialize()
	. = ..()
	cable = new(src, 0)

/obj/item/mecha_parts/mecha_equipment/cable_layer/can_attach(obj/mecha/working/M)
	if(..())
		if(istype(M))
			return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/cable_layer/attach()
	..()
	event = chassis.events.addEvent("onMove", CALLBACK(src, PROC_REF(layCable)))
	return

/obj/item/mecha_parts/mecha_equipment/cable_layer/detach()
	chassis.events.clearEvent("onMove",event)
	return ..()

/obj/item/mecha_parts/mecha_equipment/cable_layer/Destroy()
	if(chassis)
		chassis.events.clearEvent("onMove",event)
	return ..()

/obj/item/mecha_parts/mecha_equipment/cable_layer/action(obj/item/stack/cable_coil/target)
	if(!action_checks(target))
		return
	if(istype(target) && target.amount)
		var/cur_amount = cable? cable.amount : 0
		var/to_load = max(max_cable - cur_amount,0)
		if(to_load)
			to_load = min(target.amount, to_load)
			if(!cable)
				cable = new(src, 0)
			cable.amount += to_load
			target.use(to_load)
			occupant_message("<span class='notice'>[to_load] meters of cable successfully loaded.</span>")
			send_byjax(chassis.occupant,"exosuit.browser","[REF(src)]",src.get_equip_info())
		else
			occupant_message("<span class='warning'>Reel is full.</span>")
	else
		occupant_message("<span class='warning'>Unable to load [target] - no cable found.</span>")


/obj/item/mecha_parts/mecha_equipment/cable_layer/Topic(href,href_list)
	..()
	if(href_list["toggle"])
		set_ready_state(!equip_ready)
		occupant_message("[src] [equip_ready?"dea":"a"]ctivated.")
		log_message("[equip_ready?"Dea":"A"]ctivated.", LOG_MECHA)
		return
	if(href_list["cut"])
		if(cable && cable.amount)
			var/m = round(input(chassis.occupant,"Please specify the length of cable to cut","Cut cable",min(cable.amount,30)) as num, 1)
			m = min(m, cable.amount)
			if(m)
				use_cable(m)
				new /obj/item/stack/cable_coil(get_turf(chassis), m)
		else
			occupant_message("There's no more cable on the reel.")
	return

/obj/item/mecha_parts/mecha_equipment/cable_layer/get_equip_info()
	var/output = ..()
	if(output)
		return "[output] \[Cable: [cable ? cable.amount : 0] m\][(cable && cable.amount) ? "- <a href='?src=[REF(src)];toggle=1'>[!equip_ready?"Dea":"A"]ctivate</a>|<a href='?src=[REF(src)];cut=1'>Cut</a>" : null]"
	return

/obj/item/mecha_parts/mecha_equipment/cable_layer/proc/use_cable(amount)
	if(!cable || cable.amount<1)
		set_ready_state(1)
		occupant_message("Cable depleted, [src] deactivated.")
		log_message("Cable depleted, [src] deactivated.", LOG_MECHA)
		return
	if(cable.amount < amount)
		occupant_message("No enough cable to finish the task.")
		return
	cable.use(amount)
	update_equip_info()
	return 1

/obj/item/mecha_parts/mecha_equipment/cable_layer/proc/reset()
	last_piece = null

/obj/item/mecha_parts/mecha_equipment/cable_layer/proc/dismantleFloor(turf/new_turf)
	if(isfloorturf(new_turf))
		var/turf/open/floor/T = new_turf
		if(!isplatingturf(T))
			if(!T.broken && !T.burnt)
				new T.floor_tile(T)
			T.make_plating()
	return !new_turf.intact

/obj/item/mecha_parts/mecha_equipment/cable_layer/proc/layCable(turf/new_turf)
	if(equip_ready || !istype(new_turf) || !dismantleFloor(new_turf))
		return reset()
	var/fdirn = turn(chassis.dir,180)
	for(var/obj/structure/cable/LC in new_turf)		// check to make sure there's not a cable there already
		if(LC.d1 == fdirn || LC.d2 == fdirn)
			return reset()
	if(!use_cable(1))
		return reset()
	var/obj/structure/cable/NC = new(new_turf, "red")
	NC.d1 = 0
	NC.d2 = fdirn
	NC.update_appearance()

	var/datum/powernet/PN
	if(last_piece && last_piece.d2 != chassis.dir)
		last_piece.d1 = min(last_piece.d2, chassis.dir)
		last_piece.d2 = max(last_piece.d2, chassis.dir)
		last_piece.update_appearance()
		PN = last_piece.powernet

	if(!PN)
		PN = new()
		GLOB.powernets += PN
	NC.powernet = PN
	PN.cables += NC
	NC.mergeConnectedNetworks(NC.d2)

	//NC.mergeConnectedNetworksOnTurf()
	last_piece = NC
	return 1
//WS Edit End - Readded from Smartwire Revert

/obj/item/mecha_parts/mecha_equipment/salvage_saw
	name = "109-C Salvage Saw"
	desc = "Equipment for cutting open walls and airlocks."
	icon_state = "mecha_saw"
	equip_cooldown = 5
	energy_drain = 10
	force = 15
	var/dam_force = 30
	harmful = TRUE
	tool_behaviour = TOOL_DECONSTRUCT
	toolspeed = 0.5
	var/datum/effect_system/spark_spread/spark_system

/obj/item/mecha_parts/mecha_equipment/salvage_saw/can_attach(obj/mecha/M as obj)
	if(..())
		if(istype(M, /obj/mecha/working) || istype(M, /obj/mecha/combat))
			return 1
	return 0

/obj/item/mecha_parts/mecha_equipment/salvage_saw/attach()
	..()
	toolspeed = 0.5
	return

/obj/item/mecha_parts/mecha_equipment/salvage_saw/detach()
	..()
	toolspeed = 10 //yeah sure, use a mech tool without a mech. see how far that gets you
	return ..()

/obj/item/mecha_parts/mecha_equipment/salvage_saw/action(atom/target)
	if(!action_checks(target))
		return
	if(isliving(target))
		if(chassis.occupant.a_intent == INTENT_HARM)
			var/mob/living/M = target
			saw_mob(M, chassis.occupant)
		return
	else
		target.add_overlay(GLOB.cutting_effect)
		if(target.deconstruct_act(chassis.occupant, src))
			do_sparks(2, TRUE, src)
			chassis.stopped--
		target.cut_overlay(GLOB.cutting_effect)
		if(!chassis.stopped)
			occupant_message("[src] finishes cutting, allowing movement again.")

/obj/item/mecha_parts/mecha_equipment/salvage_saw/tool_start_check(user, amount)
	if(!chassis.stopped)
		occupant_message("[src] begins cutting, locking in place!")
	chassis.stopped++
	return TRUE

/obj/item/mecha_parts/mecha_equipment/salvage_saw/proc/saw_mob(mob/living/target, mob/user)
	target.visible_message("<span class='danger'>[chassis] is sawing [target] with [src]!</span>", \
						"<span class='userdanger'>[chassis] is sawing you with [src]!</span>")
	if(!do_after_cooldown(target))
		return
	log_combat(user, target, "sawed", "[name]", "(INTENT: [uppertext(user.a_intent)]) (DAMTYPE: [uppertext(damtype)])")
	if(target.stat == DEAD && target.getBruteLoss() >= 400)
		log_combat(user, target, "gibbed", name)
		target.gib()
	else
		var/obj/item/bodypart/target_part = target.get_bodypart(ran_zone(BODY_ZONE_CHEST))
		target.apply_damage(15, BRUTE, BODY_ZONE_CHEST, target.run_armor_check(target_part, "melee"))

		//blood splatters
		var/splatter_dir = get_dir(chassis, target)
		if(isalien(target))
			new /obj/effect/temp_visual/dir_setting/bloodsplatter/xenosplatter(target.drop_location(), splatter_dir)
		else
			var/splatter_color = null
			if(iscarbon(target))
				var/mob/living/carbon/carbon_target = target
				splatter_color = carbon_target.dna.blood_type.color
			new /obj/effect/temp_visual/dir_setting/bloodsplatter(target.drop_location(), splatter_dir, splatter_color)

		//organs go everywhere
		if(target_part && prob(10))
			target_part.dismember(BRUTE)

//Dunno where else to put this so shrug
/obj/item/mecha_parts/mecha_equipment/conversion_kit
	name = "Exosuit Conversion Kit"
	desc = "A perfectly generic conversion kit for a perfectly generic exosuit. How did you even get this?"
	icon_state = "ripleyupgrade"
	var/source_mech = list(null) //must be a list due to the mining ripley existing
	var/result_mech = null

/obj/item/mecha_parts/mecha_equipment/conversion_kit/can_attach(obj/mecha/M)
	if (!(M.type in source_mech))
		to_chat(loc, "<span class='warning'>This conversion kit can not be applied to this model.</span>")
		return FALSE
	if(M.type == /obj/mecha/working/ripley)
		var/obj/mecha/working/ripley/R = M
		if(R.cargo.len)
			to_chat(loc, "<span class='warning'>[R]'s cargo hold must be empty before this conversion kit can be applied.</span>")
			return FALSE
	if(!M.maint_access) //non-removable upgrade, so lets make sure the pilot or owner has their say.
		to_chat(loc, "<span class='warning'>[M] must have maintenance protocols active in order to allow this conversion kit.</span>")
		return FALSE
	if(M.occupant) //We're actually making a new mech and swapping things over, it might get weird if players are involved
		to_chat(loc, "<span class='warning'>[M] must be unoccupied before this conversion kit can be applied.</span>")
		return FALSE
	if(!M.cell) //Turns out things break if the cell is missing
		to_chat(loc, "<span class='warning'>The conversion process requires a cell installed.</span>")
		return FALSE
	return TRUE

/obj/item/mecha_parts/mecha_equipment/conversion_kit/attach(obj/mecha/M)
	var/obj/mecha/N = new result_mech(get_turf(M),1)
	if(!N)
		return
	QDEL_NULL(N.cell)
	if (M.cell)
		N.cell = M.cell
		M.cell.forceMove(N)
		M.cell = null
	QDEL_NULL(N.scanmod)
	if (M.scanmod)
		N.scanmod = M.scanmod
		M.scanmod.forceMove(N)
		M.scanmod = null
	QDEL_NULL(N.capacitor)
	if (M.capacitor)
		N.capacitor = M.capacitor
		M.capacitor.forceMove(N)
		M.capacitor = null
	N.update_part_values()
	for(var/obj/item/mecha_parts/E in M.contents)
		if(istype(E, /obj/item/mecha_parts/concealed_weapon_bay)) //why is the bay not just a variable change who did this
			E.forceMove(N)
	for(var/obj/item/mecha_parts/mecha_equipment/E in M.equipment) //Move the equipment over...
		E.detach()
		E.attach(N)
		M.equipment -= E
	N.dna_lock = M.dna_lock
	N.maint_access = M.maint_access
	N.strafe = M.strafe
	N.obj_integrity = M.obj_integrity //This is not a repair tool
	M.wreckage = 0
	qdel(M)
	playsound(get_turf(N),'sound/items/ratchet.ogg',50,TRUE)
	return

/obj/item/mecha_parts/mecha_equipment/conversion_kit/ripley
	name = "Ripley MK-II Conversion Kit"
	desc = "A pressurized canopy attachment kit for an Autonomous Power Loader Unit \"Ripley\" MK-I mecha, to convert it to the slower, but space-worthy MK-II design. This kit cannot be removed, once applied."
	icon_state = "ripleyupgrade"
	source_mech = list(/obj/mecha/working/ripley, /obj/mecha/working/ripley/mining)
	result_mech = /obj/mecha/working/ripley/mkii

/obj/item/mecha_parts/mecha_equipment/conversion_kit/ripley/clip
	name = "CLIP Ripley MK-IV Conversion Kit"
	desc = "A CLIP-custom lightweight canopy kit for an Autonomous Power Loader Unit \"Ripley\" MK-I mecha, to convert it to the mobile and spaceworthy Mk-IV design. This kit cannot be removed, once applied."
	icon_state = "clipupgrade"
	source_mech = list(/obj/mecha/working/ripley, /obj/mecha/working/ripley/mining)
	result_mech = /obj/mecha/working/ripley/clip

/obj/item/mecha_parts/mecha_equipment/conversion_kit/paladin
	name = "CLIP Paladin Conversion Kit"
	desc = "A CLIP-custom conversion kit for a Durand combat exosuit, to convert it to the specialized Paladin anti-xenofauna exosuit."
	icon_state = "clipupgrade"
	source_mech = list(/obj/mecha/combat/durand)
	result_mech = /obj/mecha/combat/durand/clip

/obj/item/mecha_parts/mecha_equipment/conversion_kit/inteq_gygax
	name = "IRMG Basenji Conversion Kit"
	desc = "An IRMG-custom conversion kit for a Gygax combat exosuit, to convert it to the specialized Pyrnese breaching exosuit."
	source_mech = list(/obj/mecha/combat/gygax,/obj/mecha/combat/gygax/dark)
	result_mech = /obj/mecha/combat/gygax/inteq

