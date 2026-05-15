/obj/structure/noticeboard
	name = "notice board"
	desc = "A board for pinning important notices upon."
	icon = 'icons/obj/structures/corkboard.dmi'
	icon_state = "board"
	density = FALSE
	anchored = TRUE
	max_integrity = 150

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/noticeboard, 32)

/obj/structure/noticeboard/Initialize(mapload)
	. = ..()

	if(!mapload)
		return

	for(var/obj/item/I in loc)
		if(contents.len > 7)
			break
		if(istype(I, /obj/item/paper) || istype(I, /obj/item/photo))
			I.forceMove(src)
	update_overlays()

//attaching papers!!
/obj/structure/noticeboard/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/paper) || istype(O, /obj/item/photo))
		if(!allowed(user))
			to_chat(user, span_warning("You are not authorized to add notices!"))
			return
		if(contents.len < 7)
			if(!user.transferItemToLoc(O, src))
				return
			update_overlays()
			to_chat(user, span_notice("You pin the [O] to the noticeboard."))
		else
			to_chat(user, span_warning("The notice board is full!"))
	else
		return ..()

/obj/structure/noticeboard/interact(mob/user)
	ui_interact(user)

/obj/structure/noticeboard/ui_interact(mob/user)
	. = ..()
	var/auth = allowed(user)
	var/dat = "<B>[name]</B><BR>"
	for(var/obj/item/P in src)
		if(istype(P, /obj/item/paper))
			dat += "<A href='byond://?src=[REF(src)];read=[REF(P)]'>[P.name]</A> [auth ? "<A href='byond://?src=[REF(src)];write=[REF(P)]'>Write</A> <A href='byond://?src=[REF(src)];remove=[REF(P)]'>Remove</A>" : ""]<BR>"
		else
			dat += "<A href='byond://?src=[REF(src)];read=[REF(P)]'>[P.name]</A> [auth ? "<A href='byond://?src=[REF(src)];remove=[REF(P)]'>Remove</A>" : ""]<BR>"
	user << browse("<HEAD><TITLE>Notices</TITLE></HEAD>[dat]","window=noticeboard")
	onclose(user, "noticeboard")

/obj/structure/noticeboard/Topic(href, href_list)
	..()
	usr.set_machine(src)
	if(href_list["remove"])
		if(usr.stat != CONSCIOUS || HAS_TRAIT(usr, TRAIT_HANDS_BLOCKED))	//For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/I = locate(href_list["remove"]) in contents
		if(istype(I) && I.loc == src)
			I.forceMove(usr.loc)
			usr.put_in_hands(I)
			update_overlays()

	if(href_list["write"])
		if(usr.stat != CONSCIOUS || HAS_TRAIT(usr, TRAIT_HANDS_BLOCKED)) //For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/P = locate(href_list["write"]) in contents
		if(istype(P) && P.loc == src)
			var/obj/item/I = usr.is_holding_item_of_type(/obj/item/pen)
			if(I)
				add_fingerprint(usr)
				P.attackby(I, usr)
			else
				to_chat(usr, span_warning("You'll need something to write with!"))

	if(href_list["read"])
		var/obj/item/I = locate(href_list["read"]) in contents
		if(istype(I) && I.loc == src)
			usr.examinate(I)

/obj/structure/noticeboard/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/sheet/metal (loc, 1)
	qdel(src)

// Notice boards for the heads of staff (plus the qm)

/obj/structure/noticeboard/update_overlays()
	. = ..()
	var/count = max(7, contents.len)
	if(!count)
		return

	var/mutable_appearance/notice_overlay
	if(!icon_exists(icon, "over_[count]"))
		return
	notice_overlay = mutable_appearance(icon, "over_[count]")
	add_overlay(notice_overlay)
