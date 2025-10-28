//MEDBOT
//MEDBOT PATHFINDING
//MEDBOT ASSEMBLY
#define MEDBOT_PANIC_NONE 0
#define MEDBOT_PANIC_LOW 15
#define MEDBOT_PANIC_MED 35
#define MEDBOT_PANIC_HIGH 55
#define MEDBOT_PANIC_FUCK 70
#define MEDBOT_PANIC_ENDING 90
#define MEDBOT_PANIC_END 100

/mob/living/simple_animal/bot/medbot
	name = "\improper Medibot"
	desc = "A little medical robot. He looks somewhat underwhelmed."
	icon = 'icons/mob/aibots.dmi'
	icon_state = "medibot"
	base_icon_state = "medibot"
	var/base_screen_state = "medibot"
	var/stationary_suffix = null //for icon states
	density = FALSE
	anchored = FALSE
	health = 20
	maxHealth = 20
	pass_flags = PASSMOB

	status_flags = (CANPUSH | CANSTUN)

	radio_key = /obj/item/encryptionkey

	bot_type = MED_BOT
	model = "Medibot"
	bot_core_type = /obj/machinery/bot_core/medbot
	window_id = "automed"
	window_name = "Automatic Medical Unit v1.1"
	data_hud_type = DATA_HUD_MEDICAL_ADVANCED
	path_image_color = "#DDDDFF"
/// drop determining variable
	var/healthanalyzer = /obj/item/healthanalyzer
/// drop determining variable
	var/firstaid = /obj/item/storage/firstaid
	var/mob/living/carbon/patient
	var/mob/living/carbon/oldpatient
	var/oldloc
	var/last_found = 0
/// Don't spam the "HEY I'M COMING" messages
	var/last_newpatient_speak = 0
/// How much healing do we do at a time?
	var/heal_amount = 2.5
/// Start healing when they have this much damage in a category
	var/heal_threshold = 10
/// If active, the bot will transmit a critical patient alert to MedHUD users.
	var/declare_crit = TRUE
/// Prevents spam of critical patient alerts.
	var/declare_cooldown = FALSE
/// If enabled, the Medibot will not move automatically.
	var/stationary_mode = FALSE

/// silences the medbot if TRUE
	var/shut_up = FALSE
/// techweb linked to the medbot
	var/datum/techweb/linked_techweb
///Is the medbot currently tending wounds
	var/tending = FALSE
///How panicked we are about being tipped over (why would you do this?)
	var/tipped_status = MEDBOT_PANIC_NONE
///The name we got when we were tipped
	var/tipper_name
///The last time we were tipped/righted and said a voice line, to avoid spam
	var/last_tipping_action_voice = 0


/mob/living/simple_animal/bot/medbot/mysterious
	name = "\improper Mysterious Medibot"
	desc = "International Medibot of mystery."
	icon_state = "medibot_bezerk"
	base_icon_state = "medibot_bezerk"
	base_screen_state = "medibot"
	heal_amount = 10

/mob/living/simple_animal/bot/medbot/rockplanet
	name = "\improper Abandoned Medibot"
	desc = "A little medical robot. They look like they have some sort of bloodlust in their eyes."
	icon_state = "medibot_evil"
	base_icon_state = "medibot_evil"
	base_screen_state = "medibot_evil"
	emagged = 2
	remote_disabled = 1
	locked = TRUE
	faction = list("mining", "silicon" , FACTION_TURRET)

/mob/living/simple_animal/bot/medbot/derelict
	name = "\improper Old Medibot"
	desc = "Looks like it hasn't been modified since the early models."
	icon_state = "medibot_bezerk"
	base_icon_state = "medibot_bezerk"
	base_screen_state = "medibot"
	heal_threshold = 0
	declare_crit = 0
	heal_amount = 5

/mob/living/simple_animal/bot/medbot/update_icon()
	. = ..()
	cut_overlays()
	var/mutable_appearance/screen_overlay = mutable_appearance(icon, null)
	var/mutable_appearance/screen_overlay_2 = mutable_appearance(icon, null)
	if(stationary_mode)//we add the stationary_suffix to the screen state name, if not dont add anythiung
		stationary_suffix = "_stationary"

	icon_state = "[base_icon_state]"
	screen_overlay.icon_state = null
	screen_overlay_2.icon_state = null

	if(on)
		screen_overlay_2.icon_state = "[base_screen_state][stationary_suffix]_idle"

	if(HAS_TRAIT(src, TRAIT_INCAPACITATED))
		screen_overlay.icon_state = "[base_screen_state][stationary_suffix]_stunned"

	if(mode == BOT_HEALING)
		icon_state = "[base_icon_state]_base_healing"
		screen_overlay.icon_state = "[base_icon_state][stationary_suffix]_healing"

		if(declare_cooldown > world.time) //when the crit patient alert cooldown is going on, we show the other healing screen
			screen_overlay_2.icon_state = "[base_screen_state][stationary_suffix]_healing_l2_crit"
		else
			screen_overlay_2.icon_state = "[base_screen_state][stationary_suffix]_healing_l2"

	add_overlay(screen_overlay)
	add_overlay(screen_overlay_2)

/mob/living/simple_animal/bot/medbot/Initialize(mapload, new_skin)
	. = ..()
	var/datum/job/doctor/J = new /datum/job/doctor
	access_card.access += J.get_access()
	prev_access = access_card.access
	qdel(J)
	if(new_skin)
		base_icon_state = new_skin
	update_appearance()

/mob/living/simple_animal/bot/medbot/Destroy()
	linked_techweb = null
	. = ..()

/mob/living/simple_animal/bot/medbot/bot_reset()
	..()
	patient = null
	oldpatient = null
	oldloc = null
	last_found = world.time
	declare_cooldown = 0
	update_appearance()

/mob/living/simple_animal/bot/medbot/proc/soft_reset() //Allows the medibot to still actively perform its medical duties without being completely halted as a hard reset does.
	path = list()
	patient = null
	mode = BOT_IDLE
	last_found = world.time
	update_appearance()

/mob/living/simple_animal/bot/medbot/set_custom_texts()

	text_hack = "You corrupt [name]'s healing processor circuits."
	text_dehack = "You reset [name]'s healing processor circuits."
	text_dehack_fail = "[name] seems damaged and does not respond to reprogramming!"

/mob/living/simple_animal/bot/medbot/attack_paw(mob/user)
	return attack_hand(user)

/mob/living/simple_animal/bot/medbot/get_controls(mob/user)
	var/dat
	dat += hack(user)
	dat += showpai(user)
	dat += "<TT><B>Medical Unit Controls v1.1</B></TT><BR><BR>"
	dat += "Status: <A href='byond://?src=[REF(src)];power=1'>[on ? "On" : "Off"]</A><BR>"
	dat += "Maintenance panel panel is [open ? "opened" : "closed"]<BR>"
	dat += "<br>Behaviour controls are [locked ? "locked" : "unlocked"]<hr>"
	if(!locked || issilicon(user) || isAdminGhostAI(user))
		dat += "<TT>Healing Threshold: "
		dat += "<a href='byond://?src=[REF(src)];adj_threshold=-10'>--</a> "
		dat += "<a href='byond://?src=[REF(src)];adj_threshold=-5'>-</a> "
		dat += "[heal_threshold] "
		dat += "<a href='byond://?src=[REF(src)];adj_threshold=5'>+</a> "
		dat += "<a href='byond://?src=[REF(src)];adj_threshold=10'>++</a>"
		dat += "</TT><br>"
		dat += "The speaker switch is [shut_up ? "off" : "on"]. <a href='byond://?src=[REF(src)];togglevoice=[1]'>Toggle</a><br>"
		dat += "Critical Patient Alerts: <a href='byond://?src=[REF(src)];critalerts=1'>[declare_crit ? "Yes" : "No"]</a><br>"
		dat += "Patrol Station: <a href='byond://?src=[REF(src)];operation=patrol'>[auto_patrol ? "Yes" : "No"]</a><br>"
		dat += "Stationary Mode: <a href='byond://?src=[REF(src)];stationary=1'>[stationary_mode ? "Yes" : "No"]</a><br>"
		dat += "<a href='byond://?src=[REF(src)];hptech=1'>Search for Technological Advancements</a><br>"

	return dat

/mob/living/simple_animal/bot/medbot/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["adj_threshold"])
		var/adjust_num = text2num(href_list["adj_threshold"])
		heal_threshold += adjust_num
		if(heal_threshold < 5)
			heal_threshold = 5
		if(heal_threshold > 75)
			heal_threshold = 75

	else if(href_list["togglevoice"])
		shut_up = !shut_up

	else if(href_list["critalerts"])
		declare_crit = !declare_crit

	else if(href_list["stationary"])
		stationary_mode = !stationary_mode
		path = list()
		update_appearance()

	else if(href_list["hptech"])
		if(!linked_techweb)
			speak("Warning: no linked server.")
			return

		var/oldheal_amount = heal_amount
		var/tech_boosters
		for(var/i in linked_techweb.researched_designs)
			var/datum/design/surgery/healing/D = SSresearch.techweb_design_by_id(i)
			if(!istype(D))
				continue
			tech_boosters++
		if(tech_boosters)
			heal_amount = (round(tech_boosters/2,0.1)*initial(heal_amount))+initial(heal_amount) //every 2 tend wounds tech gives you an extra 100% healing, adjusting for unique branches (combo is bonus)
			if(oldheal_amount < heal_amount)
				speak("Surgerical Knowledge Found! Efficiency is increased by [round(heal_amount/oldheal_amount*100)]%!")
	update_controls()
	return

/mob/living/simple_animal/bot/medbot/attackby(obj/item/W as obj, mob/user as mob, params)
	if(istype(W, /obj/item/multitool))
		var/obj/item/multitool/multi = W
		if(istype(multi.buffer, /obj/machinery/rnd/server))
			var/obj/machinery/rnd/server/serv = multi.buffer
			linked_techweb = serv.stored_research
			visible_message("Linked to Server!")
		return

	var/current_health = health
	..()
	if(health < current_health) //if medbot took some damage
		step_to(src, (get_step_away(src,user)))

/mob/living/simple_animal/bot/medbot/emag_act(mob/user)
	..()
	if(emagged == 2)
		declare_crit = 0
		if(user)
			to_chat(user, span_notice("You short out [src]'s reagent synthesis circuits."))
		audible_message(span_danger("[src] buzzes oddly!"))
		flick("medibot_spark", src)
		playsound(src, "sparks", 75, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
		if(user)
			oldpatient = user

/mob/living/simple_animal/bot/medbot/process_scan(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return

	if((H == oldpatient) && (world.time < last_found + 200))
		return

	if(assess_patient(H))
		last_found = world.time
		if((last_newpatient_speak + 300) < world.time) //Don't spam these messages!
			var/list/messagevoice = list("Hey, [H.name]! Hold on, I'm coming." = 'sound/voice/medbot/coming.ogg',"Wait [H.name]! I want to help!" = 'sound/voice/medbot/help.ogg',"[H.name], you appear to be injured!" = 'sound/voice/medbot/injured.ogg')
			var/message = pick(messagevoice)
			speak(message)
			playsound(src, messagevoice[message], 50, FALSE)
			flick_overlay_static("[base_screen_state][stationary_suffix]_notice", src, 2 SECONDS)
			last_newpatient_speak = world.time
		return H
	else
		return

/mob/living/simple_animal/bot/medbot/proc/tip_over(mob/user)
	ADD_TRAIT(src, TRAIT_IMMOBILIZED, BOT_TIPPED_OVER)
	playsound(src, 'sound/machines/warning-buzzer.ogg', 50)
	user.visible_message(span_danger("[user] tips over [src]!"), span_danger("You tip [src] over!"))
	mode = BOT_TIPPED
	var/matrix/mat = transform
	transform = mat.Turn(180)
	tipper_name = user.name

/mob/living/simple_animal/bot/medbot/proc/set_right(mob/user)
	REMOVE_TRAIT(src, TRAIT_IMMOBILIZED, BOT_TIPPED_OVER)
	var/list/messagevoice

	if(user)
		user.visible_message(span_notice("[user] sets [src] right-side up!"), span_green("You set [src] right-side up!"))
		if(user.name == tipper_name)
			messagevoice = list("I forgive you." = 'sound/voice/medbot/forgive.ogg')
		else
			messagevoice = list("Thank you!" = 'sound/voice/medbot/thank_you.ogg', "You are a good person." = 'sound/voice/medbot/youre_good.ogg')
	else
		visible_message(span_notice("[src] manages to writhe wiggle enough to right itself."))
		messagevoice = list("Fuck you." = 'sound/voice/medbot/fuck_you.ogg', "Your behavior has been reported, have a nice day." = 'sound/voice/medbot/reported.ogg')

	tipper_name = null
	if(world.time > last_tipping_action_voice + 15 SECONDS)
		last_tipping_action_voice = world.time
		var/message = pick(messagevoice)
		speak(message)
		playsound(src, messagevoice[message], 70)
	tipped_status = MEDBOT_PANIC_NONE
	mode = BOT_IDLE
	transform = matrix()

/// if someone tipped us over, check whether we should ask for help or just right ourselves eventually
/mob/living/simple_animal/bot/medbot/proc/handle_panic()
	tipped_status++
	var/list/messagevoice

	switch(tipped_status)
		if(MEDBOT_PANIC_LOW)
			messagevoice = list("I require assistance." = 'sound/voice/medbot/i_require_asst.ogg')
		if(MEDBOT_PANIC_MED)
			messagevoice = list("Please put me back." = 'sound/voice/medbot/please_put_me_back.ogg')
		if(MEDBOT_PANIC_HIGH)
			messagevoice = list("Please, I am scared!" = 'sound/voice/medbot/please_im_scared.ogg')
		if(MEDBOT_PANIC_FUCK)
			messagevoice = list("I don't like this, I need help!" = 'sound/voice/medbot/dont_like.ogg', "This hurts, my pain is real!" = 'sound/voice/medbot/pain_is_real.ogg')
		if(MEDBOT_PANIC_ENDING)
			messagevoice = list("Is this the end?" = 'sound/voice/medbot/is_this_the_end.ogg', "Nooo!" = 'sound/voice/medbot/nooo.ogg')
		if(MEDBOT_PANIC_END)
			speak("PSYCH ALERT: Crewmember [tipper_name] recorded displaying antisocial tendencies torturing bots in [get_area(src)]. Please schedule psych evaluation.", radio_channel)
			set_right() // strong independent medbot

	if(prob(tipped_status))
		do_jitter_animation(tipped_status * 0.1)

	if(messagevoice)
		var/message = pick(messagevoice)
		speak(message)
		playsound(src, messagevoice[message], 70)
	else if(prob(tipped_status * 0.2))
		playsound(src, 'sound/machines/warning-buzzer.ogg', 30, extrarange=-2)

/mob/living/simple_animal/bot/medbot/examine(mob/user)
	. = ..()
	if(tipped_status == MEDBOT_PANIC_NONE)
		return

	switch(tipped_status)
		if(MEDBOT_PANIC_NONE to MEDBOT_PANIC_LOW)
			. += "It appears to be tipped over, and is quietly waiting for someone to set it right."
		if(MEDBOT_PANIC_LOW to MEDBOT_PANIC_MED)
			. += "It is tipped over and requesting help."
		if(MEDBOT_PANIC_MED to MEDBOT_PANIC_HIGH)
			. += "They are tipped over and appear visibly distressed." // now we humanize the medbot as a they, not an it
		if(MEDBOT_PANIC_HIGH to MEDBOT_PANIC_FUCK)
			. += span_warning("They are tipped over and visibly panicking!")
		if(MEDBOT_PANIC_FUCK to INFINITY)
			. += span_warning("<b>They are freaking out from being tipped over!</b>")

/mob/living/simple_animal/bot/medbot/handle_automated_action()
	if(!..())
		return

	if(mode == BOT_TIPPED)
		handle_panic()
		return

	if(mode == BOT_HEALING)
		return

	if(IsStun() || IsParalyzed())
		oldpatient = patient
		patient = null
		mode = BOT_IDLE
		return

	if(frustration > 8)
		oldpatient = patient
		soft_reset()

	if(QDELETED(patient))
		if(!shut_up && prob(1))
			if(emagged && prob(30))
				var/list/i_need_scissors = list('sound/voice/medbot/fuck_you.ogg', 'sound/voice/medbot/turn_off.ogg', 'sound/voice/medbot/im_different.ogg', 'sound/voice/medbot/close.ogg', 'sound/voice/medbot/shindemashou.ogg')
				playsound(src, pick(i_need_scissors), 70)
			else
				var/list/messagevoice = list("Radar, put a mask on!" = 'sound/voice/medbot/radar.ogg',"There's always a catch, and I'm the best there is." = 'sound/voice/medbot/catch.ogg',"I knew it, I should've been a plastic surgeon." = 'sound/voice/medbot/surgeon.ogg',"What kind of medbay is this? Everyone's dropping like flies." = 'sound/voice/medbot/flies.ogg',"Delicious!" = 'sound/voice/medbot/delicious.ogg', "Why are we still here? Just to suffer?" = 'sound/voice/medbot/why.ogg')
				var/message = pick(messagevoice)
				speak(message)
				playsound(src, messagevoice[message], 50)
		var/scan_range = (stationary_mode ? 1 : DEFAULT_SCAN_RANGE) //If in stationary mode, scan range is limited to adjacent patients.
		patient = scan(/mob/living/carbon/human, oldpatient, scan_range)
		oldpatient = patient

	if(patient && (get_dist(src,patient) <= 1) && !tending) //Patient is next to us, begin treatment!
		if(mode != BOT_HEALING)
			mode = BOT_HEALING
			update_appearance()
			frustration = 0
			medicate_patient(patient)
		return

	//Patient has moved away from us!
	else if(patient && path.len && (get_dist(patient,path[path.len]) > 2))
		path = list()
		mode = BOT_IDLE
		last_found = world.time

	else if(stationary_mode && patient) //Since we cannot move in this mode, ignore the patient and wait for another.
		soft_reset()
		return

	if(patient && path.len == 0 && (get_dist(src,patient) > 1))
		path = get_path_to(src, patient, 30,id=access_card)
		mode = BOT_MOVING
		if(!path.len) //try to get closer if you can't reach the patient directly
			path = get_path_to(src, patient, 30,1,id=access_card)
			if(!path.len) //Do not chase a patient we cannot reach.
				soft_reset()

	if(path.len > 0 && patient)
		if(!bot_move(path[path.len]))
			oldpatient = patient
			soft_reset()
		return

	if(path.len > 8 && patient)
		frustration++

	if(auto_patrol && !stationary_mode && !patient)
		if(mode == BOT_IDLE || mode == BOT_START_PATROL)
			start_patrol()

		if(mode == BOT_PATROL)
			bot_patrol()

	return

/mob/living/simple_animal/bot/medbot/proc/assess_patient(mob/living/carbon/C)
	. = FALSE
	//Time to see if they need medical help!
	if(stationary_mode && !Adjacent(C)) //YOU come to ME, BRO
		return FALSE
	if(C.stat == DEAD || (HAS_TRAIT(C, TRAIT_FAKEDEATH)))
		return FALSE	//welp too late for them!

	var/can_inject = FALSE
	var/obj/item/bodypart/body_part
	for(var/zone in C.bodyparts)
		body_part = C.bodyparts[zone]
		if(!body_part)
			continue
		if(IS_ORGANIC_LIMB(body_part))
			can_inject = TRUE
	if(!can_inject)
		return 0

	if(!(loc == C.loc) && !(isturf(C.loc) && isturf(loc)))
		return FALSE

	if(emagged == 2) //Everyone needs our medicine. (Our medicine is toxins)
		return TRUE

	if(HAS_TRAIT(C,TRAIT_MEDIBOTCOMINGTHROUGH) && !HAS_TRAIT_FROM(C,TRAIT_MEDIBOTCOMINGTHROUGH,tag)) //the early medbot gets the worm (or in this case the patient)
		return FALSE

	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if (H.wear_suit && H.head && istype(H.wear_suit, /obj/item/clothing) && istype(H.head, /obj/item/clothing))
			var/obj/item/clothing/CS = H.wear_suit
			var/obj/item/clothing/CH = H.head
			if (CS.clothing_flags & CH.clothing_flags & THICKMATERIAL)
				return FALSE // Skip over them if they have no exposed flesh.

	if(declare_crit && C.health <= 0) //Critical condition! Call for help!
		declare(C)

	//They're injured enough for it!
	if(C.getBruteLoss() >= heal_threshold)
		return TRUE //If they're already medicated don't bother!

	if(C.getOxyLoss() >= (5 + heal_threshold))
		return TRUE

	if(C.getFireLoss() >= heal_threshold)
		return TRUE

	if(C.getToxLoss() >= heal_threshold)
		return TRUE

/mob/living/simple_animal/bot/medbot/attack_hand(mob/living/carbon/human/H)
	if(DOING_INTERACTION_WITH_TARGET(H, src))
		to_chat(H, span_warning("You're already interacting with [src]."))
		return

	if(H.a_intent == INTENT_DISARM && mode != BOT_TIPPED)
		H.visible_message(span_danger("[H] begins tipping over [src]."), span_warning("You begin tipping over [src]..."))

		if(world.time > last_tipping_action_voice + 15 SECONDS)
			last_tipping_action_voice = world.time // message for tipping happens when we start interacting, message for righting comes after finishing
			var/list/messagevoice = list("Hey, wait..." = 'sound/voice/medbot/hey_wait.ogg',"Please don't..." = 'sound/voice/medbot/please_dont.ogg',"I trusted you..." = 'sound/voice/medbot/i_trusted_you.ogg', "Nooo..." = 'sound/voice/medbot/nooo.ogg', "Oh fuck-" = 'sound/voice/medbot/oh_fuck.ogg')
			var/message = pick(messagevoice)
			speak(message)
			playsound(src, messagevoice[message], 70, FALSE)

		if(do_after(H, 3 SECONDS, target=src))
			tip_over(H)

	else if(H.a_intent == INTENT_HELP && mode == BOT_TIPPED)
		H.visible_message(span_notice("[H] begins righting [src]."), span_notice("You begin righting [src]..."))
		if(do_after(H, 3 SECONDS, target=src))
			set_right(H)
	else
		..()

/mob/living/simple_animal/bot/medbot/UnarmedAttack(atom/A)
	if(iscarbon(A) && !tending)
		var/mob/living/carbon/C = A
		patient = C
		mode = BOT_HEALING
		update_appearance()
		medicate_patient(C)
		update_appearance()
	else
		..()

/mob/living/simple_animal/bot/medbot/examinate(atom/A as mob|obj|turf in view())
	..()
	if(!is_blind())
		chemscan(src, A)

/mob/living/simple_animal/bot/medbot/proc/medicate_patient(mob/living/carbon/C)
	if(!on)
		return

	if(!istype(C))
		oldpatient = patient
		soft_reset()
		return

	if(C.stat == DEAD || (HAS_TRAIT(C, TRAIT_FAKEDEATH)))
		var/list/messagevoice = list("No! Stay with me!" = 'sound/voice/medbot/no.ogg',"Live, damnit! LIVE!" = 'sound/voice/medbot/live.ogg',"I...I've never lost a patient before. Not today, I mean." = 'sound/voice/medbot/lost.ogg')
		var/message = pick(messagevoice)
		speak(message)
		playsound(src, messagevoice[message], 50)
		oldpatient = patient
		flick_overlay_static("[base_screen_state][stationary_suffix]_death", src, 6 SECONDS)
		soft_reset()
		return

	tending = TRUE
	while(tending)
		var/treatment_method

		if(C.getBruteLoss() >= heal_threshold)
			treatment_method = BRUTE

		else if(C.getFireLoss() >= heal_threshold)
			treatment_method = BURN

		else if(C.getOxyLoss() >= (5 + heal_threshold))
			treatment_method = OXY

		else if(C.getToxLoss() >= heal_threshold)
			treatment_method = TOX

		if(!treatment_method && emagged != 2) //If they don't need any of that they're probably cured!
			if(C.maxHealth - C.get_organic_health() < heal_threshold)
				to_chat(src, span_notice("[C] is healthy! Your programming prevents you from injecting anyone without at least [heal_threshold] damage of any one type ([heal_threshold + 5] for oxygen damage.)"))
			var/list/messagevoice = list("All patched up!" = 'sound/voice/medbot/patchedup.ogg',"An apple a day keeps me away." = 'sound/voice/medbot/apple.ogg',"Feel better soon!" = 'sound/voice/medbot/feelbetter.ogg')
			var/message = pick(messagevoice)
			speak(message)
			playsound(src, messagevoice[message], 50)
			flick_overlay_static("[base_screen_state][stationary_suffix]_patched", src, 2 SECONDS)
			bot_reset()
			tending = FALSE
		else if(patient)
			C.visible_message(span_danger("[src] is trying to tend the wounds of [patient]!"), \
				span_userdanger("[src] is trying to tend your wounds!"))

			if(do_after(src, 2 SECONDS, patient)) //Slightly faster than default tend wounds, but does less HPS
				if((get_dist(src, patient) <= 1) && (on) && assess_patient(patient))
					var/healies = heal_amount
					var/obj/item/storage/firstaid/FA = firstaid
					if(treatment_method == initial(FA.damagetype_healed)) //using the damage specific medkits give bonuses when healing this type of damage.
						healies *= 1.5
					if(emagged == 2)
						patient.reagents.add_reagent(/datum/reagent/toxin/chloralhydrate, 5)
						patient.apply_damage_type((healies*1),treatment_method)
						log_combat(src, patient, "pretended to tend wounds on", "internal tools", "([uppertext(treatment_method)]) (EMAGGED)")
					else
						patient.apply_damage_type((healies*-1),treatment_method) //don't need to check treatment_method since we know by this point that they were actually damaged.
						log_combat(src, patient, "tended the wounds of", "internal tools", "([uppertext(treatment_method)])")
					C.visible_message(span_notice("[src] tends the wounds of [patient]!"), \
						span_green("[src] tends your wounds!"))
					ADD_TRAIT(patient,TRAIT_MEDIBOTCOMINGTHROUGH,tag)
					addtimer(TRAIT_CALLBACK_REMOVE(patient, TRAIT_MEDIBOTCOMINGTHROUGH, tag), (30 SECONDS))
				else
					tending = FALSE
			else
				tending = FALSE

			update_appearance()
			if(!tending)
				visible_message("[src] places its tools back into itself.")
				soft_reset()
		else
			tending = FALSE

/mob/living/simple_animal/bot/medbot/explode()
	on = FALSE
	visible_message(span_boldannounce("[src] blows apart!"))
	var/atom/Tsec = drop_location()

	drop_part(firstaid, Tsec)
	new /obj/item/assembly/prox_sensor(Tsec)
	drop_part(healthanalyzer, Tsec)

	if(prob(50))
		drop_part(robot_arm, Tsec)

	if(emagged && prob(25))
		playsound(src, 'sound/voice/medbot/insult.ogg', 50)

	do_sparks(3, TRUE, src)
	..()

/mob/living/simple_animal/bot/medbot/proc/declare(crit_patient)
	if(declare_cooldown > world.time)
		return
	var/area/location = get_area(src)
	speak("Medical emergency! [crit_patient || "A patient"] is in critical condition at [location]!",radio_channel)
	declare_cooldown = world.time + 200

/obj/machinery/bot_core/medbot
	req_one_access = list(ACCESS_MEDICAL, ACCESS_ROBOTICS)

#undef MEDBOT_PANIC_NONE
#undef MEDBOT_PANIC_LOW
#undef MEDBOT_PANIC_MED
#undef MEDBOT_PANIC_HIGH
#undef MEDBOT_PANIC_FUCK
#undef MEDBOT_PANIC_ENDING
#undef MEDBOT_PANIC_END
