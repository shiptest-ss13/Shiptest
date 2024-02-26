/datum/wires/mine
	holder_type = /obj/item/mine
	randomize = TRUE

/datum/wires/mine/New(atom/holder)
	wires = list(
		WIRE_BOOM, WIRE_BOOM, WIRE_FUSE, WIRE_PIN, WIRE_RESET
	)
	..()

/datum/wires/mine/interactable(mob/user)
	var/obj/item/mine/ourmine = holder
	if(ourmine.open_panel)
		return TRUE

//are you feelin lucky, punk?
/datum/wires/mine/on_pulse(wire)
	var/obj/item/mine/ourmine = holder
	switch(wire)
		if(WIRE_BOOM)//oopsies
			holder.visible_message(span_userdanger("[icon2html(ourmine, viewers(holder))] \The [ourmine] makes a shrill noise! It's go-"))
			ourmine.triggermine()
		//scrambles det time, up to 10 seconds, down to 10 miliseconds(basically instant)
		if(WIRE_FUSE)
			holder.visible_message(span_danger("[icon2html(ourmine, viewers(holder))] \The [ourmine] buzzes ominously."))
			playsound(ourmine, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			ourmine.blast_delay = rand(1,100)
		//Resets the detonation pin, allowing someone to step off the mine. Minor success.
		if(WIRE_PIN)
			if(ourmine.clicked == TRUE)
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] You hear something inside \the [ourmine] click softly."))
				playsound(ourmine, 'sound/weapons/empty.ogg', 30, TRUE)
				ourmine.clicked = FALSE
				var/mob/living/defuser = ourmine.foot_on_mine.resolve()
				defuser.remove_movespeed_modifier(/datum/movespeed_modifier/stepped_on_mine)
				ourmine.foot_on_mine = null
			else
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s detonation pad shifts slightly. Nothing happens."))
		if(WIRE_RESET)//Disarms the mine, allowing it to be picked up. Major success.
			if(ourmine.armed && ourmine.anchored)
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] <b> \The [ourmine]'s arming lights fade, and the securing bolts loosen. </b>"))
				playsound(ourmine, 'sound/machines/click.ogg', 100, TRUE)
				ourmine.armed = FALSE
				ourmine.clicked = FALSE
				ourmine.anchored = FALSE
				ourmine.alpha = 255
				var/mob/living/defuser = ourmine.foot_on_mine.resolve()
				defuser.remove_movespeed_modifier(/datum/movespeed_modifier/stepped_on_mine)
				ourmine.foot_on_mine = null
				ourmine.update_appearance(UPDATE_ICON_STATE)
			else if(ourmine.anchored)
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s yellow arming light flickers."))
			else
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s securing bolt shifts. Nothing happens."))

/datum/wires/mine/on_cut(wire, mend)
	var/obj/item/mine/ourmine = holder
	switch(wire)
		if(WIRE_BOOM)
			if(!mend)
				holder.visible_message(span_userdanger("[icon2html(ourmine, viewers(holder))] \The [ourmine] makes a shrill noise! It's go-"))
				ourmine.triggermine()
		//sets det time to 3 seconds, reset back to previous time on mend.
		if(WIRE_FUSE)
			var/olddelay //define the olddelay here so it exists
			if(!mend)
				holder.visible_message(span_danger("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s timer goes dark."))
				olddelay = ourmine.blast_delay//store old delay
				ourmine.blast_delay = 3 SECONDS
			else
				holder.visible_message(span_danger("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s timer flickers back on."))
				ourmine.blast_delay = olddelay//reset to old delay
		//Disables the detonation pin. Nothing will happen when the mine is triggered.
		//Mine can still be exploded by cutting wires & damage.
		if(WIRE_PIN)
			if(!mend)
				ourmine.dud = TRUE
				if(ourmine.clicked == TRUE)
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] You hear something inside \the [ourmine] shift out of place."))
					playsound(ourmine, 'sound/weapons/empty.ogg', 30, TRUE)
					ourmine.clicked = FALSE
					var/mob/living/defuser = ourmine.foot_on_mine.resolve()
					defuser.remove_movespeed_modifier(/datum/movespeed_modifier/stepped_on_mine)
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
					ourmine.armed = FALSE
					ourmine.clicked = FALSE
					ourmine.anchored = FALSE
					ourmine.alpha = 255
					var/mob/living/defuser = ourmine.foot_on_mine.resolve()
					defuser.remove_movespeed_modifier(/datum/movespeed_modifier/stepped_on_mine)
					ourmine.foot_on_mine = null
					ourmine.update_appearance(UPDATE_ICON_STATE)
				else if(ourmine.anchored)
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s yellow arming light flickers."))
				else
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s securing bolt shifts. Nothing happens."))
