/datum/job
	/// The name of the job
	var/title = "NOPE"
	/// The outfit applied when a player joins as this job
	var/datum/outfit/job_outfit
	/// The amount of hours of general playtime required before you can play this role
	var/exp_requirements = 0
	/// The subpage of the wiki that deals with this job, e.g. "Captain" links to "https://www.wiki_site.com/wiki/Captain"
	var/wiki_page = "Jobs"

/datum/job/New(new_title, datum/outfit/new_outfit, new_exp_requirements, new_wiki_page)
	title = new_title
	job_outfit = new_outfit
	exp_requirements = new_exp_requirements
	wiki_page = new_wiki_page

//Don't override this unless the job transforms into a non-human (Silicons do this for example)
/datum/job/proc/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, latejoin = FALSE, datum/outfit/outfit_override = null, client/preference_source)
	if(!H)
		return FALSE
	if(CONFIG_GET(flag/enforce_human_authority) && (title in GLOB.command_positions))
		if(H.dna.species.id != "human")
			H.set_species(/datum/species/human)
			H.apply_pref_name("human", preference_source)
	if(!visualsOnly)
		var/datum/bank_account/bank_account = new(H.real_name, src)
		bank_account.payday(STARTING_PAYCHECKS, TRUE)
		H.account_id = bank_account.account_id

	//Equip the rest of the gear
	H.dna.species.before_equip_job(src, H, visualsOnly)

	// WS Edit - Alt-Job Titles
	if(outfit && preference_source?.prefs?.alt_titles_preferences[title] && !outfit_override)
		var/outfitholder = "[outfit]/[ckey(preference_source.prefs.alt_titles_preferences[title])]"
		if(text2path(outfitholder) || !outfitholder)
			outfit_override = text2path(outfitholder)
	if(outfit_override || outfit)
		H.equipOutfit(outfit_override ? outfit_override : outfit, visualsOnly, preference_source)
	// WS Edit - Alt-Job Titles

	H.dna.species.after_equip_job(src, H, visualsOnly)

	if(!visualsOnly && announce)
		announce(H)
