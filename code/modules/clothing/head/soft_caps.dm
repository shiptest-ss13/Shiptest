/obj/item/clothing/head/soft
	name = "cargo cap"
	desc = "It's a baseball hat in a tasteless yellow colour."
	icon_state = "cargosoft"
	item_state = "helmet"
	cuttable = TRUE
	clothamnt = 2
	var/soft_type = "cargo"

	dog_fashion = /datum/dog_fashion/head/cargo_tech

	var/flipped = 0

/obj/item/clothing/head/soft/dropped()
	icon_state = "[soft_type]soft"
	flipped=0
	..()

/obj/item/clothing/head/soft/verb/flipcap()
	set category = "Object"
	set name = "Flip cap"

	flip(usr)


/obj/item/clothing/head/soft/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	else
		flip(user)


/obj/item/clothing/head/soft/proc/flip(mob/user)
	if(!user.incapacitated())
		flipped = !flipped
		if(src.flipped)
			icon_state = "[soft_type]soft_flipped"
			to_chat(user, "<span class='notice'>You flip the hat backwards.</span>")
		else
			icon_state = "[soft_type]soft"
			to_chat(user, "<span class='notice'>You flip the hat back in normal position.</span>")
		usr.update_inv_head()	//so our mob-overlays update

/obj/item/clothing/head/soft/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click the cap to flip it [flipped ? "forwards" : "backwards"].</span>"

/obj/item/clothing/head/soft/red
	name = "red cap"
	desc = "It's a baseball hat in a tasteless red colour."
	icon_state = "redsoft"
	soft_type = "red"
	dog_fashion = null

/obj/item/clothing/head/soft/blue
	name = "blue cap"
	desc = "It's a baseball hat in a tasteless blue colour."
	icon_state = "bluesoft"
	soft_type = "blue"
	dog_fashion = null

/obj/item/clothing/head/soft/green
	name = "green cap"
	desc = "It's a baseball hat in a tasteless green colour."
	icon_state = "greensoft"
	soft_type = "green"
	dog_fashion = null

/obj/item/clothing/head/soft/yellow
	name = "yellow cap"
	desc = "It's a baseball hat in a tasteless yellow colour."
	icon_state = "yellowsoft"
	soft_type = "yellow"
	dog_fashion = null

/obj/item/clothing/head/soft/grey
	name = "grey cap"
	desc = "It's a baseball hat in a tasteful grey colour."
	icon_state = "greysoft"
	soft_type = "grey"
	dog_fashion = null

/obj/item/clothing/head/soft/orange
	name = "orange cap"
	desc = "It's a baseball hat in a tasteless orange colour."
	icon_state = "orangesoft"
	soft_type = "orange"
	dog_fashion = null

/obj/item/clothing/head/soft/mime
	name = "white cap"
	desc = "It's a baseball hat in a tasteless white colour."
	icon_state = "mimesoft"
	soft_type = "mime"
	dog_fashion = null

/obj/item/clothing/head/soft/purple
	name = "purple cap"
	desc = "It's a baseball hat in a tasteless purple colour."
	icon_state = "purplesoft"
	soft_type = "purple"
	dog_fashion = null

/obj/item/clothing/head/soft/black
	name = "black cap"
	desc = "It's a baseball hat in a tasteless black colour."
	icon_state = "blacksoft"
	soft_type = "black"
	dog_fashion = null

/obj/item/clothing/head/soft/rainbow
	name = "rainbow cap"
	desc = "It's a baseball hat in a bright rainbow of colors."
	icon_state = "rainbowsoft"
	soft_type = "rainbow"
	dog_fashion = null

/obj/item/clothing/head/soft/sec
	name = "security cap"
	desc = "It's a robust baseball hat in tasteful red colour."
	icon_state = "secsoft"
	soft_type = "sec"
	dog_fashion = null

/obj/item/clothing/head/soft/sec/brig_phys
	name = "security medic cap"
	icon_state = "secsoft"

/obj/item/clothing/head/soft/paramedic
	name = "paramedic cap"
	desc = "It's a baseball hat with a dark turquoise color and a reflective cross on the top."
	icon_state = "paramedicsoft"
	soft_type = "paramedic"
	dog_fashion = null

/obj/item/clothing/head/soft/cybersun
	name = "cybersun agent cap"
	desc = "A black baseball hat emblazoned with a reflective Cybersun patch."
	icon_state = "agentsoft"
	soft_type = "agent"
	dog_fashion = null

/obj/item/clothing/head/soft/cybersun/medical
	name = "cybersun medic cap"
	desc = "A turquoise baseball hat emblazoned with a reflective cross. Typical of Cybersun Industries field medics."
	icon_state = "cybersunsoft"
	soft_type = "cybersun"
	dog_fashion = null

/obj/item/clothing/head/soft/inteq
	name = "inteq utility cover"
	desc = "A rich brown utility cover with the golden shield of the IRMG on it."
	icon_state = "inteqsoft"
	soft_type = "inteq"
	dog_fashion = null

/obj/item/clothing/head/soft/inteq/corpsman
	name = "inteq corpsman utility cover"
	desc = "A sterile white utility cover with a green cross emblazoned on it. Worn by the IRMG's support division Corpsmen."
	icon_state = "inteqmedsoft"
	soft_type = "inteqmed"
	dog_fashion = null

/obj/item/clothing/head/soft/utility_beige
	name = "beige utility cover"
	desc = "A flat beige utility cover, unbranded. Just the right color for those sandy planetoids."
	icon_state = "patrolbeigesoft"
	soft_type = "patrolbeige"
	dog_fashion = null

/obj/item/clothing/head/soft/utility_black
	name = "black utility cover"
	desc = "A flat black utility cover, unbranded. Night Vision Goggles sold separately."
	icon_state = "patrolblacksoft"
	soft_type = "patrolblack"
	dog_fashion = null

/obj/item/clothing/head/soft/utility_olive
	name = "miskilamao cap"
	desc = "An olive utility cover emblazoned with the Miskilamo Shipbreaking logo. The material feels cheap."
	icon_state = "patrololivesoft"
	soft_type = "patrololive"
	dog_fashion = null

/obj/item/clothing/head/soft/utility_navy
	name = "navy utility cover"
	desc = "A navy blue utility cover, unbranded. Perfect for Seamen on long voyages."
	icon_state = "patrolnavysoft"
	soft_type = "patrolnavy"
	dog_fashion = null
//recompile icons comment!!!!!
