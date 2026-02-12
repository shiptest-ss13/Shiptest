//Engineer Softsuit
/obj/item/clothing/suit/space/engineer
	name = "engineering space suit"
	icon_state = "space-independent-eng"
	item_state = "space-independent-eng"
	desc = "A civilian space suit designed for construction and salvage in hazardous, low-pressure environments. Has shielding against radiation and heat and abundant storage.<br>Though they lack the physical protection of more expensive hardsuits, this type of suit is extremely common wherever construction and salvage work must be done in open space."
	siemens_coefficient = 0
	armor = list("melee" = 15, "bullet" = 5, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75, "wound" = 10)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large
	resistance_flags = FIRE_PROOF
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/head/helmet/space/light/engineer
	name = "engineering space helmet"
	icon_state = "space-independent-eng"
	item_state = "space-independent-eng"
	desc = "A space helmet designed for construction and salvage in hazardous, low-pressure environments, with an integral hard hat and UV-shielded visor. Has shielding against radiation and heat."
	armor = list("melee" = 15, "bullet" = 5, "laser" = 20, "energy" = 10, "bomb" = 20, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75, "wound" = 10)
	resistance_flags = FIRE_PROOF
	light_color = "#FFCC66"
	light_power = 0.8
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 1
	light_on = FALSE
	on = FALSE
	supports_variations = SNOUTED_VARIATION

//Pilot Softsuit
/obj/item/clothing/suit/space/pilot
	name = "pilot space suit"
	icon_state = "space-pilot"
	item_state = "space-pilot"
	desc = "A lightweight, unarmored space suit designed for exosuit and shuttle pilots. Special attachment points make mounting and dismounting from exosuits much easier."
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | FAST_EMBARK
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/exo/large

/obj/item/clothing/head/helmet/space/pilot
	name = "pilot helmet"
	icon_state = "space-pilot-plain0"
	item_state = "space-pilot-plain"
	desc = "A specialized space helmet designed for exosuit and shuttle pilots. Offers limited impact protection."
	var/skin = "plain"
	var/blurb = " Its simple design is quite ancient."
	up = FALSE
	actions_types = list(/datum/action/item_action/toggle_helmet)
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70, "wound" = 5) //less wound armor. give em the fokker special
	visor_flags_inv = HIDEMASK
	visor_flags = STOPSPRESSUREDAMAGE | ALLOWINTERNALS

/obj/item/clothing/head/helmet/space/pilot/update_icon_state()
	icon_state = "space-pilot-[skin][up]"
	return ..()

/obj/item/clothing/head/helmet/space/pilot/New()
	..()
	switch(skin)
		if("plain")
			blurb = " Its simple design is quite ancient."
		if("shark")
			blurb = " It bears a classic shark mouth decoration on both cheeks."
		if("checker")
			blurb = " A bold checker stripe runs over the top of the helmet."
		if("ace")
			blurb = " A large ace of spades decorates the back of the helmet."
		if("mobius")
			blurb = " There is an unusual blue ribbon painted on the back. Something about it is strangely inspiring."
		if("viper")
			blurb = " It bears a menacing orange \"V\" on the brow. Somebody has scratched \"Speed is life\" inside the helmet."
		if("luke")
			blurb = " Strange red trefoils are painted on either side of the helmet. Wearing it gives you a headache."
		if("corvid")
			blurb = " It is sloppily painted with thin teal and red paint. There are some dark stains on the lining..."

	desc = "A specialized space helmet designed for exosuit and shuttle pilots. Offers limited impact protection.[blurb]"
	update_icon_state()

/obj/item/clothing/head/helmet/space/pilot/random/New()
	skin = pick(40;"plain", 20;"shark", 20;"checker", 20;"ace", 5;"mobius", 5;"viper", 5;"luke", 5;"corvid",)
	..()

/obj/item/clothing/head/helmet/space/pilot/attack_self(mob/user) //pilot helmet toggle
	if(!isturf(user.loc))
		to_chat(user, span_warning("You cannot toggle your helmet while in this [user.loc]!") )
		return
	up = !up
	if(!up || force)
		to_chat(user, span_notice("You close your helmet's visor and breathing mask."))
		gas_transfer_coefficient = initial(gas_transfer_coefficient)
		permeability_coefficient = initial(permeability_coefficient)
		clothing_flags |= visor_flags
		flags_cover |= HEADCOVERSEYES | HEADCOVERSMOUTH
		flags_inv |= visor_flags_inv
		cold_protection |= HEAD
	else
		to_chat(user, span_notice("You open your helmet's visor and breathing mask."))
		gas_transfer_coefficient = null
		permeability_coefficient = null
		clothing_flags &= ~visor_flags
		flags_cover &= ~(HEADCOVERSEYES | HEADCOVERSMOUTH)
		flags_inv &= ~visor_flags_inv
		cold_protection &= ~HEAD
	update_appearance()
	playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
	user.update_inv_head()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.head_update(src, forced = 1)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()
