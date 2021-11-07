/obj/item/disk
	icon = 'icons/obj/diskette.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	icon_state = "disk_map"
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound =  'sound/items/handling/disk_pickup.ogg'
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
	icon_state = "disk"
	if(random_color) //random colors!
		var/our_color = pick(random_disk_colors)
		add_atom_colour(random_disk_colors[our_color], FIXED_COLOUR_PRIORITY)
	else
		add_atom_colour(color, FIXED_COLOUR_PRIORITY)
	update_icon()
	update_overlays()

/obj/item/disk/update_overlays()
	. = ..()
	var/mutable_appearance/label = mutable_appearance(icon, "label")
	var/mutable_appearance/protect = mutable_appearance(icon, "protect")
	protect.appearance_flags = RESET_COLOR
	label.appearance_flags = RESET_COLOR
	. += label
	. += protect
	if(illustration)
		var/mutable_appearance/writing = mutable_appearance(icon, illustration)
		writing.appearance_flags = RESET_COLOR
		. += writing
