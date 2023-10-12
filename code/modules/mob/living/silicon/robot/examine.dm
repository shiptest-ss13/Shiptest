/mob/living/silicon/robot/examine(mob/user)
	. = list("<span class='info'>This is [icon2html(src, user)] \a <EM>[src]</EM>!")
	if(desc)
		. += "[desc]"

	var/obj/act_module = get_active_held_item()
	if(act_module)
		. += "It is holding [icon2html(act_module, user)] \a [act_module]."
	. += status_effect_examines()
	if (getBruteLoss())
		if (getBruteLoss() < maxHealth*0.5)
			. += "<span class='warning'>It looks slightly dented.</span>"
		else
			. += "<span class='warning'><B>It looks severely dented!</B></span>"
	if (getFireLoss() || getToxLoss())
		var/overall_fireloss = getFireLoss() + getToxLoss()
		if (overall_fireloss < maxHealth * 0.5)
			. += "<span class='warning'>It looks slightly charred.</span>"
		else
			. += "<span class='warning'><B>It looks severely burnt and heat-warped!</B></span>"
	if (health < -maxHealth*0.5)
		. += "<span class='warning'>It looks barely operational.</span>"
	if (fire_stacks < 0)
		. += "<span class='warning'>It's covered in water.</span>"
	else if (fire_stacks > 0)
		. += "<span class='warning'>It's coated in something flammable.</span>"

	if(opened)
		. += "<span class='warning'>Its cover is open and the power cell is [cell ? "installed" : "missing"].</span>"
	else
		. += "Its cover is closed[locked ? "" : ", and looks unlocked"]."

	if(cell && cell.charge <= 0)
		. += "<span class='warning'>Its battery indicator is blinking red!</span>"

	switch(stat)
		if(CONSCIOUS)
			if(shell)
				. += "It appears to be an [deployed ? "active" : "empty"] AI shell."
			else if(!client)
				. += "It appears to be in stand-by mode." //afk
		if(SOFT_CRIT, UNCONSCIOUS, HARD_CRIT)
			. += "<span class='warning'>It doesn't seem to be responding.</span>"
		if(DEAD)
			. += "<span class='deadsay'>It looks like its system is corrupted and requires a reset.</span>"
	if(temporary_flavor_text)
		if(length_char(temporary_flavor_text) <= 40)
			. += "<span class='notice'>[temporary_flavor_text]</span>"
		else
			. += "<span class='notice'>[copytext_char(temporary_flavor_text, 1, 37)]... <a href='?src=[REF(src)];temporary_flavor=1'>More...</a></span>"
	. += "</span>"

	. += ..()

/mob/living/silicon/robot/get_examine_string(mob/user, thats = FALSE)
	return null
