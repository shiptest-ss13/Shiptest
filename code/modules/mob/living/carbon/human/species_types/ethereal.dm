#define ELZUOSE_EMAG_COLORS list("#00ffff", "#ffc0cb", "#9400D3", "#4B0082", "#0000FF", "#00FF00", "#FFFF00", "#FF7F00", "#FF0000")

/datum/species/elzuose
	name = "\improper Elzuose"
	id = SPECIES_ELZUOSE
	attack_verb = "burn"
	attack_sound = 'sound/weapons/etherealhit.ogg'
	miss_sound = 'sound/weapons/etherealmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ethereal
	mutantstomach = /obj/item/organ/stomach/ethereal
	mutanttongue = /obj/item/organ/tongue/ethereal
	siemens_coeff = 0.5 //They thrive on energy
	brutemod = 1.25 //They're weak to punches
	attack_type = BURN //burn bish
	exotic_bloodtype = "E"
	damage_overlay_type = "" //We are too cool for regular damage overlays
	species_traits = list(EYECOLOR, HAIR, FACEHAIR)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/ethereal
	inherent_traits = list(TRAIT_NOHUNGER)
	sexes = FALSE //no fetish content allowed
	toxic_food = NONE
	// Body temperature for ethereals is much higher then humans as they like hotter environments
	bodytemp_normal = (HUMAN_BODYTEMP_NORMAL + 50)
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD // about 150C
	// Cold temperatures hurt faster as it is harder to move with out the heat energy
	bodytemp_cold_damage_limit = (T20C - 10) // about 10c
	hair_color = "fixedmutcolor"
	hair_alpha = 140
	mutant_bodyparts = list("elzu_horns", "tail_elzu")
	default_features = list("elzu_horns" = "None", "tail_elzu" = "None", FEATURE_BODY_SIZE = BODY_SIZE_NORMAL)
	species_eye_path = 'icons/mob/ethereal_parts.dmi'
	mutant_organs = list(/obj/item/organ/tail/elzu)

	species_chest = /obj/item/bodypart/chest/ethereal
	species_head = /obj/item/bodypart/head/ethereal
	species_l_arm = /obj/item/bodypart/l_arm/ethereal
	species_r_arm = /obj/item/bodypart/r_arm/ethereal
	species_l_leg = /obj/item/bodypart/leg/left/ethereal
	species_r_leg = /obj/item/bodypart/leg/right/ethereal

	var/obj/effect/dummy/lighting_obj/ethereal_light

	var/emp_effect = FALSE
	var/emag_effect = FALSE

	/// The color that all Elzu trend towards as they become increasingly injured.
	var/static/unhealthy_color = "#EDA495"
	/// The color that Elzu adopt when EMPed or dead.
	var/static/drain_color = "#FFFFFF"

	loreblurb = "Elzuosa are an uncommon and unusual species best described as crystalline, electrically-powered plantpeople. They hail from the warm planet Kalixcis, where they evolved alongside the Sarathi. Kalixcian culture places no importance on blood-bonds, and those from it tend to consider their family anyone they are sufficiently close to, and choose their own names."

	var/drain_time = 0 //used to keep ethereals from spam draining power sources

/datum/species/elzuose/Destroy(force)
	if(ethereal_light)
		QDEL_NULL(ethereal_light)
	return ..()

/datum/species/elzuose/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	if(!ishuman(C))
		return
	var/mob/living/carbon/human/ethereal = C

	RegisterSignal(ethereal, COMSIG_ATOM_EMAG_ACT, PROC_REF(on_emag_act))
	RegisterSignal(ethereal, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp_act))
	ethereal_light = ethereal.mob_light()
	update_elzu_color(ethereal)

	//The following code is literally only to make admin-spawned ethereals not be black.
	// not sure it does anything anymore...
	for(var/obj/item/bodypart/BP as anything in C.bodyparts)
		if(BP.limb_id == SPECIES_ELZUOSE)
			BP.update_limb(is_creating = TRUE)

/datum/species/elzuose/on_species_loss(mob/living/carbon/human/C, datum/species/new_species)
	UnregisterSignal(C, COMSIG_ATOM_EMAG_ACT)
	UnregisterSignal(C, COMSIG_ATOM_EMP_ACT)
	QDEL_NULL(ethereal_light)
	return ..()

/datum/species/elzuose/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_lizard_name(gender)

	var/randname = lizard_name(gender)

	if(lastname)
		randname += " [lastname]"

	return randname

/* Charge mechanics */

/datum/species/elzuose/spec_life(mob/living/carbon/human/H)
	.=..()
	handle_charge(H)

/datum/species/elzuose/proc/handle_charge(mob/living/carbon/human/H)
	brutemod = 1.25
	switch(get_charge(H))
		if(ELZUOSE_CHARGE_NONE to ELZUOSE_CHARGE_LOWPOWER)
			if(get_charge(H) == ELZUOSE_CHARGE_NONE)
				H.throw_alert("ELZUOSE_CHARGE", /atom/movable/screen/alert/etherealcharge, 3)
			else
				H.throw_alert("ELZUOSE_CHARGE", /atom/movable/screen/alert/etherealcharge, 2)
			if(H.health > 10.5)
				apply_damage(0.2, TOX, null, null, H)
			brutemod = 1.75
		if(ELZUOSE_CHARGE_LOWPOWER to ELZUOSE_CHARGE_NORMAL)
			H.throw_alert("ELZUOSE_CHARGE", /atom/movable/screen/alert/etherealcharge, 1)
			brutemod = 1.5
		if(ELZUOSE_CHARGE_FULL to ELZUOSE_CHARGE_OVERLOAD)
			H.throw_alert("ethereal_overcharge", /atom/movable/screen/alert/ethereal_overcharge, 1)
			brutemod = 1.5
		if(ELZUOSE_CHARGE_OVERLOAD to ELZUOSE_CHARGE_DANGEROUS)
			H.throw_alert("ethereal_overcharge", /atom/movable/screen/alert/ethereal_overcharge, 2)
			brutemod = 1.75
			if(prob(10)) //10% each tick for ethereals to explosively release excess energy if it reaches dangerous levels
				discharge_process(H)
		else
			H.clear_alert("ELZUOSE_CHARGE")
			H.clear_alert("ethereal_overcharge")

/datum/species/elzuose/proc/discharge_process(mob/living/carbon/human/H)
	to_chat(H, "<span class='warning'>You begin to lose control over your charge!</span>")
	H.visible_message("<span class='danger'>[H] begins to spark violently!</span>")
	var/static/mutable_appearance/overcharge //shameless copycode from lightning spell
	overcharge = overcharge || mutable_appearance('icons/effects/effects.dmi', "electricity", EFFECTS_LAYER)
	H.add_overlay(overcharge)
	if(do_mob(H, H, 50, 1))
		H.flash_lighting_fx(5, 7, "#" + H.dna.features[FEATURE_MUTANT_COLOR])
		var/obj/item/organ/stomach/ethereal/stomach = H.getorganslot(ORGAN_SLOT_STOMACH)
		playsound(H, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
		H.cut_overlay(overcharge)
		tesla_zap(H, 2, (stomach.crystal_charge / ELZUOSE_CHARGE_SCALING_MULTIPLIER) * 50, ZAP_OBJ_DAMAGE | ZAP_ALLOW_DUPLICATES)
		if(istype(stomach))
			stomach.adjust_charge(ELZUOSE_CHARGE_FULL - stomach.crystal_charge)
		to_chat(H, "<span class='warning'>You violently discharge energy!</span>")
		H.visible_message("<span class='danger'>[H] violently discharges energy!</span>")
		if(prob(10)) //chance of developing heart disease to dissuade overcharging oneself
			var/datum/disease/D = new /datum/disease/heart_failure
			H.ForceContractDisease(D)
			to_chat(H, "<span class='userdanger'>You're pretty sure you just felt your heart stop for a second there..</span>")
			H.playsound_local(H, 'sound/effects/singlebeat.ogg', 100, 0)
		H.Paralyze(100)
		return

/datum/species/elzuose/proc/get_charge(mob/living/carbon/H) //this feels like it should be somewhere else. Eh?
	var/obj/item/organ/stomach/ethereal/stomach = H.getorganslot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		return stomach.crystal_charge
	return ELZUOSE_CHARGE_NONE

/* Color mechanics */

/datum/species/elzuose/spec_updatehealth(mob/living/carbon/human/H)
	. = ..()
	update_elzu_color()

/// Using the Elzu's base color, their damage, and whether they are EMPed, emagged, or dead,
/// recalculate their color and update their appearance accordingly.
/datum/species/elzuose/proc/update_elzu_color(mob/living/carbon/human/H)
	if(!ethereal_light)
		return

	// base color used for limbs + light
	var/used_color = "#" + H.dna.features[FEATURE_MUTANT_COLOR]
	if(H.stat == DEAD || emp_effect)
		// their smile and optimism. gone.
		used_color = drain_color
		ethereal_light.set_light_on(FALSE)
	else
		// emagged elzu glow just as bright even when taking damage -- but the rest visibly suffer.
		if(!emag_effect)
			used_color = get_adjusted_color(H, used_color)

		// calculates the strength of their light partially based on their health
		set_ethereal_light(H, used_color)
		ethereal_light.set_light_on(TRUE)

		ethereal_light.set_light_on(FALSE)

	// this is the variable that actually controls what color the limbs and accessories (hair, tail, horns) have.
	fixed_mut_color = copytext_char(used_color, 2)

	for(var/obj/item/bodypart/part_to_update as anything in H.bodyparts)
		if(part_to_update.should_draw_greyscale)
			part_to_update.effective_skin_color = fixed_mut_color
		part_to_update.update_limb()

	H.update_body()
	H.update_hair()

/datum/species/elzuose/proc/get_adjusted_color(mob/living/carbon/human/H, base_color)
	var/health_percent = max(H.health, 0) / 100

	var/static/unhealthy_color_red_part   = GETREDPART(unhealthy_color)
	var/static/unhealthy_color_green_part = GETGREENPART(unhealthy_color)
	var/static/unhealthy_color_blue_part  = GETBLUEPART(unhealthy_color)

	var/default_color_red_part   = GETREDPART(base_color)
	var/default_color_green_part = GETGREENPART(base_color)
	var/default_color_blue_part  = GETBLUEPART(base_color)

	var/result = rgb(
		unhealthy_color_red_part   + ((default_color_red_part   - unhealthy_color_red_part)   * health_percent),
		unhealthy_color_green_part + ((default_color_green_part - unhealthy_color_green_part) * health_percent),
		unhealthy_color_blue_part  + ((default_color_blue_part  - unhealthy_color_blue_part)  * health_percent)
	)
	return result

/datum/species/elzuose/proc/set_ethereal_light(mob/living/carbon/human/H, new_light_color)
	if(!ethereal_light)
		return

	var/health_percent = max(H.health, 0) / 100

	var/light_range = 1 + (1 * health_percent)
	var/light_power = 1 + round(0.5 * health_percent)

	ethereal_light.set_light_range_power_color(light_range, light_power, new_light_color)

/datum/species/elzuose/proc/on_emp_act(mob/living/carbon/human/H, severity)
	emp_effect = TRUE
	update_elzu_color(H)

	to_chat(H, "<span class='notice'>You feel the light of your body leave you.</span>")
	switch(severity)
		if(EMP_LIGHT)
			addtimer(CALLBACK(src, PROC_REF(stop_emp), H), 10 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE) //We're out for 10 seconds
		if(EMP_HEAVY)
			addtimer(CALLBACK(src, PROC_REF(stop_emp), H), 20 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE) //We're out for 20 seconds

/datum/species/elzuose/proc/on_emag_act(mob/living/carbon/human/H, mob/user)
	if(emag_effect)
		return
	emag_effect = TRUE
	if(user)
		to_chat(user, "<span class='notice'>You tap [H] on the back with your card.</span>")
	H.visible_message("<span class='danger'>[H] starts flickering in an array of colors!</span>")
	handle_emag(H)
	addtimer(CALLBACK(src, PROC_REF(stop_emag), H), 30 SECONDS) //Disco mode for 30 seconds! This doesn't affect the ethereal at all besides either annoying some players, or making someone look badass.

/datum/species/elzuose/proc/stop_emp(mob/living/carbon/human/H)
	emp_effect = FALSE
	update_elzu_color(H)

	to_chat(H, "<span class='notice'>You feel more energized as your shine comes back.</span>")

/datum/species/elzuose/proc/handle_emag(mob/living/carbon/human/H)
	if(!emag_effect)
		return
	// gotta remove the leading # from this list... god i hate that so many colors don't have those baked in. pointless
	H.dna.features[FEATURE_MUTANT_COLOR] = copytext(pick(ELZUOSE_EMAG_COLORS), 2)
	update_elzu_color(H)

	addtimer(CALLBACK(src, PROC_REF(handle_emag), H), 5) //Call ourselves every 0.5 seconds to change color

/datum/species/elzuose/proc/stop_emag(mob/living/carbon/human/H)
	emag_effect = FALSE
	update_elzu_color(H)

	H.visible_message("<span class='danger'>[H] stops flickering and goes back to [H.p_their()] normal state!</span>")

/datum/species/elzuose/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, intent, mob/living/carbon/human/H)
	if(istype(I, /obj/item/multitool))
		if(user.a_intent == INTENT_HARM)
			. = ..() // multitool beatdown
			return

		if (emag_effect == TRUE)
			to_chat(user, "<span class='danger'>The multitool can't get a lock on [H]'s EM frequency!</span>")
			return

		if(user != H)
			// random color change
			H.dna.features[FEATURE_MUTANT_COLOR] = GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)]
			update_elzu_color(H)
			H.visible_message("<span class='danger'>[H]'s EM frequency is scrambled to a random color!</span>")
		else
			// select new color
			var/new_etherealcolor = input(user, "Choose your Elzuose color:", "Character Preference", "#" + H.dna.features[FEATURE_MUTANT_COLOR]) as color|null
			if(new_etherealcolor)
				var/temp_hsv = RGBtoHSV(new_etherealcolor)
				if(ReadHSV(temp_hsv)[3] >= ReadHSV("#505050")[3]) // elzu colors should be bright ok??
					H.dna.features[FEATURE_MUTANT_COLOR] = sanitize_hexcolor(new_etherealcolor, 6, include_crunch = FALSE)
					update_elzu_color(H)
					H.visible_message("<span class='notice'>[H] modulates \his EM frequency to [new_etherealcolor].</span>")
				else
					to_chat(user, "<span class='danger'>Invalid color. Your color is not bright enough.</span>")
	else
		. = ..()
