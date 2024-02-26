/datum/wires/mine
	holder_type = /obj/item/mine
	randomize = TRUE

/datum/wires/mine/New(atom/holder)
	wires = list(
		WIRE_BOOM, WIRE_BOOM, WIRE_TIMING, WIRE_DISABLE, WIRE_DISARM
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
		if(WIRE_TIMING)
			holder.visible_message(span_danger("[icon2html(ourmine, viewers(holder))] \The [ourmine] buzzes ominously."))
			playsound(ourmine, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			ourmine.blast_delay = rand(1,100)
		//Resets the detonation pin, allowing someone to step off the mine. Minor success.
		if(WIRE_DISABLE)
			if(ourmine.clicked == TRUE)
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] You hear something inside \the [ourmine] click softly."))
				playsound(ourmine, 'sound/weapons/empty.ogg', 30, TRUE)
				ourmine.clicked = FALSE
				if(ourmine.foot_on_mine?.resolve())
					ourmine.foot_on_mine = null
				if(isopenturf(ourmine.loc) || ourmine.oldslow)
					var/turf/open/locturf = ourmine.loc
					locturf.slowdown = ourmine.oldslow
			else
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s detonation pad shifts slightly. Nothing happens."))
		if(WIRE_DISARM)//Disarms the mine, allowing it to be picked up. Major success.
			if(ourmine.armed && ourmine.anchored)
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] <b> \The [ourmine]'s arming lights fade, and the securing bolts loosen. Disarmed. </b>"))
				playsound(ourmine, 'sound/machines/click.ogg', 100, TRUE)
				ourmine.armed = FALSE
				ourmine.clicked = FALSE
				ourmine.anchored = FALSE
				ourmine.alpha = 204
				if(isopenturf(ourmine.loc) || ourmine.oldslow)
					var/turf/open/locturf = ourmine.loc
					locturf.slowdown = ourmine.oldslow
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
		if(WIRE_TIMING)
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
		if(WIRE_DISABLE)
			if(!mend)
				ourmine.clickblock = TRUE
				if(ourmine.clicked == TRUE)
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] You hear something inside \the [ourmine] shift out of place."))
					playsound(ourmine, 'sound/weapons/empty.ogg', 30, TRUE)
					ourmine.clicked = FALSE
					ourmine.foot_on_mine = null
					if(isopenturf(ourmine.loc) || ourmine.oldslow)
						var/turf/open/locturf = ourmine.loc
						locturf.slowdown = ourmine.oldslow
				holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s detonation pad becomes loose."))
			else
				ourmine.clickblock = FALSE
		if(WIRE_DISARM)
			if(!mend)
				if(ourmine.armed && ourmine.anchored)
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] <b> \The [ourmine]'s arming lights fade, and the securing bolts loosen. Disarmed. </b>"))
					playsound(ourmine, 'sound/machines/click.ogg', 100, TRUE)
					ourmine.armed = FALSE
					ourmine.clicked = FALSE
					ourmine.anchored = FALSE
					ourmine.alpha = 204
					if(isopenturf(ourmine.loc) || ourmine.oldslow)
						var/turf/open/locturf = ourmine.loc
						locturf.slowdown = ourmine.oldslow
					ourmine.update_appearance(UPDATE_ICON_STATE)
				else if(ourmine.anchored)
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s yellow arming light flickers."))
				else
					holder.visible_message(span_notice("[icon2html(ourmine, viewers(holder))] \The [ourmine]'s securing bolt shifts. Nothing happens."))
