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

// ********************************************************************
// ** Nanotrasen **
// ********************************************************************

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
	outfit = /datum/outfit/job/nanotrasen/ert/lp
	role = "Security Specialist"

/datum/antagonist/ert/lp/medic
	name = "Loss Prevention Medical Specialist"
	outfit = /datum/outfit/job/nanotrasen/ert/lp/medic
	role = "Medical Specialist"

/datum/antagonist/ert/lp/engineer
	name = "Loss Prevention Engineering Specialist"
	outfit = /datum/outfit/job/nanotrasen/ert/lp/engineer
	role = "Engineering Specialist"

/datum/antagonist/ert/lp/lieutenant
	name = "Loss Prevention Lieutenant"
	leader = TRUE
	outfit = /datum/outfit/job/nanotrasen/ert/lp/lieutenant
	role = "Lieutenant"

// ********************************************************************
// ** Inteq **
// ********************************************************************

/datum/antagonist/ert/inteq
	name = "Inteq Mercenary"
	outfit = /datum/outfit/job/inteq/security
	random_names = TRUE
	role = "Enforcer"


/datum/antagonist/ert/inteq/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You're one of the many mercenaries under the Inteq Risk Management Group sent to [station_name()].<BR>"
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
	outfit = /datum/outfit/job/inteq/captain
	role = "Vanguard"

// ********************************************************************
// ** SolGov **
// ********************************************************************
/datum/antagonist/ert/solgov
	name = "SolGov Sonnensöldner"
	outfit = /datum/outfit/job/solgov/ert
	random_names = FALSE
	role = "Sonnensöldner"

/datum/antagonist/ert/official/solgov
	name = "SolGov Inspector"
	outfit = /datum/outfit/job/solgov/ert/inspector
	role = "Solarian Inspector"

/datum/antagonist/ert/official/solgov/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a Solarian Inspector.</font></B>")
	if (ert_team)
		to_chat(owner, "The Department of Administrative Affairs is sending you to [station_name()] with the task: [ert_team.mission.explanation_text]")
	else
		to_chat(owner, "The Department of Administrative Affairs is sending you to [station_name()] with the task: [mission.explanation_text]")


// ********************************************************************
// ** Minutemen **
// ********************************************************************

/datum/antagonist/ert/minutemen
	name = "Minutemen Infantry"
	outfit = /datum/outfit/job/minutemen/ert
	role = "Minuteman"

/datum/antagonist/ert/minutemen/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You stand shoulder to shoulder with your fellow colonists in the Colonial Minutemen within [station_name()].<BR>"
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
	outfit = /datum/outfit/job/minutemen/ert/leader
	role = "Sergeant"

/datum/antagonist/ert/minutemen/bard
	name = "BARD Infantry"
	outfit = /datum/outfit/job/minutemen/ert/bard
	role = "Minuteman"

/datum/antagonist/ert/minutemen/bard/leader
	name = "BARD Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/minutemen/ert/bard/leader
	role = "Sergeant"

/datum/antagonist/ert/minutemen/riot
	name = "Riot Officer"
	outfit = /datum/outfit/job/minutemen/ert/riot
	role = "Minuteman"

/datum/antagonist/ert/minutemen/riot/leader
	name = "Riot Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/minutemen/ert/riot/leader
	role = "Sergeant"

/datum/antagonist/ert/official/minutemen
	name = "GOLD Inspector"
	outfit = /datum/outfit/job/minutemen/ert/inspector
	role = "Lieutenant"

/datum/antagonist/ert/official/minutemen/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the GOLD Inspector.</font></B>")
	if (ert_team)
		to_chat(owner, "You are part of The Galactic Optimum Labor Division, a division of the Colonial League. Your task: [ert_team.mission.explanation_text]")
	else
		to_chat(owner, "You are part of The Galactic Optimum Labor Division, a division of the Colonial League. Your task: [ert_team.mission.explanation_text]")

/datum/antagonist/ert/minutemen/piratehunters
	name = "Pirate Hunter"
	outfit = /datum/outfit/job/minutemen/ert/pirate_hunter
	role = "Minuteman"

/datum/antagonist/ert/minutemen/piratehunters/leader
	name = "Pirate Hunter Leader"
	leader = TRUE
	outfit = /datum/outfit/job/minutemen/ert/pirate_hunter/leader
	role = "Sergeant"

// ********************************************************************
// ** Syndicate **
// ********************************************************************

/datum/antagonist/ert/syndicate
	name = "Syndicate Infantry"
	outfit = /datum/outfit/job/syndicate/ert
	role = "Squaddie"

/datum/antagonist/ert/syndicate/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You are but another member of the Syndicate sent to [station_name()].<BR>"
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
	outfit = /datum/outfit/job/syndicate/ert/leader
	role = "Sergeant"

/datum/antagonist/ert/syndicate/gorlex
	name = "2nd Battlegroup Trooper"
	outfit = /datum/outfit/job/syndicate/ert/gorlex
	role = "Trooper"

/datum/antagonist/ert/syndicate/gorlex/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You're a soldier of the 2nd Battlegroup, sometimes known as Gorlex Loyalists, sent to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergeant."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/gorlex/pointman
	name = "2nd Battlegroup Shotgunner"
	outfit = /datum/outfit/job/syndicate/ert/gorlex/pointman
	role = "Pointman"

/datum/antagonist/ert/syndicate/gorlex/medic
	name = "2nd Battlegroup Medic"
	outfit = /datum/outfit/job/syndicate/ert/gorlex/medic
	role = "Medic"

/datum/antagonist/ert/syndicate/gorlex/sniper
	name = "2nd Battlegroup Sniper"
	outfit = /datum/outfit/job/syndicate/ert/gorlex/sniper
	role = "Marksman"

/datum/antagonist/ert/syndicate/gorlex/leader
	name = "2nd Battlegroup Sergeant"
	leader = TRUE
	outfit = /datum/outfit/job/syndicate/ert/gorlex/leader
	role = "Sergeant"

/datum/antagonist/ert/syndicate/cybersun
	name = "Cybersun Commando"
	outfit = /datum/outfit/job/syndicate/ert/cybersun
	role = "Operative"

/datum/antagonist/ert/syndicate/cybersun/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You are one of the commandos enlisted in Cybersun Industries, deployed to [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the completion of your objectives."
	else
		missiondesc += "Follow orders given to you by your Sergeant."
	if(prob(50) && !leader)
		missiondesc += "<BR>In addition to your contract with Cybersun, you are also a <B>Gorlex Hardliner</B>. You do not <I>like</I> Cybersun, but you work with them regardless."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/cybersun/leader
	name = "Cybersun Commando Leader"
	leader = TRUE
	outfit = /datum/outfit/job/syndicate/ert/cybersun/leader
	role = "Lead Operative"

/datum/antagonist/ert/syndicate/cybersun/medic
	name = "Cybersun Paramedic"
	outfit = /datum/outfit/job/syndicate/ert/cybersun/medic
	role = "Medical Technician"

/datum/antagonist/ert/syndicate/cybersun/medic/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You are one of the many trained paramedics of Cybersun's Medical Intervention program, sent with your team to [station_name()] to aid Cybersun clients in distress.<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to ensure the safety of Cybersun's clientele.<BR>"
	else
		missiondesc += "Follow orders given to you by your Lead Technician. Assist Cybersun clients.<BR>"

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/syndicate/cybersun/medic/leader
	name = "Cybersun Lead Paramedic"
	leader = TRUE
	outfit = /datum/outfit/job/syndicate/ert/cybersun/medic/leader
	role = "Lead Medical Technician"

/datum/antagonist/ert/official/syndicate
	name = "Syndicate Inspector"
	outfit = /datum/outfit/job/syndicate/ert/inspector
	role = "Syndicate Inspector"

/datum/antagonist/ert/official/solgov/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a Syndicate Inspector.</font></B>")
	if (ert_team)
		to_chat(owner, "The Syndicate Coalition is sending you to [station_name()] with the task: [ert_team.mission.explanation_text]")
	else
		to_chat(owner, "The Syndicate Coalition is sending you to [station_name()] with the task: [mission.explanation_text]")

// ********************************************************************
// ** Frontiersmen **
// ********************************************************************

/datum/antagonist/ert/frontier
	name = "Frontiersmen Pirate"
	outfit = /datum/outfit/job/frontiersmen/ert
	role = "Grunt"

/datum/antagonist/ert/frontier/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You are one of the ruthless, sadistic pirates in the Frontiersmen pirate fleet, stationed in [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to complete your objectives."
	else
		missiondesc += "Follow orders given to you by your Officer."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/frontier/random
	outfit = /datum/outfit/job/frontiersmen/ert/random

/datum/antagonist/ert/frontier/leader
	name = "Frontiersmen Officer"
	outfit = /datum/outfit/job/frontiersmen/ert/leader
	role = "Officer"

/datum/antagonist/ert/frontier/medic
	name = "Frontiersmen Medic"
	outfit = /datum/outfit/job/frontiersmen/ert/medic
	role = "Stretcher-Bearer"

/datum/antagonist/ert/frontier/engineer
	name = "Frontiersmen Engineer"
	outfit = /datum/outfit/job/frontiersmen/ert/engineer
	role = "Sapper"

// ********************************************************************
// ** independent **
// ********************************************************************

/datum/antagonist/ert/independent
	name = "Independent Security Officer"
	outfit = /datum/outfit/job/independent/ert
	role = "Security Officer"

/datum/antagonist/ert/independent/greet()
	to_chat(owner, "<B><font size=3 color=red>You are the [name].</font></B>")
	var/missiondesc = "You are one of the many Independent contractors, workers and students on [station_name()].<BR>"
	if(leader) //If Squad Leader
		missiondesc += "Lead your team to complete your objectives."
	else
		missiondesc += "Follow orders given to you by your leader."

	missiondesc += "<BR><B>Your Mission</B>: [ert_team.mission.explanation_text]"
	to_chat(owner,missiondesc)

/datum/antagonist/ert/independent/emt
	name = "Independent Medical Technician"
	outfit = /datum/outfit/job/independent/ert/emt
	role = "Paramedic"

/datum/antagonist/ert/independent/firefighter
	name = "Independent Firefighter"
	outfit = /datum/outfit/job/independent/ert/firefighter
	role = "Firefighter"

/datum/antagonist/ert/independent/firefighter/medic
	name = "Independent Firefighter Paramedic"
	outfit = /datum/outfit/job/independent/ert/firefighter/medic
	role = "Paramedic"

/datum/antagonist/ert/independent/firefighter/leader
	name = "Independent Firefighter Group Captain"
	outfit = /datum/outfit/job/independent/ert/firefighter/leader
	role = "Group Captain"

/datum/antagonist/ert/independent/technician
	name = "Independent Technician"
	outfit = /datum/outfit/job/independent/ert/technician
	role = "Technician"
