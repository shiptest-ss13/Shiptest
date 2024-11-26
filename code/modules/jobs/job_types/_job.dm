/datum/job
	///The name of the job , used for preferences, bans and more. Make sure you know what you're doing before changing this.
	var/name = "NOPE"

	///Basically determines whether or not more of the job can be opened.
	var/officer = FALSE

	///The outfit this job will recieve upon joining.
	var/datum/outfit/job/outfit = null

	//Job access. The use of minimal_access or access is determined by a config setting: config.jobs_have_minimal_access
	var/list/minimal_access = list()		//Useful for servers which prefer to only have access given to the places a job absolutely needs (Larger server population)
	var/list/access = list()				//Useful for servers which either have fewer players, so each person needs to fill more than one role, or servers which like to give more access, so players can't hide forever in their super secure departments (I'm looking at you, chemistry!)

	//Bitflags for the job
	var/auto_deadmin_role_flags = NONE

	//If you have the use_age_restriction_for_jobs config option enabled and the database set up, this option will add a requirement for players to be at least minimal_player_age days old. (meaning they first signed in at least that many days before.)
	var/minimal_player_age = 0

	/// A link to the relevant wiki related to the job. Ex: "Space_law" would link to wiki.blah/Space_law
	var/wiki_page = ""

	var/list/mind_traits // Traits added to the mind of the mob assigned this job

	var/display_order = JOB_DISPLAY_ORDER_DEFAULT

	///Levels unlocked at roundstart in physiology
	var/list/roundstart_experience

/datum/job/New(new_name, datum/outfit/new_outfit)
	if(new_name)
		name = new_name
		outfit = new_outfit
		register()

/datum/job/proc/register()
	GLOB.occupations += src
	if(name in GLOB.name_occupations)
		return

	GLOB.name_occupations[name] = src

//Only override this proc
//H is usually a human unless an /equip override transformed it
//do actions on H but send messages to M as the key may not have been transferred_yet
/datum/job/proc/after_spawn(mob/living/H, mob/M)
	//do actions on H but send messages to M as the key may not have been transferred_yet
	if(mind_traits)
		for(var/t in mind_traits)
			ADD_TRAIT(H.mind, t, JOB_TRAIT)
	if(roundstart_experience && ishuman(H))
		var/mob/living/carbon/human/experiencer = H
		for(var/i in roundstart_experience)
			experiencer.mind.adjust_experience(i, roundstart_experience[i], TRUE)

	if(!iscarbon(H))
		return
	var/mob/living/carbon/spawnee = H
	if(M.client && (M.client.prefs.equipped_gear && length(M.client.prefs.equipped_gear)))
		var/obj/item/storage/box/loadout_dumper = new()
		for(var/gear in M.client.prefs.equipped_gear)
			var/datum/gear/new_gear = GLOB.gear_datums[gear]
			new_gear.spawn_item(loadout_dumper, spawnee)
		var/datum/component/storage/back_storage = spawnee.back.GetComponent(/datum/component/storage)
		if(back_storage)
			back_storage.handle_item_insertion(loadout_dumper, TRUE)
		else if(!spawnee.put_in_hands(loadout_dumper, TRUE))
			to_chat(spawnee, "Unable to place loadout box.")

/datum/job/proc/override_latejoin_spawn(mob/living/carbon/human/H)		//Return TRUE to force latejoining to not automatically place the person in latejoin shuttle/whatever.
	return FALSE

//Used for a special check of whether to allow a client to latejoin as this job.
/datum/job/proc/special_check_latejoin(client/C)
	return TRUE

//Gives the player the stuff he should have with his rank
/datum/job/proc/EquipRank(mob/living/living_mob, datum/overmap/ship/controlled/ship)
	living_mob.job = name

	SEND_SIGNAL(living_mob, COMSIG_JOB_RECEIVED, living_mob.job)

	if(living_mob.mind)
		living_mob.mind.assigned_role = name

	to_chat(living_mob, "<b>You are the [name].</b>")

	var/new_mob = equip(living_mob, null, null, null, living_mob.client)//silicons override this proc to return a mob
	if(ismob(new_mob))
		living_mob = new_mob

	if(living_mob.client.holder)
		if(CONFIG_GET(flag/auto_deadmin_players) || (living_mob.client.prefs?.toggles & DEADMIN_ALWAYS))
			living_mob.client.holder.auto_deadmin()

	radio_help_message(living_mob)
	//WS Begin - Wikilinks
	if(wiki_page)
		to_chat(living_mob, "<span class='notice'><a href=[CONFIG_GET(string/wikiurl)]/[wiki_page]>Wiki Page</a></span>")
	//WS End

	var/related_policy = get_policy(name)
	if(related_policy)
		to_chat(living_mob,related_policy)
	if(ishuman(living_mob))
		var/mob/living/carbon/human/wageslave = living_mob
		living_mob.add_memory("Your account ID is [wageslave.account_id].")
	if(living_mob)
		after_spawn(living_mob, living_mob) // note: this happens before the mob has a key! living_mob will always have a client, H might not.

	if (ship)
		var/obj/item/card/id/idcard = living_mob.get_idcard(TRUE)
		if (idcard)
			idcard.add_ship_access(ship)

	return living_mob


//Don't override this unless the job transforms into a non-human (Silicons do this for example)
/datum/job/proc/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, datum/outfit/outfit_override = null, client/preference_source)
	if(!H)
		return FALSE
	if(!visualsOnly)
		var/datum/bank_account/bank_account = new(H.real_name, H.age)
		bank_account.adjust_money(officer ? 250 : 100, CREDIT_LOG_STARTING_MONEY) //just a little bit of money for you
		H.account_id = bank_account.account_id

	//Equip the rest of the gear
	H.dna.species.before_equip_job(src, H, visualsOnly)

	if(outfit_override || outfit)
		H.equipOutfit(outfit_override ? outfit_override : outfit, visualsOnly, preference_source)

	H.dna.species.after_equip_job(src, H, visualsOnly)

/datum/job/proc/get_access()
	if(!config)	//Needed for robots.
		return src.minimal_access.Copy()

	. = list()

	if(CONFIG_GET(flag/jobs_have_minimal_access))
		. = src.minimal_access.Copy()
	else
		. = src.access.Copy()

	if(CONFIG_GET(flag/everyone_has_maint_access)) //Config has global maint access set
		. |= list(ACCESS_MAINT_TUNNELS)

//If the configuration option is set to require players to be logged as old enough to play certain jobs, then this proc checks that they are, otherwise it just returns 1
/datum/job/proc/player_old_enough(client/C)
	var/isexempt = C.prefs.db_flags & DB_FLAG_EXEMPT
	if(isexempt)
		return TRUE
	if(available_in_days(C) == 0)
		return TRUE	//Available in 0 days = available right now = player is old enough to play.
	return FALSE


/datum/job/proc/available_in_days(client/C)
	if(!C)
		return 0
	if(!CONFIG_GET(flag/use_age_restriction_for_jobs))
		return 0
	if(!SSdbcore.Connect())
		return 0 //Without a database connection we can't get a player's age so we'll assume they're old enough for all jobs
	if(!isnum(minimal_player_age))
		return 0

	return max(0, minimal_player_age - C.player_age)

/datum/job/proc/radio_help_message(mob/M)
	to_chat(M, "<b>Your ship most likely does not have telecomms. Prefix your message with :L or :R, depending on the hand you're holding the radio with, to speak with a handheld radio. Otherwise, you can speak with your headset by prefixing your message with :h.</b>")

/datum/outfit/job
	name = "Standard Gear"

	var/jobtype = null

	uniform = /obj/item/clothing/under/color/grey
	wallet = /obj/item/storage/wallet
	id = /obj/item/card/id
	bank_card = /obj/item/card/bank
	back = /obj/item/storage/backpack
	shoes = /obj/item/clothing/shoes/sneakers/black
	box = /obj/item/storage/box/survival

	var/backpack = /obj/item/storage/backpack
	var/satchel  = /obj/item/storage/backpack/satchel
	var/duffelbag = /obj/item/storage/backpack/duffelbag
	var/courierbag = /obj/item/storage/backpack/messenger

	///The icon this outfit's ID will have when shown on a sechud and ID cards. See [icons\mob\hud.dmi] for a list of icons. Leave null for default.
	var/job_icon
	// the background of the job icon
	var/faction_icon
	// if there is an id, this will get automatically applied to an id's assignment variable
	var/id_assignment

	var/alt_uniform

	var/alt_suit = null
	var/dcoat = /obj/item/clothing/suit/hooded/wintercoat

	var/pda_slot = ITEM_SLOT_BELT

/datum/outfit/job/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source = null)
	switch(H.backpack)
		if(GBACKPACK)
			back = /obj/item/storage/backpack //Grey backpack
		if(GSATCHEL)
			back = /obj/item/storage/backpack/satchel //Grey satchel
		if(GDUFFELBAG)
			back = /obj/item/storage/backpack/duffelbag //Grey duffel bag
		if(GCOURIERBAG)
			back = /obj/item/storage/backpack/messenger //Grey messenger bag
		if(LSATCHEL)
			back = /obj/item/storage/backpack/satchel/leather //Leather Satchel
		if(DSATCHEL)
			back = satchel //Department satchel
		if(DDUFFELBAG)
			back = duffelbag //Department duffel bag
		if(DCOURIERBAG)
			back = courierbag //Department messenger bag
		else
			back = backpack //Department backpack

	var/holder
	switch(H.jumpsuit_style)
		if(PREF_SKIRT)
			holder = "[uniform]/skirt"
		if(PREF_ALTSUIT)
			if(alt_uniform)
				holder = "[alt_uniform]"
		if(PREF_GREYSUIT)
			holder = "/obj/item/clothing/under/color/grey"
		else
			holder = "[uniform]"

	if(text2path(holder))
		uniform = text2path(holder)

	if(holder && text2path(holder))
		uniform = text2path(holder)


	holder = null
	switch(H.exowear)
		if(PREF_ALTEXOWEAR)
			if(alt_suit)
				holder = "[alt_suit]"
			else
				holder = "[suit]"
		if(PREF_NOEXOWEAR)
			holder = null
		if(PREF_COATEXOWEAR)
			holder = "[dcoat]"
		else
			holder = "[suit]"

	if(text2path(holder) || !holder)
		suit = text2path(holder)

/datum/outfit/job/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE, client/preference_source = null)
	if(visualsOnly)
		return

	var/datum/job/J = GLOB.type_occupations[jobtype]
	if(!J)
		J = GLOB.name_occupations[H.job]

	var/obj/item/card/id/C = H.get_idcard(TRUE)
	if(istype(C))
		C.access = J.get_access()
		SEND_SIGNAL(C, COSMIG_ACCESS_UPDATED)
		shuffle_inplace(C.access) // Shuffle access list to make NTNet passkeys less predictable
		C.registered_name = H.real_name
		if(H.job)
			C.assignment = H.job
		else
			C.assignment = J.name
		if(H.age)
			C.registered_age = H.age
		C.job_icon = job_icon
		C.faction_icon = faction_icon
		C.update_appearance()
		if(id_assignment)
			C.assignment = id_assignment
		C.update_label()
		H.sec_hud_set_ID()

	var/obj/item/card/bank/bank_card = H.get_bankcard()
	if(istype(bank_card))
		for(var/account in SSeconomy.bank_accounts)
			var/datum/bank_account/bank_account = account
			if(bank_account.account_id == H.account_id)
				bank_card.registered_account = bank_account
				bank_account.bank_cards += bank_card
				break

	var/obj/item/pda/PDA = H.get_item_by_slot(pda_slot)
	if(istype(PDA))
		PDA.owner = H.real_name
		if(H.job)
			PDA.ownjob = H.job
		else
			PDA.ownjob = J.name
		PDA.update_label()

/datum/outfit/job/get_chameleon_disguise_info()
	var/list/types = ..()
	types -= /obj/item/storage/backpack //otherwise this will override the actual backpacks
	types += backpack
	types += satchel
	types += duffelbag
	types += courierbag
	return types

//Warden and regular officers add this result to their get_access()
/datum/job/proc/check_config_for_sec_maint()
	if(CONFIG_GET(flag/security_has_maint_access))
		return list(ACCESS_MAINT_TUNNELS)
	return list()
