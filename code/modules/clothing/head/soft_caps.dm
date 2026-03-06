/obj/item/clothing/head/soft
	name = "cap"
	desc = "It's a baseball cap."
	icon_state = "whitesoft"
	item_state = "helmet"
	icon = 'icons/obj/clothing/head/color.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/color.dmi'
	cuttable = TRUE
	clothamnt = 2
	unique_reskin = list("white cap" = "whitesoft",
						"grey cap" = "greysoft",
						"black cap" = "blacksoft",
						"red cap" = "redsoft",
						"maroon cap" = "maroonsoft",
						"orange cap" = "orangesoft",
						"yellow cap" = "yellowsoft",
						"green cap" = "greensoft",
						"dark green cap" = "darkgreensoft",
						"teal cap" = "tealsoft",
						"blue cap" = "bluesoft",
						"dark blue cap" = "darkbluesoft",
						"purple cap" = "purplesoft",
						"pink cap" = "pinksoft",
						"brown cap" = "brownsoft",
						"light brown cap" = "lightbrownsoft"
						)
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE
	var/flipped = TRUE

/obj/item/clothing/head/soft/Initialize()
	. = ..()
	base_icon_state = icon_state

/obj/item/clothing/head/soft/verb/flipcap()
	set category = "Object"
	set name = "Flip cap"

	flip(usr)

/obj/item/clothing/head/soft/attack_hand_secondary(mob/user, list/modifiers)
	flip()
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/clothing/head/soft/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		return FALSE
	if(unique_reskin && !current_skin)
		reskin_obj(user)

	return TRUE

/obj/item/clothing/head/soft/proc/flip(mob/user)
	if(!user.incapacitated())
		flipped = !flipped
		if(src.flipped)
			icon_state = "[base_icon_state]_flipped"
			to_chat(user, span_notice("You flip the hat backwards."))
		else
			icon_state = base_icon_state
			to_chat(user, span_notice("You flip the hat back in normal position."))
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/soft/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click the cap to flip it [flipped ? "forwards" : "backwards"].")

/obj/item/clothing/head/soft/white
	name = "white cap"
	desc = "It's a baseball hat in a tasteful white colour."
	icon_state = "whitesoft"
	current_skin = "white cap"

/obj/item/clothing/head/soft/grey
	name = "grey cap"
	desc = "It's a baseball hat in a tasteful grey colour."
	icon_state = "greysoft"
	current_skin = "grey cap"

/obj/item/clothing/head/soft/black
	name = "black cap"
	desc = "It's a baseball hat in a tasteful black colour."
	icon_state = "blacksoft"
	current_skin = "black cap"

/obj/item/clothing/head/soft/red
	name = "red cap"
	desc = "It's a baseball hat in a tasteful red colour."
	icon_state = "redsoft"
	current_skin = "red cap"

/obj/item/clothing/head/soft/maroon
	name = "maroon cap"
	desc = "It's a baseball hat in a tasteful maroon colour."
	icon_state = "maroonsoft"
	current_skin = "maroon cap"

/obj/item/clothing/head/soft/orange
	name = "orange cap"
	desc = "It's a baseball hat in a tasteful orange colour."
	icon_state = "orangesoft"
	current_skin = "orange cap"

/obj/item/clothing/head/soft/yellow
	name = "yellow cap"
	desc = "It's a baseball hat in a tasteful yellow colour."
	icon_state = "yellowsoft"
	current_skin = "yellow cap"

/obj/item/clothing/head/soft/green
	name = "green cap"
	desc = "It's a baseball hat in a tasteful green colour."
	icon_state = "greensoft"
	current_skin = "green cap"

/obj/item/clothing/head/soft/darkgreen
	name = "dark green cap"
	desc = "It's a baseball hat in a tasteful dark green colour."
	icon_state = "darkgreensoft"
	current_skin = "dark green cap"

/obj/item/clothing/head/soft/teal
	name = "teal cap"
	desc = "It's a baseball hat in a tasteful teal colour."
	icon_state = "tealsoft"
	current_skin = "teal cap"

/obj/item/clothing/head/soft/blue
	name = "blue cap"
	desc = "It's a baseball hat in a tasteful blue colour."
	icon_state = "bluesoft"
	current_skin = "blue cap"

/obj/item/clothing/head/soft/darkblue
	name = "dark blue cap"
	desc = "It's a baseball hat in a tasteful dark blue colour."
	icon_state = "darkbluesoft"
	current_skin = "dark blue cap"

/obj/item/clothing/head/soft/purple
	name = "purple cap"
	desc = "It's a baseball hat in a tasteful purple colour."
	icon_state = "purplesoft"
	current_skin = "purple cap"

/obj/item/clothing/head/soft/pink
	name = "pink cap"
	desc = "It's a baseball hat in a tasteful pink colour."
	icon_state = "pinksoft"
	current_skin = "pink cap"

/obj/item/clothing/head/soft/brown
	name = "brown cap"
	desc = "It's a baseball hat in a tasteful brown colour."
	icon_state = "brownsoft"
	current_skin = "brown cap"

/obj/item/clothing/head/soft/lightbrown
	name = "light brown cap"
	desc = "It's a baseball hat in a tasteful light brown colour."
	icon_state = "lightbrownsoft"
	current_skin = "light brown cap"

/obj/item/clothing/head/soft/sec
	name = "security cap"
	desc = "It's a robust baseball hat in tasteful red colour."
	icon_state = "secsoft"
	unique_reskin = null
	dog_fashion = null
	icon = 'icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head.dmi'

/obj/item/clothing/head/soft/sec/brig_phys
	name = "security medic cap"
	icon_state = "secsoft"
	icon = 'icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head.dmi'

/obj/item/clothing/head/soft/paramedic
	name = "paramedic cap"
	desc = "It's a baseball hat with a dark turquoise color and a reflective cross on the top."
	icon_state = "paramedicsoft"
	unique_reskin = null
	dog_fashion = null
	icon = 'icons/obj/clothing/hats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head.dmi'

/obj/item/clothing/head/soft/cybersun
	name = "cybersun agent cap"
	desc = "A black baseball hat emblazoned with a reflective Cybersun patch."
	icon_state = "agentsoft"
	unique_reskin = null
	dog_fashion = null

/obj/item/clothing/head/soft/cybersun/medical
	name = "cybersun medic cap"
	desc = "A turquoise baseball hat emblazoned with a reflective cross. Typical of Cybersun Industries field medics."
	icon_state = "cybersunsoft"
	unique_reskin = null
	dog_fashion = null

/obj/item/clothing/head/soft/utility_beige
	name = "beige utility cover"
	desc = "A flat beige utility cover, unbranded. Just the right color for those sandy planetoids."
	icon_state = "patrolbeigesoft"
	unique_reskin = null
	dog_fashion = null

/obj/item/clothing/head/soft/utility_black
	name = "black utility cover"
	desc = "A flat black utility cover, unbranded. Night Vision Goggles sold separately."
	icon_state = "patrolblacksoft"
	unique_reskin = null
	dog_fashion = null

/obj/item/clothing/head/soft/utility_olive
	name = "miskilamao cap"
	desc = "An olive utility cover emblazoned with the Miskilamo Shipbreaking logo. The material feels cheap."
	icon_state = "patrololivesoft"
	unique_reskin = null
	dog_fashion = null

/obj/item/clothing/head/soft/utility_navy
	name = "navy utility cover"
	desc = "A navy blue utility cover, unbranded. Perfect for Seamen on long voyages."
	icon_state = "patrolnavysoft"
	unique_reskin = null
	dog_fashion = null
