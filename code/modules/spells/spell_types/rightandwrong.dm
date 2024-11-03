//In this file: Summon Magic/Summon Guns/Summon Events

// 1 in 50 chance of getting something really special.
#define SPECIALIST_MAGIC_PROB 2

// todo: this probably neds to be reorganized sometime
GLOBAL_LIST_INIT(summoned_guns, list(
	/obj/item/gun/energy/disabler,
	/obj/item/gun/energy/e_gun,
	/obj/item/gun/energy/e_gun/advtaser,
	/obj/item/gun/energy/laser,
	/obj/item/gun/ballistic/revolver/viper,
	/obj/item/gun/ballistic/revolver/detective,
	/obj/item/gun/ballistic/automatic/pistol/deagle/camo,
	/obj/item/gun/ballistic/automatic/gyropistol,
	/obj/item/gun/energy/pulse,
	/obj/item/gun/ballistic/automatic/pistol/ringneck,
	/obj/item/gun/ballistic/shotgun/doublebarrel,
	/obj/item/gun/ballistic/shotgun,
	/obj/item/gun/ballistic/shotgun/automatic/m11,
	/obj/item/gun/ballistic/automatic/assault/p16,
	/obj/item/gun/ballistic/revolver/mateba,
	/obj/item/gun/ballistic/rifle/illestren,
	/obj/item/pneumatic_cannon/speargun,
	/obj/item/gun/energy/lasercannon,
	/obj/item/gun/energy/kinetic_accelerator/crossbow/large,
	/obj/item/gun/energy/e_gun/nuclear,
	/obj/item/gun/ballistic/automatic/smg/skm_carbine/saber,
	/obj/item/gun/ballistic/automatic/smg/cobra,
	/obj/item/gun/ballistic/automatic/assault/hydra/lmg/extended,
	/obj/item/gun/ballistic/automatic/assault/hydra,
	/obj/item/gun/energy/alien,
	/obj/item/gun/energy/e_gun/dragnet,
	/obj/item/gun/energy/e_gun/turret,
	/obj/item/gun/energy/pulse/carbine,
	/obj/item/gun/energy/decloner,
	/obj/item/gun/energy/mindflayer,
	/obj/item/gun/energy/kinetic_accelerator,
	/obj/item/gun/energy/plasmacutter/adv,
	/obj/item/gun/energy/wormhole_projector,
	/obj/item/gun/ballistic/automatic/smg/wt550,
	/obj/item/gun/ballistic/shotgun/automatic/bulldog,
	/obj/item/gun/ballistic/revolver/grenadelauncher,
	/obj/item/gun/ballistic/revolver/golden,
	/obj/item/gun/ballistic/automatic/marksman/taipan,
	/obj/item/gun/ballistic/rocketlauncher,
	/obj/item/gun/medbeam,
	/obj/item/gun/energy/laser/scatter,
	/obj/item/gun/energy/gravity_gun))

// If true, it's the probability of triggering "survivor" antag.
GLOBAL_VAR_INIT(summon_guns_triggered, FALSE)

/proc/give_guns(mob/living/carbon/human/H)
	if(H.stat == DEAD || !(H.client))
		return
	if(H.mind)
		if(iswizard(H) || H.mind.has_antag_datum(/datum/antagonist/survivalist/guns))
			return

	if(prob(GLOB.summon_guns_triggered) && !(H.mind.has_antag_datum(/datum/antagonist)))
		SSticker.mode.traitors += H.mind

		H.mind.add_antag_datum(/datum/antagonist/survivalist/guns)
		H.log_message("was made into a survivalist, and trusts no one!", LOG_ATTACK, color="red")

	var/gun_type = pick(GLOB.summoned_guns)
	var/obj/item/gun/G = new gun_type(get_turf(H))
	playsound(get_turf(H),'sound/magic/summon_guns.ogg', 50, TRUE)

	var/in_hand = H.put_in_hands(G) // not always successful

	to_chat(H, "<span class='warning'>\A [G] appears [in_hand ? "in your hand" : "at your feet"]!</span>")

/proc/rightandwrong(mob/user, survivor_probability)
	if(user) //in this case someone is a badmin
		to_chat(user, "<span class='warning'>You summoned guns!</span>")
		message_admins("[ADMIN_LOOKUPFLW(user)] summoned guns!")
		log_game("[key_name(user)] summoned guns!")

	GLOB.summon_guns_triggered = survivor_probability

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		var/turf/T = get_turf(H)
		if(T && is_away_level(T))
			continue
		give_guns(H)

/proc/summonevents()
	if(!SSevents.wizardmode)
		SSevents.frequency_lower = 600									//1 minute lower bound
		SSevents.frequency_upper = 3000									//5 minutes upper bound
		SSevents.toggleWizardmode()
		SSevents.reschedule()

	else 																//Speed it up
		SSevents.frequency_upper -= 600	//The upper bound falls a minute each time, making the AVERAGE time between events lessen
		if(SSevents.frequency_upper < SSevents.frequency_lower) //Sanity
			SSevents.frequency_upper = SSevents.frequency_lower

		SSevents.reschedule()
		message_admins("Summon Events intensifies, events will now occur every [SSevents.frequency_lower / 600] to [SSevents.frequency_upper / 600] minutes.")
		log_game("Summon Events was increased!")

#undef SPECIALIST_MAGIC_PROB
