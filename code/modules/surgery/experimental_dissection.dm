#define MAX_DISSECTION_REWARD 2000
#define EXPDIS_FAIL_MSG span_notice("You dissect [target], but do not find anything particularly interesting.")
#define PUBLIC_TECHWEB_GAIN 0.6 //how many research points go directly into the main pool
#define PRIVATE_TECHWEB_GAIN (1 - PUBLIC_TECHWEB_GAIN) //how many research points go directly into the main pool

/datum/surgery/advanced/experimental_dissection
	name = "Dissection"
	desc = "A surgical procedure which analyzes the biology of a corpse, and automatically adds new findings to the research database."
	steps = list(/datum/surgery_step/incise,
				/datum/surgery_step/retract_skin,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/dissection,
				/datum/surgery_step/clamp_bleeders,
				/datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)
	target_mobtypes = list(/mob/living)
	replaced_by = /datum/surgery/advanced/experimental_dissection/adv
	requires_tech = FALSE
	var/value_multiplier = 0.25

/datum/surgery/advanced/experimental_dissection/can_start(mob/user, mob/living/target)
	. = ..()
	if(HAS_TRAIT_FROM(target, TRAIT_DISSECTED, "[name]"))
		return FALSE
	if(target.stat != DEAD)
		return FALSE
	var/datum/surgery_step/dissection/V = new /datum/surgery_step/dissection
	if(V.check_value(target, src) < 0.01)
		return FALSE

/datum/surgery_step/dissection
	name = "dissection"
	implements = list(
		/obj/item/scalpel/augment = 75,
		/obj/item/scalpel/advanced = 60,
		TOOL_SCALPEL = 45,
		/obj/item/melee/knife = 30,
		/obj/item/shard = 10)// special tools not only cut down time but also improve probability
	time = 125
	silicons_obey_prob = TRUE
	repeatable = TRUE
	experience_given = 0 //experience recieved scales with what's being dissected + which step you're doing.

/datum/surgery_step/dissection/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery)
	user.visible_message(span_notice("[user] starts dissecting [target]."), span_notice("You start dissecting [target]."))

/datum/surgery_step/dissection/proc/check_value(mob/living/target, datum/surgery/advanced/experimental_dissection/ED)
	var/cost = 0
	var/multi_surgery_adjust = 0

	//determine bonus applied
	var/static/list/mob_mult_list = list(/mob/living/simple_animal/hostile/asteroid/elite = 6,
									/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient/crystal = 5,
									/mob/living/simple_animal/hostile/jungle/mega_arachnid = 4,
									/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/forgotten = 3,
									/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/icewing = 2,
									/mob/living/simple_animal/hostile/asteroid/basilisk/watcher/magmawing = 2,
									/mob/living/simple_animal/hostile/asteroid/goliath/beast/ancient = 2
									)
	if(isalienqueen(target) || isalienroyal(target))
		cost = (MAX_DISSECTION_REWARD*38)
	else if(isalienadult(target))
		cost = (MAX_DISSECTION_REWARD*30)
	else if(isalien(target))
		cost = (MAX_DISSECTION_REWARD*14)
	else if(ismegafauna(target))
		cost = (MAX_DISSECTION_REWARD*30)
	else if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H?.dna?.species)
			if(isabductor(H))
				cost = (MAX_DISSECTION_REWARD*24)
			else if(iszombie(H) || isshadow(H) || isandroid(H))
				cost = (MAX_DISSECTION_REWARD*20)
	else for(var/type in mob_mult_list) // THIS. ELSE IF(). ENDS. HERE.
		if(istype(target, type))
			cost = (MAX_DISSECTION_REWARD*mob_mult_list[type])
			break

	//now we do math for surgeries already done (no double dipping!).
	for(var/i in typesof(/datum/surgery/advanced/experimental_dissection))
		var/datum/surgery/advanced/experimental_dissection/cringe = new i
		if(HAS_TRAIT_FROM(target, TRAIT_DISSECTED, "[cringe.name]"))
			multi_surgery_adjust = max(multi_surgery_adjust, cringe.value_multiplier)

	//multiply by multiplier in surgery
	multi_surgery_adjust *= cost
	cost *= ED.value_multiplier
	cost -= multi_surgery_adjust
	return (cost)

/datum/surgery_step/dissection/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/points_earned = check_value(target, surgery)
	user.visible_message(span_notice("[user] dissects [target], discovering [points_earned] point\s of data!"), span_notice("You dissect [target], finding [points_earned] point\s worth of discoveries, you also write a few notes."))

	var/obj/item/research_notes/the_dossier =new /obj/item/research_notes(user.loc, points_earned, "biology")
	if(!user.put_in_hands(the_dossier) && istype(user.get_inactive_held_item(), /obj/item/research_notes))
		var/obj/item/research_notes/hand_dossier = user.get_inactive_held_item()
		hand_dossier.merge(the_dossier)

	var/obj/item/bodypart/L = target.get_bodypart(BODY_ZONE_CHEST)
	target.apply_damage(80, BRUTE, L, wound_bonus=CANT_WOUND)
	ADD_TRAIT(target, TRAIT_DISSECTED, "[surgery.name]")
	repeatable = FALSE
	experience_given = max(points_earned/(MAX_DISSECTION_REWARD/MEDICAL_SKILL_MEDIUM),1)
	return ..()

/datum/surgery_step/dissection/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	var/points_earned = round(check_value(target, surgery) * 0.01)
	user.visible_message(span_notice("[user] dissects [target]!"), EXPDIS_FAIL_MSG)

	var/obj/item/research_notes/the_dossier =new /obj/item/research_notes(user.loc, points_earned, "biology")
	if(!user.put_in_hands(the_dossier) && istype(user.get_inactive_held_item(), /obj/item/research_notes))
		var/obj/item/research_notes/hand_dossier = user.get_inactive_held_item()
		hand_dossier.merge(the_dossier)

	var/obj/item/bodypart/L = target.get_bodypart(BODY_ZONE_CHEST)
	target.apply_damage(80, BRUTE, L, wound_bonus=CANT_WOUND)
	return TRUE

/datum/surgery/advanced/experimental_dissection/adv
	name = "Thorough Dissection"
	value_multiplier = 0.5
	replaced_by = /datum/surgery/advanced/experimental_dissection/exp
	requires_tech = TRUE

/datum/surgery/advanced/experimental_dissection/exp
	name = "Experimental Dissection"
	value_multiplier = 1
	replaced_by = /datum/surgery/advanced/experimental_dissection/alien
	requires_tech = TRUE

/datum/surgery/advanced/experimental_dissection/alien
	name = "Extraterrestrial Dissection"
	value_multiplier = 2
	requires_tech = TRUE
	replaced_by = null


#undef MAX_DISSECTION_REWARD
#undef EXPDIS_FAIL_MSG
#undef PUBLIC_TECHWEB_GAIN
#undef PRIVATE_TECHWEB_GAIN
