/obj/item/screwdriver
	name = "screwdriver"
	desc = "You can be totally screwy with this."
	icon = 'whitesands/icons/obj/tools.dmi' //WS Edit - Better Tool Sprites
	icon_state = "screwdriver_map"
	item_state = "screwdriver"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	belt_icon_state = "screwdriver"
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 5
	w_class = WEIGHT_CLASS_TINY
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=75)
	attack_verb = list("stabbed")
	hitsound = 'sound/weapons/bladeslice.ogg'
	usesound = list('sound/items/screwdriver.ogg', 'sound/items/screwdriver2.ogg')
	tool_behaviour = TOOL_SCREWDRIVER
	toolspeed = 1

	greyscale_config = /datum/greyscale_config/screwdriver
	greyscale_config_inhand_left = /datum/greyscale_config/screwdriver_inhand_left
	greyscale_config_inhand_right = /datum/greyscale_config/screwdriver_inhand_right
	greyscale_config_belt = /datum/greyscale_config/screwdriver_belt

	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	drop_sound = 'sound/items/handling/screwdriver_drop.ogg'
	pickup_sound =  'sound/items/handling/screwdriver_pickup.ogg'
	item_flags = SURGICAL_TOOL | EYE_STAB
	///if the screwdriver uses random coloring
	var/random_color = TRUE
	/// List of possible random colors
	var/static/list/screwdriver_colors = list(
		"blue" = "#8080ff",
		"red" = "#ff666e",
		"pink" = "#fd99ff",
		"brown" = "#b38459",
		"green" = "#9fe3a9",
		"cyan" = "#96ffef",
		"yellow" = "#ffe366"
	)

/obj/item/screwdriver/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is stabbing [src] into [user.p_their()] [pick("temple", "heart")]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return(BRUTELOSS)

/obj/item/screwdriver/Initialize(mapload)
	if(random_color)
		var/our_color = pick(screwdriver_colors)
		set_greyscale(colors=list(screwdriver_colors[our_color]))
	. = ..()
	if(prob(75))
		pixel_y = rand(0, 16)

/obj/item/screwdriver/abductor
	name = "alien screwdriver"
	desc = "An ultrasonic screwdriver."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "screwdriver_a"
	item_state = "screwdriver_nuke"
	usesound = 'sound/items/pshoom.ogg'
	toolspeed = 0.1
	random_color = FALSE
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null

/obj/item/screwdriver/abductor/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "screwdriver_nuke")

/obj/item/screwdriver/power
	name = "hand drill"
	desc = "A simple powered hand drill."
	icon_state = "drill_screw"
	item_state = "drill"
	custom_materials = list(/datum/material/iron=150,/datum/material/silver=50,/datum/material/titanium=25) //done for balance reasons, making them high value for research, but harder to get
	force = 8 //might or might not be too high, subject to change
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 8
	throw_speed = 2
	throw_range = 3//it's heavier than a screw driver/wrench, so it does more damage, but can't be thrown as far
	attack_verb = list("drilled", "screwed", "jabbed","whacked")
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.7
	random_color = FALSE
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null

/obj/item/screwdriver/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_SCREWDRIVER ? "screw" : "bolt"] bit."

/obj/item/screwdriver/power/suicide_act(mob/user)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		user.visible_message("<span class='suicide'>[user] is putting [src] to [user.p_their()] temple. It looks like [user.p_theyre()] trying to commit suicide!</span>")
	else
		user.visible_message("<span class='suicide'>[user] is pressing [src] against [user.p_their()] head! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(loc, 'sound/items/drill_use.ogg', 50, TRUE, -1)
	return(BRUTELOSS)

/obj/item/screwdriver/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_WRENCH
		to_chat(user, "<span class='notice'>You attach the bolt bit to [src].</span>")
		icon_state = "drill_bolt"
	else
		tool_behaviour = TOOL_SCREWDRIVER
		to_chat(user, "<span class='notice'>You attach the screw bit to [src].</span>")
		icon_state = "drill_screw"

/obj/item/screwdriver/cyborg
	name = "automated screwdriver"
	desc = "A powerful automated screwdriver, designed to be both precise and quick."
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "screwdriver_cyborg"
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.5
	random_color = FALSE
