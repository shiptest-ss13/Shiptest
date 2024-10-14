#define HALFWAYCRITDEATH ((HEALTH_THRESHOLD_CRIT + HEALTH_THRESHOLD_DEAD) * 0.5)

/mob/living/captive_brain
	name = "host brain"
	real_name = "host brain"

/mob/living/captive_brain/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)

	if(client)
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, "<span class='danger'>You cannot speak in IC (muted).</span>")
			return
		if(client.handle_spam_prevention(message,MUTE_IC))
			return

	if(isborer(loc))

		message = sanitize(message)
		if(!message)
			return
		log_say("[key_name(src)] : [message]")
		if(stat == 2)
			return say_dead(message)

		var/mob/living/simple_animal/borer/B = loc
		to_chat(src, "<i><span class='borer'>You whisper silently, \"[message]\"</span></i>")
		to_chat(B.victim, "<i><span class='borer'>The captive mind of [src] whispers, \"[message]\"</span></i>")

		for (var/mob/M in GLOB.player_list)
			if(isnewplayer(M))
				continue
			else if(M.stat == 2 &&  M.client.prefs.toggles & CHAT_GHOSTEARS)
				to_chat(M, "<i>Thought-speech, <b>[src]</b> -> <b>[B.truename]:</b> [message]</i>")

/mob/living/captive_brain/emote(message, intentional = FALSE)
	return

/mob/living/captive_brain/resist()

	var/mob/living/simple_animal/borer/B = loc

	to_chat(src, "<span class='danger'>You begin doggedly resisting the parasite's control (this will take approximately 40 seconds).</span>")
	to_chat(B.victim, "<span class='danger'>You feel the captive mind of [src] begin to resist your control.</span>")

	var/delay = rand(150,250) + B.victim.getOrganLoss(ORGAN_SLOT_BRAIN)
	addtimer(CALLBACK(src, PROC_REF(return_control), src.loc), delay)

/mob/living/captive_brain/proc/return_control(mob/living/simple_animal/borer/B)
	if(!B || !B.controlling)
		return

	B.victim.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(5, 10))
	to_chat(src, "<span class='danger'>With an immense exertion of will, you regain control of your body!</span>")
	to_chat(B, "<span class='danger'>You feel control of the host brain ripped from your grasp, and retract your probosci before the wild neural impulses can damage you.</span>")
	B.detach()

GLOBAL_LIST_EMPTY(borers)
GLOBAL_VAR_INIT(total_borer_hosts_needed, 3)

/mob/living/simple_animal/borer
	name = "cortical borer"
	real_name = "cortical borer"
	desc = "A small, quivering, slug-like creature."
	icon = 'icons/mob/borer.dmi'
	icon_state = "creepy"
	icon_living = "creepy"
	icon_dead = "creepy_dead"
	health = 20
	maxHealth = 20
	melee_damage_lower = 5
	melee_damage_upper = 5
	stop_automated_movement = TRUE
	verb_say = "sings"
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomp"
	attack_sound = 'sound/weapons/bite.ogg'
	pass_flags = PASSTABLE | PASSMOB | PASSDOORHATCH
	layer = UNDERDOOR
	mob_size = MOB_SIZE_SMALL
	faction = list("creature")
	ventcrawler = VENTCRAWLER_ALWAYS
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500

	var/generation = 1
	var/static/list/borer_names = list(
			"Primary", "Secondary", "Tertiary", "Quaternary", "Quinary", "Senary",
			"Septenary", "Octonary", "Novenary", "Decenary", "Undenary", "Duodenary",
			)

	var/mob/living/carbon/victim = null
	var/mob/living/captive_brain/host_brain = null
	var/truename
	var/docile = FALSE
	var/bonding = FALSE
	var/controlling = FALSE
	var/chemicals = 10
	var/leaving = FALSE
	var/hiding = FALSE
	var/waketimerid = null
	var/leap_on_click = FALSE
	var/leaping = FALSE
	var/leap_cooldown = 0

	var/datum/action/innate/borer/talk_to_host/talk_to_host_action = new
	var/datum/action/innate/borer/infest_host/infest_host_action = new
	var/datum/action/innate/borer/toggle_hide/toggle_hide_action = new
	var/datum/action/innate/borer/talk_to_borer/talk_to_borer_action = new
	var/datum/action/innate/borer/talk_to_brain/talk_to_brain_action = new
	var/datum/action/innate/borer/take_control/take_control_action = new
	var/datum/action/innate/borer/give_back_control/give_back_control_action = new
	var/datum/action/innate/borer/leave_body/leave_body_action = new
	var/datum/action/innate/borer/make_chems/make_chems_action = new
	var/datum/action/innate/borer/make_larvae/make_larvae_action = new
	var/datum/action/innate/borer/punish_victim/punish_victim_action = new
	var/datum/action/innate/borer/jumpstart_host/jumpstart_host_action = new
	var/datum/action/innate/borer/scan_host/scan_host_action = new
	var/datum/action/innate/borer/scan_chem/scan_chem_action = new
	var/datum/action/innate/borer/toggle_leap/toggle_leap_action = new

	var/is_team_borer = TRUE
	var/borer_alert = "Become a cortical borer? (Warning, You can no longer be cloned!)"

/mob/living/simple_animal/borer/sterile
	name = "neutered chemslug"
	is_team_borer = FALSE
	borer_alert = "Become a neutered cortical borer? (Warning, You can no longer be cloned!)"

/mob/living/simple_animal/borer/sterile/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/rename_on_login)
	AddElement(/datum/element/appearance_on_login/borer)

/mob/living/simple_animal/borer/Initialize(mapload, gen=1)
	. = ..()
	generation = gen
	if(is_team_borer)
		notify_ghosts("A cortical borer has been created in [get_area(src)]!", enter_link = "<a href=?src=[text_ref(src)];ghostjoin=1>(Click to enter)</a>", source = src, action = NOTIFY_ATTACK)
	var/numeral = rand(1000, 9999)
	real_name = "Cortical Borer [numeral]"
	truename = "[borer_names[min(generation, borer_names.len)]] [numeral]"

	if(is_team_borer)
		GLOB.borers += src

	GrantBorerActions()

/mob/living/simple_animal/borer/Destroy()
	GLOB.borers -= src

	host_brain = null
	victim = null

	QDEL_NULL(talk_to_host_action)
	QDEL_NULL(infest_host_action)
	QDEL_NULL(toggle_hide_action)
	QDEL_NULL(talk_to_borer_action)
	QDEL_NULL(talk_to_brain_action)
	QDEL_NULL(take_control_action)
	QDEL_NULL(give_back_control_action)
	QDEL_NULL(leave_body_action)
	QDEL_NULL(make_chems_action)
	QDEL_NULL(make_larvae_action)
	QDEL_NULL(punish_victim_action)
	QDEL_NULL(jumpstart_host_action)
	QDEL_NULL(scan_host_action)
	QDEL_NULL(scan_chem_action)
	QDEL_NULL(toggle_leap_action)

	return ..()

/mob/living/simple_animal/borer/Topic(href, href_list)//not entirely sure if this is even required
	if(href_list["ghostjoin"])
		var/mob/dead/observer/ghost = usr
		if(istype(ghost))
			attack_ghost(ghost)
	if(href_list["borer_use_chem"])
		locate(href_list["src"])
		if(!istype(src, /mob/living/simple_animal/borer))
			return

		var/datum/borer_chem/C

		for(var/datum in typesof(/datum/borer_chem))
			var/datum/borer_chem/test = new datum()
			if(test.chemname == href_list["borer_use_chem"])
				C = test
				break

		if(!C || !victim || controlling || !src || stat)
			return

		if(chemicals < C.chemuse)
			to_chat(src, "<span class='boldnotice'>You need [C.chemuse] chemicals stored to use this chemical!</span>")
			return

		to_chat(src, "<span class='userdanger'>You inject a measure of [C.chemname] from your reservoirs into [victim]'s bloodstream.</span>")
		victim.reagents.add_reagent(C.chem, C.quantity)
		chemicals -= C.chemuse
		log_game("[src]/([src.ckey]) has injected [C.chemname] ([C.chem]) into their host [victim]/([victim.ckey])")

		src << output(chemicals, "ViewBorer[text_ref(src)]Chems.browser:update_chemicals")

	..()

/mob/living/simple_animal/borer/attack_ghost(mob/user)
	if(is_banned_from(user, ROLE_BORER) || is_banned_from(user, "Syndicate"))
		return
	if(key)
		return
	if(stat != CONSCIOUS)
		return
	var/be_borer = alert(borer_alert, ,"Yes", "No")
	if(be_borer == "No" || !src || QDELETED(src))
		return
	if(key)
		return
	transfer_personality(user.client)

/mob/living/simple_animal/borer/proc/transfer_personality(client/candidate)
	if(!candidate || !candidate.mob)
		return

	if(!QDELETED(candidate) || !QDELETED(candidate.mob))
		var/datum/mind/M = create_borer_mind(candidate.ckey)
		M.transfer_to(src)

		candidate.mob = src
		ckey = candidate.ckey

/mob/living/simple_animal/borer/Stat()
	..()

	if(statpanel("Status"))
		stat(null, "Chemicals: [chemicals]")

	src << output(chemicals, "ViewBorer[text_ref(src)]Chems.browser:update_chemicals")

/mob/living/simple_animal/borer/verb/Communicate()
	set category = "Borer"
	set name = "Converse with Host"
	set desc = "Send a silent message to your host."

	if(!victim)
		to_chat(src, "You do not have a host to communicate with!")
		return

	if(stat)
		to_chat(src, "You cannot do that in your current state.")
		return

	var/input = stripped_input(src, "Please enter a message to tell your host.", "Borer", null)
	if(!input)
		return

	if(src && !QDELETED(src) && !QDELETED(victim))
		var/say_string = (docile) ? "slurs" :"states"
		if(victim)
			to_chat(victim, "<span class='borer'><i>[truename] [say_string]:</i> [input]</span>")
			log_say("Borer Communication: [key_name(src)] -> [key_name(victim)] : [input]")
			for(var/M in GLOB.dead_mob_list)
				if(isobserver(M))
					var/rendered = "<span class='borer'><i>Borer Communication from <b>[truename]</b> : [input]</i>"
					var/link = FOLLOW_LINK(M, src)
					to_chat(M, "[link] [rendered]")
		to_chat(src, "<span class='borer'><i>[truename] [say_string]:</i> [input]</span>")
		victim.verbs += /mob/living/proc/borer_comm
		talk_to_borer_action.Grant(victim)

/mob/living/proc/borer_comm()
	set name = "Converse with Borer"
	set category = "Borer"
	set desc = "Communicate mentally with your borer."


	var/mob/living/simple_animal/borer/B = has_brain_worms()
	if(!B)
		return

	var/input = stripped_input(src, "Please enter a message to tell the borer.", "Message", null)
	if(!input)
		return

	to_chat(B, "<span class='borer'><i>[src] says:</i> [input]</span>")
	log_say("Borer Communication: [key_name(src)] -> [key_name(B)] : [input]")

	for(var/M in GLOB.dead_mob_list)
		if(isobserver(M))
			var/rendered = "<span class='borer'><i>Borer Communication from <b>[src]</b> : [input]</i>"
			var/link = FOLLOW_LINK(M, src)
			to_chat(M, "[link] [rendered]")
	to_chat(src, "<span class='borer'><i>[src] says:</i> [input]</span>")

/mob/living/proc/trapped_mind_comm()
	set name = "Converse with Trapped Mind"
	set category = "Borer"
	set desc = "Communicate mentally with the trapped mind of your host."


	var/mob/living/simple_animal/borer/B = has_brain_worms()
	if(!B || !B.host_brain)
		return
	var/mob/living/captive_brain/CB = B.host_brain
	var/input = stripped_input(src, "Please enter a message to tell the trapped mind.", "Message", null)
	if(!input)
		return

	to_chat(CB, "<span class='borer'><i>[B.truename] says:</i> [input]</span>")
	log_say("Borer Communication: [key_name(B)] -> [key_name(CB)] : [input]")

	for(var/M in GLOB.dead_mob_list)
		if(isobserver(M))
			var/rendered = "<span class='borer'><i>Borer Communication from <b>[B]</b> : [input]</i>"
			var/link = FOLLOW_LINK(M, src)
			to_chat(M, "[link] [rendered]")
	to_chat(src, "<span class='borer'><i>[B.truename] says:</i> [input]</span>")

/mob/living/simple_animal/borer/Life()

	..()

	if(victim)
		if(stat != DEAD)
			if(victim.stat == DEAD)
				chemicals++
			else if(chemicals < 250)
				chemicals+=2
			chemicals = min(250, chemicals)


		if(stat != DEAD && victim.stat != DEAD)

			if(victim.reagents.has_reagent(/datum/reagent/consumable/sugar))
				if(!docile || waketimerid)
					if(controlling)
						to_chat(victim, "<span class='warning'>You feel the soporific flow of sugar in your host's blood, lulling you into docility.</span>")
					else
						to_chat(src, "<span class='warning'>You feel the soporific flow of sugar in your host's blood, lulling you into docility.</span>")
					if(waketimerid)
						deltimer(waketimerid)
						waketimerid = null
					docile = TRUE
			else
				if(docile && !waketimerid)
					if(controlling)
						to_chat(victim, "<span class='warning'>You start shaking off your lethargy as the sugar leaves your host's blood. This will take about 10 seconds...</span>")
					else
						to_chat(src, "<span class='warning'>You start shaking off your lethargy as the sugar leaves your host's blood. This will take about 10 seconds...</span>")

					waketimerid = addtimer(CALLBACK(src, "wakeup"), 10, TIMER_STOPPABLE)
			if(controlling)

				if(docile)
					to_chat(victim, "<span class='warning'>You are feeling far too docile to continue controlling your host...</span>")
					victim.release_control()
					return

				if(prob(5))
					victim.adjustOrganLoss(ORGAN_SLOT_BRAIN, rand(1,2))

				if(prob(victim.getOrganLoss(ORGAN_SLOT_BRAIN)/10))
					victim.say("*[pick(list("blink","blink_r","choke","aflap","drool","twitch","twitch_s","gasp"))]")

/mob/living/simple_animal/borer/proc/wakeup()
	if(controlling)
		to_chat(victim, "<span class='warning'>You finish shaking off your lethargy.</span>")
	else
		to_chat(src, "<span class='warning'>You finish shaking off your lethargy.</span>")
	docile = FALSE
	if(waketimerid)
		waketimerid = null

/mob/living/simple_animal/borer/ex_act()
	if(victim)
		return

	..()

/mob/living/simple_animal/borer/proc/infect_victim(mob/living/carbon/H = null)
	set name = "Infest"
	set category = "Borer"
	set desc = "Infest a suitable humanoid host."

	if(victim)
		to_chat(src, "<span class='warning'>You are already within a host.</span>")

	if(stat == DEAD)
		return

	if(!H)
		var/list/choices = list()
		for(var/mob/living/carbon/C in view(1,src))
			if(C!=src && Adjacent(C))
				choices += C

		if(!choices.len)
			return
		H = choices.len > 1 ? input(src,"Who do you wish to infest?") in null|choices : choices[1]

	if(!H || !src)
		return

	if(!Adjacent(H))
		return FALSE

	if(stat != CONSCIOUS)
		to_chat(src, "<span class='warning'>You cannot do that in your current state.</span>")
		return FALSE

	if(H.has_brain_worms())
		to_chat(src, "<span class='warning'>[H] is already infested!</span>")
		return

	if(H.is_mouth_covered(head_only = 1))
		to_chat(src, "<span class='warning'>[H] is wearing head protection!</span>")
		return

	if(H.ears)
		if(H.dropItemToGround(H.ears))
			H.visible_message("<span class='danger'>[src] tears [H.ears] off of [H]'s ear!</span>", \
							"<span class='userdanger'>[src] tears [H.ears] off of your ear!</span>") //coz, you know, they go in the ear holes

	to_chat(src, "<span class='warning'>You slither up [H] and begin probing at their ear canal...</span>")
	if(!do_after(src, 3 SECONDS, H))
		to_chat(src, "<span class='warning'>As [H] moves away, you are dislodged and fall to the ground.</span>")
		return

	if(!H || !src)
		return

	Infect(H)

/mob/living/simple_animal/borer/proc/Infect(mob/living/carbon/C)

	if(!C)
		return

	if(C.has_brain_worms())
		to_chat(src, "<span class='warning'>[C] is already infested!</span>")
		return

	if(!C.key || !C.mind)
		to_chat(src, "<span class='warning'>[C]'s mind seems unresponsive. Try someone else!</span>")
		return

	if(C && C.dna && istype(C.dna.species, /datum/species/skeleton))
		to_chat(src, "<span class='warning'>[C] does not possess the vital systems needed to support us.</span>")
		return

	victim = C
	forceMove(victim)

	RemoveBorerActions()
	GrantInfestActions()

	if(src.mind && src.mind.language_holder && C.mind.language_holder)
		src.mind.language_holder.copy_languages(C.mind.language_holder)

	log_game("[src]/([src.ckey]) has infested [victim]/([victim.ckey]")

/mob/living/simple_animal/borer/verb/secrete_chemicals()
	set category = "Borer"
	set name = "Secrete Chemicals"
	set desc = "Push some chemicals into your host's bloodstream."

	if(!victim)
		to_chat(src, "<span class='warning'>You are not inside a host body.</span>")
		return

	if(stat != CONSCIOUS)
		to_chat(src, "<span class='warning'>You cannot secrete chemicals in your current state.</span>")

	if(docile)
		to_chat(src, "<span class='warning'>You are feeling far too docile to do that.</span>")
		return

	var/content = ""
	content += "<p>Chemicals: <span id='chemicals'>[chemicals]</span></p>"

	content += "<table>"


	for(var/datum in typesof(/datum/borer_chem))
		var/datum/borer_chem/C = new datum()
		if(C.chem)
			content += "<tr><td><a class='chem-select' href='?_src_=[text_ref(src)];src=[text_ref(src)];borer_use_chem=[C.chemname]'>[C.chemname] ([C.quantity]u, takes [C.chemuse] chemical)</a><p>[C.chem_desc]</p></td></tr>"
	content += "</table>"

	var/html = get_html_template(content)

	usr << browse(null, "window=ViewBorer[text_ref(src)]Chems;size=600x800")
	usr << browse(html, "window=ViewBorer[text_ref(src)]Chems;size=600x800")

	return

/mob/living/simple_animal/borer/verb/hide()
	set category = "Borer"
	set name = "Hide"
	set desc = "Allows borers to hide beneath tables or certain items. Toggled on or off."

	if(victim)
		to_chat(src, "<span class='warning'>You cannot do this while you're inside a host.</span>")

	if(stat != CONSCIOUS)
		return

	if(!hiding)
		layer = LATTICE_LAYER
		visible_message("<span class='name'>[src] scurries to the ground!</span>", \
						"<span class='noticealien'>You are now hiding.</span>")
		hiding = TRUE
	else
		layer = UNDERDOOR
		visible_message("[src] slowly peaks up from the ground...", \
					"<span class='noticealien'>You stop hiding.</span>")
		hiding = FALSE

/mob/living/simple_animal/borer/verb/release_victim()
	set category = "Borer"
	set name = "Release Host"
	set desc = "Slither out of your host."

	if(!victim)
		to_chat(src, "<span class='userdanger'>You are not inside a host body.</span>")
		return

	if(stat != CONSCIOUS)
		to_chat(src, "<span class='userdanger'>You cannot leave your host in your current state.</span>")

	if(leaving)
		leaving = FALSE
		to_chat(src, "<span class='userdanger'>You decide against leaving your host.</span>")
		return

	to_chat(src, "<span class='userdanger'>You begin disconnecting from [victim]'s synapses and prodding at their internal ear canal.</span>")

	if(victim.stat != DEAD)
		to_chat(victim, "<span class='userdanger'>An odd, uncomfortable pressure begins to build inside your skull, behind your ear...</span>")

	leaving = TRUE

	addtimer(CALLBACK(src, PROC_REF(release_host)), 100)

/mob/living/simple_animal/borer/proc/release_host()
	if(!victim || !src || QDELETED(victim) || QDELETED(src))
		return
	if(!leaving)
		return
	if(controlling)
		return

	if(stat != CONSCIOUS)
		to_chat(src, "<span class='userdanger'>You cannot release your host in your current state.</span>")
		return

	to_chat(src, "<span class='userdanger'>You wiggle out of [victim]'s ear and plop to the ground.</span>")
	if(victim.mind)
		to_chat(victim, "<span class='danger'>Something slimy wiggles out of your ear and plops to the ground!</span>")
		to_chat(victim, "<span class='danger'>As though waking from a dream, you shake off the insidious mind control of the brain worm. Your thoughts are your own again.</span>")

	leaving = FALSE

	leave_victim()

/mob/living/simple_animal/borer/proc/leave_victim()
	if(!victim)
		return

	if(controlling)
		detach()

	if(src.mind.language_holder)
		var/datum/language_holder/language_holder = src.mind.language_holder
		language_holder.remove_all_languages()
		language_holder.grant_language(/datum/language/common)

	GrantBorerActions()
	RemoveInfestActions()

	forceMove(get_turf(victim))

	reset_perspective(null)
	unset_machine()

	victim.reset_perspective(null)
	victim.unset_machine()

	var/mob/living/V = victim
	V.verbs -= /mob/living/proc/borer_comm
	talk_to_borer_action.Remove(victim)
	victim = null
	return

/mob/living/simple_animal/borer/verb/jumpstart()
	set category = "Borer"
	set name = "Jumpstart Host"
	set desc = "Bring your host back to life."

	if(!victim)
		to_chat(src, "<span class='warning'>You need a host to be able to use this.</span>")
		return

	if(docile)
		to_chat(src, "<span class='warning'>You are feeling too docile to use this!</span>")
		return

	if(victim.stat != DEAD)
		to_chat(src, "<span class='warning'>Your host is already alive!</span>")
		return

	if(chemicals < 250)
		to_chat(src, "<span class='warning'>You need 250 chemicals to use this!</span>")
		return

	if(!istype(victim, /mob/living/carbon))
		to_chat(src, "<span class='warning'>You can't revive this creature!</span>")

	var/mob/living/carbon/C = victim

	if(victim.stat == DEAD)
		playsound(src, 'sound/machines/defib_zap.ogg', 50, TRUE, -1)
		if (C.health > HALFWAYCRITDEATH)
			C.adjustOxyLoss(C.health - HALFWAYCRITDEATH, 0) //no more aheals you slug fucks
		else
			var/overall_damage = C.getFireLoss() + C.getBruteLoss() + C.getToxLoss() + C.getOxyLoss()
			var/mobhealth = C.health
			C.adjustOxyLoss((mobhealth - HALFWAYCRITDEATH) * (C.getOxyLoss() / overall_damage), 0)
			C.adjustToxLoss((mobhealth - HALFWAYCRITDEATH) * (C.getToxLoss() / overall_damage), 0)
			C.adjustFireLoss((mobhealth - HALFWAYCRITDEATH) * (C.getFireLoss() / overall_damage), 0)
			C.adjustBruteLoss((mobhealth - HALFWAYCRITDEATH) * (C.getBruteLoss() / overall_damage), 0)
		C.updatehealth() // Previous "adjust" procs don't update health, so we do it manually.
		C.revive(full_heal = FALSE, admin_revive = FALSE)
		SEND_SIGNAL(C, COMSIG_LIVING_MINOR_SHOCK)
		log_game("[src]/([src.ckey]) has revived [victim]/([victim.ckey]")
		chemicals -= 250
		to_chat(src, "<span class='notice'>You send a jolt of energy to your host, reviving them!</span>")
		victim.grab_ghost(force = TRUE) //brings the host back, no eggscape
		C.emote("gasp")
		C.Jitter(100)

/mob/living/simple_animal/borer/verb/bond_brain()
	set category = "Borer"
	set name = "Assume Control"
	set desc = "Fully connect to the brain of your host."

	if(!victim)
		to_chat(src, "<span class='warning'>You are not inside a host body.</span>")
		return

	if(stat != CONSCIOUS)
		to_chat(src, "You cannot do that in your current state.")
		return

	if(docile)
		to_chat(src, "<span class='warning'>You are feeling far too docile to do that.</span>")
		return

	if(victim.stat == DEAD)
		to_chat(src, "<span class='warning'>This host lacks enough brain function to control.</span>")
		return

	if(bonding)
		bonding = FALSE
		to_chat(src, "<span class='userdanger'>You stop attempting to take control of your host.</span>")
		return

	to_chat(src, "<span class='danger'>You begin delicately adjusting your connection to the host brain...</span>")

	if(QDELETED(src) || QDELETED(victim))
		return

	bonding = TRUE

	var/delay = 200+(victim.getOrganLoss(ORGAN_SLOT_BRAIN)*5)
	addtimer(CALLBACK(src, PROC_REF(assume_control)), delay)

/mob/living/simple_animal/borer/proc/assume_control()
	if(!victim || !src || controlling || victim.stat == DEAD)
		return
	if(!bonding)
		return
	if(docile)
		to_chat(src, "<span class='warning'>You are feeling far too docile to do that.</span>")
		return
	else

		log_game("[src]/([src.ckey]) assumed control of [victim]/([victim.ckey] with borer powers.")
		to_chat(src, "<span class='warning'>You plunge your probosci deep into the cortex of the host brain, interfacing directly with their nervous system.</span>")
		to_chat(victim, "<span class='userdanger'>You feel a strange shifting sensation behind your eyes as an alien consciousness displaces yours.</span>")

		// host -> brain
		qdel(host_brain)
		host_brain = new(src)

		host_brain.name = victim.name
		if(victim.mind)
			host_brain.mind = victim.mind
		host_brain.ckey = victim.ckey

		to_chat(host_brain, "You are trapped in your own mind. You feel that there must be a way to resist!")

		// self -> host
		victim.mind = src.mind
		victim.ckey = src.ckey

		bonding = FALSE
		controlling = TRUE

		victim.verbs += /mob/living/carbon/proc/release_control
		if(is_team_borer)
			victim.verbs += /mob/living/carbon/proc/spawn_larvae
		victim.verbs -= /mob/living/proc/borer_comm
		victim.verbs += /mob/living/proc/trapped_mind_comm
		GrantControlActions()
		talk_to_borer_action.Remove(victim)

		victim.med_hud_set_status()

		RegisterSignal(victim, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_borer_stat_panel))

/mob/living/simple_animal/borer/verb/punish()
	set category = "Borer"
	set name = "Punish"
	set desc = "Punish your victim by disabling one of their limbs temporarily."

	if(!victim)
		to_chat(src, "<span class='warning'>You are not inside a host body.</span>")
		return

	if(stat != CONSCIOUS)
		to_chat(src, "You cannot do that in your current state.")
		return

	if(docile)
		to_chat(src, "<span class='warning'>You are feeling far too docile to do that.</span>")
		return

	if(chemicals < 75)
		to_chat(src, "<span class='warning'>You need 75 chems to punish your host.</span>")
		return

	if(chemicals < 75)
		to_chat(src, "<span class='warning'>You need 75 chems to punish your host.</span>")
		return

	var/limb = pick(victim.bodyparts)
	limb = parse_zone(limb)
	victim.apply_damage(50, STAMINA, limb)

	log_combat(src, victim, "disabled", addition = "with borer powers")

	chemicals -= 75


/mob/living/carbon/proc/release_control()
	set category = "Borer"
	set name = "Release Control"
	set desc = "Release control of your host's body."

	var/mob/living/simple_animal/borer/B = has_brain_worms()
	if(B && B.host_brain)
		to_chat(B, "<span class='danger'>You withdraw your probosci, releasing control of [B.host_brain]</span>")
		B.detach()

/mob/living/simple_animal/borer/proc/get_borer_stat_panel(mob/living/source, list/items)
	SIGNAL_HANDLER
	items += "Borer Body Health: [health]"
	items += "Chemicals: [chemicals]"

//Check for brain worms in head.
/mob/proc/has_brain_worms()

	for(var/I in contents)
		if(isborer(I))
			return I

	return FALSE

/mob/living/carbon/proc/spawn_larvae()
	set category = "Borer"
	set name = "Reproduce"
	set desc = "Spawn several young."

	var/mob/living/simple_animal/borer/B = has_brain_worms()

	if(isbrain(src))
		to_chat(src, "<span class='usernotice'>You need a mouth to be able to do this.</span>")
		return
	if(!B)
		return

	if(B.chemicals >= 200)
		visible_message("<span class='danger'>[src] heaves violently, expelling a rush of vomit and a wriggling, sluglike creature!</span>")
		B.chemicals -= 200

		new /obj/effect/decal/cleanable/vomit(get_turf(src))
		playsound(loc, 'sound/effects/splat.ogg', 50, 1)
		new /mob/living/simple_animal/borer(get_turf(src), B.generation + 1)
		log_game("[src]/([src.ckey]) has spawned a new borer via reproducing.")
	else
		to_chat(src, "<span class='warning'>You need 200 chemicals stored to reproduce.</span>")
		return

/mob/living/simple_animal/borer/proc/detach()
	if(!victim || !controlling)
		return

	controlling = FALSE

	victim.verbs -= /mob/living/carbon/proc/release_control
	if(is_team_borer)
		victim.verbs -= /mob/living/carbon/proc/spawn_larvae
	victim.verbs += /mob/living/proc/borer_comm
	victim.verbs -= /mob/living/proc/trapped_mind_comm
	RemoveControlActions()
	talk_to_borer_action.Grant(victim)

	victim.med_hud_set_status()

	if(host_brain)

		// host -> self
		mind = victim.mind
		ckey = victim.ckey

		// brain -> host
		victim.mind = host_brain.mind
		victim.ckey = host_brain.ckey

	log_game("[src]/([src.ckey]) released control of [victim]/([victim.ckey]")

	UnregisterSignal(victim, COMSIG_MOB_GET_STATUS_TAB_ITEMS)

	qdel(host_brain)

/mob/living/simple_animal/borer/proc/toggle_leap()
	set category = "Borer"
	set name = "Toggle Leap"
	set desc = "Prepare to leap at a potential victim."
	leap_on_click = !leap_on_click
	to_chat(src, "<span class='borer'>You [src.leap_on_click ? "prepare to leap at a victim...":"stop preparing to leap."]</span>")

#define MAX_BORER_LEAP_DIST 5

/mob/living/simple_animal/borer/ClickOn(atom/A, params)
	face_atom(A)
	if(leap_on_click)
		leap_at(A)
	else
		..()

/mob/living/simple_animal/borer/proc/leap_at(atom/A)
	if((mobility_flags & (MOBILITY_MOVE | MOBILITY_STAND)) != (MOBILITY_MOVE | MOBILITY_STAND) || leaping)
		return

	if(leap_cooldown > world.time)
		to_chat(src, "<span class='borer'>You are too fatigued to leap right now!</span>")
		return

	if(!has_gravity() || !A.has_gravity())
		to_chat(src, "<span class='borer'>It is unsafe to leap without gravity!</span>")
		//It's also extremely buggy visually, so it's balance+bugfix
		return

	else
		if(hiding)
			src.hide()
		leaping = TRUE
		throw_at(A, MAX_BORER_LEAP_DIST, 1, src, FALSE, TRUE, callback = CALLBACK(src, PROC_REF(leap_end)))

/mob/living/simple_animal/borer/proc/leap_end()
	leaping = FALSE

/mob/living/simple_animal/borer/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)

	if(!leaping)
		return ..()

	leap_cooldown = world.time + 60
	if(hit_atom)
		if(isliving(hit_atom))
			var/mob/living/L = hit_atom
			var/blocked = FALSE
			if(ishuman(hit_atom))
				var/mob/living/carbon/human/H = hit_atom
				if(H.is_mouth_covered(head_only = 1))
					to_chat(src, "<span class='userdanger'>You smash against [H]'s [H.head]!</span>")
					H.visible_message("<span class='danger'>[src] smashes against [H]'s [H.head]!</span>", \
					"<span class='userdanger'>[src] smashes against your [H.head]!</span>")
					blocked = TRUE
			if(!blocked)
				L.visible_message("<span class='danger'>[src] pounces on [L]!</span>", "<span class='userdanger'>[src] pounces on you!</span>")
				L.Paralyze(50)
				sleep(2)//Runtime prevention (infinite bump() calls on hulks)
				step_towards(src,L)
				if(iscarbon(hit_atom))
					var/mob/living/carbon/C = hit_atom
					addtimer(CALLBACK(src, PROC_REF(infect_victim), C), 15)
			else
				Paralyze(40, 1, 1)

			toggle_leap()
		else if(hit_atom.density && !hit_atom.CanPass(src))
			visible_message("<span class='danger'>[src] smashes into [hit_atom]!</span>", "<span class='borer'>[src] smashes into [hit_atom]!</span>")
			Paralyze(40, 1, 1)

		if(leaping)
			leaping = FALSE
			update_icons()

/proc/create_borer_mind(key)
	var/datum/mind/M = new /datum/mind(key)
	M.assigned_role = "Cortical Borer"
	M.special_role = "Cortical Borer"
	return M

/mob/living/simple_animal/borer/proc/GrantBorerActions()
	infest_host_action.Grant(src)
	toggle_hide_action.Grant(src)
	toggle_leap_action.Grant(src)

/mob/living/simple_animal/borer/proc/RemoveBorerActions()
	infest_host_action.Remove(src)
	toggle_hide_action.Remove(src)
	toggle_leap_action.Remove(src)

/mob/living/simple_animal/borer/proc/GrantInfestActions()
	talk_to_host_action.Grant(src)
	leave_body_action.Grant(src)
	take_control_action.Grant(src)
	punish_victim_action.Grant(src)
	make_chems_action.Grant(src)
	jumpstart_host_action.Grant(src)
	scan_host_action.Grant(src)
	scan_chem_action.Grant(src)

/mob/living/simple_animal/borer/proc/RemoveInfestActions()
	talk_to_host_action.Remove(src)
	take_control_action.Remove(src)
	leave_body_action.Remove(src)
	punish_victim_action.Remove(src)
	make_chems_action.Remove(src)
	jumpstart_host_action.Remove(src)
	scan_host_action.Remove(src)
	scan_chem_action.Remove(src)

/mob/living/simple_animal/borer/proc/GrantControlActions()
	talk_to_brain_action.Grant(victim)
	give_back_control_action.Grant(victim)
	if(is_team_borer) //The entire structure of this mob is fucking garbage.
		make_larvae_action.Grant(victim)

/mob/living/simple_animal/borer/proc/RemoveControlActions()
	talk_to_brain_action.Remove(victim)
	make_larvae_action.Remove(victim)
	give_back_control_action.Remove(victim)

/datum/action/innate/borer
	icon_icon = 'icons/mob/actions/actions_borer.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/borer/talk_to_host
	name = "Converse with Host"
	desc = "Send a silent message to your host."
	button_icon_state = "borer_whisper"

/datum/action/innate/borer/talk_to_host/Activate()
	var/mob/living/simple_animal/borer/B = owner
	B.Communicate()

/datum/action/innate/borer/infest_host
	name = "Infest"
	desc = "Infest a suitable humanoid host."
	button_icon_state = "infest"

/datum/action/innate/borer/infest_host/Activate()
	var/mob/living/simple_animal/borer/B = owner
	B.infect_victim()

/datum/action/innate/borer/toggle_hide
	name = "Toggle Hide"
	desc = "Allows borers to hide beneath tables or certain items. Toggled on or off."
	button_icon_state = "borer_hiding_false"

/datum/action/innate/borer/toggle_hide/Activate()
	var/mob/living/simple_animal/borer/B = owner
	B.hide()
	button_icon_state = "borer_hiding_[B.hiding ? "true" : "false"]"
	UpdateButtonIcon()

/datum/action/innate/borer/toggle_leap
	name = "Prepare Leap"
	desc = "Prepare to leap at an unsuspecting host."
	button_icon_state = "borer_leap"

/datum/action/innate/borer/toggle_leap/Activate()
	var/mob/living/simple_animal/borer/B = owner
	B.toggle_leap()

/datum/action/innate/borer/talk_to_borer
	name = "Converse with Borer"
	desc = "Communicate mentally with your borer."
	button_icon_state = "borer_whisper"

/datum/action/innate/borer/talk_to_borer/Activate()
	var/mob/living/simple_animal/borer/B = owner.has_brain_worms()
	B.victim = owner
	B.victim.borer_comm()

/datum/action/innate/borer/talk_to_brain
	name = "Converse with Trapped Mind"
	desc = "Communicate mentally with the trapped mind of your host."
	button_icon_state = "borer_whisper"

/datum/action/innate/borer/talk_to_brain/Activate()
	var/mob/living/simple_animal/borer/B = owner.has_brain_worms()
	B.victim = owner
	B.victim.trapped_mind_comm()

/datum/action/innate/borer/take_control
	name = "Assume Control"
	desc = "Fully connect to the brain of your host."
	button_icon_state = "borer_brain"

/datum/action/innate/borer/take_control/Activate()
	var/mob/living/simple_animal/borer/B = owner
	B.bond_brain()

/datum/action/innate/borer/give_back_control
	name = "Release Control"
	desc = "Release control of your host's body."
	button_icon_state = "borer_leave"

/datum/action/innate/borer/give_back_control/Activate()
	var/mob/living/simple_animal/borer/B = owner.has_brain_worms()
	B.victim = owner
	B.victim.release_control()

/datum/action/innate/borer/leave_body
	name = "Release Host"
	desc = "Slither out of your host."
	button_icon_state = "borer_leave"

/datum/action/innate/borer/leave_body/Activate()
	var/mob/living/simple_animal/borer/B = owner
	B.release_victim()

/datum/action/innate/borer/make_chems
	name = "Secrete Chemicals"
	desc = "Push some chemicals into your host's bloodstream."
	icon_icon = 'icons/obj/chemical/chem_machines.dmi'
	button_icon_state = "minidispenser"

/datum/action/innate/borer/make_chems/Activate()
	var/mob/living/simple_animal/borer/B = owner
	B.secrete_chemicals()

/datum/action/innate/borer/make_larvae
	name = "Reproduce"
	desc = "Spawn several young."
	button_icon_state = "borer_reproduce"

/datum/action/innate/borer/make_larvae/Activate()
	var/mob/living/simple_animal/borer/B = owner.has_brain_worms()
	B.victim = owner
	B.victim.spawn_larvae()

/datum/action/innate/borer/punish_victim
	name = "Punish"
	desc = "Punish your host by disabling one of their limbs."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "legsweep"

/datum/action/innate/borer/punish_victim/Activate()
	var/mob/living/simple_animal/borer/B = owner
	B.punish()

/datum/action/innate/borer/jumpstart_host
	name = "Jumpstart Host"
	desc = "Bring your host back to life."
	icon_icon = 'icons/obj/defib.dmi'
	button_icon_state = "defibpaddles0"

/datum/action/innate/borer/jumpstart_host/Activate()
	var/mob/living/simple_animal/borer/B = owner
	B.jumpstart()

/datum/action/innate/borer/scan_host
	name = "Analyze Host"
	desc = "Analyze you host's current health."
	icon_icon = 'icons/obj/device.dmi'
	button_icon_state = "health"

/datum/action/innate/borer/scan_host/Activate()
	var/mob/living/simple_animal/borer/B = owner
	var/mob/living/carbon/C = B.victim
	healthscan(B, C)

/datum/action/innate/borer/scan_chem
	name = "Taste Blood"
	desc = "Analyze the chemicals in your host."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "scan_mode"

/datum/action/innate/borer/scan_chem/Activate()
	var/mob/living/simple_animal/borer/B = owner
	var/mob/living/carbon/C = B.victim
	chemscan(B, C)

/////ACTUAL ANTAG DATUM THINGS (Translation: Big Scary Magic Things)
/datum/team/borer
	name = "Cortical Borers"

/datum/team/borer/New()
	..()
	add_objective(new/datum/objective/borer)

/datum/team/borer/roundend_report()
	var/list/parts = list()

	var/won = TRUE
	for(var/datum/objective/O in objectives)
		if(!O.check_completion())
			won = FALSE
	if(won)
		parts += "<span class='greentext big'>The [name] were successful!</span>"
	else
		parts += "<span class='redtext big'>The [name] have failed.</span>"

	parts += "<span class='header'>The [name] were:</span>"
	for(var/mob/living/simple_animal/borer/B in GLOB.borers)
		var/borertext
		if(B.is_team_borer && (B.key || B.controlling) && B.stat != DEAD)
			if(!won && B.client)
				SEND_SOUND(B.client, 'sound/ambience/ambifailure.ogg')
			borertext += "<br><b>[B.controlling ? B.victim.key : B.key]</b> was <b>[B.truename]</b> and "
			var/turf/location = get_turf(B)
			if(B.stat != DEAD)
				if(is_centcom_level(location) && B.victim)
					borertext += "<span class='greentext'>escaped with a host</span>"
				else
					borertext += "<span class='redtext'>failed to find a host</span>"
			else
				borertext += "<span class='redtext'>died</span>"
			parts += borertext
	parts += printobjectives(objectives)
	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/team/borer/proc/add_objective(datum/objective/O)
	O.team = src
	O.update_explanation_text()
	objectives += O

/datum/antagonist/borer
	name = "Cortical Borer"
	roundend_category = "borers"
	antagpanel_category = "borer"
	job_rank = ROLE_BORER
	show_in_antagpanel = TRUE
	var/datum/team/borer/borer_team

/datum/antagonist/borer/create_team(datum/team/borer/new_team)
	if(!new_team)
		for(var/datum/antagonist/borer/X in GLOB.antagonists)
			if(!X.owner || !X.borer_team)
				continue
			borer_team = X.borer_team
			return
		borer_team = new
	else
		if(!istype(new_team))
			CRASH("Wrong borer team type provided to create_team")
		borer_team = new_team

/datum/antagonist/borer/get_team()
	return borer_team

/datum/antagonist/borer/on_gain()
	objectives = borer_team.objectives
	to_chat(owner.current, "<span class='notice'>You are the [name].</span>")
	to_chat(owner.current, "You are a brain slug that worms its way into the head of its victim. Use stealth, persuasion and your powers of mind control to keep you, your host and your eventual spawn safe and warm.")
	to_chat(owner.current, "Sugar nullifies your abilities, avoid it at all costs!")
	to_chat(owner.current, "You can speak to your fellow borers by prefixing your messages with '.j'. Check out your Borer tab to see your abilities. To reproduce, you must have 200 chemicals and be controlling a host.")
	return ..()

//Objective
/datum/objective/borer
	target_amount = 3

/datum/objective/borer/New()
	target_amount = clamp(rand(2, 10), 2, round(get_active_player_count(TRUE, FALSE, TRUE)/2))//"dynamic" scaling
	explanation_text = "You must escape with at least [target_amount] borers with hosts on the shuttle."

/datum/objective/borer/check_completion()
	var/total_borers = 0
	for(var/mob/living/simple_animal/borer/B in GLOB.borers)
		if((B.key || B.victim) && B.stat != DEAD)
			total_borers++
	if(total_borers)
		var/total_borer_hosts = 0
		for(var/mob/living/carbon/C in GLOB.mob_list)
			var/mob/living/simple_animal/borer/D = C.has_brain_worms()
			var/turf/location = get_turf(C)
			if(is_centcom_level(location) && D && D.stat != DEAD)
				total_borer_hosts++
		if(total_borer_hosts >= target_amount)
			return TRUE

//Mob
/mob/living/simple_animal/borer/mind_initialize()
	..()
	if(is_team_borer && !mind.has_antag_datum(/datum/antagonist/borer))
		mind.add_antag_datum(/datum/antagonist/borer)

#undef HALFWAYCRITDEATH
