/obj/item/clothing/shoes/sneakers
	name = "shoes"
	icon_state = "white"
	item_state = "white"
	icon = 'icons/obj/clothing/feet/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/feet/color.dmi'
	dying_key = DYE_REGISTRY_SNEAKERS
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	custom_price = 50
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	unique_reskin = list("white shoes" = "white",
						"grey shoes" = "grey",
						"black shoes" = "black",
						"red shoes" = "red",
						"maroon shoes" = "maroon",
						"orange shoes" = "orange",
						"yellow shoes" = "yellow",
						"green shoes" = "green",
						"dark green shoes" = "darkgreen",
						"teal shoes" = "teal",
						"blue shoes" = "blue",
						"dark blue shoes" = "darkblue",
						"purple shoes" = "purple",
						"pink shoes" = "pink",
						"brown shoes" = "brown",
						"light brown shoes" = "lightbrown"
						)
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE

/obj/item/clothing/shoes/sneakers/white
	name = "white shoes"
	desc = "A pair of white shoes."
	icon_state = "white"
	current_skin = "white shoes"
	permeability_coefficient = 0.01

/obj/item/clothing/shoes/sneakers/grey
	name = "grey shoes"
	desc = "A pair of grey shoes."
	icon_state = "grey"
	current_skin = "grey shoes"

/obj/item/clothing/shoes/sneakers/black
	name = "black shoes"
	desc = "A pair of black shoes."
	icon_state = "black"
	current_skin = "black shoes"

/obj/item/clothing/shoes/sneakers/red
	name = "red shoes"
	desc = "Stylish red shoes."
	icon_state = "red"
	current_skin = "red shoes"

/obj/item/clothing/shoes/sneakers/yellow
	name = "yellow shoes"
	desc = "A pair of yellow shoes."
	icon_state = "yellow"
	current_skin = "yellow shoes"

/obj/item/clothing/shoes/sneakers/green
	name = "green shoes"
	desc = "A pair of green shoes."
	icon_state = "green"
	current_skin = "green shoes"

/obj/item/clothing/shoes/sneakers/darkgreen
	name = "dark green shoes"
	desc = "A pair of dark green shoes."
	icon_state = "darkgreen"
	current_skin = "dark green shoes"

/obj/item/clothing/shoes/sneakers/teal
	name = "teal shoes"
	desc = "A pair of teal shoes."
	icon_state = "teal"
	current_skin = "teal shoes"

/obj/item/clothing/shoes/sneakers/blue
	name = "blue shoes"
	desc = "A pair of blue shoes."
	icon_state = "blue"
	current_skin = "blue shoes"

/obj/item/clothing/shoes/sneakers/darkblue
	name = "dark blue shoes"
	desc = "A pair of dark blue shoes."
	icon_state = "darkblue"
	current_skin = "dark blue shoes"

/obj/item/clothing/shoes/sneakers/purple
	name = "purple shoes"
	desc = "A pair of purple shoes."
	icon_state = "purple"
	current_skin = "purple shoes"

/obj/item/clothing/shoes/sneakers/pink
	name = "pink shoes"
	desc = "A pair of pink shoes."
	icon_state = "pink"
	current_skin = "pink shoes"

/obj/item/clothing/shoes/sneakers/brown
	name = "brown shoes"
	desc = "A pair of brown shoes."
	icon_state = "brown"
	current_skin = "brown shoes"

/obj/item/clothing/shoes/sneakers/lightbrown
	name = "light brown shoes"
	desc = "A pair of light brown shoes."
	icon_state = "lightbrown"
	current_skin = "light brown shoes"

/obj/item/clothing/shoes/sneakers/orange
	name = "orange shoes"
	desc = "A pair of orange shoes."
	icon_state = "orange"
	current_skin = "orange shoes"

/obj/item/clothing/shoes/sneakers/orange/attack_self(mob/user)
	if (src.chained)
		src.chained = null
		src.slowdown = SHOES_SLOWDOWN
		new /obj/item/restraints/handcuffs(user.loc)
		src.icon_state = "orange"
	return

/obj/item/clothing/shoes/sneakers/orange/attackby(obj/H, loc, params)
	..()
	// Note: not using istype here because we want to ignore all subtypes
	if (H.type == /obj/item/restraints/handcuffs && !chained)
		qdel(H)
		src.chained = 1
		src.slowdown = 15
		src.icon_state = "orange1"
	return

/obj/item/clothing/shoes/sneakers/orange/allow_attack_hand_drop(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/C = user
		if(C.shoes == src && chained == 1)
			to_chat(user, span_warning("You need help taking these off!"))
			return FALSE
	return ..()

/obj/item/clothing/shoes/sneakers/orange/MouseDrop(atom/over)
	var/mob/m = usr
	if(ishuman(m))
		var/mob/living/carbon/human/c = m
		if(c.shoes == src && chained == 1)
			to_chat(c, span_warning("You need help taking these off!"))
			return
	return ..()

