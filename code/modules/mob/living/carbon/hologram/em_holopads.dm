
/obj/machinery/holopad/emergency
	name = "advanced holopad"
	icon_state = "holopad3"
	///The linked Emergency Hologram
	var/mob/living/simple_animal/hologram/em
	///The type of emergency hologram to spawn
	var/mob/living/simple_animal/hologram/em_spawn_type = /mob/living/simple_animal/hologram
	///If the emergency hologram is active
	var/em_active = FALSE
	///If the holopad has been activated and will allow a ghost to
	var/em_starting = FALSE
	///If the holopad is recharging before allowing you to use the emergency hologram again
	var/em_cooldown = FALSE
	///Name displayed on the holopad, done because I don't know how else to do it
	var/em_name = "emergency hologram"

/obj/machinery/holopad/emergency/Destroy()
	. = ..()
	QDEL_NULL(em)

/obj/machinery/holopad/emergency/clear_holo(mob/living/user)
	. = ..()
	if(user == em)
		qdel(em)

/obj/machinery/holopad/emergency/update_icon_state()
	var/total_users = LAZYLEN(masters) + LAZYLEN(holo_calls)
	if(ringing)
		icon_state = "holopad_ringing"
	else if(total_users || replay_mode)
		icon_state = "holopad1"
	else
		icon_state = "holopad3"

/obj/machinery/holopad/emergency/attack_ghost(mob/dead/observer/user)
	if(!SSticker.HasRoundStarted() || !loc || !em_starting || em)
		return ..()
	if(is_banned_from(user.key, ROLE_POSIBRAIN))
		to_chat(user, "<span class='warning'>You are banned from becoming a hologram!</span>")
		return
	if(QDELETED(src) || QDELETED(user))
		return
	var/ghost_role = alert("Become a hologram? (Warning, You can no longer be revived!)", "Become Hologram", "Yes", "No")
	if(ghost_role == "No" || !loc || !istype(user))
		return
	if(!em)
		em = new em_spawn_type(get_turf(src), user.started_as_observer ? user.client.prefs : null, src) //A bit snowflakey, allows people who started the round as observers to have their loaded character be the hologram's icon
	em.ckey = user.ckey
	em.say("Please state the nature of the [em_name] emergency.")
	calling = FALSE
	em_starting = FALSE
	em_active = TRUE
	SetLightsAndPower()

/obj/machinery/holopad/emergency/attackby(obj/item/P, mob/user, params)
	if(em && user.a_intent == INTENT_HARM)
		em.apply_damage(rand(5,10), BRUTE)
	. = ..()

/obj/machinery/holopad/emergency/emp_act(severity)
	. = ..()
	if(em)
		em.apply_damage(5*severity)

/obj/machinery/holopad/emergency/proc/stop_starting()
	if(em?.ckey)
		return
	if(!em_starting)
		return
	SetLightsAndPower()
	calling = FALSE
	em_starting = FALSE
	em_cooldown = TRUE
	say("Failed to initiate hologram personality matrices. Please try again later.")
	addtimer(VARSET_CALLBACK(src, em_cooldown, FALSE), 600)

/obj/machinery/holopad/emergency/ui_data(mob/user)
	var/list/data = ..()
	data["em_hologram"] = em_name
	data["em_cooldown"] = em_cooldown
	data["em_active"] = em_active
	return data

/obj/machinery/holopad/emergency/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	if(!em)
		em_active = FALSE

	switch(action)
		if("em_action")
			if(!em_active)
				var/area/A = get_area(src)
				notify_ghosts("An emergency hologram is being requested in \the [A.name].", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_DRONE)
				em_starting = TRUE
				icon_state = "holopad_ringing"
				calling = TRUE
				addtimer(CALLBACK(src, .proc/stop_starting), 300)
			else
				QDEL_NULL(em)
				em_cooldown = TRUE
				em_active = FALSE
				say("Recharging holoemitters...")
				addtimer(VARSET_CALLBACK(src, em_cooldown, FALSE), 600)
			return TRUE
		if("hang_up")
			if(em_starting)
				stop_starting()
				return TRUE


/obj/machinery/holopad/emergency/medical
	name = "advanced medical holopad"
	em_name = "medical"
	em_spawn_type = /mob/living/simple_animal/hologram/medical

/obj/machinery/holopad/emergency/bar
	name = "advanced bar holopad"
	em_name = "bartending"
	em_spawn_type = /mob/living/simple_animal/hologram/bar

/obj/machinery/holopad/emergency/science
	name = "advanced science holopad"
	em_name = "scientific"
	em_spawn_type = /mob/living/simple_animal/hologram/science

/obj/machinery/holopad/emergency/engineering
	name = "advanced engineering holopad"
	em_name = "engineering"
	em_spawn_type = /mob/living/simple_animal/hologram/engineering

/obj/machinery/holopad/emergency/command
	name = "advanced command holopad"
	em_name = "command"
	em_spawn_type = /mob/living/simple_animal/hologram/command

/obj/machinery/holopad/emergency/kitchen
	name = "advanced kitchen holopad"
	em_name = "culinary"
	em_spawn_type = /mob/living/simple_animal/hologram/kitchen

/obj/machinery/holopad/emergency/botany
	name = "advanced botany holopad"
	em_name = "botanical"
	em_spawn_type = /mob/living/simple_animal/hologram/botany

/obj/machinery/holopad/emergency/counselor
	name = "advanced counseling holopad"
	em_name = "counseling"
	em_spawn_type = /mob/living/simple_animal/hologram/psychologist

/obj/machinery/holopad/emergency/atmos
	name = "advanced atmospheric holopad"
	em_name = "atmospheric"
	em_spawn_type = /mob/living/simple_animal/hologram/atmos

/obj/machinery/holopad/emergency/janitor
	name = "advanced custodial holopad"
	em_name = "custodial"
	em_spawn_type = /mob/living/simple_animal/hologram/janitor

/obj/machinery/holopad/emergency/security
	name = "advanced security holopad"
	em_name = "security"
	em_spawn_type = /mob/living/simple_animal/hologram/security

/obj/machinery/holopad/emergency/cargo
	name = "advanced logistics holopad"
	em_name = "logistics"
	em_spawn_type = /mob/living/simple_animal/hologram/cargo

/obj/machinery/holopad/emergency/clown
	name = "advanced comedy holopad"
	em_name = "comedy"
	em_spawn_type = /mob/living/simple_animal/hologram/clown

/obj/machinery/holopad/emergency/detective
	name = "advanced forensics holopad"
	em_name = "forensics"
	em_spawn_type = /mob/living/simple_animal/hologram/detective

/obj/machinery/holopad/emergency/curator
	name = "advanced literacy holopad"
	em_name = "literacy"
	em_spawn_type = /mob/living/simple_animal/hologram/curator

/obj/machinery/holopad/emergency/buddy
	name = "advanced company holopad"
	em_name = "company"
	em_spawn_type = /mob/living/simple_animal/hologram/assistant
