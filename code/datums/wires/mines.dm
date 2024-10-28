/datum/wires/mine
	holder_type = /obj/item/mine/pressure
	randomize = TRUE

/datum/wires/mine/New(atom/holder)
	wires = list(
		WIRE_BOOM, WIRE_DELAYBOOM, WIRE_PIN, WIRE_RESET
	)
	..()

/datum/wires/mine/interactable(mob/user)
	var/obj/item/mine/pressure/ourmine = holder
	if(ourmine.open_panel)
		return TRUE

//are you feelin lucky, punk?
/datum/wires/mine/on_pulse(wire)
	var/obj/item/mine/pressure/ourmine = holder
	switch(wire)
		if(WIRE_BOOM)//oopsies
			holder.visible_message(span_userdanger("[icon2html(ourmine, viewers(holder))] \The [ourmine] makes a shrill noise! It's go-"))
			ourmine.trigger_mine()
		if(WIRE_DELAYBOOM)//oopsies but you get to run
			ourmine.blast_delay = clamp(ourmine.blast_delay * 5, 8, 50)
			holder.visible_message(span_userdanger("[icon2html(ourmine, viewers(holder))] \The [ourmine] makes a shrill noise! It's go-"))
			ourmine.trigger_mine()
		//Resets the detonation pin, allowing someone to step off the mine. Minor success.
		if(WIRE_PIN)
			if(ourmine.clicked == TRUE)
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] You hear something inside \the [ourmine] click softly."))
				playsound(ourmine, SOUND_EMPTY_MAG, 30, TRUE)
				ourmine.clicked = FALSE
			else
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s detonation pad shifts slightly. Nothing happens."))
		if(WIRE_RESET)//Disarms the mine, allowing it to be picked up. Major success.
			if(ourmine.armed && ourmine.anchored)
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] <b> \The [ourmine]'s arming lights fade, and the securing bolts loosen. </b>"))
				playsound(ourmine, 'sound/machines/click.ogg', 100, TRUE)
				ourmine.disarm()
			else if(ourmine.anchored)
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s yellow arming light flickers."))
			else
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s securing bolt shifts. Nothing happens."))

/datum/wires/mine/on_cut(wire, mend)
	var/obj/item/mine/pressure/ourmine = holder
	switch(wire)
		if(WIRE_BOOM)
			if(!mend)
				holder.visible_message(span_userdanger("[icon2html(ourmine, viewers(holder))] \The [ourmine] makes a shrill noise! It's go-"))
				ourmine.trigger_mine()
		if(WIRE_DELAYBOOM)
			if(!mend)
				ourmine.blast_delay = clamp(ourmine.blast_delay * 5, 8, 50)
				holder.visible_message(span_userdanger("[icon2html(ourmine, viewers(holder))] \The [ourmine] makes a shrill noise! It's go-"))
				ourmine.trigger_mine()
		//Disables the detonation pin. Nothing will happen when the mine is triggered.
		//Mine can still be exploded by cutting wires & damage.
		if(WIRE_PIN)
			if(!mend)
				ourmine.dud = TRUE
				if(ourmine.clicked == TRUE)
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] You hear something inside \the [ourmine] shift out of place."))
					playsound(ourmine, SOUND_EMPTY_MAG, 30, TRUE)
					ourmine.clicked = FALSE
				else
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s detonation pad goes loose."))
				ourmine.foot_on_mine = null
			else
				ourmine.dud = FALSE
				ourmine.clicked = FALSE
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] You hear something inside \the [ourmine] shift back into place."))
		if(WIRE_RESET)
			if(!mend)
				if(ourmine.armed && ourmine.anchored)
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] <b> \The [ourmine]'s arming lights fade, and the securing bolts loosen. Disarmed. </b>"))
					playsound(ourmine, 'sound/machines/click.ogg', 100, TRUE)
					ourmine.disarm()
				else if(ourmine.anchored)
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s yellow arming light flickers."))
				else
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s securing bolt shifts. Nothing happens."))
