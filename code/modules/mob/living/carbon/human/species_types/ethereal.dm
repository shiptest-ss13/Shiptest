#define ETHEREAL_EMAG_COLORS list("#00ffff", "#ffc0cb", "#9400D3", "#4B0082", "#0000FF", "#00FF00", "#FFFF00", "#FF7F00", "#FF0000") //WS Edit -- Multitool Color Change

/datum/species/ethereal
	name = "Ethereal"
	id = "ethereal"
	attack_verb = "burn"
	attack_sound = 'sound/weapons/etherealhit.ogg'
	miss_sound = 'sound/weapons/etherealmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/ethereal
	mutantstomach = /obj/item/organ/stomach/ethereal
	mutanttongue = /obj/item/organ/tongue/ethereal
	exotic_blood = /datum/reagent/consumable/liquidelectricity //Liquid Electricity. fuck you think of something better gamer
	siemens_coeff = 0.5 //They thrive on energy
	brutemod = 1.25 //They're weak to punches
	attack_type = BURN //burn bish
	damage_overlay_type = "" //We are too cool for regular damage overlays
	species_traits = list(DYNCOLORS, AGENDER, HAIR, FACEHAIR)    //WS Edit - Gave Ethereals Beards
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	species_language_holder = /datum/language_holder/ethereal
	inherent_traits = list(TRAIT_NOHUNGER)
	sexes = FALSE //no fetish content allowed
	toxic_food = NONE
	// Body temperature for ethereals is much higher then humans as they like hotter environments
	bodytemp_normal = (BODYTEMP_NORMAL + 50)
	bodytemp_heat_damage_limit = FIRE_MINIMUM_TEMPERATURE_TO_SPREAD // about 150C
	// Cold temperatures hurt faster as it is harder to move with out the heat energy
	bodytemp_cold_damage_limit = (T20C - 10) // about 10c
	hair_color = "fixedmutcolor"
	hair_alpha = 140
	var/current_color
	var/EMPeffect = FALSE
	var/emag_effect = FALSE                          //WS Edit -- Multitool Color Change
	var/static/unhealthy_color = rgb(237, 164, 149)  //WS Edit -- Multitool Color Change
	loreblurb = "Ethereals are organic humanoid beings with a blood that has strange luminiscent and electrical properties. They require electricity to survive, rather than food, and cast bright, colorful light from their bodies."
	var/drain_time = 0 //used to keep ethereals from spam draining power sources
	var/obj/effect/dummy/lighting_obj/ethereal_light


/datum/species/ethereal/Destroy(force)
	if(ethereal_light)
		QDEL_NULL(ethereal_light)
	return ..()


/datum/species/ethereal/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(!ishuman(C))
		return
	var/mob/living/carbon/human/ethereal = C
	default_color = "#[ethereal.dna.features["ethcolor"]]"
	//WS Removal -- Multitool Color Change
	RegisterSignal(ethereal, COMSIG_ATOM_EMAG_ACT, .proc/on_emag_act)
	RegisterSignal(ethereal, COMSIG_ATOM_EMP_ACT, .proc/on_emp_act)
	ethereal_light = ethereal.mob_light()
	spec_updatehealth(ethereal)


/datum/species/ethereal/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	UnregisterSignal(C, COMSIG_ATOM_EMAG_ACT)
	UnregisterSignal(C, COMSIG_ATOM_EMP_ACT)
	QDEL_NULL(ethereal_light)
	return ..()


/datum/species/ethereal/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_ethereal_name()

	var/randname = ethereal_name()

	return randname


/datum/species/ethereal/spec_updatehealth(mob/living/carbon/human/H)
	. = ..()
	if(H.stat != DEAD && !EMPeffect)
		//WS Start -- Multitool Color Change
		if(!emag_effect)
			current_color = health_adjusted_color(H, default_color)
		set_ethereal_light(H, current_color)
		ethereal_light.set_light_on(TRUE)
		fixed_mut_color = copytext_char(current_color, 2)
		//WS End
	else
		ethereal_light.set_light_on(FALSE)
		fixed_mut_color = rgb(128,128,128)
	H.update_body()

//WS Start -- Multitool Color Change
/datum/species/ethereal/proc/health_adjusted_color(mob/living/carbon/human/H, default_color)
	var/health_percent = max(H.health, 0) / 100

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

/datum/species/ethereal/proc/set_ethereal_light(mob/living/carbon/human/H, current_color)
	var/health_percent = max(H.health, 0) / 100

	var/light_range = 1 + (2 * health_percent)
	var/light_power = 1 + (1 * health_percent)

	ethereal_light.set_light_range_power_color(light_range, light_power, current_color)
//WS End

/datum/species/ethereal/proc/on_emp_act(mob/living/carbon/human/H, severity)
	EMPeffect = TRUE
	spec_updatehealth(H)
	to_chat(H, "<span class='notice'>You feel the light of your body leave you.</span>")
	switch(severity)
		if(EMP_LIGHT)
			addtimer(CALLBACK(src, .proc/stop_emp, H), 10 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE) //We're out for 10 seconds
		if(EMP_HEAVY)
			addtimer(CALLBACK(src, .proc/stop_emp, H), 20 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE) //We're out for 20 seconds

/datum/species/ethereal/proc/on_emag_act(mob/living/carbon/human/H, mob/user)
	if(emag_effect)                              //WS Edit -- Multitool Color Change
		return
	emag_effect = TRUE                           //WS Edit -- Multitool Color Change
	if(user)
		to_chat(user, "<span class='notice'>You tap [H] on the back with your card.</span>")
	H.visible_message("<span class='danger'>[H] starts flickering in an array of colors!</span>")
	handle_emag(H)
	addtimer(CALLBACK(src, .proc/stop_emag, H), 30 SECONDS) //Disco mode for 30 seconds! This doesn't affect the ethereal at all besides either annoying some players, or making someone look badass.


/datum/species/ethereal/spec_life(mob/living/carbon/human/H)
	.=..()
	handle_charge(H)


/datum/species/ethereal/proc/stop_emp(mob/living/carbon/human/H)
	EMPeffect = FALSE
	spec_updatehealth(H)
	to_chat(H, "<span class='notice'>You feel more energized as your shine comes back.</span>")


/datum/species/ethereal/proc/handle_emag(mob/living/carbon/human/H)
	if(!emag_effect)                              //WS Edit -- Multitool Color Change
		return
	current_color = pick(ETHEREAL_EMAG_COLORS)    //WS Edit -- Multitool Color Change
	spec_updatehealth(H)
	addtimer(CALLBACK(src, .proc/handle_emag, H), 5) //Call ourselves every 0.5 seconds to change color

/datum/species/ethereal/proc/stop_emag(mob/living/carbon/human/H)
	emag_effect = FALSE                           //WS Edit -- Multitool Color Change
	spec_updatehealth(H)
	H.visible_message("<span class='danger'>[H] stops flickering and goes back to their normal state!</span>")

/datum/species/ethereal/proc/handle_charge(mob/living/carbon/human/H)
	brutemod = 1.25
	switch(get_charge(H))
		//WS Begin - Display Ethereal no charge icon
		if(ETHEREAL_CHARGE_NONE to ETHEREAL_CHARGE_LOWPOWER)
			if(get_charge(H) == ETHEREAL_CHARGE_NONE)
				H.throw_alert("ethereal_charge", /atom/movable/screen/alert/etherealcharge, 3)
			else
				H.throw_alert("ethereal_charge", /atom/movable/screen/alert/etherealcharge, 2)
			//WS End
			if(H.health > 10.5)
				apply_damage(0.2, TOX, null, null, H)
			brutemod = 1.75
		if(ETHEREAL_CHARGE_LOWPOWER to ETHEREAL_CHARGE_NORMAL)
			H.throw_alert("ethereal_charge", /atom/movable/screen/alert/etherealcharge, 1)
			brutemod = 1.5
		if(ETHEREAL_CHARGE_FULL to ETHEREAL_CHARGE_OVERLOAD)
			H.throw_alert("ethereal_overcharge", /atom/movable/screen/alert/ethereal_overcharge, 1)
			brutemod = 1.5
		if(ETHEREAL_CHARGE_OVERLOAD to ETHEREAL_CHARGE_DANGEROUS)
			H.throw_alert("ethereal_overcharge", /atom/movable/screen/alert/ethereal_overcharge, 2)
			brutemod = 1.75
			if(prob(10)) //10% each tick for ethereals to explosively release excess energy if it reaches dangerous levels
				discharge_process(H)
		else
			H.clear_alert("ethereal_charge")
			H.clear_alert("ethereal_overcharge")

/datum/species/ethereal/proc/discharge_process(mob/living/carbon/human/H)
	to_chat(H, "<span class='warning'>You begin to lose control over your charge!</span>")
	H.visible_message("<span class='danger'>[H] begins to spark violently!</span>")
	var/static/mutable_appearance/overcharge //shameless copycode from lightning spell
	overcharge = overcharge || mutable_appearance('icons/effects/effects.dmi', "electricity", EFFECTS_LAYER)
	H.add_overlay(overcharge)
	if(do_mob(H, H, 50, 1))
		H.flash_lighting_fx(5, 7, current_color)
		var/obj/item/organ/stomach/ethereal/stomach = H.getorganslot(ORGAN_SLOT_STOMACH)
		playsound(H, 'sound/magic/lightningshock.ogg', 100, TRUE, extrarange = 5)
		H.cut_overlay(overcharge)
		tesla_zap(H, 2, (stomach.crystal_charge / ETHEREAL_CHARGE_SCALING_MULTIPLIER) * 50, ZAP_OBJ_DAMAGE | ZAP_ALLOW_DUPLICATES)       //WS Edit -- Ethereal Charge Scaling
		if(istype(stomach))
			stomach.adjust_charge(ETHEREAL_CHARGE_FULL - stomach.crystal_charge)     //WS Edit -- Ethereal Charge Scaling
		to_chat(H, "<span class='warning'>You violently discharge energy!</span>")
		H.visible_message("<span class='danger'>[H] violently discharges energy!</span>")
		if(prob(10)) //chance of developing heart disease to dissuade overcharging oneself
			var/datum/disease/D = new /datum/disease/heart_failure
			H.ForceContractDisease(D)
			to_chat(H, "<span class='userdanger'>You're pretty sure you just felt your heart stop for a second there..</span>")
			H.playsound_local(H, 'sound/effects/singlebeat.ogg', 100, 0)
		H.Paralyze(100)
		return

/datum/species/ethereal/proc/get_charge(mob/living/carbon/H) //this feels like it should be somewhere else. Eh?
	var/obj/item/organ/stomach/ethereal/stomach = H.getorganslot(ORGAN_SLOT_STOMACH)
	if(istype(stomach))
		return stomach.crystal_charge
	return ETHEREAL_CHARGE_NONE

//WS Start -- Multitool Color Change
/datum/species/ethereal/spec_attacked_by(obj/item/I, mob/living/user, obj/item/bodypart/affecting, intent, mob/living/carbon/human/H)
	if(istype(I, /obj/item/multitool))
		if(user.a_intent == INTENT_HARM)
			. = ..() // multitool beatdown
			return

		if (emag_effect == TRUE)
			to_chat(user, "<span class='danger'>The multitool can't get a lock on [H]'s EM frequency</span>")
			return

		if(user != H)
			// random color change
			default_color = "#" + GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)]
			current_color = health_adjusted_color(H, default_color)
			spec_updatehealth(H)
			H.visible_message("<span class='danger'>[H]'s EM frequency is scrambled to a random color.</span>")
		else
			// select new color
			var/new_etherealcolor = input(user, "Choose your ethereal color", "Character Preference") as null|anything in GLOB.color_list_ethereal
			if(new_etherealcolor)
				default_color = "#" + GLOB.color_list_ethereal[new_etherealcolor]
				current_color = health_adjusted_color(H, default_color)
				spec_updatehealth(H)
				H.visible_message("<span class='notice'>[H] modulates \his EM frequency to [new_etherealcolor].</span>")
	else
		. = ..()
//WS End
