
/obj/item/organ/wings/bee
	name = "pair of bee wings"
	desc = "A pair of bee wings. They seem tiny and undergrown"
	icon_state = "beewings"
	flight_level = WINGS_COSMETIC
	actions_types = list(/datum/action/item_action/organ_action/use/bee_dash)
	wing_type = "Bee"
	var/jumpdist = 3

/obj/item/organ/wings/bee/Remove(mob/living/carbon/human/H, special)
	jumpdist = initial(jumpdist)
	return ..()

/datum/action/item_action/organ_action/use/bee_dash
	var/jumpspeed = 1
	var/recharging_rate = 100
	var/recharging_time = 0

/datum/action/item_action/organ_action/use/bee_dash/Trigger()
	var/mob/living/carbon/L = owner
	var/obj/item/organ/wings/bee/wings = locate(/obj/item/organ/wings/bee) in L.internal_organs
	var/jumpdistance = wings.jumpdist

	if(L.stat != CONSCIOUS || L.buckling || L.restrained()) // Has to be conscious and unbuckled
		return
	if(recharging_time > world.time)
		to_chat(L, "<span class='warning'>The wings aren't ready to dash yet!</span>")
		return
	var/datum/gas_mixture/environment = L.loc.return_air()
	if(environment && !(environment.return_pressure() > 30))
		to_chat(L, "<span class='warning'>The atmosphere is too thin for you to dash!</span>")
		return

	var/turf/target = get_edge_target_turf(L, L.dir) //represents the user's direction
	var/hoppingtable = FALSE // Triggers the trip
	var/jumpdistancemoved = jumpdistance // temp jumpdistance
	var/turf/checkjump = get_turf(L)

	for(var/i in 1 to jumpdistance) //This is how hiero club find the tiles in front of it, tell me/fix it if there's a better way
		var/turf/T = get_step(checkjump, L.dir)
		if(T.density || !T.ClickCross(invertDir(L.dir), border_only = 1))
			break
		if(locate(/obj/structure/table) in T) // If there's a table, trip
			hoppingtable = TRUE
			jumpdistancemoved = i
			break
		if(!T.ClickCross(L.dir)) // Check for things other than tables that would block flight at the T turf
			break
		checkjump = get_step(checkjump, L.dir)

	var/datum/callback/crashcallback
	if(hoppingtable)
		crashcallback = CALLBACK(src, PROC_REF(crash_into_table), get_step(checkjump, L.dir))
	if(L.throw_at(target, jumpdistancemoved, jumpspeed, spin = FALSE, diagonals_first = TRUE, callback = crashcallback, force = MOVE_FORCE_WEAK))
		playsound(L, 'sound/creatures/bee.ogg', 50, 1, 1)
		L.visible_message("<span class='warning'>[usr] dashes forward into the air!</span>")
		recharging_time = world.time + recharging_rate
	else
		to_chat(L, "<span class='warning'>Something prevents you from dashing forward!</span>")

/datum/action/item_action/organ_action/use/bee_dash/proc/crash_into_table(turf/tableturf)
	if(owner.loc == tableturf)
		var/mob/living/carbon/L = owner
		L.take_bodypart_damage(10,check_armor = TRUE)
		L.Paralyze(40)
		L.visible_message("<span class='danger'>[L] crashes into a table, falling over!</span>",\
			"<span class='userdanger'>You violently crash into a table!</span>")
		playsound(src,'sound/weapons/punch1.ogg',50,1)
