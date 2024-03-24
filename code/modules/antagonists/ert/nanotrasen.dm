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
	outfit = /datum/outfit/job/nanotrasen/security/ert/lp
	role = "Security Specialist"

/datum/antagonist/ert/lp/medic
	name = "Loss Prevention Medical Specialist"
	outfit = /datum/outfit/job/nanotrasen/security/ert/lp/medic
	role = "Medical Specialist"

/datum/antagonist/ert/lp/engineer
	name = "Loss Prevention Engineering Specialist"
	outfit = /datum/outfit/job/nanotrasen/security/ert/lp/engineer
	role = "Engineering Specialist"

/datum/antagonist/ert/lp/lieutenant
	name = "Loss Prevention Lieutenant"
	leader = TRUE
	outfit = /datum/outfit/job/nanotrasen/security/ert/lp/lieutenant
	role = "Lieutenant"
