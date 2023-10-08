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
	. += "<span class='notice'> Capable of interchanging between electromagnetic, electrical, & screw turning functionality.</span>"
	if(uses_left > -1)
		. += "<span class='notice'> It has [uses_left] charge\s left.</span>"

/obj/item/card/emag/limited
	name = "limited cryptographic sequencer"
	desc = "It's a card with a magnetic strip attached to some circuitry. It has limited charges."
	uses_left = 1

/obj/item/card/emag/borg/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == NONE)
		tool_behaviour = TOOL_SCREWDRIVER
		to_chat(user, "<span class='notice'>You extend the screwdriver within the [src].</span>")
		icon_state = "inf_screwdriver"
		emag_on = FALSE
	else if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_MULTITOOL
		to_chat(user, "<span class='notice'>You prime the multitool attachment of the [src].</span>")
		icon_state = "inf_multi"
		emag_on = FALSE
	else
		tool_behaviour = NONE
		to_chat(user, "<span class='notice'>You enable the electromagnetic hacking system of the [src].</span>")
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
	name = "identification card"
	desc = "A card used to provide ID and determine access across the station."
	icon_state = "id"
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	slot_flags = ITEM_SLOT_ID
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/mining_points = 0 //For redeeming at mining equipment vendors
	var/list/access = list()
	var/list/ship_access = list()
	var/registered_name = null // The name registered_name on the card
	var/assignment = null
	var/access_txt // mapping aid
	var/datum/bank_account/registered_account
	var/obj/machinery/paystand/my_store
	var/uses_overlays = TRUE
	var/icon/cached_flat_icon
	var/registered_age = 13 // default age for ss13 players
	var/job_icon

/obj/item/card/id/Initialize(mapload)
	. = ..()
	if(mapload && access_txt)
		access = text2access(access_txt)
	update_label()
	RegisterSignal(src, COMSIG_ATOM_UPDATED_ICON, .proc/update_in_wallet)

/obj/item/card/id/Destroy()
	if (registered_account)
		registered_account.bank_cards -= src
	if (my_store && my_store.my_card == src)
		my_store.my_card = null
	return ..()

/obj/item/card/id/attack_self(mob/user)
	if(Adjacent(user))
		var/minor
		if(registered_name && registered_age && registered_age < AGE_MINOR)
			minor = " <b>(MINOR)</b>"
		user.visible_message("<span class='notice'>[user] shows you: [icon2html(src, viewers(user))] [src.name][minor].</span>", "<span class='notice'>You show \the [src.name][minor].</span>")
	add_fingerprint(user)

/obj/item/card/id/vv_edit_var(var_name, var_value)
	. = ..()
	if(.)
		switch(var_name)
			if(NAMEOF(src, assignment),NAMEOF(src, registered_name),NAMEOF(src, registered_age))
				update_label()

/obj/item/card/id/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/holochip))
		insert_money(W, user)
		return
	else if(istype(W, /obj/item/spacecash/bundle))
		insert_money(W, user, TRUE)
		return
	else if(istype(W, /obj/item/coin))
		insert_money(W, user, TRUE)
		return
	else if(istype(W, /obj/item/storage/bag/money))
		var/obj/item/storage/bag/money/money_bag = W
		var/list/money_contained = money_bag.contents

		var/money_added = mass_insert_money(money_contained, user)

		if (money_added)
			to_chat(user, "<span class='notice'>You stuff the contents into the card! They disappear in a puff of bluespace smoke, adding [money_added] worth of credits to the linked account.</span>")
		return
	else
		return ..()

/obj/item/card/id/proc/insert_money(obj/item/I, mob/user, physical_currency)
	var/cash_money = I.get_item_credit_value()
	if(!cash_money)
		to_chat(user, "<span class='warning'>[I] doesn't seem to be worth anything!</span>")
		return

	if(!registered_account)
		to_chat(user, "<span class='warning'>[src] doesn't have a linked account to deposit [I] into!</span>")
		return

	registered_account.adjust_money(cash_money)
	SSblackbox.record_feedback("amount", "credits_inserted", cash_money)
	log_econ("[cash_money] credits were inserted into [src] owned by [src.registered_name]")
	if(physical_currency)
		to_chat(user, "<span class='notice'>You stuff [I] into [src]. It disappears in a small puff of bluespace smoke, adding [cash_money] credits to the linked account.</span>")
	else
		to_chat(user, "<span class='notice'>You insert [I] into [src], adding [cash_money] credits to the linked account.</span>")

	to_chat(user, "<span class='notice'>The linked account now reports a balance of [registered_account.account_balance] cr.</span>")
	qdel(I)

/obj/item/card/id/proc/mass_insert_money(list/money, mob/user)
	if (!money || !money.len)
		return FALSE

	var/total = 0

	for (var/obj/item/physical_money in money)
		var/cash_money = physical_money.get_item_credit_value()

		total += cash_money

		registered_account.adjust_money(cash_money)
	SSblackbox.record_feedback("amount", "credits_inserted", total)
	log_econ("[total] credits were inserted into [src] owned by [src.registered_name]")
	QDEL_LIST(money)

	return total

/obj/item/card/id/proc/alt_click_can_use_id(mob/living/user)
	if(!isliving(user))
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	return TRUE

// Returns true if new account was set.
/obj/item/card/id/proc/set_new_account(mob/living/user)
	. = FALSE
	var/datum/bank_account/old_account = registered_account

	var/new_bank_id = input(user, "Enter your account ID number.", "Account Reclamation", 111111) as num | null

	if (isnull(new_bank_id))
		return

	if(!alt_click_can_use_id(user))
		return
	if(!new_bank_id || new_bank_id < 111111 || new_bank_id > 999999)
		to_chat(user, "<span class='warning'>The account ID number needs to be between 111111 and 999999.</span>")
		return
	if (registered_account && registered_account.account_id == new_bank_id)
		to_chat(user, "<span class='warning'>The account ID was already assigned to this card.</span>")
		return

	for(var/A in SSeconomy.bank_accounts)
		var/datum/bank_account/B = A
		if(B.account_id == new_bank_id)
			if (old_account)
				old_account.bank_cards -= src

			B.bank_cards += src
			registered_account = B
			to_chat(user, "<span class='notice'>The provided account has been linked to this ID card.</span>")

			return TRUE

	to_chat(user, "<span class='warning'>The account ID number provided is invalid.</span>")
	return

/obj/item/card/id/AltClick(mob/living/user)
	if(!alt_click_can_use_id(user))
		return

	if(!registered_account)
		set_new_account(user)
		return

	if (world.time < registered_account.withdrawDelay)
		registered_account.bank_card_talk("<span class='warning'>ERROR: UNABLE TO LOGIN DUE TO SCHEDULED MAINTENANCE. MAINTENANCE IS SCHEDULED TO COMPLETE IN [(registered_account.withdrawDelay - world.time)/10] SECONDS.</span>", TRUE)
		return

	var/amount_to_remove =  FLOOR(input(user, "How much do you want to withdraw? Current Balance: [registered_account.account_balance]", "Withdraw Funds", 5) as num|null, 1)

	if(!amount_to_remove || amount_to_remove < 0)
		return
	if(!alt_click_can_use_id(user))
		return
	if(registered_account.adjust_money(-amount_to_remove))
		var/obj/item/holochip/holochip = new (user.drop_location(), amount_to_remove)
		user.put_in_hands(holochip)
		to_chat(user, "<span class='notice'>You withdraw [amount_to_remove] credits into a holochip.</span>")
		SSblackbox.record_feedback("amount", "credits_removed", amount_to_remove)
		log_econ("[amount_to_remove] credits were removed from [src] owned by [src.registered_name]")
		return
	else
		if (registered_account.frozen)
			registered_account.bank_card_talk("<span class='warning'>ERROR: The linked account is frozen! Contact your department head.</span>", TRUE)
		else
			var/difference = amount_to_remove - registered_account.account_balance
			registered_account.bank_card_talk("<span class='warning'>ERROR: The linked account requires [difference] more credit\s to perform that withdrawal.</span>", TRUE)

/obj/item/card/id/examine(mob/user)
	. = ..()
	if(registered_account)
		. += "The account linked to the ID belongs to '[registered_account.account_holder]' and reports a balance of [registered_account.account_balance] cr."
		if(registered_account.frozen)
			. += "<span class='warning'>The linked account is frozen, and cannot be withdrawn from or deposited into!</span>"
	. += "<span class='notice'><i>There's more information below, you can look again to take a closer look...</i></span>"

/obj/item/card/id/examine_more(mob/user)
	var/list/msg = list("<span class='notice'><i>You examine [src] closer, and note the following...</i></span>")

	if(registered_age)
		msg += "The card indicates that the holder is [registered_age] years old. [(registered_age < AGE_MINOR) ? "There's a holographic stripe that reads <b><span class='danger'>'MINOR: DO NOT SERVE ALCOHOL OR TOBACCO'</span></b> along the bottom of the card." : ""]"
	if(mining_points)
		msg += "There's [mining_points] mining equipment redemption point\s loaded onto this card."
	if(length(ship_access))
		var/list/ship_names = list()
		for(var/datum/overmap/ship/controlled/ship in ship_access)
			ship_names += ship.name
		msg += "The card has access to the following ships: [ship_names.Join(", ")]"
	if(registered_account)
		msg += "The account linked to the ID belongs to '[registered_account.account_holder]' and reports a balance of [registered_account.account_balance] cr."
		msg += "<span class='info'>Alt-Click the ID to pull money from the linked account in the form of holochips.</span>"
		msg += "<span class='info'>You can insert credits into the linked account by pressing holochips, cash, or coins against the ID.</span>"
		if(registered_account.account_holder == user.real_name)
			msg += "<span class='boldnotice'>If you lose this ID card, you can reclaim your account by Alt-Clicking a blank ID card while holding it and entering your account ID number.</span>"
	else
		msg += "<span class='info'>There is no registered account linked to this card. Alt-Click to add one.</span>"

	return msg

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

// Removes the referenced ship from the card
/obj/item/card/id/proc/remove_ship_access(datum/overmap/ship/controlled/ship)
	if (ship)
		ship_access -= ship

// Finds the referenced ship in the list
/obj/item/card/id/proc/has_ship_access(datum/overmap/ship/controlled/ship)
	if (ship)
		return ship_access.Find(ship)

/*
Usage:
update_label()
	Sets the id name to whatever registered_name and assignment is
*/

/obj/item/card/id/proc/update_label()
	var/blank = !registered_name
	name = "[blank ? initial(name) : "[registered_name]'s ID Card"][(!assignment) ? "" : " ([assignment])"]"
	update_appearance()

/obj/item/card/id/silver
	name = "silver identification card"
	desc = "A silver card which shows honour and dedication."
	icon_state = "silver"
	item_state = "silver_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'

/obj/item/card/id/silver/hologram
	assignment = "Head of Personnel"
	registered_name = "Emergency Command Hologram"
	access = list(ACCESS_CHANGE_IDS)

/obj/item/card/id/silver/reaper
	access = list(ACCESS_MAINT_TUNNELS)
	assignment = "Reaper"
	registered_name = "Thirteen"

/obj/item/card/id/gold
	name = "gold identification card"
	desc = "A golden card which shows power and might."
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
				to_chat(usr, "<span class='notice'>The card's microscanners activate as you pass it over the ID, copying its access.</span>")

/obj/item/card/id/syndicate/attack_self(mob/user)
	if(isliving(user) && user.mind)
		var/first_use = registered_name ? FALSE : TRUE
		if(!(user.mind.special_role || anyone)) //Unless anyone is allowed, only syndies can use the card, to stop metagaming.
			if(first_use) //If a non-syndie is the first to forge an unassigned agent ID, then anyone can forge it.
				anyone = TRUE
			else
				return ..()

		var/popup_input = alert(user, "Choose Action", "Agent ID", "Show", "Forge/Reset", "Change Account ID")
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
			to_chat(user, "<span class='notice'>You successfully forge the ID card.</span>")
			log_game("[key_name(user)] has forged \the [initial(name)] with name \"[registered_name]\" and occupation \"[assignment]\".")

			// First time use automatically sets the account id to the user.
			if (first_use && !registered_account)
				if(ishuman(user))
					var/mob/living/carbon/human/accountowner = user

					for(var/bank_account in SSeconomy.bank_accounts)
						var/datum/bank_account/account = bank_account
						if(account.account_id == accountowner.account_id)
							account.bank_cards += src
							registered_account = account
							to_chat(user, "<span class='notice'>Your account number has been automatically assigned.</span>")
			return
		else if (popup_input == "Forge/Reset" && forged)
			registered_name = initial(registered_name)
			assignment = initial(assignment)
			log_game("[key_name(user)] has reset \the [initial(name)] named \"[src]\" to default.")
			update_label()
			forged = FALSE
			to_chat(user, "<span class='notice'>You successfully reset the ID card.</span>")
			return
		else if (popup_input == "Change Account ID")
			set_new_account(user)
			return
	return ..()

/obj/item/card/id/syndicate/anyone
	anyone = TRUE

/obj/item/card/id/syndicate/nuke_leader
	name = "lead agent card"
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SYNDICATE, ACCESS_SYNDICATE_LEADER)

/obj/item/card/id/syndicate_command
	name = "syndicate ID card"
	desc = "An ID straight from the Syndicate."
	registered_name = "Syndicate"
	assignment = "Syndicate Overlord"
	icon_state = "syndie"
	access = list(ACCESS_SYNDICATE)
	uses_overlays = FALSE
	registered_age = null

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
	access = list(ACCESS_SYNDICATE)

/obj/item/card/id/captains_spare
	desc = "The spare ID of the High Lord himself."
	icon_state = "gold"
	item_state = "gold_id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	registered_name = "Captain"
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
	name = "\improper CentCom ID"
	desc = "An ID straight from Central Command."
	icon_state = "centcom"
	registered_name = "Central Command"
	assignment = "Central Command"
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
	registered_name = "Emergency Response Team Commander"
	assignment = "Emergency Response Team Commander"
	uses_overlays = FALSE
	registered_age = null

/obj/item/card/id/ert/Initialize()
	access = get_all_accesses()+get_ert_access("commander")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/security
	registered_name = "Security Response Officer"
	assignment = "Security Response Officer"
	icon_state = "ert_security"

/obj/item/card/id/ert/security/Initialize()
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/engineer
	registered_name = "Engineering Response Officer"
	assignment = "Engineering Response Officer"
	icon_state = "ert_engineer"

/obj/item/card/id/ert/engineer/Initialize()
	access = get_all_accesses()+get_ert_access("eng")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/medical
	registered_name = "Medical Response Officer"
	assignment = "Medical Response Officer"
	icon_state = "ert_medic"

/obj/item/card/id/ert/medical/Initialize()
	access = get_all_accesses()+get_ert_access("med")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/chaplain
	registered_name = "Religious Response Officer"
	assignment = "Religious Response Officer"
	icon_state = "ert_chaplain"

/obj/item/card/id/ert/chaplain/Initialize()
	access = get_all_accesses()+get_ert_access("sec")-ACCESS_CHANGE_IDS
	. = ..()

/obj/item/card/id/ert/janitor
	registered_name = "Janitorial Response Officer"
	assignment = "Janitorial Response Officer"
	icon_state = "ert_janitor"

/obj/item/card/id/ert/janitor/Initialize()
	access = get_all_accesses()
	. = ..()

/obj/item/card/id/ert/clown
	registered_name = "Entertainment Response Officer"
	assignment = "Entertainment Response Officer"
	icon_state = "ert_clown"

/obj/item/card/id/ert/clown/Initialize()
	access = get_all_accesses()
	. = ..()

/obj/item/card/id/ert/deathsquad
	name = "\improper Death Squad ID"
	desc = "A Death Squad ID card."
	icon_state = "deathsquad" //NO NO SIR DEATH SQUADS ARENT A PART OF NANOTRASEN AT ALL
	registered_name = "Death Commando"
	assignment = "Death Commando"
	uses_overlays = FALSE

/obj/item/card/id/debug
	name = "\improper Debug ID"
	desc = "A debug ID card. Has ALL the all access, you really shouldn't have this."
	icon_state = "ert_janitor"
	assignment = "Jannie"
	uses_overlays = FALSE

/obj/item/card/id/debug/Initialize()
	access = get_all_accesses()+get_all_centcom_access()+get_all_syndicate_access()
	registered_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
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
	to_chat(usr, "<span class='notice'>You have accumulated [points] out of the [goal] points you need for freedom.</span>")

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

/obj/item/card/id/mining
	name = "mining ID"
	access = list(ACCESS_MINING, ACCESS_MINING_STATION, ACCESS_MECH_MINING, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM)
	custom_price = 250

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

/obj/item/card/id/away/old
	name = "\proper a perfectly generic identification card"
	desc = "A perfectly generic identification card. Looks like it could use some flavor."

/obj/item/card/id/away/old/sec
	name = "Charlie Station Security Officer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Security Officer\"."
	assignment = "Charlie Station Security Officer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old/sci
	name = "Charlie Station Scientist's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Scientist\"."
	assignment = "Charlie Station Scientist"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/eng
	name = "Charlie Station Engineer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Station Engineer\"."
	assignment = "Charlie Station Engineer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_ENGINE)

/obj/item/card/id/away/old/cap
	name = "Charlie Station Captain's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Captain\"."
	assignment = "Charlie Station Captain"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_ENGINE, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old/apc
	name = "APC Access ID"
	desc = "A special ID card that allows access to APC terminals."
	access = list(ACCESS_ENGINE_EQUIP)

/obj/item/card/id/away/deep_storage //deepstorage.dmm space ruin
	name = "bunker access ID"

/obj/item/card/id/solgov
	name = "\improper SolGov ID"
	desc = "A SolGov ID with no proper access to speak of."
	assignment = "Officer"
	icon_state = "solgov"
	uses_overlays = FALSE

/obj/item/card/id/solgov/commander
	name = "\improper SolGov ID"
	desc = "A SolGov ID with no proper access to speak of. This one indicates a Commander."
	assignment = "Commander"

/obj/item/card/id/away/slime //We're ranchin, baby! //It's slimin time
	name = "\improper Slime Lab access card"
	desc = "An ID card with access to the Slime Lab"
	assignment = "Slime Research Staff"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_XENOBIOLOGY)
	registered_name = "Slime Researcher"
	icon_state = "id"

/obj/item/card/id/departmental_budget
	name = "departmental card (FUCK)"
	desc = "Provides access to the departmental budget."
	icon_state = "budgetcard"
	uses_overlays = FALSE
	var/department_ID = ACCOUNT_CIV
	var/department_name = ACCOUNT_CIV_NAME
	registered_age = null

/obj/item/card/id/departmental_budget/Initialize()
	. = ..()
	var/datum/bank_account/B = SSeconomy.get_dep_account(department_ID)
	if(B)
		registered_account = B
		if(!B.bank_cards.Find(src))
			B.bank_cards += src
		name = "departmental card ([department_name])"
		desc = "Provides access to the [department_name]."
	SSeconomy.dep_cards += src

/obj/item/card/id/departmental_budget/Destroy()
	SSeconomy.dep_cards -= src
	return ..()

/obj/item/card/id/departmental_budget/update_label()
	return

/obj/item/card/id/departmental_budget/civ
	department_ID = ACCOUNT_CIV
	department_name = ACCOUNT_CIV_NAME
	icon_state = "civ_budget"

/obj/item/card/id/departmental_budget/eng
	department_ID = ACCOUNT_ENG
	department_name = ACCOUNT_ENG_NAME
	icon_state = "eng_budget"

/obj/item/card/id/departmental_budget/sci
	department_ID = ACCOUNT_SCI
	department_name = ACCOUNT_SCI_NAME
	icon_state = "sci_budget"

/obj/item/card/id/departmental_budget/med
	department_ID = ACCOUNT_MED
	department_name = ACCOUNT_MED_NAME
	icon_state = "med_budget"

/obj/item/card/id/departmental_budget/srv
	department_ID = ACCOUNT_SRV
	department_name = ACCOUNT_SRV_NAME
	icon_state = "srv_budget"

/obj/item/card/id/departmental_budget/car
	department_ID = ACCOUNT_CAR
	department_name = ACCOUNT_CAR_NAME
	icon_state = "car_budget" //saving up for a new tesla

/obj/item/card/id/departmental_budget/sec
	department_ID = ACCOUNT_SEC
	department_name = ACCOUNT_SEC_NAME
	icon_state = "sec_budget"
