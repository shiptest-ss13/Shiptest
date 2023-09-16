/obj/item/disk
	icon = 'icons/obj/diskette.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	icon_state = "disk_map"
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound =  'sound/items/handling/disk_pickup.ogg'
	//use the blueshifted pallete instead of a greyscale one? Looks good with anything colored, anything not is reccomended to turn this to false
	var/blueshift_pallete = TRUE
	var/random_color = TRUE
	var/illustration = "generic"
	var/static/list/random_disk_colors = list(
		"blue" = rgb(24, 97, 213),
		"red" = rgb(255, 0, 0),
		"pink" = rgb(213, 24, 141),
		"brown" = rgb(160, 82, 18),
		"green" = rgb(14, 127, 27),
		"cyan" = rgb(24, 162, 213),
		"yellow" = rgb(255, 165, 0)
	)

/obj/item/disk/Initialize()
	. = ..()
	if(blueshift_pallete)
		icon_state = "disk_bs"
	else
		icon_state = "disk"
	if(random_color) //random colors!
		var/our_color = pick(random_disk_colors)
		add_atom_colour(random_disk_colors[our_color], FIXED_COLOUR_PRIORITY)
	else
		add_atom_colour(color, FIXED_COLOUR_PRIORITY)
	update_appearance()
	update_overlays()

/obj/item/disk/update_overlays()
	. = ..()
	var/mutable_appearance/label
	if(blueshift_pallete)
		label = mutable_appearance(icon, "label_bs")
	else
		label = mutable_appearance(icon, "label")
	var/mutable_appearance/protect
	if(blueshift_pallete)
		protect = mutable_appearance(icon, "protect_bs")
	else
		protect = mutable_appearance(icon, "protect")
	protect.appearance_flags = RESET_COLOR
	label.appearance_flags = RESET_COLOR
	. += label
	. += protect
	if(illustration)
		var/mutable_appearance/writing = mutable_appearance(icon, illustration)
		writing.appearance_flags = RESET_COLOR
		. += writing

/obj/item/disk/attackby(obj/item/object, mob/user, params)
	if(istype(object, /obj/item/pen))
		if(!user.is_literate())
			to_chat(user, "<span class='notice'>You scribble illegibly on the cover of [src]!</span>")
			return
		var/inputvalue = stripped_input(user, "What would you like to label the Disk?", "Disk Labelling", "", MAX_NAME_LEN)

		if(!inputvalue)
			return

		if(user.canUseTopic(src, BE_CLOSE))
			name = "[initial(src.name)][(inputvalue ? " - '[inputvalue]'" : null)]"
	return
