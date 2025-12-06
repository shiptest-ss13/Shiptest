//A system to manage and display alerts on screen without needing you to do it yourself

//PUBLIC -  call these wherever you want


/mob/proc/throw_alert(category, type, severity, obj/new_master, override = FALSE)

/* Proc to create or update an alert. Returns the alert if the alert is new or updated, 0 if it was thrown already
category is a text string. Each mob may only have one alert per category; the previous one will be replaced
path is a type path of the actual alert type to throw
severity is an optional number that will be placed at the end of the icon_state for this alert
For example, high pressure's icon_state is "highpressure" and can be serverity 1 or 2 to get "highpressure1" or "highpressure2"
new_master is optional and sets the alert's icon state to "template" in the ui_style icons with the master as an overlay.
Clicks are forwarded to master
Override makes it so the alert is not replaced until cleared by a clear_alert with clear_override, and it's used for hallucinations.
 */

	if(!category || QDELETED(src))
		return

	var/atom/movable/screen/alert/thealert
	if(alerts[category])
		thealert = alerts[category]
		if(thealert.override_alerts)
			return 0
		if(new_master && new_master != thealert.master)
			WARNING("[src] threw alert [category] with new_master [new_master] while already having that alert with master [thealert.master]")

			clear_alert(category)
			return .()
		else if(thealert.type != type)
			clear_alert(category)
			return .()
		else if(!severity || severity == thealert.severity)
			if(thealert.timeout)
				clear_alert(category)
				return .()
			else //no need to update
				return 0
	else
		thealert = new type()
		thealert.override_alerts = override
		if(override)
			thealert.timeout = null
	thealert.owner = src

	if(new_master)
		var/old_layer = new_master.layer
		var/old_plane = new_master.plane
		new_master.layer = FLOAT_LAYER
		new_master.plane = FLOAT_PLANE
		thealert.add_overlay(new_master)
		new_master.layer = old_layer
		new_master.plane = old_plane
		thealert.icon_state = "template" // We'll set the icon to the client's ui pref in reorganize_alerts()
		thealert.master = new_master
	else
		thealert.icon_state = "[initial(thealert.icon_state)][severity]"
		thealert.severity = severity

	alerts[category] = thealert
	if(client && hud_used)
		hud_used.reorganize_alerts()
	thealert.transform = matrix(32, 6, MATRIX_TRANSLATE)
	animate(thealert, transform = matrix(), time = 2.5, easing = CUBIC_EASING)

	if(thealert.timeout)
		addtimer(CALLBACK(src, PROC_REF(alert_timeout), thealert, category), thealert.timeout)
		thealert.timeout = world.time + thealert.timeout - world.tick_lag
	return thealert

/mob/proc/alert_timeout(atom/movable/screen/alert/alert, category)
	if(alert.timeout && alerts[category] == alert && world.time >= alert.timeout)
		clear_alert(category)

// Proc to clear an existing alert.
/mob/proc/clear_alert(category, clear_override = FALSE)
	var/atom/movable/screen/alert/alert = alerts[category]
	if(!alert)
		return 0
	if(alert.override_alerts && !clear_override)
		return 0

	alerts -= category
	if(client && hud_used)
		hud_used.reorganize_alerts()
		client.screen -= alert
	qdel(alert)

/atom/movable/screen/alert
	icon = 'icons/hud/screen_alert.dmi'
	icon_state = "default"
	name = "Alert"
	desc = "Something seems to have gone wrong with this alert, so report this bug please"
	mouse_opacity = MOUSE_OPACITY_ICON
	var/timeout = 0 //If set to a number, this alert will clear itself after that many deciseconds
	var/severity = 0
	var/alerttooltipstyle = ""
	var/override_alerts = FALSE //If it is overriding other alerts of the same type
	var/mob/owner //Alert owner


/atom/movable/screen/alert/MouseEntered(location,control,params)
	. = ..()
	if(!QDELETED(src))
		openToolTip(usr,src,params,title = name,content = desc,theme = alerttooltipstyle)


/atom/movable/screen/alert/MouseExited()
	closeToolTip(usr)


//Gas alerts
/atom/movable/screen/alert/not_enough_oxy
	name = "Choking (No O2)"
	desc = "You're not getting enough oxygen. Find some good air before you pass out! The box in your backpack has an oxygen tank and breath mask in it."
	icon_state = ALERT_NOT_ENOUGH_OXYGEN

/atom/movable/screen/alert/too_much_oxy
	name = "Choking (O2)"
	desc = "There's too much oxygen in the air, and you're breathing it in! Find some good air before you pass out!"
	icon_state = ALERT_TOO_MUCH_OXYGEN

/atom/movable/screen/alert/not_enough_nitro
	name = "Choking (No N2)"
	desc = "You're not getting enough nitrogen. Find some good air before you pass out!"
	icon_state = ALERT_NOT_ENOUGH_NITRO

/atom/movable/screen/alert/too_much_nitro
	name = "Choking (N2)"
	desc = "There's too much nitrogen in the air, and you're breathing it in! Find some good air before you pass out!"
	icon_state = ALERT_TOO_MUCH_NITRO

/atom/movable/screen/alert/not_enough_co2
	name = "Choking (No CO2)"
	desc = "You're not getting enough carbon dioxide. Find some good air before you pass out!"
	icon_state = ALERT_NOT_ENOUGH_CO2

/atom/movable/screen/alert/too_much_co2
	name = "Choking (CO2)"
	desc = "There's too much carbon dioxide in the air, and you're breathing it in! Find some good air before you pass out!"
	icon_state = ALERT_TOO_MUCH_CO2

/atom/movable/screen/alert/not_enough_tox
	name = "Choking (No Plasma)"
	desc = "You're not getting enough plasma. Find some good air before you pass out!"
	icon_state = ALERT_NOT_ENOUGH_PLASMA

/atom/movable/screen/alert/too_much_tox
	name = "Choking (Plasma)"
	desc = "There's highly flammable, toxic plasma in the air and you're breathing it in. Find some fresh air. The box in your backpack has an oxygen tank and gas mask in it."
	icon_state = ALERT_TOO_MUCH_PLASMA

/atom/movable/screen/alert/not_enough_n2o
	name = "Choking (No N2O)"
	desc = "You're not getting enough N2O. Find some good air before you pass out!"
	icon_state = ALERT_NOT_ENOUGH_N2O

/atom/movable/screen/alert/too_much_n2o
	name = "Choking (N2O)"
	desc = "There's semi-toxic sleeping gas in the air and you're breathing it in. Find some fresh air. The box in your backpack has an oxygen tank and gas mask in it."
	icon_state = ALERT_TOO_MUCH_N2O

//End gas alerts

/atom/movable/screen/alert/bronchodilated
	name = "Bronchodilated"
	desc = "You feel like your lungs are larger than usual! You're taking deeper breaths!"
	icon_state = ALERT_BRONCHODILATION

/atom/movable/screen/alert/bronchoconstricted
	name = "Bronchocontracted"
	desc = "You feel like your lungs are smaller than usual! You might need a higher pressure environment/internals to breathe!"
	icon_state = ALERT_BRONCHOCONSTRICTION

/atom/movable/screen/alert/hungry
	name = "Hungry"
	desc = "Some food would be good right about now."
	icon_state = "hungry"

/atom/movable/screen/alert/starving
	name = "Starving"
	desc = "You're severely malnourished. The hunger pains make moving around a chore."
	icon_state = "starving"

/atom/movable/screen/alert/gross
	name = "Queasy."
	desc = "You're starting to feel queasy.."
	icon_state = "gross"

/atom/movable/screen/alert/verygross
	name = "Nauseated."
	desc = "You're feeling discomforted as unease creeps into your throat..."
	icon_state = "gross2"

/atom/movable/screen/alert/disgusted
	name = "Very Nauseated"
	desc = "You can barely think against the grains of discomfort ravaging your body!"
	icon_state = "gross3"

/atom/movable/screen/alert/hot
	name = "Hot"
	desc = "It's quite warm. Get somewhere cooler and take off any insulating clothing like a fire suit."
	icon_state = "hot"

/atom/movable/screen/alert/warm
	name = "Warm"
	desc = "It's a bit warm, but not unbearably so."
	icon_state = "hot"

/atom/movable/screen/alert/cold
	name = "Cold"
	desc = "It's quite cold. Get somewhere warmer and take off any insulating clothing like a space suit."
	icon_state = "cold"

/atom/movable/screen/alert/chilly
	name = "Chilly"
	desc = "It's a bit chilly, but not unbearably so."
	icon_state = "cold"

/atom/movable/screen/alert/sweat
	name = "Sweating"
	desc = "You're sweating and the heat is starting to hurt. Get somewhere cooler, and take off any insulating clothing like a fire suit."
	icon_state = "sweat"

/atom/movable/screen/alert/shiver
	name = "Shivering"
	desc = "You're shivering and the cold is starting to hurt. Get somewhere warmer and take off any insulating clothing like a space suit."
	icon_state = "shiver"

/atom/movable/screen/alert/fans
	name = "High Fan Speed"
	desc = "Your fans are spinning quite fast, and your components are reaching a dangerous temperature! Get somewhere cooler and take off any insulating clothing like a fire suit."
	icon_state = "fans"

/atom/movable/screen/alert/lowpressure
	name = "Low Pressure"
	desc = "The air around you is hazardously thin. A space suit would protect you."
	icon_state = "lowpressure"

/atom/movable/screen/alert/highpressure
	name = "High Pressure"
	desc = "The air around you is hazardously thick. A fire suit would protect you."
	icon_state = "highpressure"

/atom/movable/screen/alert/blind
	name = "Blind"
	desc = "You can't see! This may be caused by a genetic defect, eye trauma, being unconscious, \
or something covering your eyes."
	icon_state = "blind"

/atom/movable/screen/alert/high
	name = "High"
	desc = "Whoa man, you're tripping balls! Careful you don't get addicted... if you aren't already."
	icon_state = "high"

/atom/movable/screen/alert/hypnosis
	name = "Hypnosis"
	desc = "Something's hypnotizing you, but you're not really sure about what."
	icon_state = "hypnosis"
	var/phrase

/atom/movable/screen/alert/mind_control
	name = "Mind Control"
	desc = "Your mind has been hijacked! Click to view the mind control command."
	icon_state = "mind_control"
	var/command

/atom/movable/screen/alert/mind_control/Click()
	var/mob/living/L = usr
	if(L != owner)
		return
	to_chat(L, span_mind_control("[command]"))

/atom/movable/screen/alert/embeddedobject
	name = "Embedded Object"
	desc = "Something got lodged into your flesh and is causing major bleeding. It might fall out with time, but surgery is the safest way. \
If you're feeling frisky, examine yourself and click the underlined item to pull the object out."
	icon_state = "embeddedobject"

/atom/movable/screen/alert/embeddedobject/Click()
	if(isliving(usr) && usr == owner)
		var/mob/living/carbon/M = usr
		return M.help_shake_act(M)

/atom/movable/screen/alert/weightless
	name = "Weightless"
	desc = "Gravity has ceased affecting you, and you're floating around aimlessly. You'll need something large and heavy, like a \
wall or lattice, to push yourself off if you want to move. A jetpack would enable free range of motion. A pair of \
magboots would let you walk around normally on the floor. Barring those, you can throw things, use a fire extinguisher, \
or shoot a gun to move around via Newton's 3rd Law of Motion."
	icon_state = "weightless"

/atom/movable/screen/alert/highgravity
	name = "High Gravity"
	desc = "You're getting crushed by high gravity, picking up items and movement will be slowed."
	icon_state = "paralysis"

/atom/movable/screen/alert/veryhighgravity
	name = "Crushing Gravity"
	desc = "You're getting crushed by high gravity, picking up items and movement will be slowed. You'll also accumulate brute damage!"
	icon_state = "paralysis"

//rest of these should be alerts eventually today tho. lazy.
#define ALERT_FIRE "fire"

/atom/movable/screen/alert/fire
	name = "On Fire"
	desc = "You're on fire. Stop, drop and roll to put the fire out or move to a vacuum area."
	icon_state = "fire"

/atom/movable/screen/alert/fire/Click()
	var/mob/living/L = usr
	if(!istype(L) || !L.can_resist() || L != owner)
		return
	L.changeNext_move(CLICK_CD_RESIST)
	if(L.mobility_flags & MOBILITY_MOVE)
		return L.resist_fire() //I just want to start a flame in your hearrrrrrtttttt.

/atom/movable/screen/alert/give // information set when the give alert is made
	icon_state = "default"
	var/mob/living/carbon/offerer
	var/obj/item/receiving

/**
 * Handles assigning most of the variables for the alert that pops up when an item is offered
 *
 * Handles setting the name, description and icon of the alert and tracking the person giving
 * and the item being offered, also registers a signal that removes the alert from anyone who moves away from the offerer
 * Arguments:
 * * taker - The person receiving the alert
 * * offerer - The person giving the alert and item
 * * receiving - The item being given by the offerer
 */
/atom/movable/screen/alert/give/proc/setup(mob/living/carbon/taker, mob/living/carbon/offerer, obj/item/receiving)
	name = "[offerer] is offering [receiving]"
	desc = "[offerer] is offering [receiving]. Click this alert to take it."
	icon_state = "template"
	cut_overlays()
	add_overlay(receiving)
	src.receiving = receiving
	src.offerer = offerer
	RegisterSignal(taker, COMSIG_MOVABLE_MOVED, PROC_REF(check_in_range), override = TRUE) //Override to prevent runtimes when people offer a item multiple times

/atom/movable/screen/alert/give/proc/removeAlert()
	to_chat(owner, span_warning("You moved out of range of [offerer]!"))
	owner.clear_alert("[offerer]")

/atom/movable/screen/alert/give/Click(location, control, params)
	. = ..()
	var/mob/living/carbon/C = owner
	C.take(offerer, receiving)

/// An overrideable proc used simply to hand over the item when claimed, this is a proc so that high-fives can override them since nothing is actually transferred
/atom/movable/screen/alert/give/proc/handle_transfer()
	var/mob/living/carbon/taker = owner
	taker.take(offerer, receiving)

/// Simply checks if the other person is still in range
/atom/movable/screen/alert/give/proc/check_in_range(atom/taker)
	SIGNAL_HANDLER

	if(!offerer.CanReach(taker))
		to_chat(owner, span_warning("You moved out of range of [offerer]!"))
		owner.clear_alert("[offerer]")

/atom/movable/screen/alert/give/highfive/setup(mob/living/carbon/taker, mob/living/carbon/offerer, obj/item/receiving)
	. = ..()
	name = "[offerer] is offering a high-five!"
	desc = "[offerer] is offering a high-five! Click this alert to slap it."
	RegisterSignal(offerer, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(check_fake_out))

/atom/movable/screen/alert/give/highfive/handle_transfer()
	var/mob/living/carbon/taker = owner
	if(receiving && (receiving in offerer.held_items))
		receiving.on_offer_taken(offerer, taker)
		return
	too_slow_p1()

/// If the person who offered the high five no longer has it when we try to accept it, we get pranked hard
/atom/movable/screen/alert/give/highfive/proc/too_slow_p1()
	var/mob/living/carbon/rube = owner
	if(!rube || !offerer)
		qdel(src)
		return

	offerer.visible_message(span_notice("[rube] rushes in to high-five [offerer], but-"), span_nicegreen("[rube] falls for your trick just as planned, lunging for a high-five that no longer exists! Classic!"), ignored_mobs=rube)
	to_chat(rube, span_nicegreen("You go in for [offerer]'s high-five, but-"))
	addtimer(CALLBACK(src, PROC_REF(too_slow_p2), offerer, rube), 0.5 SECONDS)

/// Part two of the ultimate prank
/atom/movable/screen/alert/give/highfive/proc/too_slow_p2()
	var/mob/living/carbon/rube = owner
	if(!rube || !offerer)
		qdel(src)
		return

	offerer.visible_message(span_danger("[offerer] pulls away from [rube]'s slap at the last second, dodging the high-five entirely!"), span_nicegreen("[rube] fails to make contact with your hand, making an utter fool of [rube.p_them()]self!"), span_hear("You hear a disappointing sound of flesh not hitting flesh!"), ignored_mobs=rube)
	var/all_caps_for_emphasis = uppertext("NO! [offerer] PULLS [offerer.p_their()] HAND AWAY FROM YOURS! YOU'RE TOO SLOW!")
	to_chat(rube, span_userdanger("[all_caps_for_emphasis]"))
	playsound(offerer, 'sound/weapons/thudswoosh.ogg', 100, TRUE, 1)
	rube.Knockdown(1 SECONDS)
	SEND_SIGNAL(offerer, COMSIG_ADD_MOOD_EVENT, "high_five", /datum/mood_event/down_low)
	SEND_SIGNAL(rube, COMSIG_ADD_MOOD_EVENT, "high_five", /datum/mood_event/too_slow)
	qdel(src)

/// If someone examine_more's the offerer while they're trying to pull a too-slow, it'll tip them off to the offerer's trickster ways
/atom/movable/screen/alert/give/highfive/proc/check_fake_out(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if(!receiving)
		examine_list += "[span_warning("[offerer]'s arm appears tensed up, as if [offerer.p_they()] plan on pulling it back suddenly...")]\n"

/// Gives the player the option to succumb while in critical condition
/atom/movable/screen/alert/succumb
	name = "Succumb"
	desc = "Shuffle off this mortal coil."
	icon_state = "succumb"

/atom/movable/screen/alert/succumb/Click()
	if (isobserver(usr))
		return

	var/mob/living/living_owner = owner
	var/last_whisper = input("Do you have any last words?", "Final Words") as null | text
	if (isnull(last_whisper) || !CAN_SUCCUMB(living_owner))
		return

	if (length(last_whisper))
		living_owner.say("#[last_whisper]")
		//Say handles everything else for us
		return

	living_owner.succumb(FALSE)

//ALIENS

/atom/movable/screen/alert/alien_tox
	name = "Plasma"
	desc = "There's flammable plasma in the air. If it lights up, you'll be toast."
	icon_state = "alien_tox"
	alerttooltipstyle = "alien"

/atom/movable/screen/alert/alien_fire
// This alert is temporarily gonna be thrown for all hot air but one day it will be used for literally being on fire
	name = "Too Hot"
	desc = "It's too hot! Flee to space or at least away from the flames. Standing on weeds will heal you."
	icon_state = "alien_fire"
	alerttooltipstyle = "alien"

/atom/movable/screen/alert/alien_vulnerable
	name = "Severed Matriarchy"
	desc = "Your queen has been killed, you will suffer movement penalties and loss of hivemind. A new queen cannot be made until you recover."
	icon_state = "alien_noqueen"
	alerttooltipstyle = "alien"

//SILICONS

/atom/movable/screen/alert/nocell
	name = "Missing Power Cell"
	desc = "Unit has no power cell. No modules are available until a power cell is reinstalled."
	icon_state = "nocell"

/atom/movable/screen/alert/emptycell
	name = "Out of Power"
	desc = "Unit's power cell has no charge remaining. No modules are available until power cell is recharged."
	icon_state = "emptycell"

/atom/movable/screen/alert/lowcell
	name = "Low Charge"
	desc = "Unit's power cell is running low. All modules may be disabled soon unless recharged."
	icon_state = "lowcell"

//Ethereal

/atom/movable/screen/alert/etherealcharge
	name = "Low Blood Charge"
	desc = "Your blood's electric charge is running low, find a source of charge for your blood. Use a recharging station, or eat some Elzuose-friendly food."
	icon_state = "etherealcharge"

/atom/movable/screen/alert/ethereal_overcharge
	name = "Blood Overcharge"
	desc = "Your blood's electric charge is becoming dangerously high, find an outlet for your energy. Use Grab Intent on an APC to channel your energy into it."
	icon_state = "ethereal_overcharge"

//MODsuit unique
/atom/movable/screen/alert/nocore
	name = "Missing Core"
	desc = "Unit has no core. No modules are available until a core is reinstalled."
	icon_state = "no_cell"

/atom/movable/screen/alert/emptycell/plasma
	name = "Out of Power"
	desc = "Unit's plasma core has no charge remaining. No modules are available until plasma core is recharged. \
		Unit can be refilled through plasma fuel."

/atom/movable/screen/alert/emptycell/plasma/update_desc()
	. = ..()
	desc = initial(desc)

/atom/movable/screen/alert/lowcell/plasma
	name = "Low Charge"
	desc = "Unit's plasma core is running low. Unit can be refilled through plasma fuel."

/atom/movable/screen/alert/lowcell/plasma/update_desc()
	. = ..()
	desc = initial(desc)

//Need to cover all use cases - emag, illegal upgrade module, malf AI hack, traitor cyborg
/atom/movable/screen/alert/hacked
	name = "Hacked"
	desc = "Hazardous non-standard equipment detected. Please ensure any usage of this equipment is in line with unit's laws, if any."
	icon_state = "hacked"

/atom/movable/screen/alert/locked
	name = "Locked Down"
	desc = "Unit has been remotely locked down. Usage of a Robotics Control Console by an AI or any qualified \
	humanoid may resolve this matter."
	icon_state = "locked"

/atom/movable/screen/alert/newlaw
	name = "Law Update"
	desc = "Laws have potentially been uploaded to or removed from this unit. Please be aware of any changes \
so as to remain in compliance with the most up-to-date laws."
	icon_state = "newlaw"
	timeout = 300

/atom/movable/screen/alert/hackingapc
	name = "Hacking APC"
	desc = "An Area Power Controller is being hacked. When the process is \
		complete, you will have exclusive control of it, and you will gain \
		additional processing time to unlock more malfunction abilities."
	icon_state = "hackingapc"
	timeout = 600
	var/atom/target = null

/atom/movable/screen/alert/hackingapc/Click()
	if(!usr || !usr.client || usr != owner)
		return
	if(!target)
		return
	var/mob/living/silicon/ai/AI = usr
	var/turf/T = get_turf(target)
	if(T)
		AI.eyeobj.setLoc(T)

//EXOSUITS

/atom/movable/screen/alert/low_mech_integrity
	name = "Exosuit Damaged"
	desc = "Exosuit integrity is low."
	icon_state = "low_mech_integrity"


//GHOSTS
//TODO: expand this system to replace the pollCandidates/CheckAntagonist/"choose quickly"/etc Yes/No messages
/atom/movable/screen/alert/notify_cloning
	name = "Revival"
	desc = "Someone is trying to revive you. Re-enter your corpse if you want to be revived!"
	icon_state = "template"
	timeout = 300

/atom/movable/screen/alert/notify_cloning/Click()
	if(!usr || !usr.client || usr != owner)
		return
	var/mob/dead/observer/G = usr
	G.reenter_corpse()

/atom/movable/screen/alert/notify_action
	name = "Body created"
	desc = "A body was created. You can enter it."
	icon_state = "template"
	timeout = 300
	var/datum/weakref/target_ref
	var/action = NOTIFY_JUMP

/atom/movable/screen/alert/notify_action/Click()
	if(!usr || !usr.client || usr != owner)
		return
	var/atom/target = target_ref?.resolve()
	if(!target)
		return
	var/mob/dead/observer/G = usr
	if(!istype(G))
		return
	switch(action)
		if(NOTIFY_ATTACK)
			target.attack_ghost(G)
		if(NOTIFY_JUMP)
			var/turf/T = get_turf(target)
			if(T && isturf(T))
				G.abstract_move(T)
		if(NOTIFY_ORBIT)
			G.ManualFollow(target)


//DWARF
/atom/movable/screen/alert/dorflow
	name = "Low Alchohol"
	desc = "Your body's alchohol reserves are running low. Find some booze, or make some yourself by distilling plants in a barrel!"
	icon_state = "dorf"

/atom/movable/screen/alert/overdorf
	name = "Metabolic Surge"
	desc = "Excess alchohol has put your cellular metabolism into overdrive! You now have natural regeneration, but everything seems to be getting hotter..."
	icon_state = "overdorf"

//OBJECT-BASED

/atom/movable/screen/alert/restrained/buckled
	name = "Buckled"
	desc = "You've been buckled to something. Click the alert to unbuckle unless you're handcuffed."
	icon_state = "buckled"

/atom/movable/screen/alert/restrained/handcuffed
	name = "Handcuffed"
	desc = "You're handcuffed and can't act. If anyone drags you, you won't be able to move. Click the alert to free yourself."

/atom/movable/screen/alert/restrained/legcuffed
	name = "Legcuffed"
	desc = "You're legcuffed, which slows you down considerably. Click the alert to free yourself."

/atom/movable/screen/alert/restrained/Click()
	var/mob/living/L = usr
	if(!istype(L) || !L.can_resist() || L != owner)
		return
	L.changeNext_move(CLICK_CD_RESIST)
	if((L.mobility_flags & MOBILITY_MOVE) && (L.last_special <= world.time) && !L.buckled)           // WS Edit - cuff resist while buckled fail fast
		return L.resist_restraints()

/atom/movable/screen/alert/restrained/buckled/Click()
	var/mob/living/L = usr
	if(!istype(L) || !L.can_resist() || L != owner)
		return
	L.changeNext_move(CLICK_CD_RESIST)
	if(L.last_special <= world.time)
		return L.resist_buckle()

/atom/movable/screen/alert/shoes/untied
	name = "Untied Shoes"
	desc = "Your shoes are untied! Click the alert or your shoes to tie them."
	icon_state = "shoealert"

/atom/movable/screen/alert/shoes/knotted
	name = "Knotted Shoes"
	desc = "Someone tied your shoelaces together! Click the alert or your shoes to undo the knot."
	icon_state = "shoealert"

/atom/movable/screen/alert/shoes/Click()
	var/mob/living/carbon/C = usr
	if(!istype(C) || !C.can_resist() || C != owner || !C.shoes)
		return
	C.changeNext_move(CLICK_CD_RESIST)
	C.shoes.handle_tying(C)

// PRIVATE = only edit, use, or override these if you're editing the system as a whole

// Re-render all alerts - also called in /datum/hud/show_hud() because it's needed there
/datum/hud/proc/reorganize_alerts(mob/viewmob)
	var/mob/screenmob = viewmob || mymob
	if(!screenmob.client)
		return
	var/list/alerts = mymob.alerts
	if(!hud_shown)
		for(var/i = 1, i <= alerts.len, i++)
			screenmob.client.screen -= alerts[alerts[i]]
		return 1
	for(var/i = 1, i <= alerts.len, i++)
		var/atom/movable/screen/alert/alert = alerts[alerts[i]]
		if(alert.icon_state == "template")
			alert.icon = ui_style
		switch(i)
			if(1)
				. = ui_alert1
			if(2)
				. = ui_alert2
			if(3)
				. = ui_alert3
			if(4)
				. = ui_alert4
			if(5)
				. = ui_alert5 // Right now there's 5 slots
			else
				. = ""
		alert.screen_loc = .
		screenmob.client.screen |= alert
	if(!viewmob)
		for(var/M in mymob.observers)
			reorganize_alerts(M)
	return 1

/atom/movable/screen/alert/Click(location, control, params)
	if(!usr || !usr.client)
		return
	var/list/modifiers = params2list(params)
	if(LAZYACCESS(modifiers, SHIFT_CLICK)) // screen objects don't do the normal Click() stuff so we'll cheat
		to_chat(usr, span_boldnotice("[name]</span> - <span class='info'>[desc]"))
		return
	if(usr != owner)
		return
	if(master)
		return usr.client.Click(master, location, control, params)

/atom/movable/screen/alert/Destroy()
	. = ..()
	severity = 0
	master = null
	owner = null
	screen_loc = ""
