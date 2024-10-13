#define ELZUOSE_EMAG_COLORS list("#00ffff", "#ffc0cb", "#9400D3", "#4B0082", "#0000FF", "#00FF00", "#FFFF00", "#FF7F00", "#FF0000")
#define GOOD_SOIL list(/turf/open/floor/plating/grass, /turf/open/floor/plating/dirt, /turf/open/floor/ship/dirt, /turf/open/floor/grass/ship, /turf/open/floor/plating/asteroid/whitesands/grass, /turf/open/floor/grass/fairy/beach)
#define DIG_TIME (7.5 SECONDS)
#define ROOT_TIME (3 SECONDS)
#define ROOT_CHARGE_GAIN (5 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)

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
	species_age_max = 300
	species_traits = list(DYNCOLORS, EYECOLOR, HAIR, FACEHAIR)
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

	max_temp_comfortable = HUMAN_BODYTEMP_NORMAL + 100

	hair_color = "fixedmutcolor"
	hair_alpha = 140
	mutant_bodyparts = list("elzu_horns", "tail_elzu")
	default_features = list("elzu_horns" = "None", "tail_elzu" = "None", "body_size" = "Normal")
	species_eye_path = 'icons/mob/ethereal_parts.dmi'
	mutant_organs = list(/obj/item/organ/tail/elzu)

	species_chest = /obj/item/bodypart/chest/ethereal
	species_head = /obj/item/bodypart/head/ethereal
	species_l_arm = /obj/item/bodypart/l_arm/ethereal
	species_r_arm = /obj/item/bodypart/r_arm/ethereal
	species_l_leg = /obj/item/bodypart/leg/left/ethereal
	species_r_leg = /obj/item/bodypart/leg/right/ethereal

	var/current_color
	var/EMPeffect = FALSE
	var/static/unhealthy_color = rgb(237, 164, 149)
	loreblurb = "Elzuosa are an uncommon and unusual species best described as crystalline, electrically-powered plantpeople. They hail from the warm planet Kalixcis, where they evolved alongside the Sarathi. Kalixcian culture places no importance on blood-bonds, and those from it tend to consider their family anyone they are sufficiently close to, and choose their own names."
	var/drain_time = 0 //used to keep ethereals from spam draining power sources
	var/obj/effect/dummy/lighting_obj/ethereal_light
	var/datum/action/innate/root/rooting

/datum/species/elzuose/Destroy(force)
	if(ethereal_light)
		QDEL_NULL(ethereal_light)
	return ..()

/datum/species/elzuose/on_species_gain(mob/living/carbon/_carbon, datum/species/old_species, pref_load)
	. = ..()
	if(!ishuman(_carbon))
		return
	var/mob/living/carbon/human/ethereal = _carbon
	default_color = "#[ethereal.dna.features["ethcolor"]]"
	RegisterSignal(ethereal, COMSIG_ATOM_EMP_ACT, PROC_REF(on_emp_act))
	ethereal_light = ethereal.mob_light()
	spec_updatehealth(ethereal)
	rooting = new
	rooting.Grant(_carbon)
	RegisterSignal(ethereal, COMSIG_DIGOUT, PROC_REF(digout))
	RegisterSignal(ethereal, COMSIG_MOVABLE_MOVED, PROC_REF(uproot))

	//The following code is literally only to make admin-spawned ethereals not be black.
	_carbon.dna.features["mcolor"] = _carbon.dna.features["ethcolor"] //Ethcolor and Mut color are both dogshit and will be replaced
	for(var/obj/item/bodypart/BP as anything in _carbon.bodyparts)
		if(BP.limb_id == SPECIES_ELZUOSE)
			BP.update_limb(is_creating = TRUE)

/datum/species/elzuose/on_species_loss(mob/living/carbon/human/_carbon, datum/species/new_species, pref_load)
	UnregisterSignal(_carbon, COMSIG_ATOM_EMP_ACT)
	UnregisterSignal(_carbon, COMSIG_DIGOUT)
	UnregisterSignal(_carbon, COMSIG_MOVABLE_MOVED)
	QDEL_NULL(ethereal_light)
	if(rooting)
		rooting.Remove(_carbon)
	return ..()

/datum/action/innate/root
	name = "Root"
	desc = "Root into good soil to gain charge."
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "plant-22"
	icon_icon = 'icons/obj/flora/plants.dmi'
	background_icon_state = "bg_alien"

/datum/action/innate/root/Activate()
	var/mob/living/carbon/human/_human = owner
	var/datum/species/elzuose/_elzu = _human.dna.species
	// this is healthy for elzu, they shouldnt be able to overcharge and get heart attacks from this
	var/obj/item/organ/stomach/ethereal/stomach = _human.getorganslot(ORGAN_SLOT_STOMACH)

	if(_human.wear_suit && istype(_human.wear_suit, /obj/item/clothing))
		var/obj/item/clothing/CS = _human.wear_suit
		if (CS.clothing_flags & THICKMATERIAL)
			to_chat(_human, span_warning("Your [CS.name] is too thick to root in!"))
			return

	if(stomach.crystal_charge > ELZUOSE_CHARGE_FULL)
		to_chat(_human,span_warning("Your charge is full!"))
		return
	_elzu.drain_time = world.time + ROOT_TIME
	_human.visible_message(span_notice("[_human] is digging into the ground"),span_warning("You start to dig yourself into the ground to root. You won't won't be able to move once you start the process."),span_notice("You hear digging."))
	if(!do_after(_human,DIG_TIME, target = _human))
		to_chat(_human,span_warning("You were interupted!"))
		return
	_human.apply_status_effect(/datum/status_effect/rooted)
	to_chat(_human, span_notice("You root into the ground and begin to feed."))

	while(do_after(_human, ROOT_TIME, target = _human))
		if(istype(stomach))
			to_chat(_human, span_notice("You receive some charge from rooting."))
			stomach.adjust_charge(ROOT_CHARGE_GAIN)
			_human.adjustBruteLoss(-3)
			_human.adjustFireLoss(-3)

			if(stomach.crystal_charge > ELZUOSE_CHARGE_FULL)
				stomach.crystal_charge = ELZUOSE_CHARGE_FULL
				to_chat(_human, span_notice("You're full on charge!"))
				break

		else
			to_chat(_human,span_warning("You're missing your biological battery and can't recieve charge from rooting!"))
			break

/datum/species/elzuose/proc/digout(mob/living/carbon/human/_human)
	if(do_after(_human, DIG_TIME,target = _human))
		to_chat(_human,span_notice("You finish digging yourself out."))
		_human.remove_status_effect(/datum/status_effect/rooted)
		return

/datum/species/elzuose/proc/uproot(mob/living/carbon/human/_human)
	//You got moved and uprooted, time to suffer the consequences.
	if(_human.has_status_effect(/datum/status_effect/rooted))
		_human.visible_message(span_warning("[_human] is forcefully uprooted. That looked like it hurt."),span_warning("You're forcefully unrooted! Ouch!"),span_warning("You hear someone scream in pain."))
		_human.apply_damage(8,BRUTE,BODY_ZONE_CHEST)
		_human.apply_damage(8,BRUTE,BODY_ZONE_L_LEG)
		_human.apply_damage(8,BRUTE,BODY_ZONE_R_LEG)
		_human.force_scream()
		_human.remove_status_effect(/datum/status_effect/rooted)
		return

/datum/action/innate/root/IsAvailable()
	if(..())
		var/mob/living/carbon/human/_human = owner
		var/turf/terrain = get_turf(_human)
		if(_human.has_status_effect(/datum/status_effect/rooted))
			return FALSE
		if(is_type_in_list(terrain,GOOD_SOIL))
			return TRUE
		return FALSE

/datum/species/elzuose/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_lizard_name(gender)

	var/randname = lizard_name(gender)

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/elzuose/spec_updatehealth(mob/living/carbon/human/_human)
	. = ..()
	if(!ethereal_light)
		return

	if(_human.stat != DEAD && !EMPeffect)
		current_color = health_adjusted_color(_human, default_color)
		set_ethereal_light(_human, current_color)
		ethereal_light.set_light_on(TRUE)
		fixed_mut_color = copytext_char(current_color, 2)
	else
		ethereal_light.set_light_on(FALSE)
		fixed_mut_color = rgb(128,128,128)

	for(var/obj/item/bodypart/parts_to_update as anything in _human.bodyparts)
		parts_to_update.species_color = fixed_mut_color
		parts_to_update.update_limb()

	_human.update_body()
	_human.update_hair()

/datum/species/elzuose/proc/health_adjusted_color(mob/living/carbon/human/_human, default_color)
	var/health_percent = max(_human.health, 0) / 100

	var/static/unhealthy_color_red_part   = GETREDPART(unhealthy_color)
	var/static/unhealthy_color_green_part = GETGREENPART(unhealthy_color)
	var/static/unhealthy_color_blue_part  = GETBLUEPART(unhealthy_color)

	var/default_color_red_part   = GETREDPART(default_color)
	var/default_color_green_part = GETGREENPART(default_color)
	var/default_color_blue_part  = GETBLUEPART(default_color)

	var/result = rgb(
		unhealthy_color_red_part   + ((default_color_red_part   - unhealthy_color_red_part)   * health_percent),
		unhealthy_color_green_part + ((default_color_green_part - unhealthy_color_green_part) * health_percent),
		unhealthy_color_blue_part  + ((default_color_blue_part  - unhealthy_color_blue_part)  * health_percent)
	)
	return result

/datum/species/elzuose/proc/set_ethereal_light(mob/living/carbon/human/_human, current_color)
	if(!ethereal_light)
		return

	var/health_percent = max(_human.health, 0) / 100

	var/light_range = 1 + (1 * health_percent)
	var/light_power = 1 + round(0.5 * health_percent)

	ethereal_light.set_light_range_power_color(light_range, light_power, current_color)

/datum/species/elzuose/proc/on_emp_act(mob/living/carbon/human/_human, severity)
	EMPeffect = TRUE
	spec_updatehealth(_human)
	to_chat(_human, span_notice("You feel the light of your body leave you."))
	switch(severity)
		if(EMP_LIGHT)
			addtimer(CALLBACK(src, PROC_REF(stop_emp), _human), 10 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE) //We're out for 10 seconds
		if(EMP_HEAVY)
			addtimer(CALLBACK(src, PROC_REF(stop_emp), _human), 20 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE) //We're out for 20 seconds

/datum/species/elzuose/spec_life(mob/living/carbon/human/_human)
	.=..()
	handle_charge(_human)

/datum/species/elzuose/proc/stop_emp(mob/living/carbon/human/_human)
	EMPeffect = FALSE
	spec_updatehealth(_human)
	to_chat(_human, span_notice("You feel more energized as your shine comes back."))

/datum/species/elzuose/proc/handle_charge(mob/living/carbon/human/_human)
	brutemod = 1.25
	switch(get_charge(_human))
		if(ELZUOSE_CHARGE_NONE to ELZUOSE_CHARGE_LOWPOWER)
			if(get_charge(_human) == ELZUOSE_CHARGE_NONE)
				_human.throw_alert("ELZUOSE_CHARGE", /atom/movable/screen/alert/etherealcharge, 3)
			else
				_human.throw_alert("ELZUOSE_CHARGE", /atom/movable/screen/alert/etherealcharge, 2)
			if(_human.health > 10.5)
				apply_damage(0.2, TOX, null, null, _human)
			brutemod = 1.75
		if(ELZUOSE_CHARGE_LOWPOWER to ELZUOSE_CHARGE_NORMAL)
			_human.throw_alert("ELZUOSE_CHARGE", /atom/movable/screen/alert/etherealcharge, 1)
			brutemod = 1.5
		if(ELZUOSE_CHARGE_FULL to ELZUOSE_CHARGE_OVERLOAD)
			_human.throw_alert("ethereal_overcharge", /atom/movable/screen/alert/ethereal_overcharge, 1)
			brutemod = 1.5
		if(ELZUOSE_CHARGE_OVERLOAD to ELZUOSE_CHARGE_DANGEROUS)
			_human.throw_alert("ethereal_overcharge", /atom/movable/screen/alert/ethereal_overcharge, 2)
			brutemod = 1.75
			if(prob(10)) //10% each tick for ethereals to explosively release excess energy if it reaches dangerous levels
				discharge_process(_human)
		else
			_human.clear_alert("ELZUOSE_CHARGE")
			_human.clear_alert("ethereal_overcharge")

/datum/species/elzuose/proc/discharge_process(mob/living/carbon/human/_human)
	_human.visible_message(span_danger("[_human] begins to spark violently!"),_human,span_warning("You begin to lose control over your charge!"))
	var/static/mutable_appearance/overcharge //shameless copycode from lightning spell
	overcharge = overcharge || mutable_appearance('icons/effects/effects.dmi', "electricity", EFFECTS_LAYER)
	_human.add_overlay(overcharge)
	if(do_after(_human, 50, _human, TRUE))
		_human.flash_lighting_fx(5, 7, current_color)
		var/obj/item/organ/stomach/ethereal/stomach = _human.getorganslot(ORGAN_SLOT_STOMACH)
		playsound(_human, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
		_human.cut_overlay(overcharge)
		tesla_zap(_human, 2, (stomach.crystal_charge / ELZUOSE_CHARGE_SCALING_MULTIPLIER) * 50, ZAP_OBJ_DAMAGE | ZAP_ALLOW_DUPLICATES)
		if(istype(stomach))
			stomach.adjust_charge(ELZUOSE_CHARGE_FULL - stomach.crystal_charge)
		to_chat(_human,span_warning("You violently discharge energy!"))
		_human.visible_message(span_danger("[_human] violently discharges energy!"))
		if(prob(10)) //chance of developing heart disease to dissuade overcharging oneself
			var/datum/disease/D = new /datum/disease/heart_failure
			_human.ForceContractDisease(D)
			to_chat(_human, span_userdanger("You're pretty sure you just felt your heart stop for a second there."))
			_human.playsound_local(_human, 'sound/effects/singlebeat.ogg', 100, 0)
		_human.Paralyze(100)
		return

/datum/species/elzuose/proc/get_charge(mob/living/carbon/_human) //this feels like it should be somewhere else. Eh?
	var/obj/item/organ/stomach/ethereal/stomach = _human.getorganslot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		return stomach.crystal_charge
	return ELZUOSE_CHARGE_NONE
