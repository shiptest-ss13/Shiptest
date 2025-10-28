/obj/item/antag_spawner
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	var/used = FALSE

/obj/item/antag_spawner/proc/spawn_antag(client/C, turf/T, kind = "", datum/mind/user)
	return

/obj/item/antag_spawner/proc/equip_antag(mob/target)
	return


///////////WIZARD

/obj/item/antag_spawner/contract
	name = "contract"
	desc = "A magic contract previously signed by an apprentice. In exchange for instruction in the magical arts, they are bound to answer your call for aid."
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"

/obj/item/antag_spawner/contract/attack_self(mob/user)
	user.set_machine(src)
	var/dat
	if(used)
		dat = "<B>You have already summoned your apprentice.</B><BR>"
	else
		dat = "<B>Contract of Apprenticeship:</B><BR>"
		dat += "<I>Using this contract, you may summon an apprentice to aid you on your mission.</I><BR>"
		dat += "<I>If you are unable to establish contact with your apprentice, you can feed the contract back to the spellbook to refund your points.</I><BR>"
		dat += "<B>Which school of magic is your apprentice studying?:</B><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_DESTRUCTION]'>Destruction</A><BR>"
		dat += "<I>Your apprentice is skilled in offensive magic. They know Magic Missile and Fireball.</I><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_BLUESPACE]'>Bluespace Manipulation</A><BR>"
		dat += "<I>Your apprentice is able to defy physics, melting through solid objects and travelling great distances in the blink of an eye. They know Teleport and Ethereal Jaunt.</I><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_HEALING]'>Healing</A><BR>"
		dat += "<I>Your apprentice is training to cast spells that will aid your survival. They know Forcewall and Charge and come with a Staff of Healing.</I><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_ROBELESS]'>Robeless</A><BR>"
		dat += "<I>Your apprentice is training to cast spells without their robes. They know Knock and Mindswap.</I><BR>"
	user << browse(dat, "window=radio")
	onclose(user, "radio")
	return

/obj/item/antag_spawner/contract/Topic(href, href_list)
	. = ..()

	if(usr.stat != CONSCIOUS || HAS_TRAIT(usr, TRAIT_HANDS_BLOCKED))
		return
	if(!ishuman(usr))
		return TRUE
	var/mob/living/carbon/human/H = usr

	if(loc == H || (in_range(src, H) && isturf(loc)))
		H.set_machine(src)
		if(href_list["school"])
			if(used)
				to_chat(H, span_warning("You already used this contract!"))
				return
			var/list/candidates = pollCandidatesForMob("Do you want to play as a wizard's [href_list["school"]] apprentice?", ROLE_WIZARD, null, ROLE_WIZARD, 150, src)
			if(LAZYLEN(candidates))
				if(QDELETED(src))
					return
				if(used)
					to_chat(H, span_warning("You already used this contract!"))
					return
				used = TRUE
				var/mob/dead/observer/C = pick(candidates)
				spawn_antag(C.client, get_turf(src), href_list["school"],H.mind)
			else
				to_chat(H, span_warning("Unable to reach your apprentice! You can either attack the spellbook with the contract to refund your points, or wait and try again later."))

/obj/item/antag_spawner/contract/spawn_antag(client/C, turf/T, kind ,datum/mind/user)
	new /obj/effect/particle_effect/smoke(T)
	var/mob/living/carbon/human/M = new/mob/living/carbon/human(T)
	C.prefs.copy_to(M)
	M.key = C.key
	var/datum/mind/app_mind = M.mind

	var/datum/antagonist/wizard/apprentice/app = new()
	app.master = user
	app.school = kind

	var/datum/antagonist/wizard/master_wizard = user.has_antag_datum(/datum/antagonist/wizard)
	if(master_wizard)
		if(!master_wizard.wiz_team)
			master_wizard.create_wiz_team()
		app.wiz_team = master_wizard.wiz_team
		master_wizard.wiz_team.add_member(app_mind)
	app_mind.add_antag_datum(app)
	//TODO Kill these if possible
	app_mind.assigned_role = "Apprentice"
	app_mind.special_role = "apprentice"
	//
	SEND_SOUND(M, sound('sound/effects/magic.ogg'))

///////////BORGS AND OPERATIVES


/obj/item/antag_spawner/nuke_ops
	name = "syndicate operative teleporter"
	desc = "A single-use teleporter designed to quickly reinforce operatives in the field."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"
	var/nukieonly = TRUE
	var/borg_to_spawn
	var/locked = TRUE

/obj/item/antag_spawner/nuke_ops/proc/check_usability(mob/user)
	if(used)
		to_chat(user, span_warning("[src] is out of power!"))
		return FALSE
	if(locked)
		if(!user.mind.has_antag_datum(/datum/antagonist/nukeop,TRUE))
			to_chat(user, span_danger("AUTHENTICATION FAILURE. ACCESS DENIED."))
			return FALSE
	return TRUE


/obj/item/antag_spawner/nuke_ops/attack_self(mob/user)
	if(!(check_usability(user)))
		return

	to_chat(user, span_notice("You activate [src] and wait for confirmation."))
	var/list/nuke_candidates = pollGhostCandidates("Do you want to play as a syndicate [borg_to_spawn ? "[lowertext(borg_to_spawn)] cyborg":"operative"]?", ROLE_OPERATIVE, null, ROLE_OPERATIVE, 150, POLL_IGNORE_SYNDICATE)
	if(LAZYLEN(nuke_candidates))
		if(QDELETED(src) || !check_usability(user))
			return
		used = TRUE
		var/mob/dead/observer/G = pick(nuke_candidates)
		spawn_antag(G.client, get_turf(src), "syndieborg", user.mind)
		do_sparks(4, TRUE, src)
		qdel(src)
	else
		to_chat(user, span_warning("Unable to connect to Syndicate command. Please wait and try again later or use the teleporter on your uplink to get your points refunded."))

/obj/item/antag_spawner/nuke_ops/spawn_antag(client/C, turf/T, kind, datum/mind/user)
	var/mob/living/carbon/human/M = new/mob/living/carbon/human(T)
	C.prefs.copy_to(M)
	M.key = C.key

	var/datum/antagonist/nukeop/new_op = new()
	new_op.send_to_spawnpoint = FALSE
	new_op.nukeop_outfit = /datum/outfit/syndicate/no_crystals

	var/datum/antagonist/nukeop/creator_op = user.has_antag_datum(/datum/antagonist/nukeop,TRUE)
	if(creator_op)
		M.mind.add_antag_datum(new_op,creator_op.nuke_team)
		M.mind.special_role = "Nuclear Operative"

//////SYNDICATE BORG
/obj/item/antag_spawner/nuke_ops/borg_tele
	name = "syndicate cyborg teleporter"
	desc = "A single-use teleporter designed to quickly reinforce operatives in the field."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"

/obj/item/antag_spawner/nuke_ops/borg_tele/assault
	name = "syndicate assault cyborg teleporter"
	borg_to_spawn = "Assault"

/obj/item/antag_spawner/nuke_ops/borg_tele/medical
	name = "syndicate medical teleporter"
	borg_to_spawn = "Medical"

/obj/item/antag_spawner/nuke_ops/borg_tele/medical/unlocked // used for cybersun ERT
	locked = FALSE
	nukieonly = FALSE

/obj/item/antag_spawner/nuke_ops/borg_tele/saboteur
	name = "syndicate saboteur teleporter"

/obj/item/antag_spawner/nuke_ops/borg_tele/commando
	name = "mysterious device"
	desc = "A dusty brick of electronics, wired to some kind of bluespace launch apparatus. A small plastic sticker on the side of the housing reads MODPICK!BRIG@DORPROTOTYPE in hastily-scrawled sharpie."
	borg_to_spawn = "Commando"
	locked = FALSE

/obj/item/antag_spawner/nuke_ops/borg_tele/spawn_antag(client/C, turf/T, kind, datum/mind/user)
	var/mob/living/silicon/robot/R
	var/datum/antagonist/nukeop/creator_op = user.has_antag_datum(/datum/antagonist/nukeop,TRUE)
	if(!creator_op && nukieonly)
		return

	switch(borg_to_spawn)
		if("Medical")
			R = new /mob/living/silicon/robot/modules/syndicate/medical(T)
		if("Saboteur")
			R = new /mob/living/silicon/robot/modules/syndicate/saboteur(T)
		if("Commando")
			R = new /mob/living/silicon/robot/modules/syndicateproto(T)
		else
			R = new /mob/living/silicon/robot/modules/syndicate(T) //Assault borg by default

	var/brainfirstname = pick(GLOB.first_names_male)
	if(prob(50))
		brainfirstname = pick(GLOB.first_names_female)
	var/brainopslastname = pick(GLOB.last_names)
	if(nukieonly)  //the brain inside the syndiborg has the same last name as the other ops.
		if(creator_op.nuke_team.syndicate_name)
			brainopslastname = creator_op.nuke_team.syndicate_name
	var/brainopsname = "[brainfirstname] [brainopslastname]"

	R.mmi.name = "[initial(R.mmi.name)]: [brainopsname]"
	R.mmi.brain.name = "[brainopsname]'s brain"
	R.mmi.brainmob.real_name = brainopsname
	R.mmi.brainmob.name = brainopsname
	R.real_name = R.name

	R.key = C.key

	var/datum/antagonist/nukeop/new_borg = new()
	new_borg.send_to_spawnpoint = FALSE
	if(nukieonly)
		R.mind.add_antag_datum(new_borg,creator_op.nuke_team)
	R.mind.special_role = "Syndicate Cyborg"

///////////SLAUGHTER DEMON

/obj/item/antag_spawner/slaughter_demon //Warning edgiest item in the game
	name = "vial of blood"
	desc = "A magically infused bottle of blood, distilled from countless murder victims. Used in unholy rituals to attract horrifying creatures."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"

	var/shatter_msg = span_notice("You shatter the bottle, no turning back now!")
	var/veil_msg = span_warning("You sense a dark presence lurking just beyond the veil...")
	var/mob/living/demon_type = /mob/living/simple_animal/slaughter
	var/antag_type = /datum/antagonist/slaughter


/obj/item/antag_spawner/slaughter_demon/attack_self(mob/user)
	if(used)
		return
	var/list/candidates = pollCandidatesForMob("Do you want to play as a [initial(demon_type.name)]?", ROLE_ALIEN, null, ROLE_ALIEN, 50, src)
	if(LAZYLEN(candidates))
		if(used || QDELETED(src))
			return
		used = TRUE
		var/mob/dead/observer/C = pick(candidates)
		spawn_antag(C.client, get_turf(src), initial(demon_type.name),user.mind)
		to_chat(user, shatter_msg)
		to_chat(user, veil_msg)
		playsound(user.loc, 'sound/effects/glassbr1.ogg', 100, TRUE)
		qdel(src)
	else
		to_chat(user, span_warning("You can't seem to work up the nerve to shatter the bottle! Perhaps you should try again later."))


/obj/item/antag_spawner/slaughter_demon/spawn_antag(client/C, turf/T, kind = "", datum/mind/user)
	var/obj/effect/dummy/phased_mob/slaughter/holder = new /obj/effect/dummy/phased_mob/slaughter(T)
	var/mob/living/simple_animal/slaughter/S = new demon_type(holder)
	S.holder = holder
	S.key = C.key
	S.mind.assigned_role = S.name
	S.mind.special_role = S.name
	S.mind.add_antag_datum(antag_type)
	to_chat(S, S.playstyle_string)
	to_chat(S, "<B>You are currently not currently in the same plane of existence as the station. \
	Ctrl+Click a blood pool to manifest.</B>")

/obj/item/antag_spawner/syndi_borer
	name = "syndicate brain-slug container"
	desc = "Releases a modified cortical borer to assist the user."
	icon = 'icons/obj/chemical/hypovial.dmi'
	icon_state = "hypoviallarge-b"
	var/polling = FALSE

/obj/item/antag_spawner/syndi_borer/spawn_antag(client/C, turf/T, mob/owner)
	var/mob/living/simple_animal/borer/syndi_borer/B = new /mob/living/simple_animal/borer/syndi_borer(T)

	B.key = C.key
	if (owner)
		B.owner = owner
		B.faction = B.faction | owner.faction.Copy()

		B.mind.assigned_role = B.name
		B.mind.special_role = B.name
		SSticker.mode.traitors += B.mind
		var/datum/objective/syndi_borer/new_objective
		new_objective = new /datum/objective/syndi_borer
		new_objective.owner = B.mind
		new_objective.target = owner.mind
		new_objective.explanation_text = "You are a modified cortical borer. You obey [owner.real_name] and must assist them in completing their objectives."
		B.mind.objectives += new_objective

		to_chat(B, "<B>You are awake at last! Seek out whoever released you and aid them as best you can!</B>")
		if(new_objective)
			to_chat(B, "<B>Objective #[1]</B>: [new_objective.explanation_text]")

/obj/item/antag_spawner/syndi_borer/proc/check_usability(mob/user)
	if(used)
		to_chat(user, span_warning("[src] appears to be empty!"))
		return 0
	if(polling == TRUE)
		to_chat(user, span_warning("[src] is busy activating!"))
		return 0
	return 1

/obj/item/antag_spawner/syndi_borer/attack_self(mob/user)
	if(!(check_usability(user)))
		return
	polling = TRUE
	var/list/borer_candidates = pollCandidatesForMob("Do you want to play as a syndicate cortical borer?", ROLE_BORER, null, ROLE_BORER, 150, src)
	if(borer_candidates.len)
		polling = FALSE
		if(!(check_usability(user)))
			return
		used = 1
		var/mob/dead/observer/theghost = pick(borer_candidates)
		spawn_antag(theghost.client, get_turf(src), user)
		var/datum/effect_system/spark_spread/S = new /datum/effect_system/spark_spread
		S.set_up(4, 1, src)
		S.start()
		qdel(src)
	else
		polling = FALSE
		to_chat(user, span_warning("Unable to connect to release specimen. Please wait and try again later or use the container on your uplink to get your points refunded."))
