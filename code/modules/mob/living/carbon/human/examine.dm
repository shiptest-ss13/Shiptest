/mob/living/carbon/human/examine(mob/user)
//this is very slightly better than it was because you can use it more places. still can't do \his[src] though.
	var/t_He = p_they(TRUE)
	var/t_he = p_they()
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()
	var/t_es = p_es()
	var/obscure_name
	var/list/obscured = check_obscured_slots()
	var/skipface = ((wear_mask?.flags_inv & HIDEFACE) || (head?.flags_inv & HIDEFACE))

	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE

	. = list(span_info("This is <EM>[name]</EM>!"))

	if(user != src)
		if(!obscure_name && !skipface)
			var/face_name = get_face_name("")
			if(face_name)
				//if we have no guestbook, we just KNOW okay?
				var/known_name = user.mind?.guestbook ? user.mind.guestbook.get_known_name(user, src, face_name) : face_name
				if(known_name)
					. += "You know [t_him] as <EM>[known_name]</EM>."
				else
					. += "You don't recognize [t_him]. You can <B>Ctrl-Shift click</b> [t_him] to memorize their face."
			else
				. += "You can't see [t_his] face very well."
		else
			. += "You can't see [t_his] face very well."
	else
		. += "It's you, <EM>[real_name]</EM>."

	//uniform
	if(w_uniform && !(ITEM_SLOT_ICLOTHING in obscured))
		//accessory
		var/accessory_msg
		if(istype(w_uniform, /obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.attached_accessory)
				accessory_msg += " with [icon2html(U.attached_accessory, user)] \a [U.attached_accessory]"

		. += "[t_He] [t_is] wearing [w_uniform.get_examine_string(user)][accessory_msg]."
	//head
	if(head)
		. += "[t_He] [t_is] wearing [head.get_examine_string(user)] on [t_his] head."
	//suit/armor
	if(wear_suit)
		. += "[t_He] [t_is] wearing [wear_suit.get_examine_string(user)]."
	//suit/armor storage
	if(s_store && !(ITEM_SLOT_SUITSTORE in obscured))
		if(wear_suit)
			. += "[t_He] [t_is] carrying [s_store.get_examine_string(user)] on [t_his] [wear_suit.name]."
		else if(w_uniform && !(ITEM_SLOT_ICLOTHING in obscured))
			. += "[t_He] [t_is] carrying [s_store.get_examine_string(user)] on [t_his] [w_uniform.name]."
		else
			. += "[t_He] [t_is] carrying [s_store.get_examine_string(user)]."
	//back
	if(back)
		. += "[t_He] [t_has] [back.get_examine_string(user)] on [t_his] back."

	//Hands
	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT))
			. += "[t_He] [t_is] holding [I.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	var/datum/component/forensics/FR = GetComponent(/datum/component/forensics)
	//gloves
	if(gloves && !(ITEM_SLOT_GLOVES in obscured))
		. += "[t_He] [t_has] [gloves.get_examine_string(user)] on [t_his] hands."
	else if(FR && length(FR.blood_DNA))
		if(num_hands)
			. += span_warning("[t_He] [t_has] [num_hands > 1 ? "" : "a"] blood-stained hand[num_hands > 1 ? "s" : ""]!")

	//handcuffed?

	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/restraints/handcuffs/cable))
			. += span_warning("[t_He] [t_is] [icon2html(handcuffed, user)] restrained with cable!")
		else
			. += span_warning("[t_He] [t_is] [icon2html(handcuffed, user)] handcuffed!")

	//belt
	if(belt)
		. += "[t_He] [t_has] [belt.get_examine_string(user)] about [t_his] waist."

	//shoes
	if(shoes && !(ITEM_SLOT_FEET in obscured))
		. += "[t_He] [t_is] wearing [shoes.get_examine_string(user)] on [t_his] feet."

	//mask
	if(wear_mask && !(ITEM_SLOT_MASK in obscured))
		. += "[t_He] [t_has] [wear_mask.get_examine_string(user)] on [t_his] face."

	if(wear_neck && !(ITEM_SLOT_NECK in obscured))
		. += "[t_He] [t_is] wearing [wear_neck.get_examine_string(user)] around [t_his] neck."

	//eyes
	if(!(ITEM_SLOT_EYES in obscured))
		if(glasses)
			. += "[t_He] [t_has] [glasses.get_examine_string(user)] covering [t_his] eyes."
		else if(HAS_TRAIT(src, TRAIT_CLOUDED))
			. += span_notice("[t_His] eyes are clouded in silver.")
		else if(HAS_TRAIT(src, TRAIT_PINPOINT_EYES))
			. += span_warning("[t_His] pupils have diliated to pinpricks.")

	//ears
	if(ears && !(ITEM_SLOT_EARS in obscured))
		. += "[t_He] [t_has] [ears.get_examine_string(user)] on [t_his] ears."

	//ID
	if(wear_id)
		. += "[t_He] [t_is] wearing [wear_id.get_examine_string(user)]."

	//Status effects
	var/list/status_examines = get_status_effect_examinations()
	if (length(status_examines))
		. += status_examines

	var/appears_dead = FALSE
	var/just_sleeping = FALSE

	if(stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH)))
		appears_dead = TRUE

		var/obj/item/clothing/glasses/G = get_item_by_slot(ITEM_SLOT_EYES)
		var/are_we_in_weekend_at_bernies = G?.tint && buckled && istype(buckled, /obj/vehicle/ridden/wheelchair)

		if(isliving(user) && (HAS_TRAIT(user, TRAIT_NAIVE) || are_we_in_weekend_at_bernies))
			just_sleeping = TRUE

		if(!just_sleeping)
			. += ""
			if(getorgan(/obj/item/organ/brain) && !key && !get_ghost(FALSE, TRUE))
				. += span_deadsay("[t_He] [t_is] limp and unresponsive; there are no signs of life and [t_he] won't be coming back...")
			else
				. += span_deadsay("[t_He] [t_is] limp and unresponsive; there are no signs of life...")


	if(get_bodypart(BODY_ZONE_HEAD) && !getorgan(/obj/item/organ/brain))
		. += span_deadsay("It appears that [t_his] brain is missing...")

	var/temp = getBruteLoss() //no need to calculate each of these twice

	var/list/msg = list()

	var/list/missing = list()
	var/list/disabled = list()

	var/obj/item/bodypart/body_part
	for(var/zone in bodyparts)
		body_part = bodyparts[zone]
		if(!body_part)
			missing += zone
			continue
		if(body_part.bodypart_disabled)
			disabled += body_part

		for(var/obj/item/I in body_part.embedded_objects)
			if(I.isEmbedHarmless())
				msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] stuck to [t_his] [body_part.name]!</B>\n"
			else
				msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] embedded in [t_his] [body_part.name]!</B>\n"

		for(var/i in body_part.wounds)
			var/datum/wound/iter_wound = i
			msg += "[iter_wound.get_examine_description(user)]\n"

	for(var/X in disabled)
		body_part = X
		var/damage_text
		if(HAS_TRAIT(body_part, TRAIT_DISABLED_BY_WOUND))
			continue // skip if it's disabled by a wound (cuz we'll be able to see the bone sticking out!)
		if(!(body_part.get_damage(include_stamina = FALSE) >= body_part.max_damage)) //we don't care if it's stamcritted
			damage_text = "limp and lifeless"
		else
			damage_text = (body_part.brute_dam >= body_part.burn_dam) ? body_part.heavy_brute_msg : body_part.heavy_burn_msg
		msg += "<B>[capitalize(t_his)] [body_part.name] is [damage_text]!</B>\n"

	//stores missing limbs
	var/l_limbs_missing = 0
	var/r_limbs_missing = 0
	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			msg += "<span class='deadsay'><B>[t_His] [parse_zone(t)] is missing!</B><span class='warning'>\n"
			continue
		if(t == BODY_ZONE_L_ARM || t == BODY_ZONE_L_LEG)
			l_limbs_missing++
		else if(t == BODY_ZONE_R_ARM || t == BODY_ZONE_R_LEG)
			r_limbs_missing++

		msg += "<B>[capitalize(t_his)] [parse_zone(t)] is missing!</B>\n"

	if(l_limbs_missing >= 2 && r_limbs_missing == 0)
		msg += "[t_He] look[p_s()] all right now.\n"
	else if(l_limbs_missing == 0 && r_limbs_missing >= 2)
		msg += "[t_He] really keeps to the left.\n"
	else if(l_limbs_missing >= 2 && r_limbs_missing >= 2)
		msg += "[t_He] [p_do()]n't seem all there.\n"

	for(var/zone in bodyparts)
		body_part = bodyparts[zone]
		if(!body_part)
			continue
		if(body_part.limb_id != (dna.species.examine_limb_id ? dna.species.examine_limb_id : dna.species.id))
			msg += "[span_info("[t_He] [t_has] \an [body_part.name].")]\n"

	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

		temp = getFireLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor cellular damage.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> cellular damage!\n"
			else
				msg += "<b>[t_He] [t_has] severe cellular damage!</b>\n"

	if(pulledby && pulledby.grab_state)
		msg += "[t_He] [t_is] restrained by [pulledby]'s grip.\n"

	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		msg += "[t_He] [t_is] severely malnourished.\n"
	switch(disgust)
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			msg += "[t_He] look[p_s()] a bit grossed out.\n"
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			msg += "[t_He] look[p_s()] really grossed out.\n"
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			msg += "[t_He] look[p_s()] extremely disgusted.\n"

	var/apparent_blood_volume = blood_volume
	if(skin_tone == "albino")
		apparent_blood_volume -= 150 // enough to knock you down one tier
	switch(apparent_blood_volume)
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			msg += "[t_He] [t_has] looks a little pale.\n"
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
			msg += "<b>[t_He] look[p_s()] like [t_he] is going to faint.</b>\n"
		if(-INFINITY to BLOOD_VOLUME_BAD)
			msg += span_deadsay("<b>[t_He] looks drained of blood...</b>\n")

	if(bleedsuppress)
		msg += "[t_He] [t_is] imbued with a power that defies bleeding.\n"
	else if(is_bleeding())
		var/list/obj/item/bodypart/bleeding_limbs = list()
		var/list/obj/item/bodypart/grasped_limbs = list()

		for(var/zone in bodyparts)
			body_part = bodyparts[zone]
			if(!body_part)
				continue
			if(body_part.get_part_bleed_rate())
				bleeding_limbs += body_part
			if(body_part.grasped_by)
				grasped_limbs += body_part

		var/num_bleeds = LAZYLEN(bleeding_limbs)

		var/list/bleed_text
		if(appears_dead)
			bleed_text = list(span_deadsay("<B>Blood is visible in [t_his] open"))
		else
			bleed_text = list("<B>[t_He] [t_is] bleeding from [t_his]")

		switch(num_bleeds)
			if(1 to 2)
				bleed_text += " [bleeding_limbs[1].name][num_bleeds == 2 ? " and [bleeding_limbs[2].name]" : ""]"
			if(3 to INFINITY)
				for(var/i in 1 to (num_bleeds - 1))
					body_part = bleeding_limbs[i]
					bleed_text += " [body_part.name],"
				bleed_text += " and [bleeding_limbs[num_bleeds].name]"

		if(appears_dead)
			bleed_text += ", but it has pooled and is not flowing.</span></B>\n"
		else
			if(reagents.has_reagent(/datum/reagent/toxin/heparin, needs_metabolizing = TRUE))
				bleed_text += " incredibly quickly"

		bleed_text += "</B>\n"

		for(var/i in grasped_limbs)
			var/obj/item/bodypart/grasped_part = i
			bleed_text += "[t_He] [t_is] holding [t_his] [grasped_part.name] to slow the bleeding!\n"

		msg += bleed_text.Join()

	if(islist(stun_absorption))
		for(var/i in stun_absorption)
			if(stun_absorption[i]["end_time"] > world.time && stun_absorption[i]["examine_message"])
				msg += "[t_He] [t_is][stun_absorption[i]["examine_message"]]\n"

	if(just_sleeping)
		msg += "[t_He] [t_is]n't responding to anything around [t_him] and seem[p_s()] to be asleep.\n"

	if(!appears_dead)

		if(src != user)
			if(HAS_TRAIT(user, TRAIT_EMPATH))
				if (a_intent != INTENT_HELP)
					msg += "[t_He] seem[p_s()] to be on guard.\n"
				if (getOxyLoss() >= 10)
					msg += "[t_He] seem[p_s()] winded.\n"
				if (getToxLoss() >= 10)
					msg += "[t_He] seem[p_s()] sickly.\n"
				var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
				if(mood.sanity <= SANITY_DISTURBED)
					msg += "[t_He] seem[p_s()] distressed.\n"
					SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "empath", /datum/mood_event/sad_empath, src)
				if (is_blind())
					msg += "[t_He] appear[p_s()] to be staring off into space.\n"
				if (HAS_TRAIT(src, TRAIT_DEAF))
					msg += "[t_He] appear[p_s()] to not be responding to noises.\n"

			msg += "</span>"

		switch(stat)
			if(UNCONSCIOUS, HARD_CRIT)
				msg += "[t_He] [t_is]n't responding to anything around [t_him] and seem[p_s()] to be asleep.\n"
			if(SOFT_CRIT)
				msg += "[t_He] [t_is] barely conscious.\n"
			if(CONSCIOUS)
				if(HAS_TRAIT(src, TRAIT_DUMB))
					msg += "[t_He] [t_has] a stupid expression on [t_his] face.\n"
		if(getorgan(/obj/item/organ/brain))
			if(ai_controller?.ai_status == AI_STATUS_ON)
				msg += "[span_deadsay("[t_He] do[t_es]n't appear to be [t_him]self.")]\n"
			if(!key)
				msg += "[span_deadsay("[t_He] [t_is] totally catatonic. The stresses of life in deep-space must have been too much for [t_him]. Any recovery is unlikely.")]\n"
			else if(!client)
				msg += "[span_warning("[t_He] [t_has] been suffering from SSD - Space Sleep Disorder - for [trunc(((world.time - lastclienttime) / (1 MINUTES)))] minutes. [t_He] may snap out of it at any time! Or maybe never. It's best to leave [t_him] be.")]\n"
	if (length(msg))
		. += span_warning("[msg.Join("")]")

// evil ass cursed code alert
	switch(mothdust)
		if(1 to 50)
			. += "[t_He] [t_is] a little dusty."
		if(51 to 150)
			. += "[t_He] [t_has] a layer of shimmering dust on [t_him]."
		if(151 to INFINITY)
			. += "<b>[t_He] [t_is] covered in glistening dust!</b>"
// end evil ass cursed code

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	var/traitstring = get_trait_string(see_all=FALSE)

	var/perpname = get_face_name(get_id_name(""))
	if(perpname && (HAS_TRAIT(user, TRAIT_SECURITY_HUD) || HAS_TRAIT(user, TRAIT_MEDICAL_HUD)))
		var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.general)
		if(R)
			. += "[span_deptradio("Rank:")] [R.fields["rank"]]\n<a href='byond://?src=[REF(src)];hud=1;photo_front=1'>\[Front photo\]</a><a href='byond://?src=[REF(src)];hud=1;photo_side=1'>\[Side photo\]</a>"
		if(HAS_TRAIT(user, TRAIT_MEDICAL_HUD))
			var/cyberimp_detect
			for(var/obj/item/organ/cyberimp/CI in internal_organs)
				if(CI.status == ORGAN_ROBOTIC && !CI.syndicate_implant)
					cyberimp_detect += "[!cyberimp_detect ? "[CI.get_examine_string(user)]" : ", [CI.get_examine_string(user)]"]"
			if(cyberimp_detect)
				. += "<span class='notice ml-1'>Detected cybernetic modifications:</span>"
				. += "<span class='notice ml-2'>[cyberimp_detect]</span>"
			if(R)
				var/health_r = R.fields["p_stat"]
				. += "<a href='byond://?src=[REF(src)];hud=m;p_stat=1'>\[[health_r]\]</a>"
				health_r = R.fields["m_stat"]
				. += "<a href='byond://?src=[REF(src)];hud=m;m_stat=1'>\[[health_r]\]</a>"
			R = find_record("name", perpname, GLOB.data_core.medical)
			if(R)
				. += "<a href='byond://?src=[REF(src)];hud=m;evaluation=1'>\[Medical evaluation\]</a><br>"
			if(traitstring)
				. += "<span class='notice ml-1'>Detected physiological traits:</span>"
				. += "<span class='notice ml-2'>[traitstring]</span>"

		if(HAS_TRAIT(user, TRAIT_SECURITY_HUD))
			if(!user.stat && user != src)
			//|| !user.canmove || user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
				var/criminal = "None"

				R = find_record("name", perpname, GLOB.data_core.security)
				if(R)
					criminal = R.fields["criminal"]

				. += "[span_deptradio("Criminal status:")] <a href='byond://?src=[REF(src)];hud=s;status=1'>\[[criminal]\]</a>"
				. += jointext(list("[span_deptradio("Security record:")] <a href='byond://?src=[REF(src)];hud=s;view=1'>\[View\]</a>",
					"<a href='byond://?src=[REF(src)];hud=s;add_crime=1'>\[Add crime\]</a>",
					"<a href='byond://?src=[REF(src)];hud=s;view_comment=1'>\[View comment log\]</a>",
					"<a href='byond://?src=[REF(src)];hud=s;add_comment=1'>\[Add comment\]</a>"), "")
	else if(isobserver(user) && traitstring)
		. += span_info("<b>Traits:</b> [traitstring]")

	//No flavor text unless the face can be seen. Prevents certain metagaming with impersonation.
	var/invisible_man = skipface || get_visible_name() == "Unknown"
	if(invisible_man)
		. += "...?"
	else
		var/flavor = print_flavor_text()
		if(flavor)
			. += flavor
	. += "</span>"

	SEND_SIGNAL(src, COMSIG_ATOM_EXAMINE, user, .)

/**
 * Shows any and all examine text related to any status effects the user has.
 */
/mob/living/proc/get_status_effect_examinations()
	var/list/examine_list = list()

	for(var/datum/status_effect/effect as anything in status_effects)
		var/effect_text = effect.get_examine_text()
		if(!effect_text)
			continue

		examine_list += effect_text

	if(!length(examine_list))
		return

	return examine_list.Join("\n")

/mob/living/carbon/human/examine_more(mob/user)
	. = ..()
	if ((wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE)))
		return
	if(get_age())
		. += span_notice("[p_they(TRUE)] appear[p_s()] to be [get_age()].")
