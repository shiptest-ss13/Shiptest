/datum/ert
	var/mobtype = /mob/living/carbon/human
	var/team = /datum/team/ert
	// opens a special subtype of blastdoor. also a legacy setting that will probably not work with multiple outposts
	var/opendoors = FALSE
	var/leader_role = /datum/antagonist/ert/independent
	// makes members spawn as humans. mostly a legacy setting but maybe you'll find it useful
	var/enforce_human = FALSE
	// list of possible roles to be assigned to ERT members. if it has a value (e.g. datum/antagonist/myspecialguy = 1), the role will be limited
	var/roles = list(/datum/antagonist/ert/independent)
	// this will appear in the end of round report and the antagonist team list
	var/rename_team = "Emergency Response Team"
	// this will be shown to the ERT members to be put in their memory
	var/mission = "Make effective use of your tools."
	// determines the size of the team. make sure there's enough size for all the special roles you may add
	var/teamsize = 5
	// this will be shown to ghosts as "Would you like to be considered for [polldesc]?"
	var/polldesc = "an emergency response team"
	/// If TRUE, gives the team members "[role] [random last name]" style names
	var/random_names = FALSE
	/// If TRUE, special slots (that are not the leader) will use a predefined limit
	var/limit_slots = TRUE
	/// If TRUE, the admin who created the response team will be spawned in the briefing room (or in the shuttle) in their preferred briefing outfit (assuming they're a ghost)
	var/spawn_admin = FALSE
	/// If TRUE, we try and pick one of the most experienced players who volunteered to fill the leader slot
	var/leader_experience = TRUE
	/// A custom map template to spawn the ERT at. If use_custom_shuttle is FALSE, the ERT will spawn on foot. By default, a Kunai-Class.
	var/datum/map_template/ert_template = /datum/map_template/shuttle/subshuttles/kunai
	/// If we should actually _use_ the ert_template custom shuttle
	var/use_custom_shuttle = TRUE
	/// If TRUE, the ERT will spawn at the outpost. If use_custom_shuttle is also TRUE, the shuttle will be docked at the outpost
	var/spawn_at_outpost = TRUE
	/// should we give the ERT access to the outpost
	var/outpost_access = FALSE

/datum/ert/New()
	. = ..()
	if(!polldesc)
		polldesc = "uhm uhh uhmmmm"
