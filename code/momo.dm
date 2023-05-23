	var/equip = job.EquipRank(character, crew)
	if(isliving(equip))	//Borgs get borged in the equip, so we need to make sure we handle the new mob.
		character = equip

	if(job && !job.override_latejoin_spawn(character))
		crew.join_crew(character, job)
		var/atom/movable/screen/splash/Spl = new(character.client, TRUE)
		Spl.Fade(TRUE)
		character.playsound_local(get_turf(character), 'sound/voice/ApproachingTG.ogg', 25)

		character.update_parallax_teleport()

	character.client.init_verbs() // init verbs for the late join

	if(ishuman(character))	//These procs all expect humans
		var/mob/living/carbon/human/humanc = character
		GLOB.data_core.manifest_inject(humanc, client)
		AnnounceArrival(humanc, job.name, crew)
		// AddEmploymentContract(humanc)
		SSblackbox.record_feedback("tally", "species_spawned", 1, humanc.dna.species.name)

		/**	Random wiz bs
		if(GLOB.summon_guns_triggered)
			give_guns(humanc)
		if(GLOB.summon_magic_triggered)
			give_magic(humanc)
		if(GLOB.curse_of_madness_triggered)
			give_madness(humanc, GLOB.curse_of_madness_triggered)
		**/

		if(CONFIG_GET(flag/roundstart_traits))
			SSquirks.AssignQuirks(humanc, humanc.client, TRUE)

	GLOB.joined_player_list += character.ckey

	log_manifest(character.mind.key, character.mind, character, TRUE)

	if(length(crew.job_slots) > 1 && crew.job_slots[1] == job) // if it's the "captain" equivalent job of the crew. checks to make sure it's not a one-job crew
		minor_announce("[job.name] [character.real_name] on deck!", zlevel = character.virtual_z())
	return TRUE
