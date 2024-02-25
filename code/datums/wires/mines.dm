/datum/wires/mine
	holder_type = /obj/item/mine
	randomize = TRUE

/datum/wires/mine/New(atom/holder)
	wires = list(
		WIRE_BOOM, WIRE_BOOM, WIRE_TIMING, WIRE_DISABLE, WIRE_DISARM
	)
	..()

/datum/wires/mine/interactable(mob/user)
	var/obj/item/mine/P = holder
	if(P.open_panel)
		return TRUE

//are you feelin lucky, punk?
/datum/wires/mine/on_pulse(wire)
	var/obj/item/mine/B = holder
	switch(wire)
		if(WIRE_BOOM)//oopsies
			holder.visible_message(span_userdanger("[icon2html(B, viewers(holder))] \The [B] makes a shrill noise! It's go-"))
			B.triggermine()
		//scrambles det time, up to 10 seconds, down to 10 miliseconds(basically instant)
		if(WIRE_TIMING)
			holder.visible_message(span_danger("[icon2html(B, viewers(holder))] \The [B] buzzes ominously."))
			playsound(B, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
			B.blast_delay = rand(1,100)
		//Resets the detonation pin, allowing someone to step off the mine. Minor success.
		if(WIRE_DISABLE)
			if(B.clicked == TRUE)
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] You hear something inside \the [B] click softly."))
				playsound(B, 'sound/weapons/empty.ogg', 30, TRUE)
				B.clicked = FALSE
			else
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] \The [B]'s detonation pad shifts slightly. Nothing happens."))
		if(WIRE_DISARM)//Disarms the mine, allowing it to be picked up. Major success.
			if(B.armed && B.anchored)
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] <b> \The [B]'s arming lights fade, and the securing bolts loosen. Disarmed. </b>"))
				playsound(B, 'sound/machines/click.ogg', 100, TRUE)
				B.armed = FALSE
				B.clicked = FALSE
				B.anchored = FALSE
				if(isopenturf(B.loc) || B.oldslow)
					var/turf/open/locturf = B.loc
					locturf.slowdown = B.oldslow
				B.update_appearance(UPDATE_ICON_STATE)
			else if(B.anchored)
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] \The [B]'s yellow arming light flickers."))
			else
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] \The [B]'s securing bolt shifts. Nothing happens."))

/datum/wires/mine/on_cut(wire, mend)
	var/obj/item/mine/B = holder
	switch(wire)
		if(WIRE_BOOM)
			if(!mend)
				holder.visible_message(span_userdanger("[icon2html(B, viewers(holder))] \The [B] makes a shrill noise! It's go-"))
				B.triggermine()
		//sets det time to 3 seconds, reset back to previous time on mend.
		if(WIRE_TIMING)
			var/olddelay //define the olddelay here so it exists
			if(!mend)
				holder.visible_message(span_danger("[icon2html(B, viewers(holder))] \The [B]'s timer goes dark."))
				olddelay = B.blast_delay//store old delay
				B.blast_delay = 3
			else
				holder.visible_message(span_danger("[icon2html(B, viewers(holder))] \The [B]'s timer flickers back on."))
				B.blast_delay = olddelay//reset to old delay
		//Disables the detonation pin. Nothing will happen when the mine is triggered.
		//Mine can still be exploded by cutting wires & damage.
		if(WIRE_DISABLE)
			if(!mend)
				B.clickblock = TRUE
				if(B.clicked == TRUE)
					holder.visible_message(span_notice("[icon2html(B, viewers(holder))] You hear something inside \the [B] shift out of place."))
					playsound(B, 'sound/weapons/empty.ogg', 30, TRUE)
					B.clicked = FALSE
				holder.visible_message(span_notice("[icon2html(B, viewers(holder))] \The [B]'s detonation pad becomes loose."))
		if(WIRE_DISARM)
			if(!mend)
				if(B.armed && B.anchored)
					holder.visible_message(span_notice("[icon2html(B, viewers(holder))] <b> \The [B]'s arming lights fade, and the securing bolts loosen. Disarmed. </b>"))
					playsound(B, 'sound/machines/click.ogg', 100, TRUE)
					B.armed = FALSE
					B.clicked = FALSE
					B.anchored = FALSE
					if(isopenturf(B.loc) || B.oldslow)
						var/turf/open/locturf = B.loc
						locturf.slowdown = B.oldslow
					B.update_appearance(UPDATE_ICON_STATE)
				else if(B.anchored)
					holder.visible_message(span_notice("[icon2html(B, viewers(holder))] \The [B]'s yellow arming light flickers."))
				else
					holder.visible_message(span_notice("[icon2html(B, viewers(holder))] \The [B]'s securing bolt shifts. Nothing happens."))
