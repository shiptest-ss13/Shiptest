/obj/item/organ/eyes/night_vision/spider
	name = "spider eyes"
	desc = "These eyes seem to have increased sensitivity to bright light, offset by basic night vision."
	see_in_dark = 4
	flash_protect = FLASH_PROTECTION_SENSITIVE

/datum/species/spider
	name = "Rachnid"
	id = SPECIES_RACHNID
	default_color = "00FF00"
	species_traits = list(LIPS, MUTCOLORS_PARTSONLY)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BUG
	mutant_bodyparts = list("spider_legs", "spider_spinneret")
	default_features = list("spider_legs" = "Carapaced", "spider_spinneret" = "Plain", "body_size" = "Normal")
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	liked_food = MEAT | RAW | GORE // Regular spiders literally liquify the insides of their prey and drink em like a smoothie. I think this fits
	disliked_food = FRUIT | GROSS
	toxic_food = VEGETABLES | DAIRY | CLOTH
	mutanteyes = /obj/item/organ/eyes/night_vision/spider
	mutanttongue = /obj/item/organ/tongue/spider
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP
	species_language_holder = /datum/language_holder/spider
	loreblurb = "Rachnids are aliens with coincidental physiological similarities to Sol's spiders. Despite visible adaptations that would make them excellent hunters, modern Rachnidian culture revolves around honing the skills and talents of oneself, treating them as forms of self-expression. Rachnids tend to focus on their work intensely, priding themselves on a job well done and languishing if they see themselves as underperforming in their field."
	var/web_cooldown = 30
	var/web_ready = TRUE
	var/spinner_rate = 75

	// TODO - add more arms
	species_limbs = list(
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/rachnid,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/rachnid,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/rachnid,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/rachnid,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/rachnid,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/rachnid,
	)

/datum/species/spider/random_name(gender,unique,lastname)
	if(unique)
		return random_unique_spider_name()
	return spider_name()

/datum/species/spider/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/toxin/pestkiller)
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
	return ..()

/mob/living/carbon/human/species/spider
	race = /datum/species/spider

/datum/species/spider/on_species_gain(mob/living/carbon/human/H, datum/species/old_species)
	. = ..()
	var/datum/action/innate/spin_web/SW = new
	var/datum/action/innate/spin_cocoon/SC = new
	SC.Grant(H)
	SW.Grant(H)

/datum/species/spider/on_species_loss(mob/living/carbon/human/H)
	. = ..()
	var/datum/action/innate/spin_web/SW = locate(/datum/action/innate/spin_web) in H.actions
	var/datum/action/innate/spin_cocoon/SC = locate(/datum/action/innate/spin_cocoon) in H.actions
	SC?.Remove(H)
	SW?.Remove(H)

/datum/action/innate/spin_web
	name = "Spin Web"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "lay_web"

/datum/action/innate/spin_cocoon
	name = "Spin Cocoon"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "wrap_0"

/datum/action/innate/spin_web/Activate()
	var/mob/living/carbon/human/species/spider/H = owner
	var/datum/species/spider/E = H.dna.species
	if(H.stat == "DEAD")
		return
	if(E.web_ready == FALSE)
		to_chat(H, span_warning("You need to wait awhile to regenerate web fluid."))
		return
	var/turf/T = get_turf(H)
	if(!T)
		to_chat(H, span_warning("There's no room to spin your web here!"))
		return
	var/obj/structure/spider/stickyweb/W = locate() in T
	var/obj/structure/spider_player/W2 = locate() in T
	if(W || W2)
		to_chat(H, span_warning("There's already a web here!"))
		return
	// Should have some minimum amount of food before trying to activate
	var/nutrition_threshold = NUTRITION_LEVEL_FED
	if (H.nutrition >= nutrition_threshold)
		to_chat(H, "<i>You begin spinning some web...</i>")
		if(!do_after(H, 10 SECONDS, T, hidden = TRUE))
			to_chat(H, span_warning("Your web spinning was interrupted!"))
			return
		if(prob(75))
			H.adjust_nutrition(-E.spinner_rate)
			addtimer(VARSET_CALLBACK(E, web_ready, TRUE), E.web_cooldown)
			to_chat(H, "<i>You use up a fair amount of energy spinning the web.</i>")
		new /obj/structure/spider_player(T, owner)
		to_chat(H, "<i>You weave a web on the ground with your spinneret!</i>")

	else
		to_chat(H, span_warning("You're too hungry to spin web right now, eat something first!"))
		return
/*
	This took me far too long to figure out so I'm gonna document it here.
	1) Create an innate action for the species
	2) Have that action trigger a RegisterSignal for mob clicking
	3) Trigger the cocoonAtom proc on that signal
	4) Validate the target then start spinning
	5) if you're not interrupted, force move the target to the cocoon created at their location.
*/
/datum/action/innate/spin_cocoon/Activate()
	var/mob/living/carbon/human/species/spider/H = owner
	var/datum/species/spider/E = H.dna.species
	if(H.stat == "DEAD")
		return
	if(E.web_ready == FALSE)
		to_chat(H, span_warning("You need to wait awhile to regenerate web fluid."))
		return
	var/nutrition_threshold = NUTRITION_LEVEL_FED
	if (H.nutrition >= nutrition_threshold)
		to_chat(H, "<span class='warning'>You pull out a strand from your spinneret, ready to wrap a target. <BR> \
		(Press ALT+CLICK or MMB on the target to start wrapping.)</span>")
		addtimer(VARSET_CALLBACK(E, web_ready, TRUE), E.web_cooldown)
		RegisterSignals(H, list(COMSIG_MOB_MIDDLECLICKON, COMSIG_MOB_ALTCLICKON), PROC_REF(cocoonAtom))
		return
	else
		to_chat(H, span_warning("You're too hungry to spin web right now, eat something first!"))
		return

/datum/action/innate/spin_cocoon/proc/cocoonAtom(mob/living/carbon/human/species/spider/H, atom/movable/A)
	UnregisterSignal(H, list(COMSIG_MOB_MIDDLECLICKON, COMSIG_MOB_ALTCLICKON))
	var/datum/species/spider/E = H.dna.species
	if (!H || !isspiderperson(H))
		return COMSIG_MOB_CANCEL_CLICKON
	else
		if(E.web_ready == FALSE)
			to_chat(H, span_warning("You need to wait awhile to regenerate web fluid."))
			return
		if(!H.Adjacent(A))	//No.
			return
		if(!isliving(A) && A.anchored)
			to_chat(H, span_warning("[A] is bolted to the floor!"))
			return
		if(istype(A, /obj/structure/spider_player))
			to_chat(H, span_warning("No double wrapping."))
			return
		if(istype(A, /obj/effect))
			to_chat(H, span_warning("You cannot wrap this."))
			return
		H.visible_message(span_danger("[H] starts to wrap [A] into a cocoon!"),span_warning("You start to wrap [A] into a cocoon."))
		if(!do_after(H, 10 SECONDS, A, hidden = TRUE))
			to_chat(H, span_warning("Your web spinning was interrupted!"))
			return
		H.adjust_nutrition(E.spinner_rate * -3.5)
		var/obj/structure/spider_player/cocoon/C = new(A.loc)
		if(isliving(A))
			C.icon_state = pick("cocoon_large1","cocoon_large2","cocoon_large3")
			A.forceMove(C)
			H.visible_message(span_danger("[H] wraps [A] into a large cocoon!"))
			return
		else
			A.forceMove(C)
			H.visible_message(span_danger("[H] wraps [A] into a cocoon!"))
			return
