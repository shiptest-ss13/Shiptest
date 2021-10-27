/*
 * Cryogenic refrigeration unit. Basically a despawner.
 * Stealing a lot of concepts/code from sleepers due to massive laziness.
 * The despawn tick will only fire if it's been more than time_till_despawned ticks
 * since time_entered, which is world.time when the occupant moves in.
 * ~ Zuhayr
 */
GLOBAL_LIST_EMPTY(cryopod_computers)

//Main cryopod console.

/obj/machinery/computer/cryopod
	name = "cryogenic oversight console"
	desc = "An interface between crew and the cryogenic storage oversight systems."
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "cellconsole_1"
	// circuit = /obj/item/circuitboard/cryopodcontrol
	density = FALSE
	interaction_flags_machine = INTERACT_MACHINE_OFFLINE
	req_one_access = list(ACCESS_HEADS, ACCESS_ARMORY) //Heads of staff or the warden can go here to claim recover items from their department that people went were cryodormed with.
	var/mode = null

	//Used for logging people entering cryosleep and important items they are carrying.
	var/list/frozen_crew = list()
	var/list/frozen_items = list()

	var/storage_type = "crewmembers"
	var/storage_name = "Cryogenic Oversight Control"
	var/allow_items = TRUE

/obj/machinery/computer/cryopod/Initialize()
	. = ..()
	GLOB.cryopod_computers += src

/obj/machinery/computer/cryopod/Destroy()
	GLOB.cryopod_computers -= src
	..()

/obj/machinery/computer/cryopod/attack_ai()
	attack_hand()

/obj/machinery/computer/cryopod/attack_hand(mob/user = usr)
	if(machine_stat & (NOPOWER|BROKEN))
		return

	user.set_machine(src)
	add_fingerprint(user)

	var/dat

	dat += "<hr/><br/><b>[storage_name]</b><br/>"
	dat += "<i>Welcome, [user.real_name].</i><br/><br/><hr/>"
	dat += "<a href='?src=[REF(src)];log=1'>View storage log</a>.<br>"
	if(allow_items)
		dat += "<a href='?src=[REF(src)];view=1'>View objects</a>.<br>"
		dat += "<a href='?src=[REF(src)];item=1'>Recover object</a>.<br>"
		dat += "<a href='?src=[REF(src)];allitems=1'>Recover all objects</a>.<br>"

	user << browse(dat, "window=cryopod_console")
	onclose(user, "cryopod_console")

/obj/machinery/computer/cryopod/Topic(href, href_list)
	if(..())
		return 1

	var/mob/user = usr

	add_fingerprint(user)

	if(href_list["log"])

		var/dat = "<b>Recently stored [storage_type]</b><br/><hr/><br/>"
		for(var/person in frozen_crew)
			dat += "[person]<br/>"
		dat += "<hr/>"

		user << browse(dat, "window=cryolog")

	if(href_list["view"])
		if(!allow_items) return

		var/dat = "<b>Recently stored objects</b><br/><hr/><br/>"
		for(var/obj/item/I in frozen_items)
			dat += "[I.name]<br/>"
		dat += "<hr/>"

		user << browse(dat, "window=cryoitems")

	else if(href_list["item"])
		if(!allowed(user))
			to_chat(user, "<span class='warning'>Access Denied.</span>")
			return
		if(!allow_items) return

		if(frozen_items.len == 0)
			to_chat(user, "<span class='notice'>There is nothing to recover from storage.</span>")
			return

		var/obj/item/I = input(user, "Please choose which object to retrieve.","Object recovery",null) as null|anything in frozen_items
		if(!I)
			return

		if(!(I in frozen_items))
			to_chat(user, "<span class='notice'>\The [I] is no longer in storage.</span>")
			return

		visible_message("<span class='notice'>The console beeps happily as it disgorges \the [I].</span>")

		I.forceMove(get_turf(src))
		frozen_items -= I

	else if(href_list["allitems"])
		if(!allowed(user))
			to_chat(user, "<span class='warning'>Access Denied.</span>")
			return
		if(!allow_items) return

		if(frozen_items.len == 0)
			to_chat(user, "<span class='notice'>There is nothing to recover from storage.</span>")
			return

		visible_message("<span class='notice'>The console beeps happily as it disgorges the desired objects.</span>")

		for(var/obj/item/I in frozen_items)
			I.forceMove(get_turf(src))
			frozen_items -= I

	updateUsrDialog()
	return

//Cryopods themselves.
/obj/machinery/cryopod
	name = "cryogenic freezer"
	desc = "Suited for Cyborgs and Humanoids, the pod is a safe place for personnel affected by the Space Sleep Disorder to get some rest."
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "cryopod-open"
	density = TRUE
	anchored = TRUE
	state_open = TRUE

	/// Time until the human inside is despawned. Reduced to 10% of this if player manually enters cryo.
	var/time_till_despawn = 5 MINUTES

	var/obj/machinery/computer/cryopod/control_computer
	var/last_no_computer_message = 0

	// These items are preserved when the process() despawn proc occurs.
	var/static/list/preserve_items = list(
		/obj/item/hand_tele,
		/obj/item/card/id/captains_spare,
		/obj/item/aicard,
		/obj/item/mmi,
		/obj/item/paicard,
		/obj/item/gun,
		/obj/item/pinpointer,
		/obj/item/clothing/shoes/magboots,
		/obj/item/areaeditor/blueprints,
		/obj/item/clothing/head/helmet/space,
		/obj/item/clothing/suit/space,
		/obj/item/clothing/suit/armor,
		/obj/item/defibrillator/compact,
		/obj/item/reagent_containers/hypospray/CMO,
		/obj/item/clothing/accessory/medal/gold/captain,
		/obj/item/clothing/gloves/krav_maga,
		/obj/item/nullrod,
		/obj/item/tank/jetpack,
		/obj/item/documents,
		/obj/item/nuke_core_container
	)
	// These items will NOT be preserved
	var/static/list/do_not_preserve_items = list (
		/obj/item/mmi/posibrain
	)

/obj/machinery/cryopod/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD //Gotta populate the cryopod computer GLOB first

/obj/machinery/cryopod/LateInitialize()
	update_icon()
	find_control_computer()

/obj/machinery/cryopod/proc/find_control_computer(urgent = FALSE)
	for(var/M in GLOB.cryopod_computers)
		var/obj/machinery/computer/cryopod/C = M
		if(get_area(C) == get_area(src))
			control_computer = C
			break

	// Don't send messages unless we *need* the computer, and less than five minutes have passed since last time we messaged
	if(!control_computer && urgent && last_no_computer_message + 5 MINUTES < world.time)
		log_admin("Cryopod in [get_area(src)] could not find control computer!")
		message_admins("Cryopod in [get_area(src)] could not find control computer!")
		last_no_computer_message = world.time

	return control_computer != null

/obj/machinery/cryopod/JoinPlayerHere(mob/M, buckle)
	. = ..()
	close_machine(M, TRUE)

/obj/machinery/cryopod/close_machine(mob/user, exiting = FALSE)
	if(!control_computer)
		find_control_computer(TRUE)
	if((isnull(user) || istype(user)) && state_open && !panel_open)
		..(user)
		if(exiting && istype(user, /mob/living/carbon))
			var/mob/living/carbon/C = user
			C.SetSleeping(50)
			to_chat(occupant, "<span class='boldnotice'>You begin to wake from cryosleep...</span>")
			icon_state = "cryopod"
			return
		var/mob/living/mob_occupant = occupant
		if(mob_occupant && mob_occupant.stat != DEAD)
			to_chat(occupant, "<span class='boldnotice'>You feel cool air surround you. You go numb as your senses turn inward.</span>")
		addtimer(CALLBACK(src, .proc/try_despawn_occupant, mob_occupant), mob_occupant.client ? time_till_despawn * 0.1 : time_till_despawn) // If they're logged in, reduce the timer
	icon_state = "cryopod"

/obj/machinery/cryopod/open_machine()
	..()
	icon_state = "cryopod-open"
	density = TRUE
	name = initial(name)

/obj/machinery/cryopod/container_resist_act(mob/living/user)
	visible_message("<span class='notice'>[occupant] emerges from [src]!</span>",
		"<span class='notice'>You climb out of [src]!</span>")
	open_machine()

/obj/machinery/cryopod/relaymove(mob/user)
	container_resist_act(user)

/obj/machinery/cryopod/proc/try_despawn_occupant(mob/target)
	if(!occupant || occupant != target)
		return

	var/mob/living/mob_occupant = occupant
	if(mob_occupant.stat > UNCONSCIOUS) // Eject occupant if they're not alive
		open_machine()
		return

	if(!mob_occupant.client) //Occupant's client isn't present
		if(!control_computer)
			find_control_computer(urgent = TRUE)//better hope you found it this time

		despawn_occupant()
	else
		addtimer(CALLBACK(src, .proc/try_despawn_occupant, mob_occupant), time_till_despawn) //try again with normal delay

/obj/machinery/cryopod/proc/handle_objectives()
	var/mob/living/mob_occupant = occupant
	//Update any existing objectives involving this mob.
	for(var/datum/objective/O in GLOB.objectives)
		// We don't want revs to get objectives that aren't for heads of staff. Letting
		// them win or lose based on cryo is silly so we remove the objective.
		if(istype(O,/datum/objective/mutiny) && O.target == mob_occupant.mind)
			O.team.objectives -= O
			qdel(O)
			for(var/datum/mind/M in O.team.members)
				to_chat(M.current, "<BR><span class='userdanger'>Your target is no longer within reach. Objective removed!</span>")
				M.announce_objectives()
		else if(O.target && istype(O.target, /datum/mind))
			if(O.target == mob_occupant.mind)
				var/old_target = O.target
				O.target = null
				if(!O)
					return
				O.find_target()
				if(!O.target && O.owner)
					to_chat(O.owner.current, "<BR><span class='userdanger'>Your target is no longer within reach. Objective removed!</span>")
					for(var/datum/antagonist/A in O.owner.antag_datums)
						A.objectives -= O
				if (!O.team)
					O.update_explanation_text()
					O.owner.announce_objectives()
					to_chat(O.owner.current, "<BR><span class='userdanger'>You get the feeling your target is no longer within reach. Time for Plan [pick("A","B","C","D","X","Y","Z")]. Objectives updated!</span>")
				else
					var/list/objectivestoupdate
					for(var/datum/mind/own in O.get_owners())
						to_chat(own.current, "<BR><span class='userdanger'>You get the feeling your target is no longer within reach. Time for Plan [pick("A","B","C","D","X","Y","Z")]. Objectives updated!</span>")
						for(var/datum/objective/ob in own.get_all_objectives())
							LAZYADD(objectivestoupdate, ob)
					objectivestoupdate += O.team.objectives
					for(var/datum/objective/ob in objectivestoupdate)
						if(ob.target != old_target || !istype(ob,O.type))
							return
						ob.target = O.target
						ob.update_explanation_text()
						to_chat(O.owner.current, "<BR><span class='userdanger'>You get the feeling your target is no longer within reach. Time for Plan [pick("A","B","C","D","X","Y","Z")]. Objectives updated!</span>")
						ob.owner.announce_objectives()
				qdel(O)

/// This function can not be undone; do not call this unless you are sure. It compeletely removes all trace of the mob from the round.
/obj/machinery/cryopod/proc/despawn_occupant()
	var/mob/living/mob_occupant = occupant

	if(mob_occupant.mind && mob_occupant.mind.assigned_role)
		//Handle job slot/tater cleanup.
		var/job = mob_occupant.mind.assigned_role
		SSjob.FreeRole(job)
		if(LAZYLEN(mob_occupant.mind.objectives))
			mob_occupant.mind.objectives.Cut()
			mob_occupant.mind.special_role = null

	// Delete them from datacore.

	var/announce_rank = null
	for(var/datum/data/record/R in GLOB.data_core.medical)
		if((R.fields["name"] == mob_occupant.real_name))
			qdel(R)
	for(var/datum/data/record/T in GLOB.data_core.security)
		if((T.fields["name"] == mob_occupant.real_name))
			qdel(T)
	for(var/datum/data/record/G in GLOB.data_core.general)
		if((G.fields["name"] == mob_occupant.real_name))
			announce_rank = G.fields["rank"]
			qdel(G)

	// Regardless of what ship you spawned in you need to be removed from it.
	// This covers scenarios where you spawn in one ship but cryo in another.
	for(var/obj/structure/overmap/ship/simulated/sim_ship as anything in SSovermap.simulated_ships)
		sim_ship.manifest -= mob_occupant.real_name

	//Make an announcement and log the person entering storage.
	if(control_computer)
		control_computer.frozen_crew += "[mob_occupant.real_name]"

	if(GLOB.announcement_systems.len)
		var/obj/machinery/announcement_system/announcer = pick(GLOB.announcement_systems)
		announcer.announce("CRYOSTORAGE", mob_occupant.real_name, announce_rank, list())
		visible_message("<span class='notice'>\The [src] hums and hisses as it moves [mob_occupant.real_name] into storage.</span>")


	for(var/obj/item/W in mob_occupant.GetAllContents())
		if(W.loc.loc && (( W.loc.loc == loc ) || (W.loc.loc == control_computer)))
			continue//means we already moved whatever this thing was in
			//I'm a professional, okay
			//what the fuck are you on rn and can I have some
		for(var/T in preserve_items)
			if(istype(W, T))
				if(control_computer && control_computer.allow_items)
					control_computer.frozen_items += W
					mob_occupant.transferItemToLoc(W, control_computer, TRUE)
				else
					mob_occupant.transferItemToLoc(W, loc, TRUE)

	for(var/obj/item/W in mob_occupant.GetAllContents())
		qdel(W)//because we moved all items to preserve away
		//and yes, this totally deletes their bodyparts one by one, I just couldn't bother

	if(iscyborg(mob_occupant))
		var/mob/living/silicon/robot/R = occupant
		if(!istype(R)) return

		R.contents -= R.mmi
		qdel(R.mmi)

	// Ghost and delete the mob.
	if(!mob_occupant.get_ghost(TRUE))
		if(world.time < 15 MINUTES)//before the 15 minute mark
			mob_occupant.ghostize(FALSE) // Players despawned too early may not re-enter the game
		else
			mob_occupant.ghostize(TRUE)
	handle_objectives()
	QDEL_NULL(occupant)
	open_machine()
	name = initial(name)

/obj/machinery/cryopod/MouseDrop_T(mob/living/target, mob/user)
	if(!istype(target) || user.incapacitated() || !target.Adjacent(user) || !Adjacent(user) || !ismob(target) || (!ishuman(user) && !iscyborg(user)) || !istype(user.loc, /turf) || target.buckled)
		return

	if(occupant)
		to_chat(user, "<span class='boldnotice'>The cryo pod is already occupied!</span>")
		return

	if(target.stat == DEAD)
		to_chat(user, "<span class='notice'>Dead people can not be put into cryo.</span>")
		return

	if(target.client && user != target)
		if(iscyborg(target))
			to_chat(user, "<span class='danger'>You can't put [target] into [src]. They're online.</span>")
		else
			to_chat(user, "<span class='danger'>You can't put [target] into [src]. They're conscious.</span>")
		return
	else if(target.client)
		if(tgui_alert(target, "Would you like to enter cryosleep?", "Cryopod", list("Yes","No")) != "Yes")
			return

	if(!target || user.incapacitated() || !target.Adjacent(user) || !Adjacent(user) || (!ishuman(user) && !iscyborg(user)) || !istype(user.loc, /turf) || target.buckled)
		return
		//rerun the checks in case of shenanigans

	if(target == user)
		visible_message("[user] starts climbing into [src].")
	else
		visible_message("[user] starts putting [target] into [src].")

	if(occupant)
		to_chat(user, "<span class='boldnotice'>\The [src] is in use.</span>")
		return
	close_machine(target)

	to_chat(target, "<span class='boldnotice'>If you ghost, log out or close your client now, your character will shortly be permanently removed from the round.</span>")
	name = "[name] ([occupant.name])"
	log_admin("<span class='notice'>[key_name(target)] entered a stasis pod.</span>")
	message_admins("[key_name_admin(target)] entered a stasis pod. (<A HREF='?_src_=holder;[HrefToken()];adminplayerobservecoodjump=1;X=[x];Y=[y];Z=[z]'>JMP</a>)")
	add_fingerprint(target)

/obj/machinery/cryopod/latejoin
	var/obj/docking_port/mobile/linked_ship

/obj/machinery/cryopod/latejoin/Initialize()
	. = ..()
	new /obj/effect/landmark/latejoin(src)

/obj/machinery/cryopod/latejoin/despawn_occupant()
	if(!linked_ship)
		return ..()
	var/mob/living/mob_occupant = occupant
	if(mob_occupant.job in linked_ship.current_ship.job_slots)
		linked_ship.current_ship.job_slots[mob_occupant.job]++
	return ..()

/obj/machinery/cryopod/latejoin/connect_to_shuttle(obj/docking_port/mobile/port, obj/docking_port/stationary/dock, idnum, override)
	. = ..()
	linked_ship = port
	linked_ship.spawn_points += src

/obj/machinery/cryopod/latejoin/Destroy()
	SSjob.latejoin_trackers -= src
	linked_ship?.spawn_points -= src
	. = ..()
