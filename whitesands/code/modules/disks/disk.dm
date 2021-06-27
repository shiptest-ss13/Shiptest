/obj/item/disk
	icon = 'whitesands/icons/obj/diskette.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	icon_state = "disk_map"
	drop_sound = 'sound/items/handling/disk_drop.ogg'
	pickup_sound =  'sound/items/handling/disk_pickup.ogg'
	var/random_color = TRUE
	var/illustration
	var/static/list/random_disk_colors = list(
		"blue" = "#0000ff",
		"red" = "#ff000d",
		"pink" = "#fb00ff",
		"brown" = "#ff7b00",
		"green" = "#00ff26",
		"cyan" = "#00ffd9",
		"yellow" = "#ffd000"
	)

obj/item/screwdriver/Initialize()
	. = ..()
	if(random_color) //random colors!
		icon_state = "disk"
		var/our_color = pick(random_disk_colors)
		add_atom_colour(random_disk_colors[our_color], FIXED_COLOUR_PRIORITY)
		update_icon()

/obj/item/screwdriver/update_overlays()
	. = ..()
	if(!random_color) //icon override
		return
	var/mutable_appearance/label = mutable_appearance(icon, "label")
	var/mutable_appearance/protect = mutable_appearance(icon, "protect")
	protect.appearance_flags = RESET_COLOR
	. += label
	. += protect
	if(illustration)
		. += illustration
