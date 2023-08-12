/*****************Marker Beacons**************************/
GLOBAL_LIST_INIT(marker_beacon_colors, sortList(list(
"Random" = FALSE, //not a true color, will pick a random color
"Burgundy" = LIGHT_COLOR_FLARE,
"Bronze" = LIGHT_COLOR_ORANGE,
"Yellow" = LIGHT_COLOR_YELLOW,
"Lime" = LIGHT_COLOR_SLIME_LAMP,
"Olive" = LIGHT_COLOR_GREEN,
"Jade" = LIGHT_COLOR_BLUEGREEN,
"Teal" = LIGHT_COLOR_LIGHT_CYAN,
"Cerulean" = LIGHT_COLOR_BLUE,
"Indigo" = LIGHT_COLOR_DARK_BLUE,
"Purple" = LIGHT_COLOR_PURPLE,
"Violet" = LIGHT_COLOR_LAVENDER,
"Fuchsia" = LIGHT_COLOR_PINK)))

/obj/item/stack/marker_beacon
	name = "marker beacon"
	singular_name = "marker beacon"
	desc = "You should not see this!" //unless you're coding or mapping
	icon = 'icons/obj/lighting.dmi'
	icon_state = "marker"
	merge_type = /obj/item/stack/marker_beacon
	max_amount = 100
	novariants = TRUE
	custom_price = 200
	var/picked_color = "random"
	var/structure_type = /obj/structure/marker_beacon

/obj/item/stack/marker_beacon/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/stack/marker_beacon/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Use in-hand to place a [singular_name].\n"+\
	"Alt-click to select a color. Current color is [picked_color].</span>"

/obj/item/stack/marker_beacon/update_icon_state()
	icon_state = "[initial(icon_state)][lowertext(picked_color)]"
	return ..()

/obj/item/stack/marker_beacon/attack_self(mob/user)
	if(!isturf(user.loc))
		to_chat(user, "<span class='warning'>You need more space to place a [singular_name] here.</span>")
		return
	if(locate(/obj/structure/marker_beacon) in user.loc)
		to_chat(user, "<span class='warning'>There is already a [singular_name] here.</span>")
		return
	if(use(1))
		to_chat(user, "<span class='notice'>You activate and anchor [amount ? "a":"the"] [singular_name] in place.</span>")
		playsound(user, 'sound/machines/click.ogg', 50, TRUE)
		var/obj/structure/marker_beacon/marker = new structure_type(get_turf(user),picked_color)
		transfer_fingerprints_to(marker)

/obj/item/stack/marker_beacon/AltClick(mob/living/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	var/input_color = input(user, "Choose a color.", "Beacon Color") as null|anything in GLOB.marker_beacon_colors
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	if(input_color)
		picked_color = input_color
		update_appearance()

/obj/structure/marker_beacon
	name = "marker beacon"
	desc = "A Prism-brand path illumination device. It is anchored in place and glowing steadily."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "marker"
	layer = BELOW_OPEN_DOOR_LAYER
	armor = list("melee" = 50, "bullet" = 75, "laser" = 75, "energy" = 75, "bomb" = 25, "bio" = 100, "rad" = 100, "fire" = 25, "acid" = 0)
	max_integrity = 50
	anchored = TRUE
	light_range = 2
	light_power = 3
	var/remove_speed = 15
	var/picked_color
	var/stack_type = /obj/item/stack/marker_beacon

/obj/structure/marker_beacon/Initialize(mapload, set_color)
	. = ..()
	if(set_color)
		picked_color = set_color
	update_appearance()

/obj/structure/marker_beacon/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))

		var/obj/item/stack/marker_beacon/marker = new(loc)
		marker.picked_color = picked_color
		marker.update_appearance()

	qdel(src)

/obj/structure/marker_beacon/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to select a color. Current color is [picked_color].</span>"

/obj/structure/marker_beacon/update_appearance(updates)
	while(!picked_color || !GLOB.marker_beacon_colors[picked_color])
		picked_color = pick(GLOB.marker_beacon_colors)

	. = ..()
	set_light(light_range, light_power, GLOB.marker_beacon_colors[picked_color])

/obj/structure/marker_beacon/update_icon_state()
	icon_state = "[initial(icon_state)][lowertext(picked_color)]-on"
	return ..()

/obj/structure/marker_beacon/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	to_chat(user, "<span class='notice'>You start picking [src] up...</span>")
	if(do_after(user, remove_speed, target = src))

		var/obj/item/stack/marker_beacon/marker = new stack_type(loc)
		marker.picked_color = picked_color
		marker.update_appearance()
		transfer_fingerprints_to(marker)
		if(user.put_in_hands(marker, TRUE)) //delete the beacon if it fails
			playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
			qdel(src) //otherwise delete us

/obj/structure/marker_beacon/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/marker_beacon))
		if(istype(I, stack_type))
			var/obj/item/stack/marker_beacon/marker = I
			to_chat(user, "<span class='notice'>You start picking [src] up...</span>")
			if(do_after(user, remove_speed, target = src) && marker.amount + 1 <= marker.max_amount)
				marker.add(1)
				playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
				qdel(src)
				return
		else
			to_chat(user, "<span class = 'notice'>[src] is a different type of beacon.")
			return
	if(istype(I, /obj/item/light_eater))
		var/obj/effect/decal/cleanable/ash/A = new /obj/effect/decal/cleanable/ash(drop_location())
		A.desc += "\nLooks like this used to be \a [src] some time ago."
		visible_message("<span class='danger'>[src] is disintegrated by [I]!</span>")
		playsound(src, 'sound/items/welder.ogg', 50, TRUE)
		qdel(src)
		return
	return ..()

/obj/structure/marker_beacon/AltClick(mob/living/user)
	..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	var/input_color = input(user, "Choose a color.", "Beacon Color") as null|anything in GLOB.marker_beacon_colors
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE))
		return
	if(input_color)
		picked_color = input_color
		update_appearance()

//default beacons

/obj/item/stack/marker_beacon/default
	name = "marker beacon"
	desc = "Prism-brand path illumination devices. Used by miners to mark paths and warn of danger."
	novariants = TRUE
	custom_price = 200
	structure_type = /obj/structure/marker_beacon/default
	merge_type = /obj/item/stack/marker_beacon/default

/obj/item/stack/marker_beacon/default/ten //miners start with 10 of these
	amount = 10

/obj/item/stack/marker_beacon/default/thirty //and they're bought in stacks of 1, 10, or 30
	amount = 30

/obj/structure/marker_beacon/default
	name = "marker beacon"
	desc = "A Prism-brand path illumination device. It is anchored in place and glowing steadily."
	stack_type = /obj/item/stack/marker_beacon/default


//acid proof beacons, since we have acid rain on some worlds

/obj/item/stack/marker_beacon/acidproof
	name = "Acid-Proof Marker Beacon"
	desc = "Prism-brand path illumination devices. Used by miners to mark paths and warn of danger. This one has a reinforced casing"
	resistance_flags = 100
	merge_type = /obj/item/stack/marker_beacon/acidproof
	custom_price = 400 //more expensive than normal ones
	structure_type = /obj/structure/marker_beacon/acidproof


/obj/item/stack/marker_beacon/acidproof/ten
	amount = 10

/obj/item/stack/marker_beacon/acidproof/thirty
	amount = 30

//and the structure

/obj/structure/marker_beacon/acidproof
	name = "acid proof marker beacon"
	desc = "Prism-brand path illumination device. It is anchored in place and glowing steadily. This one has a reinforced casing"
	resistance_flags = 100
	stack_type = /obj/item/stack/marker_beacon/acidproof

