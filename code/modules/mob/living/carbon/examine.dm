/mob/living/carbon/examine(mob/user)
	var/t_He = p_they(TRUE)
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()

	. = list("<span class='info'>This is [icon2html(src, user)] \a <EM>[src]</EM>!")
	var/list/obscured = check_obscured_slots()

	if(handcuffed)
		. += span_warning("[t_He] [t_is] [icon2html(handcuffed, user)] handcuffed!")
	if(head)
		. += "[t_He] [t_is] wearing [head.get_examine_string(user)] on [t_his] head. "
	if(wear_mask && !(ITEM_SLOT_MASK in obscured))
		. += "[t_He] [t_is] wearing [wear_mask.get_examine_string(user)] on [t_his] face."
	if(wear_neck && !(ITEM_SLOT_NECK in obscured))
		. += "[t_He] [t_is] wearing [wear_neck.get_examine_string(user)] around [t_his] neck."

	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT))
			. += "[t_He] [t_is] holding [I.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	if(back)
		. += "[t_He] [t_has] [back.get_examine_string(user)] on [t_his] back."

	var/appears_dead = 0
	if(stat == DEAD)
		appears_dead = 1
		if(getorgan(/obj/item/organ/brain))
			. += span_deadsay("[t_He] [t_is] limp and unresponsive, with no signs of life.")
		else if(get_bodypart(BODY_ZONE_HEAD))
			. += span_deadsay("It appears that [t_his] brain is missing...")

	var/list/msg = list("<span class='warning'>")
	var/list/missing = list()
	var/list/disabled = list()
	var/obj/item/bodypart/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(!limb)
			missing += zone
			continue
		if(limb.bodypart_disabled)
			disabled += limb

		for(var/obj/item/I in limb.embedded_objects)
			if(I.isEmbedHarmless())
				msg += "<B>[t_He] [t_has] [icon2html(I, user)] \a [I] stuck to [t_his] [limb.name]!</B>\n"
			else
				msg += "<B>[t_He] [t_has] [icon2html(I, user)] \a [I] embedded in [t_his] [limb.name]!</B>\n"

		for(var/i in limb.wounds)
			var/datum/wound/W = i
			msg += "[W.get_examine_description(user)]\n"

	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(!limb)
			continue
		var/damage_text
		if(!(limb.get_damage(include_stamina = FALSE) >= limb.max_damage)) //Stamina is disabling the limb
			damage_text = "limp and lifeless"
		else
			damage_text = (limb.brute_dam >= limb.burn_dam) ? limb.heavy_brute_msg : limb.heavy_burn_msg
		msg += "<B>[capitalize(t_his)] [limb.name] is [damage_text]!</B>\n"

	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			msg += "[span_deadsay("<B>[t_His] [parse_zone(t)] is missing!</B>")]\n"
			continue
		msg += "[span_warning("<B>[t_His] [parse_zone(t)] is missing!</B>")]\n"


	var/temp = getBruteLoss()
	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

		temp = getFireLoss()
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_is] slightly deformed.\n"
			else if (temp < 50)
				msg += "[t_He] [t_is] <b>moderately</b> deformed!\n"
			else
				msg += "<b>[t_He] [t_is] severely deformed!</b>\n"

	if(HAS_TRAIT(src, TRAIT_DUMB))
		msg += "[t_He] seem[p_s()] to be clumsy and unable to think.\n"

	switch(fire_stacks)
		if(1 to INFINITY)
			msg += "[t_He] [t_is] covered in something flammable.\n"
		if(0)
			EMPTY_BLOCK_GUARD
		if(-15 to -1)
			msg += "[t_He] look[p_s()] a little soaked.\n"
		if(-20 to -15)
			msg += "[t_He] look[p_s()] completely sopping.\n"


	if(pulledby && pulledby.grab_state)
		msg += "[t_He] [t_is] restrained by [pulledby]'s grip.\n"

	msg += "</span>"

	. += msg.Join("")

	if(!appears_dead)
		switch(stat)
			if(SOFT_CRIT)
				. += "[t_His] breathing is shallow and labored."
			if(UNCONSCIOUS, HARD_CRIT)
				. += "[t_He] [t_is]n't responding to anything around [t_him] and seems to be asleep."

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
	if(mood)
		switch(mood.shown_mood)
			if(-INFINITY to MOOD_LEVEL_SAD4)
				. += "[t_He] look[p_s()] depressed."
			if(MOOD_LEVEL_SAD4 to MOOD_LEVEL_SAD3)
				. += "[t_He] look[p_s()] very sad."
			if(MOOD_LEVEL_SAD3 to MOOD_LEVEL_SAD2)
				. += "[t_He] look[p_s()] a bit down."
			if(MOOD_LEVEL_HAPPY2 to MOOD_LEVEL_HAPPY3)
				. += "[t_He] look[p_s()] quite happy."
			if(MOOD_LEVEL_HAPPY3 to MOOD_LEVEL_HAPPY4)
				. += "[t_He] look[p_s()] very happy."
			if(MOOD_LEVEL_HAPPY4 to INFINITY)
				. += "[t_He] look[p_s()] ecstatic."

	switch(mothdust) //WS edit - moth dust from hugging
		if(1 to 50)
			. += "[t_He] [t_is] a little dusty."
		if(51 to 150)
			. += "[t_He] [t_has] a layer of shimmering dust on them."
		if(151 to INFINITY)
			. += "[t_He] [t_is] covered in glistening dust!" //End WS edit

	. += "</span>"

	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .)

/mob/living/carbon/examine_more(mob/user)
	. = ..()
	var/msg = list(span_notice("<i>You examine [src] closer, and note the following...</i>"))
	var/t_His = p_their(TRUE)
	var/t_He = p_they(TRUE)
	var/t_Has = p_have()

	var/any_bodypart_damage = FALSE
	var/obj/item/bodypart/limb
	for(var/zone in bodyparts)
		limb = bodyparts[zone]
		if(!limb)
			continue
		if(limb.is_pseudopart)
			continue
		var/limb_max_damage = limb.max_damage
		var/status = ""
		var/brutedamage = round(limb.brute_dam/limb_max_damage*100)
		var/burndamage = round(limb.burn_dam/limb_max_damage*100)
		switch(brutedamage)
			if(20 to 35)
				status = limb.light_brute_msg
			if(36 to 65)
				status = limb.medium_brute_msg
			if(66 to 100)
				status += limb.heavy_brute_msg

		if(burndamage >= 20 && status)
			status += "and "
		switch(burndamage)
			if(20 to 35)
				status += limb.light_burn_msg
			if(36 to 65)
				status += limb.medium_burn_msg
			if(66 to 100)
				status += limb.heavy_burn_msg

		if(status)
			any_bodypart_damage = TRUE
			msg += "\t<span class='warning'>[t_His] [limb.name] is [status].</span>"

		for(var/thing in limb.wounds)
			any_bodypart_damage = TRUE
			var/datum/wound/W = thing
			switch(W.severity)
				if(WOUND_SEVERITY_TRIVIAL)
					msg += "\t<span class='warning'>[t_His] [limb.name] is suffering [W.a_or_from] [W.get_topic_name(user)].</span>"
				if(WOUND_SEVERITY_MODERATE)
					msg += "\t<span class='warning'>[t_His] [limb.name] is suffering [W.a_or_from] [W.get_topic_name(user)]!</span>"
				if(WOUND_SEVERITY_SEVERE)
					msg += "\t<span class='warning'><b>[t_His] [limb.name] is suffering [W.a_or_from] [W.get_topic_name(user)]!</b></span>"
				if(WOUND_SEVERITY_CRITICAL)
					msg += "\t<span class='warning'><b>[t_His] [limb.name] is suffering [W.a_or_from] [W.get_topic_name(user)]!!</b></span>"
		if(limb.current_gauze)
			var/datum/bodypart_aid/current_gauze = limb.current_gauze
			msg += "\t<span class='notice'><i>[t_His] [limb.name] is [current_gauze.desc_prefix] with <a href='?src=[REF(current_gauze)];remove=1'>[current_gauze.get_description()]</a>.</i></span>"
		if(limb.current_splint)
			var/datum/bodypart_aid/current_splint = limb.current_splint
			msg += "\t<span class='notice'><i>[t_His] [limb.name] is [current_splint.desc_prefix] with <a href='?src=[REF(current_splint)];remove=1'>[current_splint.get_description()]</a>.</i></span>"

	if(!any_bodypart_damage)
		msg += "\t<span class='smallnotice'><i>[t_He] [t_Has] no significantly damaged bodyparts.</i></span>"

	return msg
