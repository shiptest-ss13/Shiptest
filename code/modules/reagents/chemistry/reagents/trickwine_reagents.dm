///////////////////
// STATUS EFFECT //
///////////////////
/atom/movable/screen/alert/status_effect/trickwine
	name = "Trickwine"
	desc = "Your empowered or weakened by a trickwine!"
	icon_state = "breakaway_flask"

/atom/movable/screen/alert/status_effect/trickwine/proc/setup(datum/reagent/consumable/ethanol/trickwine/trickwine_reagent)
	name = trickwine_reagent.name
	icon_state = "template"
	cut_overlays()
	var/icon/flask_icon = icon('icons/obj/drinks/drinks.dmi', trickwine_reagent.breakaway_flask_icon_state)
	add_overlay(flask_icon)

/datum/status_effect/trickwine
	id = "trick_wine"
	examine_text = span_notice("They seem to be affected by a trickwine.")
	alert_type = /atom/movable/screen/alert/status_effect/trickwine
	// Try to match normal reagent tick rate based on on_mob_life
	tick_interval = 20
	var/obj/effect/abstract/particle_holder/particle_generator
	// Used to make icon for status_effect
	var/flask_icon_state
	var/flask_icon = 'icons/obj/drinks/drinks.dmi'
	// Used for mod outline
	var/reagent_color = "#FFFFFF"
	var/message_apply_others = "is affected by a wine!"
	var/message_apply_self = "You are affected by trickwine!"
	var/message_remove_others = "is no longer affected by a wine!"
	var/message_remove_self = "You are no longer affected by trickwine!"
	var/trickwine_examine_text
	var/alert_desc
	// Applied and removes with reagent
	var/trait

/datum/status_effect/trickwine/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent)
	flask_icon_state = trickwine_reagent.breakaway_flask_icon_state
	if(!trickwine_reagent)
		CRASH("A trickwine status effect was created without a attached reagent")
	reagent_color = trickwine_reagent.color
	. = ..()
	if(istype(linked_alert, /atom/movable/screen/alert/status_effect/trickwine))
		var/atom/movable/screen/alert/status_effect/trickwine/trickwine_alert = linked_alert
		trickwine_alert.setup(trickwine_reagent)
		trickwine_alert.desc = alert_desc


/datum/status_effect/trickwine/on_apply()
	owner.visible_message(span_notice("[owner] " + message_apply_others), span_notice(message_apply_self))
	if(trait)
		ADD_TRAIT(owner, trait, id)
	if(!particle_generator)
		particle_generator = new(owner, /particles/trickwine_drunk, PARTICLE_ATTACH_MOB)
		particle_generator.particles.color = reagent_color
	return ..()

/datum/status_effect/trickwine/on_remove()
	owner.visible_message(span_notice("[owner] " + message_remove_others), span_notice(message_remove_self))
	if(trait)
		REMOVE_TRAIT(owner, trait, id)
	if(particle_generator)
		QDEL_NULL(particle_generator)

//////////
// BUFF //
//////////
/datum/status_effect/trickwine/buff
	id = "trick_wine_buff"
	alert_desc = "Your empowered a trickwine!"

/datum/status_effect/trickwine/buff/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent)
	. = ..()
	if(trickwine_examine_text)
		examine_text = span_notice(trickwine_examine_text)
	else
		examine_text = span_notice("SUBJECTPRONOUN seems to be affected by [trickwine_reagent.name].")

////////////
// DEBUFF //
////////////
/datum/status_effect/trickwine/debuff
	id = "trick_wine_debuff"
	alert_desc = "Your weakened a trickwine!"

/datum/status_effect/trickwine/debuff/on_creation(mob/living/new_owner, datum/reagent/consumable/ethanol/trickwine/trickwine_reagent, set_duration = null)
	if(isnum(set_duration))
		duration = set_duration
	. = ..()
	if(trickwine_examine_text)
		examine_text = span_notice(trickwine_examine_text)
	else
		examine_text = span_notice("SUBJECTPRONOUN seems to be covered in [trickwine_reagent.name].")

//////////////
// REAGENTS //
//////////////

/datum/reagent/consumable/ethanol/trickwine
	name = "Trickwine"
	var/datum/status_effect/trickwine/debuff_effect = null
	var/datum/status_effect/trickwine/buff_effect = null
	//the kind of ammo you get from dipping 38 in this
	var/obj/item/ammo_casing/c38/dip_ammo_type = null
	var/dip_consumption = 2

/datum/reagent/consumable/ethanol/trickwine/dip_object(obj/item/I, mob/user, obj/item/reagent_containers/H)
	. = ..()
	if(!dip_ammo_type)
		return
	if(istype(I, /obj/item/ammo_casing/c38))
		if(volume > dip_consumption)
			var/obj/item/ammo_casing/c38/new_ammo = new dip_ammo_type(user.loc)
			user.put_in_hands(new_ammo)
			to_chat(user,span_notice("You dip \the [I] into the trickwine, suffusing it with the wine's effects."))
			H.reagents.remove_reagent(src.type, dip_consumption)
			qdel(I)
			return TRUE
		else
			to_chat(user,span_warning("There's not enough trickwine left to soak \the [I]!"))
			return FALSE

	else if(istype(I, /obj/item/ammo_box/magazine/ammo_stack))
		var/obj/item/ammo_box/magazine/ammo_stack/dip_stack = I
		if(dip_stack.ammo_type == /obj/item/ammo_casing/c38)
			var/trickwine_used = dip_consumption * dip_stack.ammo_count(FALSE)
			if(volume > trickwine_used)
				var/obj/item/ammo_box/magazine/ammo_stack/prefilled/new_stack
				new_stack = new(user.loc, dip_stack.ammo_count(FALSE), dip_ammo_type)
				user.put_in_hands(new_stack)
				to_chat(user,span_notice("You dip \the [I] into the trickwine, suffusing it with the wine's effects."))
				H.reagents.remove_reagent(src.type, trickwine_used)
				qdel(I)
				return TRUE
			else
				to_chat(user,span_warning("There's not enough trickwine left to soak \the [I]!"))
				return FALSE
		return FALSE
	else
		return FALSE



/datum/reagent/consumable/ethanol/trickwine/on_mob_metabolize(mob/living/consumer)
	if(buff_effect)
		consumer.apply_status_effect(buff_effect, src)
	..()

/datum/reagent/consumable/ethanol/trickwine/on_mob_end_metabolize(mob/living/consumer)
	if(buff_effect && consumer.has_status_effect(buff_effect))
		consumer.remove_status_effect((buff_effect))
	..()

/datum/reagent/consumable/ethanol/trickwine/expose_mob(mob/living/exposed_mob, method = TOUCH, reac_volume)
	if(method == TOUCH)
		if(debuff_effect)
			exposed_mob.apply_status_effect(debuff_effect, src, (reac_volume / ETHANOL_METABOLISM) * 10)
	return ..()


/datum/reagent/consumable/ethanol/trickwine/ash_wine
	name = "Wine Of Ash"
	description = "A traditional sacrament for members of the Saint-Roumain Militia. Believed to grant visions, seeing use both in ritual and entertainment within the Militia."
	color = "#6CC66C"
	boozepwr = 80
	quality = DRINK_VERYGOOD
	taste_description = "a rustic fruit, with hints of sweet yet tangy ash."
	glass_name = "Wine Of Ash"
	glass_desc = "A traditional sacrament for members of the Saint-Roumain Militia. Believed to grant visions, seeing use both in ritual and entertainment within the Militia."
	breakaway_flask_icon_state = "baflaskashwine"
	buff_effect = /datum/status_effect/trickwine/buff/ash
	debuff_effect = /datum/status_effect/trickwine/debuff/ash
	dip_ammo_type = /obj/item/ammo_casing/c38/ashwine

/datum/reagent/consumable/ethanol/trickwine/ash_wine/on_mob_life(mob/living/M)
	var/high_message = pick("You feel far more devoted to the cause", "You feel like you should go on a hunt")
	var/cleanse_message = pick("Divine light purifies you.", "You are purged of foul spirts.")
	if(prob(10))
		M.adjust_drugginess(5)
		to_chat(M, span_notice("[high_message]"))
	if(M.faction && ("roumain" in M.faction))
		M.adjustToxLoss(-2)
		if(prob(10))
			to_chat(M, span_notice("[cleanse_message]"))
	return ..()

/datum/status_effect/trickwine/buff/ash
	id = "ash_wine_buff"
trickwine_examine_text = "SUBJECTPRONOUN is filled with energy and devotion. Their eyes are dialated and they seem to be twitching."
	message_apply_others =  "jolts, their eyes dilating with fervant energy."
	message_apply_self = "Wonderous thoughts of righteous fervor fill your mind!"
	message_remove_others = "slows, their fervor subsiding."
	message_remove_self = "The righteous reverie leaves you."
	alert_desc = "Glorious visions of hunt and reverie surround you! If you are truly faithful, your toxin damage will slowly heal." //by "truly faithful" we mean "roumain" in M.faction. Militamen only.

/datum/status_effect/trickwine/debuff/ash
	id = "ash_wine_debuff"
	rickwine_examine_text = "SUBJECTPRONOUN is covered in a thin layer of ash. They are twitching and jittery."
	message_apply_others =  "begins twitching uncontrolably."
	message_apply_self = "Your vision spins, a dizzying energy overpowering you!"
	message_remove_others = "stills, their jittering fit subsiding."
	message_remove_self = "The overpowering disorientation fades."
	alert_desc = "Disorienting visions have overcome you! You will randomly become dizzy or druggy while the visions last."

/datum/status_effect/trickwine/debuff/ash/tick()
	switch(pick("jitter", "dizzy", "drug"))
		if("jitter")
			owner.adjust_jitter(3)
		if("dizzy")
			owner.Dizzy(2)
		if("drug")
			owner.adjust_drugginess(3)

/datum/reagent/consumable/ethanol/trickwine/ice_wine
	name = "Wine Of Ice"
	description = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	color = "#C0F1EE"
	boozepwr = 70
	taste_description = "a weighty meat, undercut by a mild pepper."
	glass_name = "Wine Of Ice"
	glass_desc = "A specialized brew utilized by members of the Saint-Roumain Militia, designed to assist in temperature regulation while working in hot environments. Known to give one the cold shoulder when thrown."
	breakaway_flask_icon_state = "baflaskicewine"
	buff_effect = /datum/status_effect/trickwine/buff/ice
	debuff_effect = /datum/status_effect/trickwine/debuff/ice
	dip_ammo_type = /obj/item/ammo_casing/c38/iceblox

/datum/reagent/consumable/ethanol/trickwine/ice_wine/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal(), FALSE)
	M.adjustFireLoss(-0.25)
	if(prob(5))
		to_chat(M, span_notice("Sweat runs down your body."))
	return ..()

/datum/status_effect/trickwine/buff/ice
	id = "ice_wine_buff"
	trickwine_examine_text = "SUBJECTPRONOUN is coated in a thin layer of icy mist."
	message_apply_others =  "begins emanating icy mist."
	message_apply_self = "An internal cold flows through your body."
	message_remove_others = "stops emanating icy mist."
	message_remove_self = "Your internal cold dissipates, warmth returning to you."
	alert_desc = "You're being protected by an inner winter! You will thermoregulate faster when overheating, and you cannot be set on fire."
	trait = TRAIT_NOFIRE

/datum/status_effect/trickwine/debuff/ice
	id = "ice_wine_debuff"
	trickwine_examine_text = "SUBJECTPRONOUN is encased in cloudy ice."
	message_apply_others = "becomes frozen in a cube!"
	message_apply_self = "" //the ice cubing has its own big words(tm) messages.
	message_remove_others = "is freed, the ice cube imprisoning them melting into nothingness."
	message_remove_self = ""
	alert_desc = "A block of ice has entrapped you! You will be immobilized until the ice subsides."
	var/icon/cube

/datum/status_effect/trickwine/debuff/ice/on_apply()
	RegisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(owner_moved))
	owner.Paralyze(duration)
	to_chat(owner, span_userdanger("You become frozen in a cube!"))
	cube = icon('icons/effects/freeze.dmi', "ice_cube")
	var/icon/size_check = icon(owner.icon, owner.icon_state)
	cube.Scale(size_check.Width(), size_check.Height())
	owner.add_overlay(cube)
	return ..()

/// Blocks movement from the status effect owner
/datum/status_effect/trickwine/debuff/ice/proc/owner_moved()
	return COMPONENT_MOVABLE_BLOCK_PRE_MOVE

/datum/status_effect/trickwine/debuff/ice/on_remove()
	to_chat(owner, span_notice("The cube melts!"))
	owner.cut_overlay(cube)
	UnregisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE)

/datum/reagent/consumable/ethanol/trickwine/shock_wine
	name = "Lightning's Blessing"
	description = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	color = "#FEFEB8"
	boozepwr = 50
	taste_description = "a sharp and unrelenting citrus"
	glass_name = "Lightning's Blessing"
	glass_desc = "A stimulating brew utilized by members of the Saint-Roumain Militia, created to allow trackers to keep up with highly mobile prey. Known to have a shocking effect when thrown"
	breakaway_flask_icon_state = "baflaskshockwine"
	buff_effect = /datum/status_effect/trickwine/buff/shock
	debuff_effect = /datum/status_effect/trickwine/debuff/shock
	dip_ammo_type = /obj/item/ammo_casing/c38/shock

/datum/reagent/consumable/ethanol/trickwine/shock_wine/expose_mob(mob/living/M, method=TOUCH, reac_volume)
	if(method == TOUCH)
		M.electrocute_act(reac_volume, src, siemens_coeff = 1, flags = SHOCK_NOSTUN|SHOCK_TESLA)
		do_sparks(5, FALSE, M)
		playsound(M, 'sound/machines/defib_zap.ogg', 100, TRUE)
	return ..()

/datum/status_effect/trickwine/buff/shock
	id = "shock_wine_buff"
	trickwine_examine_text = "SUBJECTPRONOUN is crackling with energy."
	message_apply_others = "begins crackling with static energy!"
	message_apply_self = "You feel like a bolt of lightning!"
	message_remove_others = "has lost their static energy."
	message_remove_self = "Inertia leaves your body!"
	alert_desc = "You feel faster then lightning and crackling with energy! You're immune to shock damage and move faster!"
	trait = TRAIT_SHOCKIMMUNE

/datum/status_effect/trickwine/buff/shock/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	return ..()

/datum/status_effect/trickwine/buff/shock/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/shock_wine)
	..()

/datum/status_effect/trickwine/debuff/shock
	id = "shock_wine_debuff"
	trickwine_examine_text = "SUBJECTPRONOUN is covered in sparking fluid."
	message_apply_others =  "seizes as a burst of arcing lightning surrounds them!"
	message_apply_self = "A searing pain tears at your muscles!"
	message_remove_others = "stops sparking, the trickwines' energy exhausted."
	message_remove_self = "The electrical energy fades."
	alert_desc = "You're saturated with residual charge! You will spark intermittently, which may ignite some flammable substances."

/datum/status_effect/trickwine/debuff/shock/tick()
	if(rand(25))
		do_sparks(5, FALSE, owner)

/datum/reagent/consumable/ethanol/trickwine/hearth_wine
	name = "Hearthflame"
	description = "A fiery brew utilized by members of the Saint-Roumain Militia, engineered to heat the body and cauterize wounds. Goes out in a blaze of glory when thrown."
	color = "#FEE185"
	boozepwr = 70
	taste_description = "apple cut apart by tangy pricks"
	glass_name = "Hearthflame"
	glass_desc = "A fiery brew utilized by members of the Saint-Roumain Militia, engineered to heat the body and cauterize wounds. Goes out in a blaze of glory when thrown."
	breakaway_flask_icon_state = "baflaskhearthwine"
	buff_effect = /datum/status_effect/trickwine/buff/hearth
	debuff_effect = /datum/status_effect/trickwine/debuff/hearth
	dip_ammo_type = /obj/item/ammo_casing/c38/hotshot

//This needs a buff
/datum/reagent/consumable/ethanol/trickwine/hearth_wine/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, M.get_body_temp_normal(), FALSE)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.heal_bleeding(0.25)
	return ..()

/datum/status_effect/trickwine/buff/hearth
	id = "hearth_wine_buff"
	trickwine_examine_text = "SUBJECTPRONOUN is surrounded by a quivering heat haze."
	message_apply_others =  "begins to exude a faint cloud of steam."
	message_apply_self = "An energizing warmth spreads from your stomach."
	message_remove_others = "cools down, their vaporous aura dissipating."
	message_remove_self = "The warming sensation fades."
	alert_desc = "You're being fueled by an inner fire! You're resistant to cold temperatures and your bleeding wounds will auto-cauterize."
	trait = TRAIT_RESISTCOLD

/datum/status_effect/trickwine/debuff/hearth
	id = "hearth_wine_debuff"
	trickwine_examine_text = "SUBJECTPRONOUN is shedding flaming fumes!"
	message_apply_others =  "becomes covered in burning fluid!"
	message_apply_self = "Your skin begins to sizzle and spark agonizingly!"
	message_remove_others = "stops emmanating fire."
	message_remove_self = "The painful sizzling subsides."
	alert_desc = "You're covered in flaming residue! You will create fires wherever you step."

/datum/status_effect/trickwine/debuff/hearth/tick()
	//owner.fire_act()
	var/turf/owner_turf = get_turf(owner)
	owner_turf.ignite_turf(duration)
	//new /obj/effect/hotspot(owner_turf, 1)

/datum/reagent/consumable/ethanol/trickwine/force_wine
	name = "Forcewine"
	description = "Creates a barrier on the skin that catches shrapnel and when reversed locks threats down with a barrier"
	color = "#709AAF"
	boozepwr = 70
	taste_description = "the strength of your convictions"
	glass_name = "Forcewine"
	glass_desc = "Creates a barrier on the skin that catches shrapnel and when reversed locks threats down with a barrier"
	breakaway_flask_icon_state = "baflaskforcewine"
	buff_effect = /datum/status_effect/trickwine/buff/force
	debuff_effect = /datum/status_effect/trickwine/debuff/force
	dip_ammo_type = /obj/item/ammo_casing/c38/force

/datum/status_effect/trickwine/buff/force
	id = "force_wine_buff"
	trickwine_examine_text = "SUBJECTPRONOUN is glowing a dim grey. "//yes i know grey isnt a real color of light, because you can't make light darker than itself. This is magic forcefield wine. i don't care.
	message_apply_others =  "begins to exude a viscous aura."
	message_apply_self = "The space around you thickens, radiating a faint grey."
	message_remove_others = "'s aura fades away."
	message_remove_self = "Space becomes vulnerably thin once more."
	alert_desc = "The space around you has become thick and viscous! It will catch pointy things, rendering you immune to piercing effects such as shrapnel."
	// No shrapnel seems useful
	trait = TRAIT_PIERCEIMMUNE

/datum/status_effect/trickwine/debuff/force
	id = "force_wine_debuff"
	trickwine_examine_text = "" //instantanious effect
	message_apply_others =  "is suddenly surrounded by a cloud of resinous foam."
	message_apply_self = "A resinous foam bursts forth, entrapping you!"
	message_remove_others = ""
	message_remove_self = ""//instantanious effect
	alert_desc = ""

/datum/status_effect/trickwine/debuff/force/on_apply()
	var/turf/turf = get_turf(owner)
	var/turf/other_turf
	new /obj/structure/foamedmetal/forcewine(turf, duration)
	for(var/direction in GLOB.cardinals)
		other_turf = get_step(turf, direction)
		new /obj/structure/foamedmetal/forcewine(other_turf, duration)
	return ..()

/datum/reagent/consumable/ethanol/trickwine/prism_wine
	name = "Prismwine"
	description = "A glittering brew utilized by members of the Saint-Roumain Militia, mixed to defend against the blasts and burns of foes and fauna alike. Softens targets against your own burns when thrown."
	color = "#F0F0F0"
	boozepwr = 70
	taste_description = "the reflective quality of meditation"
	glass_name = "Prismwine"
	glass_desc = "A glittering brew utilized by members of the Saint-Roumain Militia, mixed to defend against the blasts and burns of foes and fauna alike. Softens targets against your own burns when thrown."
	breakaway_flask_icon_state = "baflaskprismwine"
	buff_effect = /datum/status_effect/trickwine/buff/prism
	debuff_effect = /datum/status_effect/trickwine/debuff/prism
	dip_ammo_type = /obj/item/ammo_casing/c38/dumdum

#define MAX_REFLECTS 3
/datum/status_effect/trickwine/buff/prism
	id = "prism_wine_buff"
	trickwine_examine_text = "SUBJECTPRONOUN is sweating a glossy resinous fluid."
	message_apply_others =  "starts sweating viscous resin."
	message_apply_self = "Your sweat becomes viscous and glossy."
	message_remove_others = "stops sweating so much."
	message_remove_self = "Your sweat thins and drips away."
	alert_desc = "You're sweating reflective resin! Accumulate charges by moving, up to three at once, and they will be consumed to reflect incoming lasers."
	var/reflect_count = 0
	var/recent_movement = FALSE

/datum/status_effect/trickwine/buff/prism/on_apply()
	RegisterSignal(owner, COMSIG_CHECK_REFLECT, PROC_REF(on_check_reflect))
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	return ..()

/datum/status_effect/trickwine/buff/prism/on_remove()
	UnregisterSignal(owner, list(COMSIG_CHECK_REFLECT, COMSIG_MOVABLE_MOVED))
	..()

/datum/status_effect/trickwine/buff/prism/tick()
	. = ..()
	if(prob(25) && reflect_count < MAX_REFLECTS)
		if(recent_movement)
			adjust_charge(1)
			to_chat(owner, span_notice("Your resin sweat builds up another layer!"))
		else
			to_chat(owner, span_warning("You need to keep moving to build up resin sweat!"))
	recent_movement = FALSE

/datum/status_effect/trickwine/buff/prism/proc/adjust_charge(change)
	reflect_count = clamp(reflect_count + change, 0, MAX_REFLECTS)
	owner.add_filter(id, 2, drop_shadow_filter(x = 0, y = -1, size = 1 + reflect_count, color = reagent_color))

/datum/status_effect/trickwine/buff/prism/proc/on_check_reflect(mob/living/carbon/human/owner, def_zone)
	SIGNAL_HANDLER
	if(reflect_count > 0)
		to_chat(owner, span_notice("Your resin sweat protects you!"))
		adjust_charge(-1)
		return TRUE

// The idea is that its a resin made of sweat, therfore stay moving
/datum/status_effect/trickwine/buff/prism/proc/on_move()
	recent_movement = TRUE
#undef MAX_REFLECTS

/datum/status_effect/trickwine/debuff/prism
	id = "prism_wine_debuff"
	trickwine_examine_text = "SUBJECTPRONOUN is soaked in refractive resin."
	message_apply_others =  "is covered in light focusing sludge."
	message_apply_self = "A refractive fluid covers you!"
	message_remove_others = "escapes their refractive coating."
	message_remove_self = "The refractive coating dries and falls away."
	alert_desc = "You've been innundated in a refractive resin! The lensing effect causes all burns to deal double damage."

/datum/status_effect/trickwine/debuff/prism/on_apply()
	if(ishuman(owner))
		var/mob/living/carbon/human/the_human = owner
		the_human.physiology.burn_mod *= 2
	return ..()

/datum/status_effect/trickwine/debuff/prism/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/the_human = owner
		the_human.physiology.burn_mod *= 0.5
	..()


