/* Cards
 * Contains:
 *		DATA CARD
 *		ID CARD
 *		FINGERPRINT CARD HOLDER
 *		FINGERPRINT CARD
 */



/*
 * DATA CARDS - Used for the IC data card reader
 */

/obj/item/card
	name = "card"
	desc = "Does card things."
	icon = 'icons/obj/card.dmi'
	w_class = WEIGHT_CLASS_TINY

	var/list/files = list()

/obj/item/card/data
	name = "data card"
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one has a stripe running down the middle."
	icon_state = "data_1"
	obj_flags = UNIQUE_RENAME
	var/function = "storage"
	var/data = "null"
	var/special = null
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	var/detail_color = COLOR_ASSEMBLY_ORANGE

/obj/item/card/data/Initialize()
	.=..()
	update_appearance()

/obj/item/card/data/update_overlays()
	. = ..()
	if(detail_color == COLOR_FLOORTILE_GRAY)
		return
	var/mutable_appearance/detail_overlay = mutable_appearance('icons/obj/card.dmi', "[icon_state]-color")
	detail_overlay.color = detail_color
	. += detail_overlay

/obj/item/card/data/full_color
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one has the entire card colored."
	icon_state = "data_2"

/obj/item/card/data/disk
	desc = "A plastic magstripe card for simple and speedy data storage and transfer. This one inexplicibly looks like a floppy disk."
	icon_state = "data_3"

/*
 * ID CARDS
 */
/obj/item/card/emag
	desc = "It's a card with a magnetic strip attached to some circuitry."
	name = "cryptographic sequencer"
	icon_state = "emag"
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	item_flags = NO_MAT_REDEMPTION | NOBLUDGEON
	var/prox_check = TRUE //If the emag requires you to be in range
	var/emag_on = TRUE //added to suppport multi-function tools with a deployable emag - hams
	var/uses_left = -1 //how many uses does the emag have left before it's toast? If set to -1 then it never runs out

//multi-purpose emag tool example- used in syndicate borgs.
/obj/item/card/emag/borg
	name = "/INFILTRATE/ module"
	desc = "A cyborg subsystem of debatable legality, designed to defeat security systems and unlock backdoor functionality."
	icon_state = "inf_emag"
	icon = 'icons/obj/items_cyborg.dmi'

/obj/item/card/emag/borg/examine()
	. = ..()
	. += span_notice(" Capable of interchanging between electromagnetic, electrical, & screw turning functionality.")
	if(uses_left > -1)
		. += span_notice(" It has [uses_left] charge\s left.")

/obj/item/card/emag/limited
	name = "limited cryptographic sequencer"
	desc = "It's a card with a magnetic strip attached to some circuitry. It has limited charges."
	uses_left = 1

/obj/item/card/emag/borg/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == NONE)
		tool_behaviour = TOOL_SCREWDRIVER
		to_chat(user, span_notice("You extend the screwdriver within the [src]."))
		icon_state = "inf_screwdriver"
		emag_on = FALSE
	else if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_MULTITOOL
		to_chat(user, span_notice("You prime the multitool attachment of the [src]."))
		icon_state = "inf_multi"
		emag_on = FALSE
	else
		tool_behaviour = NONE
		to_chat(user, span_notice("You enable the electromagnetic hacking system of the [src]."))
		icon_state = "inf_emag"
		emag_on = TRUE

/obj/item/card/emag/bluespace
	name = "bluespace cryptographic sequencer"
	desc = "It's a blue card with a magnetic strip attached to some circuitry. It appears to have some sort of transmitter attached to it."
	color = rgb(40, 130, 255)
	prox_check = FALSE

/obj/item/card/emag/attack()
	if(emag_on == TRUE)
		return

/obj/item/card/emag/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(emag_on == TRUE)
		var/atom/A = target
		if(!proximity && prox_check)
			return
		log_combat(user, A, "attempted to emag")
		A.emag_act(user)
		if(!(uses_left == -1))
			uses_left--
			if(uses_left == 0)
				emag_on = FALSE

/obj/item/card/emagfake
	desc = "It's a card with a magnetic strip attached to some circuitry. Closer inspection shows that this card is a poorly made replica, with a \"DonkCo\" logo stamped on the back."
	name = "cryptographic sequencer"
	icon_state = "emag"
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/emagfake/afterattack()
	. = ..()
	playsound(src, 'sound/items/bikehorn.ogg', 50, TRUE)

/obj/item/card/id
	name = "access card"
	desc = "These cards provide access to different sections of a ship."
	icon_state = "id"
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	slot_flags = ITEM_SLOT_ID
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF | INDESTRUCTIBLE
	var/list/access = list()
	var/list/ship_access = list()
	var/registered_name = null // The name registered_name on the card
	var/assignment = null
	var/access_txt // mapping aid
	//var/datum/bank_account/registered_account
	var/uses_overlays = TRUE
	var/icon/cached_flat_icon
	var/registered_age = 18 // default age for ss13 players
	var/job_icon
	var/faction_icon
	var/officer = FALSE // Whether the ID belongs to an officer, set in /datum/job/proc/equip

/obj/item/card/id/Initialize(mapload)
	. = ..()
	if(mapload && access_txt)
		access = text2access(access_txt)
		SEND_SIGNAL(src, COSMIG_ACCESS_UPDATED)
	update_label()
	update_appearance()
	RegisterSignal(src, COMSIG_ATOM_UPDATED_ICON, PROC_REF(update_in_wallet))

/obj/item/card/id/attack_self(mob/user)
	if(Adjacent(user))
		var/id_message = "\the [initial(name)] "
		var/list/id_info = list()
		if(assignment)
			id_info += "JOB: [assignment]"
		if(registered_name)
			id_info += "NAME: [registered_name]"
		if(id_info)
			id_message += id_info.Join(", ")
		var/self_message = span_notice("You show [id_message]")
		var/other_message = span_notice("[user] shows you: [icon2html(src, viewers(user))] [id_message]")

		user.visible_message(other_message, self_message)
	add_fingerprint(user)

/obj/item/card/id/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if(NAMEOF(src, assignment),NAMEOF(src, registered_name),NAMEOF(src, registered_age))
				update_label()

/obj/item/card/id/examine(mob/user)
	. = ..()
	. += "<br>CARD INFO:"
	if(registered_name)
		. += "<B>NAME:</B>"
		. += "[registered_name]"
	if(registered_age)
		. += "<B>AGE:</B>"
		. += "[registered_age] years old [(registered_age < AGE_DRINKING) ? "There's a holographic stripe that reads <b>[span_danger("'DO NOT SERVE ALCOHOL OR TOBACCO'")]</b> along the bottom of the card." : ""]"
	if(length(ship_access))
		var/list/ship_factions = list()
		var/list/ship_names = list()
		for(var/datum/overmap/ship/controlled/ship in ship_access)
			ship_factions |= ship.source_template.faction.name
			ship_names += ship.name

		. += "<B>FACTION ACCESS:</B>"
		. += "[ship_factions.Join(", ")]"

		. += "<B>SHIP ACCESS:</B>"
		. += "[ship_names.Join(", ")]"

/obj/item/card/id/GetAccess()
	return access

/obj/item/card/id/GetID()
	return src

/obj/item/card/id/RemoveID()
	return src

/obj/item/card/id/update_overlays()
	. = ..()
	if(!uses_overlays)
		return
	cached_flat_icon = null
	if(registered_name && registered_name != "Captain")
		. += mutable_appearance(icon, "assigned")
	if(job_icon)
		. += mutable_appearance(icon, "id[job_icon]")

/obj/item/card/id/proc/update_in_wallet()
	SIGNAL_HANDLER

	if(istype(loc, /obj/item/storage/wallet))
		var/obj/item/storage/wallet/powergaming = loc
		if(powergaming.front_id == src)
			powergaming.update_label()
			powergaming.update_appearance()

/obj/item/card/id/proc/get_cached_flat_icon()
	if(!cached_flat_icon)
		cached_flat_icon = getFlatIcon(src)
	return cached_flat_icon


/obj/item/card/id/get_examine_string(mob/user, thats = FALSE)
	if(uses_overlays)
		return "[icon2html(get_cached_flat_icon(), user)] [thats? "That's ":""][get_examine_name(user)]" //displays all overlays in chat
	return ..()

// Adds the referenced ship directly to the card
/obj/item/card/id/proc/add_ship_access(datum/overmap/ship/controlled/ship)
	if (ship)
		ship_access += ship
		SEND_SIGNAL(src, COSMIG_ACCESS_UPDATED)

// Removes the referenced ship from the card
/obj/item/card/id/proc/remove_ship_access(datum/overmap/ship/controlled/ship)
	if (ship)
		ship_access -= ship
		SEND_SIGNAL(src, COSMIG_ACCESS_UPDATED)

// Finds the referenced ship in the list
/obj/item/card/id/proc/has_ship_access(datum/overmap/ship/controlled/ship)
	if (ship)
		return ship in ship_access

/*
Usage:
update_label()
	Sets the id name to whatever the assignment is
*/

/obj/item/card/id/proc/update_label()
	name = "[(istype(src, /obj/item/card/id/syndicate)) ? "[initial(name)]" : "access card"][(!assignment) ? "" : " ([assignment])"]"

/obj/item/card/id/silver
	desc = "A silver-colored card, usually given to higher-ranking officials in ships and stations."
	icon_state = "silver"
	item_state = "silver_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/id/silver/hologram
	assignment = "Head of Personnel"
	registered_name = "Emergency Command Hologram"
	access = list(ACCESS_CHANGE_IDS)

/obj/item/card/id/gold
	desc = "A golden-colored card, usually given to those at the top of the hierarchy in a ship."
	icon_state = "gold"
	item_state = "gold_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/id/syndicate
	name = "agent card"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SYNDICATE)
	var/anyone = FALSE //Can anyone forge the ID or just syndicate?
	var/forged = FALSE //have we set a custom name and job assignment, or will we use what we're given when we chameleon change?

/obj/item/card/id/syndicate/Initialize()
	. = ..()
	var/datum/action/item_action/chameleon/change/id/chameleon_action = new(src)
	chameleon_action.chameleon_type = /obj/item/card/id
	chameleon_action.chameleon_name = "ID Card"
	chameleon_action.initialize_disguises()

/obj/item/card/id/syndicate/afterattack(obj/item/O, mob/user, proximity)
	if(!proximity)
		return
	if(istype(O, /obj/item/card/id))
		var/obj/item/card/id/I = O
		src.access |= I.access
		if(isliving(user) && user.mind)
			if(user.mind.special_role || anyone)
				to_chat(usr, span_notice("The card's microscanners activate as you pass it over the ID, copying its access."))

/obj/item/card/id/syndicate/attack_self(mob/user)
	if(isliving(user) && user.mind)
		var/first_use = registered_name ? FALSE : TRUE
		if(!(user.mind.special_role || anyone)) //Unless anyone is allowed, only syndies can use the card, to stop metagaming.
			if(first_use) //If a non-syndie is the first to forge an unassigned agent ID, then anyone can forge it.
				anyone = TRUE
			else
				return ..()

		var/popup_input = alert(user, "Choose Action", "Agent ID", "Show", "Forge/Reset")
		if(user.incapacitated())
			return
		if(popup_input == "Forge/Reset" && !forged)
			var/input_name = stripped_input(user, "What name would you like to put on this card? Leave blank to randomise.", "Agent card name", registered_name ? registered_name : (ishuman(user) ? user.real_name : user.name), MAX_NAME_LEN)
			input_name = reject_bad_name(input_name)
			if(!input_name)
				// Invalid/blank names give a randomly generated one.
				if(user.gender == MALE)
					input_name = "[pick(GLOB.first_names_male)] [pick(GLOB.last_names)]"
				else if(user.gender == FEMALE)
					input_name = "[pick(GLOB.first_names_female)] [pick(GLOB.last_names)]"
				else
					input_name = "[pick(GLOB.first_names)] [pick(GLOB.last_names)]"

			var/target_occupation = stripped_input(user, "What occupation would you like to put on this card?\nNote: This will not grant any access levels other than Maintenance.", "Agent card job assignment", assignment ? assignment : "Assistant", MAX_MESSAGE_LEN)
			if(!target_occupation)
				return

			var/newAge = input(user, "Choose the ID's age:\n([AGE_MIN]-[AGE_MAX])", "Agent card age") as num|null
			if(newAge)
				registered_age = max(round(text2num(newAge)), 0)

			registered_name = input_name
			assignment = target_occupation
			update_label()
			forged = TRUE
			to_chat(user, span_notice("You successfully forge the ID card."))
			log_game("[key_name(user)] has forged \the [initial(name)] with name \"[registered_name]\" and occupation \"[assignment]\".")

			return
		else if (popup_input == "Forge/Reset" && forged)
			registered_name = initial(registered_name)
			assignment = initial(assignment)
			faction_icon = initial(faction_icon)
			job_icon = initial(job_icon)
			log_game("[key_name(user)] has reset \the [initial(name)] named \"[src]\" to default.")
			update_label()
			forged = FALSE
			to_chat(user, span_notice("You successfully reset the ID card."))
			return
	return ..()

/obj/item/card/id/syndicate/anyone
	anyone = TRUE

/obj/item/card/id/syndicate/nuke_leader
	name = "lead agent card"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SYNDICATE, ACCESS_SYNDICATE_LEADER)

/obj/item/card/id/syndicate_command
	desc = "An access card widely utilized by Coalition splinters in the frontier."
	icon_state = "syndie"
	access = list(ACCESS_SYNDICATE)
	uses_overlays = FALSE

/obj/item/card/id/syndicate_command/crew_id
	assignment = "Operative"
	access = list(ACCESS_SYNDICATE)
	uses_overlays = FALSE

/obj/item/card/id/syndicate_command/crew_id/engi // twinkleshine specific IDs
	assignment = "Engineer"
	access = list(ACCESS_SYNDICATE, ACCESS_ENGINE, ACCESS_CONSTRUCTION)
	uses_overlays = FALSE

/obj/item/card/id/syndicate_command/crew_id/med
	assignment = "Medic"
	access = list(ACCESS_SYNDICATE, ACCESS_MEDICAL)
	uses_overlays = FALSE

/obj/item/card/id/syndicate_command/lieutenant
	assignment = "Lieutenant"
	access = list(ACCESS_SYNDICATE, ACCESS_ARMORY)
	uses_overlays = FALSE

/obj/item/card/id/syndicate_command/captain_id
	assignment = "Captain"
	access = list(ACCESS_SYNDICATE, ACCESS_ROBOTICS, ACCESS_ARMORY, ACCESS_SYNDICATE_LEADER)
	uses_overlays = FALSE

/obj/item/card/id/patient //Aegis ID
	assignment = "Long Term Patient"
	uses_overlays = FALSE

/obj/item/card/id/captains_spare
	icon_state = "gold"
	item_state = "gold_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	assignment = "Captain"
	registered_age = null

/obj/item/card/id/captains_spare/Initialize()
	var/datum/job/captain/J = new/datum/job/captain
	access = J.get_access()
	add_ship_access(SSshuttle.get_ship(src))
	. = ..()
	update_label()

/obj/item/card/id/captains_spare/update_label() //so it doesn't change to Captain's ID card (Captain) on a sneeze
	if(registered_name == "Captain")
		name = "[initial(name)][(!assignment || assignment == "Captain") ? "" : " ([assignment])"]"
		update_appearance()
	else
		..()

/obj/item/card/id/centcom
	name = "\improper Nanotrasen Central Command access card"
	desc = "An access card sourced from Nanotrasen's Central Command."
	icon_state = "centcom"
	uses_overlays = FALSE
	registered_age = null

/obj/item/card/id/centcom/Initialize()
	access = get_all_centcom_access()
	. = ..()

/obj/item/card/id/centcom/has_ship_access(datum/overmap/ship/controlled/ship)
	return TRUE

/obj/item/card/id/ert
	name = "\improper CentCom ID"
	desc = "An ERT ID card."
	icon_state = "ert_commander"
	uses_overlays = FALSE
	registered_age = null

/obj/item/card/id/ert/Initialize()
	access = get_all_accesses()+get_ert_access("commander")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/security
	icon_state = "ert_security"

/obj/item/card/id/ert/security/Initialize()
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/engineer
	icon_state = "ert_engineer"

/obj/item/card/id/ert/engineer/Initialize()
	access = get_all_accesses()+get_ert_access("eng")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/medical
	icon_state = "ert_medic"

/obj/item/card/id/ert/medical/Initialize()
	access = get_all_accesses()+get_ert_access("med")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/chaplain
	icon_state = "ert_chaplain"

/obj/item/card/id/ert/chaplain/Initialize()
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/janitor
	icon_state = "ert_janitor"

/obj/item/card/id/ert/janitor/Initialize()
	access = get_all_accesses()
	. = ..()

/obj/item/card/id/ert/deathsquad
	desc = "An access card colored in black and red."
	icon_state = "deathsquad" //NO NO SIR DEATH SQUADS ARENT A PART OF NANOTRASEN AT ALL
	uses_overlays = FALSE
	job_icon = "deathsquad"

/obj/item/card/id/debug
	name = "\improper Debug ID"
	desc = "A debug ID card. Has ALL the all access, you really shouldn't have this."
	icon_state = "ert_janitor"
	assignment = "Jannie"
	uses_overlays = FALSE

/obj/item/card/id/debug/Initialize()
	access = get_all_accesses()+get_all_centcom_access()+get_all_syndicate_access()
	. = ..()

/obj/item/card/id/prisoner
	name = "prisoner ID card"
	desc = "You are a number, you are not a free man."
	icon_state = "orange"
	item_state = "orange-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	assignment = "Prisoner"
	uses_overlays = FALSE
	var/goal = 0 //How far from freedom?
	var/points = 0
	registered_age = null

/obj/item/card/id/prisoner/attack_self(mob/user)
	to_chat(usr, span_notice("You have accumulated [points] out of the [goal] points you need for freedom."))

/obj/item/card/id/prisoner/one
	name = "Prisoner #13-001"
	registered_name = "Prisoner #13-001"
	icon_state = "prisoner_001"

/obj/item/card/id/prisoner/two
	name = "Prisoner #13-002"
	registered_name = "Prisoner #13-002"
	icon_state = "prisoner_002"

/obj/item/card/id/prisoner/three
	name = "Prisoner #13-003"
	registered_name = "Prisoner #13-003"
	icon_state = "prisoner_003"

/obj/item/card/id/prisoner/four
	name = "Prisoner #13-004"
	registered_name = "Prisoner #13-004"
	icon_state = "prisoner_004"

/obj/item/card/id/prisoner/five
	name = "Prisoner #13-005"
	registered_name = "Prisoner #13-005"
	icon_state = "prisoner_005"

/obj/item/card/id/prisoner/six
	name = "Prisoner #13-006"
	registered_name = "Prisoner #13-006"
	icon_state = "prisoner_006"

/obj/item/card/id/prisoner/seven
	name = "Prisoner #13-007"
	registered_name = "Prisoner #13-007"
	icon_state = "prisoner_007"

/obj/item/card/id/away
	name = "\proper a perfectly generic identification card"
	desc = "A perfectly generic identification card. Looks like it could use some flavor."
	access = list(ACCESS_AWAY_GENERAL)
	icon_state = "retro"
	uses_overlays = FALSE
	registered_age = null

/obj/item/card/id/away/hotel
	name = "Staff ID"
	desc = "A staff ID used to access the hotel's doors."
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)

/obj/item/card/id/away/hotel/securty
	name = "Officer ID"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT, ACCESS_AWAY_SEC)

/obj/item/card/id/away/deep_storage //deepstorage.dmm space ruin
	name = "bunker access ID"

/obj/item/card/id/solgov
	name = "\improper SolGov keycard"
	desc = "A SolGov keycard with no proper access to speak of."
	assignment = "Officer"
	icon_state = "solgov"
	uses_overlays = FALSE

/obj/item/card/id/solgov/commander
	name = "\improper SolGov commander keycard"
	desc = "A SolGov keycard with no proper access to speak of. This one indicates a Commander."
	assignment = "Commander"

/obj/item/card/id/suns
	name = "\improper SUNS keycard"
	desc = "A keycard belonging to the Student-Union Association of Naturalistic Sciences."
	assignment = "Student"
	icon_state = "suns"
	uses_overlays = FALSE

/obj/item/card/id/suns/command
	name = "\improper SUNS command keycard"
	desc = "A keycard belonging to the Student-Union Association of Naturalistic Sciences. This one has a gold stripe, indicating a command member."
	assignment = "Academic Staff"
	icon_state = "sunscommand"
