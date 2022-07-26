//Slime guardian- modified support guardian who has higher utility but is less potent in battle
/mob/living/simple_animal/hostile/guardian/slime
	a_intent = INTENT_HARM
	speed = 0
	damage_coeff = list(BRUTE = 0.7, BURN = 0.7, TOX = 0.7, CLONE = 0.7, STAMINA = 0, OXY = 0.7)
	melee_damage_lower = 10
	melee_damage_upper = 10
	melee_damage_type = TOX
	playstyle_string = "<span class='holoparasite'>As a <b>slime</b> type, you can toggle between a weak combat mode, and a strong healing mode that nourishes and repairs damage. This mode also works on slimes. Be warned: You are more vulnerable to damage then most holoparasites.</span>"
	magic_fluff_string = "<span class='holoparasite'>..And draw the Xenobiologist, a purveyor of godlike power.</span>"
	carp_fluff_string = "<span class='holoparasite'>CARP CARP CARP! You caught a slimy carp. Gross, maybe you should throw this one back.</span>"
	tech_fluff_string = "<span class='holoparasite'>Boot sequence complete. Xenobiological support module active. Holoparasite swarm online.</span>"
	miner_fluff_string = "<span class='holoparasite'>You encounter... Slime, the master of xenobiology.</span>"
	slime_fluff_string = "<span class='holoparasite'>The crystal in your hand shatters into mist, which forms a strange, slimy figure!</span>"
	toggle_button_type = /atom/movable/screen/guardian/ToggleMode
	var/toggle = FALSE

/mob/living/simple_animal/hostile/guardian/slime/Initialize()
	. = ..()
	var/datum/atom_hud/medsensor = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	medsensor.add_hud_to(src)

/mob/living/simple_animal/hostile/guardian/slime/AttackingTarget()
	. = ..()
	if(is_deployed() && toggle && isslime(target))
		var/mob/living/simple_animal/slime/slime = target
		slime.add_nutrition(rand(14, 30))
		slime.adjustHealth(10)
		return

	if(is_deployed() && toggle && iscarbon(target))
		var/mob/living/carbon/C = target
		C.adjustBruteLoss(-7)
		C.adjustFireLoss(-7)
		C.adjustOxyLoss(-7)
		C.adjustToxLoss(-7)
		C.adjustCloneLoss(-0.5)
		C.adjust_nutrition(10)
		var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal(get_turf(C))
		if(guardiancolor)
			H.color = guardiancolor
		if(C == summoner)
			update_health_hud()
			med_hud_set_health()
			med_hud_set_status()

	if(is_deployed() && toggle == FALSE && iscarbon(target))
		if(prob(20))
			var/mob/living/carbon/D = target
			D.Paralyze(25)
			D.visible_message("<span class='danger'>\The [src] knocks down \the [D]!</span>", \
					"<span class='userdanger'>\The [src] knocks you down!</span>")

/mob/living/simple_animal/hostile/guardian/slime/ToggleMode()
	if(src.loc == summoner)
		if(toggle)
			a_intent = INTENT_HARM
			speed = -1
			damage_coeff = list(BRUTE = 0.7, BURN = 0.7, TOX = 0.2, CLONE = 0.7, STAMINA = 0, OXY = 0.7)
			melee_damage_lower = 15
			melee_damage_upper = 15
			to_chat(src, "<span class='danger'><B>Blorble... You switch to combat mode.</span></B>")
			toggle = FALSE
		else
			a_intent = INTENT_HELP
			speed = 2
			damage_coeff = list(BRUTE = 1.2, BURN = 1.2, TOX = 0.7, CLONE = 1.2, STAMINA = 0, OXY = 1.2)
			melee_damage_lower = 0
			melee_damage_upper = 0
			to_chat(src, "<span class='danger'><B>You switch to nourshing mode. Yummy.</span></B>")
			toggle = TRUE
	else
		to_chat(src, "<span class='danger'><B>You have to be recalled to toggle modes!</span></B>")
