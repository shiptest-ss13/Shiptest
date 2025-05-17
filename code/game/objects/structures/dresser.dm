/obj/structure/dresser
	name = "dresser"
	desc = "A nicely-crafted wooden dresser. It's filled with lots of undies."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "dresser"
	density = TRUE
	anchored = TRUE

	obj_flags = parent_type::obj_flags | ELEVATED_SURFACE
	hitsound_type = PROJECTILE_HITSOUND_WOOD

/obj/structure/dresser/attackby(obj/item/I, mob/user, params)
	var/list/modifiers = params2list(params)
	if(user.transferItemToLoc(I, drop_location(), silent = FALSE))
		//Center the icon where the user clicked.
		if(!LAZYACCESS(modifiers, ICON_X) || !LAZYACCESS(modifiers, ICON_Y))
			return
		//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
		I.pixel_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size/2), world.icon_size/2)
		I.pixel_y = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(world.icon_size/2), world.icon_size/2)
		return TRUE
	else
		return ..()

/obj/structure/dresser/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	to_chat(user, span_notice("You begin to [anchored ? "unwrench" : "wrench"] [src]."))
	if(I.use_tool(src, user, 20, volume=50))
		to_chat(user, span_notice("You successfully [anchored ? "unwrench" : "wrench"] [src]."))
		set_anchored(!anchored)

/obj/structure/dresser/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(!anchored)
		to_chat(user, span_notice("You begin to pull apart [src]."))
		if(I.use_tool(src, user, 30, volume=50))
			to_chat(user, span_notice("You successfully deconstruct [src]."))
			deconstruct()

/obj/structure/dresser/deconstruct_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return FALSE
	to_chat(user, span_notice("You begin to disassemble [src]."))
	if(I.use_tool(src, user, 10, volume=50))
		to_chat(user, span_notice("You successfully deconstruct [src]."))
		deconstruct()

/obj/structure/dresser/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	qdel(src)

/obj/structure/dresser/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!Adjacent(user))//no tele-grooming
		return
	if(ishuman(user))
		var/mob/living/carbon/human/H = user

		if(H.dna && H.dna.species && (NO_UNDERWEAR in H.dna.species.species_traits))
			to_chat(user, span_warning("You are not capable of wearing underwear."))
			return

		var/choice = input(user, "Underwear, Undershirt, or Socks?", "Changing") as null|anything in list("Underwear", "Underwear Color", "Undershirt", "Undershirt Color", "Socks", "Socks Color")

		if(!Adjacent(user))
			return
		switch(choice)
			if("Underwear")
				var/new_undies = input(user, "Select your underwear", "Changing")  as null|anything in GLOB.underwear_list
				if(new_undies)
					H.underwear = new_undies
			if("Underwear Color")
				var/new_underwear_color = input(H, "Choose your underwear color", "Underwear Color","#"+H.underwear_color) as color|null
				if(new_underwear_color)
					H.underwear_color = sanitize_hexcolor(new_underwear_color)
			if("Undershirt")
				var/new_undershirt = input(user, "Select your undershirt", "Changing") as null|anything in GLOB.undershirt_list
				if(new_undershirt)
					H.undershirt = new_undershirt
			if("Undershirt Color")
				var/new_undershirt_color = input(H, "Choose your undershirt color", "Undershirt Color","#"+H.undershirt_color) as color|null
				if(new_undershirt_color)
					H.undershirt_color = sanitize_hexcolor(new_undershirt_color)
			if("Socks")
				var/new_socks = input(user, "Select your socks", "Changing") as null|anything in GLOB.socks_list
				if(new_socks)
					H.socks= new_socks
			if("Socks Color")
				var/new_socks_color = input(H, "Choose your socks color", "Socks Color","#"+H.socks_color) as color|null
				if(new_socks_color)
					H.socks_color = sanitize_hexcolor(new_socks_color)

		add_fingerprint(H)
		H.update_body()
