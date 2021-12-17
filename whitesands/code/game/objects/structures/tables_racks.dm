
/* Tables and Racks - File webedited in with love by TripleZeta
 * Contains:
 *		Reinforced Wooden Tables
 *
 */

/obj/structure/table/wood/reinforced //a reinforced version of the regular wooden table, primarily for use in solgov outposts or ships
	name = "reinforced wooden table"
	desc = "A reinforced version of the four-legged wooden table. Likely as easy to burn as a normal one."
	icon = 'whitesands/icons/obj/smooth_structures/reinforced_wood_table.dmi'
	icon_state = "reinforced_wood_table-0"
	base_icon_state = "reinforced_wood_table"
	deconstruction_ready = 0
	buildstack = /obj/item/stack/sheet/plasteel
	resistance_flags = FLAMMABLE
	max_integrity = 200
	integrity_failure = 0.25
	armor = list("melee" = 10, "bullet" = 30, "laser" = 30, "energy" = 100, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70) //trolld
	can_flip = FALSE //same as reinforced and theres no sprites for it

/obj/structure/table/wood/reinforced/deconstruction_hints(mob/user)
	if(deconstruction_ready)
		return "<span class='notice'>The top cover has been <i>pried</i> loose and the main frame's <b>bolts</b> are exposed.</span>"
	else
		return "<span class='notice'>The top cover is firmly stuck on, but could be <i>pried</i> off with considerable effort.</span>"

/obj/structure/table/wood/reinforced/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_CROWBAR && user.a_intent != INTENT_HELP)
		if(!W.tool_start_check(user, amount=0))
			return

		if(deconstruction_ready)
			to_chat(user, "<span class='notice'>You begin levering the top cover back in place...</span>")
			if (W.use_tool(src, user, 50, volume=50))
				to_chat(user, "<span class='notice'>You pry the top cover back into place.</span>")
				deconstruction_ready = 0
		else
			to_chat(user, "<span class='notice'>You start prying off the top cover...</span>")
			if (W.use_tool(src, user, 50, volume=50))
				to_chat(user, "<span class='notice'>You pry off the top cover.</span>")
				deconstruction_ready = 1
	else
		. = ..()
