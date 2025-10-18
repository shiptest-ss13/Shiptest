/datum/species/ipc // im fucking lazy mk2 and cant get sprites to normally work
	name = "\improper Positronic" //inherited from the real species, for health scanners and things
	id = SPECIES_IPC
	species_age_min = 0
	species_age_max = 300
	species_traits = list(HAIR,NOTRANSSTING,NO_DNA_COPY,TRAIT_EASYDISMEMBER,NOZOMBIE,MUTCOLORS,REVIVESBYHEALING,NOHUSK,NOMOUTH) //all of these + whatever we inherit from the real species
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_VIRUSIMMUNE,TRAIT_NOBREATH,TRAIT_RADIMMUNE,TRAIT_GENELESS,TRAIT_LIMBATTACHMENT)
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	mutantbrain = /obj/item/organ/brain/mmi_holder/posibrain
	mutanteyes = /obj/item/organ/eyes/robotic
	mutanttongue = /obj/item/organ/tongue/robot
	mutantheart = /obj/item/organ/heart/cybernetic/ipc
	mutantliver = /obj/item/organ/liver/cybernetic/upgraded/ipc
	mutantstomach = /obj/item/organ/stomach/cell
	mutantears = /obj/item/organ/ears/robot
	mutantlungs = null //no more collecting change for you
	mutantappendix = null
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)
	mutant_bodyparts = list("ipc_screen", "ipc_antenna", "ipc_chassis", "ipc_tail", "ipc_brain")
	default_features = list("mcolor" = "#7D7D7D", "ipc_screen" = "Static", "ipc_antenna" = "None", "ipc_chassis" = "Morpheus Cyberkinetics (Custom)", "ipc_tail" = "None", "ipc_brain" = "Posibrain", "body_size" = "Normal")
	meat = /obj/item/stack/sheet/plasteel{amount = 5}
	skinned_type = /obj/item/stack/sheet/metal{amount = 10}
	exotic_bloodtype = "Coolant"
	damage_overlay_type = "synth"
	heatmod = 1.5
	siemens_coeff = 1.5
	reagent_tag = PROCESS_SYNTHETIC
	species_gibs = "robotic"
	attack_sound = 'sound/items/trayhit1.ogg'
	deathsound = "sound/voice/borg_deathsound.ogg"
	wings_icons = list("Robotic")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	species_language_holder = /datum/language_holder/ipc
	loreblurb = "Integrated Positronic Chassis or \"IPC\" for short, are synthetic lifeforms composed of an Artificial \
	Intelligence program encased in a bipedal robotic shell. They are fragile, allergic to EMPs, and the butt of endless toaster jokes. \
	Just as easy to repair as they are to destroy, they might just get their last laugh in as you're choking on neurotoxins. Beep Boop."
	ass_image = 'icons/ass/assmachine.png'

	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc,
	)

	/// The last screen used when the IPC died.
	var/saved_screen
	var/datum/action/innate/change_screen/change_screen
	var/has_screen = TRUE //do we have a screen. Used to determine if we mess with the screen or not

/datum/species/ipc/random_name(unique)
	var/ipc_name = "[pick(GLOB.posibrain_names)]-[rand(100, 999)]"
	return ipc_name

/datum/species/ipc/New()

	// This is in new because "[HEAD_LAYER]" etc. is NOT a constant compile-time value. For some reason.
	// Why not just use HEAD_LAYER? Well, because HEAD_LAYER is a number, and if you try to use numbers as indexes,
	// BYOND will try to make it an ordered list. So, we have to use a string. This is annoying, but it's the only way to do it smoothly.
	offset_clothing = list(
		"[GLASSES_LAYER]" = list("[NORTH]" = list("x" = 0, "y" = 0), "[EAST]" = list("x" = 2, "y" = 0), "[SOUTH]" = list("x" = 0, "y" = 0), "[WEST]" = list("x" = -2, "y" = 0)),
	)

/datum/species/ipc/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load) // Let's make that IPC actually robotic.
	if(C.dna?.features["ipc_brain"] == "Man-Machine Interface")
		mutantbrain = /obj/item/organ/brain/mmi_holder
	. = ..()
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(!change_screen)
			var/datum/species/ipc/species_datum = H.dna.species
			if(species_datum?.has_screen)
				change_screen = new
				change_screen.Grant(H)
		C.RegisterSignal(C, COMSIG_PROCESS_BORGCHARGER_OCCUPANT, TYPE_PROC_REF(/mob/living/carbon, charge))

/datum/species/ipc/on_species_loss(mob/living/carbon/C)
	. = ..()
	if(change_screen)
		change_screen.Remove(C)
	C.UnregisterSignal(C, COMSIG_PROCESS_BORGCHARGER_OCCUPANT)

/datum/species/ipc/spec_death(gibbed, mob/living/carbon/C)
	if(!has_screen)
		return
	saved_screen = C.dna.features["ipc_screen"]
	C.dna.features["ipc_screen"] = "BSOD"
	C.update_body()
	addtimer(CALLBACK(src, PROC_REF(post_death), C), 5 SECONDS)

/datum/species/ipc/proc/post_death(mob/living/carbon/C)
	if(C.stat < DEAD)
		return
	if(!has_screen)
		return
	C.dna.features["ipc_screen"] = null // Turns off their monitor on death.
	C.update_body()

/datum/action/innate/change_screen
	name = "Change Display"
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_silicon.dmi'
	button_icon_state = "drone_vision"

/datum/action/innate/change_screen/Activate()
	var/screen_choice = input(usr, "Which screen do you want to use?", "Screen Change") as null | anything in GLOB.ipc_screens_list
	var/color_choice = input(usr, "Which color do you want your screen to be?", "Color Change") as null | color
	if(!screen_choice)
		return
	if(!color_choice)
		return
	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/H = owner
	var/datum/species/ipc/species_datum = H.dna.species
	if(!species_datum)
		return
	if(!species_datum.has_screen)
		return
	H.dna.features["ipc_screen"] = screen_choice
	H.eye_color = sanitize_hexcolor(color_choice)
	H.update_body()

/obj/item/apc_powercord
	name = "power cord"
	desc = "An internal power cord hooked up to a battery. Useful if you run on electricity. Not so much otherwise."
	icon = 'icons/obj/power.dmi'
	icon_state = "wire1"

/obj/item/apc_powercord/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if((!istype(target, /obj/machinery/power/apc) && !iselzuose(target)) || !ishuman(user) || !proximity_flag)
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/stomach/cell/battery = H.getorganslot(ORGAN_SLOT_STOMACH)
	if(!battery)
		to_chat(H, span_warning("You try to siphon energy from \the [target], but your power cell is gone!"))
		return

	if(istype(H) && H.nutrition >= NUTRITION_LEVEL_ALMOST_FULL)
		to_chat(user, span_warning("You are already fully charged!"))
		return

	if(istype(target, /obj/machinery/power/apc))
		var/obj/machinery/power/apc/A = target
		if(A.cell && A.cell.charge > A.cell.maxcharge/4)
			powerdraw_loop(A, H, TRUE)
			return
		else
			to_chat(user, span_warning("There is not enough charge to draw from that APC."))
			return

	if(iselzuose(target))
		var/mob/living/carbon/human/target_ethereal = target
		var/obj/item/organ/stomach/ethereal/eth_stomach = target_ethereal.getorganslot(ORGAN_SLOT_STOMACH)
		if(target_ethereal.nutrition > 0 && eth_stomach)
			powerdraw_loop(eth_stomach, H, FALSE)
			return
		else
			to_chat(user, span_warning("There is not enough charge to draw from that being!"))
			return

/obj/item/apc_powercord/proc/powerdraw_loop(atom/target, mob/living/carbon/human/H, apc_target)
	H.visible_message(span_notice("[H] inserts a power connector into the [target]."), span_notice("You begin to draw power from the [target]."))
	var/obj/item/organ/stomach/cell/battery = H.getorganslot(ORGAN_SLOT_STOMACH)
	if(apc_target)
		var/obj/machinery/power/apc/A = target
		if(!istype(A))
			return
		while(do_after(H, 10, target = A))
			if(loc != H)
				to_chat(H, span_warning("You must keep your connector out while charging!"))
				break
			if(A.cell.charge == 0)
				to_chat(H, span_warning("The [A] doesn't have enough charge to spare."))
				break
			A.charging = 1
			if(A.cell.charge >= 500)
				H.nutrition += 50
				A.cell.charge -= 250
				to_chat(H, span_notice("You siphon off some of the stored charge for your own use."))
			else
				H.nutrition += A.cell.charge/10
				A.cell.charge = 0
				to_chat(H, span_notice("You siphon off as much as the [A] can spare."))
				break
			if(H.nutrition > NUTRITION_LEVEL_WELL_FED)
				to_chat(H, span_notice("You are now fully charged."))
				break
	else
		var/obj/item/organ/stomach/ethereal/A = target
		if(!istype(A))
			return
		var/siphon_amt
		while(do_after(H, 10, target = A.owner))
			if(!battery)
				to_chat(H, span_warning("You need a battery to recharge!"))
				break
			if(loc != H)
				to_chat(H, span_warning("You must keep your connector out while charging!"))
				break
			if(A.crystal_charge == 0)
				to_chat(H, span_warning("[A] is completely drained!"))
				break
			siphon_amt = A.crystal_charge <= (2 * ELZUOSE_CHARGE_SCALING_MULTIPLIER) ? A.crystal_charge : (2 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)
			A.adjust_charge(-1 * siphon_amt)
			H.nutrition += (siphon_amt)
			if(H.nutrition > NUTRITION_LEVEL_WELL_FED)
				to_chat(H, span_notice("You are now fully charged."))
				break

	H.visible_message(span_notice("[H] unplugs from the [target]."), span_notice("You unplug from the [target]."))
	return

/datum/species/ipc/spec_life(mob/living/carbon/human/H)
	. = ..()
	if(H.health <= HEALTH_THRESHOLD_CRIT && H.stat != DEAD) // So they die eventually instead of being stuck in crit limbo.
		H.adjustFireLoss(6) // After BODYTYPE_ROBOTIC resistance this is ~2/second
		if(prob(5))
			to_chat(H, span_warning("Alert: Internal temperature regulation systems offline; thermal damage sustained. Shutdown imminent."))
			H.visible_message("[H]'s cooling system fans stutter and stall. There is a faint, yet rapid beeping coming from inside their chassis.")


/datum/species/ipc/spec_revival(mob/living/carbon/human/H)
	if(has_screen)
		H.dna.features["ipc_screen"] = "BSOD"
		H.update_body()
	H.say("Reactivating [pick("core systems", "central subroutines", "key functions")]...")
	addtimer(CALLBACK(src, PROC_REF(post_revival), H), 6 SECONDS)

/datum/species/ipc/proc/post_revival(mob/living/carbon/human/H)
	if(H.stat == DEAD)
		return
	if(!has_screen)
		return
	H.dna.features["ipc_screen"] = saved_screen
	H.update_body()

/datum/species/ipc/replace_body(mob/living/carbon/C, datum/species/old_species, datum/species/new_species, robotic)
	var/datum/sprite_accessory/ipc_chassis/chassis_of_choice = GLOB.ipc_chassis_list[C.dna.features["ipc_chassis"]]
	if(chassis_of_choice)
		qdel(species_limbs)
		species_limbs = chassis_of_choice.chassis_bodyparts.Copy() // elegant.
		var/obj/item/bodypart/chest/new_chest = species_limbs[BODY_ZONE_CHEST]
		if(new_chest)
			bodytype = initial(new_chest.acceptable_bodytype)
		else
			stack_trace("[chassis_of_choice.type] had no chest bodypart!")
		for(var/feature in chassis_of_choice.chassis_features)
			mutant_bodyparts |= feature
			default_features[feature] = chassis_of_choice.chassis_features[feature]
	else // in case of fuckery
		stack_trace("Invalid IPC chassis: [C.dna.features["ipc_chassis"]]")
	return ..()

/mob/living/carbon/proc/charge(datum/source, amount, repairs)
	if(nutrition < NUTRITION_LEVEL_WELL_FED)
		adjust_nutrition(amount / 10) // The original amount is capacitor_rating*100
