//Both ERT and DS are handled by the same datums since they mostly differ in equipment in objective.
/datum/team/ert
	name = "Emergency Response Team"
	var/datum/objective/mission //main mission

/datum/antagonist/ert
	name = "Emergency Response Officer"
	var/datum/team/ert/ert_team
	var/leader = FALSE
	var/datum/outfit/outfit = /datum/outfit/centcom/ert/security
	var/role = "Security Officer"
	var/list/name_source
	var/random_names = TRUE
	var/deathsquad = FALSE
	var/equip_ert = TRUE
	var/forge_objectives_for_ert = TRUE
	can_elimination_hijack = ELIMINATION_PREVENT
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	antag_moodlet = /datum/mood_event/focused

/datum/antagonist/ert/on_gain()
	if(random_names)
		update_name()
	if(forge_objectives_for_ert)
		forge_objectives()
	if(equip_ert)
		equipERT()
	. = ..()

/datum/antagonist/ert/create_team(datum/team/ert/new_team)
	if(istype(new_team))
		ert_team = new_team

/datum/antagonist/ert/proc/forge_objectives()
	if(ert_team)
		objectives |= ert_team.objectives

/datum/antagonist/ert/proc/equipERT()
	var/mob/living/carbon/human/H = owner.current
	if(!istype(H))
		return
	H.equipOutfit(outfit)

/datum/antagonist/ert/get_team()
	return ert_team

/datum/antagonist/ert/New()
	. = ..()
	name_source = GLOB.last_names

/datum/antagonist/ert/proc/update_name()
	owner.current.fully_replace_character_name(owner.current.real_name,"[role] [pick(name_source)]")

/datum/antagonist/ert/greet()
	if(!ert_team)
		return

	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")

	var/missiondesc = "Your team is being sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += " Lead your team to ensure the completion of your objectives."
	else
		missiondesc += " Follow orders given to you by your squad leader."
	if(deathsquad)
		missiondesc += "Leave no witnesses."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

// Nanotrasen

// Official
/datum/antagonist/ert/official
	name = "CentCom Official"
	show_name_in_check_antagonists = TRUE
	var/datum/objective/mission
	role = "Inspector"
	random_names = FALSE
	outfit = /datum/outfit/centcom/centcom_official

/datum/antagonist/ert/official/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a CentCom Official.</font></B>")
	if (ert_team)
		to_chat(owner, "Central Command is sending you to [station_name()] with the task: [ert_team.mission.explanation_text]")
	else
		to_chat(owner, "Central Command is sending you to [station_name()] with the task: [mission.explanation_text]")

/datum/antagonist/ert/official/forge_objectives()
	if (ert_team)
		return ..()
	if(mission)
		return
	var/datum/objective/missionobj = new ()
	missionobj.owner = owner
	missionobj.explanation_text = "Conduct a routine performance review of [station_name()]'s vessels."
	missionobj.completed = TRUE
	mission = missionobj
	objectives |= mission

// Standard ERT

/datum/antagonist/ert/security // kinda handled by the base template but here for completion

/datum/antagonist/ert/security/red
	outfit = /datum/outfit/centcom/ert/security/alert

/datum/antagonist/ert/engineer
	role = "Engineer"
	outfit = /datum/outfit/centcom/ert/engineer

/datum/antagonist/ert/engineer/red
	outfit = /datum/outfit/centcom/ert/engineer/alert

/datum/antagonist/ert/medic
	role = "Medical Officer"
	outfit = /datum/outfit/centcom/ert/medic

/datum/antagonist/ert/medic/red
	outfit = /datum/outfit/centcom/ert/medic/alert

/datum/antagonist/ert/commander
	role = "Commander"
	outfit = /datum/outfit/centcom/ert/commander

/datum/antagonist/ert/commander/red
	outfit = /datum/outfit/centcom/ert/commander/alert

// Deathsquad

/datum/antagonist/ert/deathsquad
	name = "Deathsquad Trooper"
	outfit = /datum/outfit/centcom/death_commando
	role = "Trooper"
	deathsquad = TRUE

/datum/antagonist/ert/deathsquad/leader
	name = "Deathsquad Officer"
	outfit = /datum/outfit/centcom/death_commando
	role = "Officer"

/datum/antagonist/ert/deathsquad/New()
	. = ..()
	name_source = GLOB.commando_names

/datum/antagonist/ert/deathsquad/apply_innate_effects(mob/living/mob_override)
	ADD_TRAIT(owner, TRAIT_DISK_VERIFIER, DEATHSQUAD_TRAIT)

/datum/antagonist/ert/deathsquad/remove_innate_effects(mob/living/mob_override)
	REMOVE_TRAIT(owner, TRAIT_DISK_VERIFIER, DEATHSQUAD_TRAIT)

// Janitor

/datum/antagonist/ert/janitor
	role = "Janitor"
	outfit = /datum/outfit/centcom/ert/janitor

/datum/antagonist/ert/janitor/heavy
	role = "Heavy Duty Janitor"
	outfit = /datum/outfit/centcom/ert/janitor/heavy

// Intern

/datum/antagonist/ert/intern
	name = "CentCom Intern"
	outfit = /datum/outfit/centcom/centcom_intern
	random_names = FALSE
	role = "Intern"

/datum/antagonist/ert/intern/leader
	name = "CentCom Head Intern"
	outfit = /datum/outfit/centcom/centcom_intern/leader
	role = "Head Intern"

/datum/antagonist/ert/intern/unarmed
	outfit = /datum/outfit/centcom/centcom_intern/unarmed

/datum/antagonist/ert/intern/leader/unarmed
	outfit = /datum/outfit/centcom/centcom_intern/leader/unarmed

// Marine

/datum/antagonist/ert/marine
	name = "Marine Commander"
	outfit = /datum/outfit/centcom/ert/marine
	role = "Commander"

/datum/antagonist/ert/marine/security
	name = "Marine Heavy"
	outfit = /datum/outfit/centcom/ert/marine/security
	role = "Trooper"

/datum/antagonist/ert/marine/engineer
	name = "Marine Engineer"
	outfit = /datum/outfit/centcom/ert/marine/engineer
	role = "Engineer"

/datum/antagonist/ert/marine/medic
	name = "Marine Medic"
	outfit = /datum/outfit/centcom/ert/marine/medic
	role = "Medical Officer"

// Loss Prevention

/datum/antagonist/ert/lp
	name = "Loss Prevention Security Specialist"
	outfit = /datum/outfit/centcom/ert/lp
	role = "Security Specialist"

/datum/antagonist/ert/lp/medic
	name = "Loss Prevention Medical Specialist"
	outfit = /datum/outfit/centcom/ert/lp/medic
	role = "Medical Specialist"

/datum/antagonist/ert/lp/engineer
	name = "Loss Prevention Engineering Specialist"
	outfit = /datum/outfit/centcom/ert/lp/engineer
	role = "Engineering Specialist"

/datum/antagonist/ert/lp/lieutenant
	name = "Loss Prevention Lieutenant"
	leader = TRUE
	outfit = /datum/outfit/centcom/ert/lp/lieutenant
	role = "Lieutenant"

// ********************************************************************
// ** Inteq **
// ********************************************************************

/datum/antagonist/ert/inteq
	name = "Inteq Mercenary"
	outfit = /datum/outfit/job/security/inteq
	random_names = TRUE
	role = "Enforcer"


/datum/antagonist/ert/inteq/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "As part of Inteq Risk Management, you have been sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your squadron to ensure the completion of your contract."
	else
		missiondesc += "Follow orders given to you by your Vanguard."
	if(deathsquad)
		missiondesc += "Leave no witnesses."

	missiondesc += "<BR><B>Contract Terms</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/inteq/leader
	name = "Inteq Mercenary Leader"
	outfit = /datum/outfit/job/captain/inteq
	role = "Vanguard"

// ********************************************************************
// ** SolGov **
// ********************************************************************
/datum/antagonist/ert/solgov
	name = "SolGov Sonnensöldner"
	outfit = /datum/outfit/centcom/ert/solgov
	random_names = FALSE
	role = "Sonnensöldner"

/datum/antagonist/ert/solgov/inspector
	name = "SolGov Inspector"
	outfit = /datum/outfit/centcom/ert/solgov/inspector
	role = "Solarian Inspector"

/datum/antagonist/ert/official/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a Solarian Inspector.</font></B>")
	if (ert_team)
		to_chat(owner, "The Department of Administrative Affairs is sending you to [station_name()] with the task: [ert_team.mission.explanation_text]")
	else
		to_chat(owner, "The Department of Administrative Affairs is sending you to [station_name()] with the task: [mission.explanation_text]")

/datum/antagonist/ert/official/forge_objectives()
	if (ert_team)
		return ..()
	if(mission)
		return
	var/datum/objective/missionobj = new ()
	missionobj.owner = owner
	missionobj.explanation_text = "Conduct a routine performance review of [station_name()]'s vessels."
	missionobj.completed = TRUE
	mission = missionobj
	objectives |= mission

// ********************************************************************
// ** Minutemen **
// ********************************************************************

/datum/antagonist/ert/minutemen
	name = "Minutemen Infantry"
	outfit = /datum/outfit/centcom/ert/minutemen
	role = "Minuteman"

/datum/antagonist/ert/minutemen/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "As part of the Colonial Minutemen, you have been sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergent."
	if(deathsquad)
		missiondesc += "Leave no witnesses."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/minutemen/leader
	name = "Minutemen Leader"
	leader = TRUE
	outfit = /datum/outfit/centcom/ert/minutemen/leader
	role = "Sargent"

/datum/antagonist/ert/minutemen/bard
	name = "BARD Infantry"
	outfit = /datum/outfit/centcom/ert/minutemen/bard
	role = "Minuteman"

/datum/antagonist/ert/minutemen/bard/leader
	name = "BARD Leader"
	leader = TRUE
	outfit = /datum/outfit/centcom/ert/minutemen/bard/leader
	role = "Sargent"

/datum/antagonist/ert/minutemen/riot
	name = "Riot Officer"
	outfit = /datum/outfit/centcom/ert/minutemen/riot
	role = "Minuteman"

/datum/antagonist/ert/minutemen/riot/leader
	name = "Riot Sargent"
	leader = TRUE
	outfit = /datum/outfit/centcom/ert/minutemen/riot/leader
	role = "Sargent"

/datum/antagonist/ert/minutemen/gold_irs
	name = "GOLD Collector"
	outfit = /datum/outfit/centcom/ert/minutemen/gold_irs
	role = "Lieutenant"

/datum/antagonist/ert/minutemen/piratehunters
	name = "Pirate Hunter"
	outfit = /datum/outfit/centcom/ert/minutemen/piratehunters
	role = "Minuteman"

/datum/antagonist/ert/minutemen/piratehunters/leader
	name = "Pirate Hunter Leader"
	leader = TRUE
	outfit = /datum/outfit/centcom/ert/minutemen/piratehunters/leader
	role = "Sergeant"

// ********************************************************************
// ** Syndicate **
// ********************************************************************

/datum/antagonist/ert/syndicate
	name = "Syndicate Infantry"
	outfit = /datum/outfit/centcom/ert/syndicate
	role = "Squaddie"

/datum/antagonist/ert/syndicate/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "As part of the Syndicate Coalition, you have been sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergeant."
	if(deathsquad)
		missiondesc += "Leave no witnesses."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/leader
	name = "Syndicate Sergeant"
	leader = TRUE
	outfit = /datum/outfit/centcom/ert/syndicate/leader
	role = "Sergeant"

/datum/antagonist/ert/syndicate/gorlex
	name = "Gorlex Trooper"
	outfit = /datum/outfit/centcom/ert/syndicate/gorlex
	role = "Trooper"

/datum/antagonist/ert/syndicate/gorlex/leader
	name = "Gorlex Sergeant"
	leader = TRUE
	outfit = /datum/outfit/centcom/ert/syndicate/gorlex/leader
	role = "Sergeant"

/datum/antagonist/ert/syndicate/cybersun
	name = "Cybersun Commando"
	outfit = /datum/outfit/centcom/ert/syndicate/cybersun
	role = "Operative"

/datum/antagonist/ert/syndicate/cybersun/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "As part of Cybersun enterprises, you have been sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergeant."
	if(prob(50) && !leader)
		missiondesc += "In addition to your contract with Cybersun, you are also a <B>Gorlex Hardliner</B>. You do not <I>like</I> Cybersun, but you work with them regardless."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/cybersun/leader
	name = "Cybersun Commando Leader"
	leader = TRUE
	outfit = /datum/outfit/centcom/ert/syndicate/cybersun/leader
	role = "Lead Operative"

/datum/antagonist/ert/syndicate/cybersun/medic
	name = "Cybersun Paramedic"
	outfit = /datum/outfit/centcom/ert/syndicate/cybersun/medic
	role = "Medical Technician"

/datum/antagonist/ert/syndicate/cybersun/medic/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "As part of Cybersun's Medical Intervention program, you have been sent to [station_name()] to aid Cybersun clients in distress.<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the safety of Cybersun's clientele.<BR>"
	else
		missiondesc += "Follow orders given to you by your Lead Technician. Assist Cybersun clients.<BR>"

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/cybersun/medic/leader
	name = "Cybersun Lead Paramedic"
	leader = TRUE
	outfit = /datum/outfit/centcom/ert/syndicate/cybersun/medic/leader
	role = "Lead Medical Technician"

// ********************************************************************
// ** Frontiersmen **
// ********************************************************************

/datum/antagonist/ert/frontier
	name = "Frontiersmen Pirate"
	outfit = /datum/outfit/job/assistant/frontiersmen
	role = "Buccaneer"

/datum/antagonist/ert/frontier/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You have been sent on a mission by the Frontiersmen to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to complete your objectives."
	else
		missiondesc += "Follow orders given to you by your Officer."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/frontier/leader
	name = "Frontiersmen Officer"
	outfit = /datum/outfit/job/head_of_personnel/frontiersmen
	role = "Officer"

/datum/antagonist/ert/frontier/medic
	name = "Frontiersmen Medic"
	outfit = /datum/outfit/job/doctor/frontiersmen
	role = "Medic"

/datum/antagonist/ert/frontier/engineer
	name = "Frontiersmen Engineer"
	outfit = /datum/outfit/job/engineer/independent/frontiersmen
	role = "Carpenter"
