/obj/item/card/data/music
	icon_state = "data_3"
	var/datum/track/track
	var/uploader_ckey

/obj/machinery/musicwriter
	name = "brain signals recorder МК-3"
	desc = "Can be reloaded with the multitool."
	icon = 'icons/obj/machines/musicconsole.dmi'
	icon_state = "off"
	var/mob/person //current user
	var/writing = 0
	var/assemblytype = /obj/structure/musicwriter

/obj/machinery/musicwriter/examine(mob/user)
	. = ..()
	if(writing)
		. += span_notice("Can be reloaded with the <b>multitool</b>.")

/obj/machinery/musicwriter/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(writing && do_after(user, 5 SECONDS, src))
		writing = 0
		to_chat(user,span_warning("Reloading system with the multitool."))
		icon_state = "off"
		person = null

/obj/machinery/musicwriter/ui_interact(mob/user)
	if(!anchored)
		to_chat(user,span_warning("Needs to be wrenched!"))
		return
	if(!allowed(user))
		to_chat(user,span_warning("Error! No access."))
		user.playsound_local(src,'sound/misc/compiler-failure.ogg', 25, 1)
		return
	if(writing)
		say("Writing [user.name]'s brain... Wait!")
		return
	write(user)

/obj/machinery/musicwriter/proc/write(mob/user)
	if(!writing && !person)
		icon_state = "on"
		writing = TRUE
		person = user
		var/N = sanitize(input("Song name") as text|null)
		if(N)
			var/sound/S = input("File") as sound|null
			var/mob/living/carbon/human/H = user
			var/obj/item/card/id/C = H.get_idcard(TRUE)
			var/datum/bank_account/account = C.registered_account
			if(!account.adjust_money(-15))
				say("You do not possess the funds to use musicwriter.")
				return
			if(S)
				var/datum/track/T = new()
				var/obj/item/card/data/music/disk = new(src)
				T.song_path = S
				T.song_name = N
				T.song_length = length(S)
				T.song_beat = 5
				disk.track = T
				disk.name = "music disk ([N])"
				disk.forceMove(get_turf(src))
				disk.uploader_ckey = person.ckey
				message_admins("[ADMIN_LOOKUPFLW(user)] uploaded <A HREF='?_src_=holder;listensound=\ref[S]'>sound</A> named as [N]. <A HREF='?_src_=holder;wipedata=\ref[disk]'>Wipe</A> data.")

		icon_state = "off"
		writing = FALSE
		person = null

/obj/machinery/musicwriter/attackby(obj/item/O, mob/living/user, params)
	if(default_deconstruction_screwdriver(user, "off", "off", O))
		return TRUE
	if(default_deconstruction_crowbar(O))
		return TRUE
	if(user.a_intent == INTENT_HARM) //so we can hit the machine
		return ..()
	return ..()

/obj/machinery/musicwriter/deconstruct(disassembled)
	if(!(flags_1 & NODECONSTRUCT_1))
		var/obj/structure/musicwriter/assembly = new assemblytype(loc)
		assembly.pixel_x = src.pixel_x
		assembly.pixel_y = src.pixel_y
		assembly.set_anchored(TRUE)
		assembly.state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
		contents = null
		new /obj/item/electronics/musicwriter(loc)
	qdel(src)

/obj/item/wallframe/musicwriter
	name = "\improper brain signals recorder frame"
	desc = "Used to build brain signals recorder."
	icon = 'icons/obj/machines/musicconsole.dmi'
	icon_state = "off"
	result_path = /obj/structure/musicwriter
	pixel_shift = 32
	inverse = 1

/obj/item/electronics/musicwriter
	name = "brain signals recorder frame circuit"
	desc = "Used to build brain signals recorder."

/obj/structure/musicwriter
	name = "\improper unfinished brain signals recorder"
	desc = "Used to build brain signals recorder. In consruction."
	icon = 'icons/obj/machines/musicconsole.dmi'
	icon_state = "off"
	anchored = TRUE
	var/obj/item/electronics/musicwriter/electronics = null
	var/state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
	var/previous_assembly = /obj/structure/musicwriter

/obj/structure/musicwriter/examine(mob/user)
	. = ..()
	if(!electronics)
		. += "<span class='notice'>The maintenance panel is <b>open</b>, but the circuit slot is <i>empty</i>.</span>"
	else
		. += "<span class='notice'>The musicwriter can be finished with the <i>screwdriwer</i>.</span>"

/obj/structure/musicwriter/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/electronics/musicwriter) && state == AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
		I.play_tool_sound(src, 100)
		user.visible_message("<span class='notice'>[user] installs the electronics into [src].</span>", \
							"<span class='notice'>You start to install electronics into [src]...</span>")
		if(do_after(user, 4 SECONDS, target = src))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
				return
			if(!user.transferItemToLoc(I, src))
				return

			to_chat(user, "<span class='notice'>You install the electronics.</span>")
			state = AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER
			electronics = I
	else if((I.tool_behaviour == TOOL_CROWBAR) && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
		user.visible_message("<span class='notice'>[user] removes the electronics from [src].</span>", \
							"<span class='notice'>You start to remove electronics from [src]...</span>")

		if(I.use_tool(src, user, 4 SECONDS, volume=100))
			if(state != AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
				return
			to_chat(user, "<span class='notice'>You remove the electronics.</span>")
			state = AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS
			var/obj/item/electronics/musicwriter/musicwriter_electronics
			if (!electronics)
				musicwriter_electronics = new /obj/item/electronics/musicwriter(loc)
			else
				musicwriter_electronics = electronics
				electronics = null
				musicwriter_electronics.forceMove(loc)

	else if((I.tool_behaviour == TOOL_SCREWDRIVER) && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
		user.visible_message(
			"<span class='notice'>[user] finishes [src].</span>",
			"<span class='notice'>You start finishing [src]...</span>"
		)
		if(I.use_tool(src, user, 4 SECONDS, volume=100))
			if(loc && state == AIRLOCK_ASSEMBLY_NEEDS_SCREWDRIVER)
				to_chat(user, "<span class='notice'>You finish [src].</span>")
				var/obj/machinery/musicwriter/machine = new /obj/machinery/musicwriter(loc)
				machine.setDir(dir)
				machine.pixel_x = src.pixel_x
				machine.pixel_y = src.pixel_y
				machine.assemblytype = previous_assembly
				electronics.forceMove(machine)
				qdel(src)

	else
		return ..()

/obj/structure/musicwriter/wrench_act(mob/user, obj/item/I)
	. = ..()
	if(state != AIRLOCK_ASSEMBLY_NEEDS_ELECTRONICS)
		return
	I.play_tool_sound(src)
	to_chat(user, "<span class='notice'>You detach [src] from its place.</span>")
	new /obj/item/stack/sheet/metal(drop_location())

	qdel(src)
	return TRUE

/datum/design/musicwriter_board
	name = "Musicwriter Electronics"
	id = "musicwriter_board"
	build_type = AUTOLATHE | PROTOLATHE
	materials = list(/datum/material/iron = 50, /datum/material/glass = 50)
	build_path = /obj/item/electronics/musicwriter
	category = list("initial", "Electronics")
