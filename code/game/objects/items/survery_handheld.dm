/obj/item/gear_pack/powered/survey_pack
	name = "Survey Pack"
	desc = "A large scientific kit designed for planetary survey"
	icon = 'icons/obj/item/survey_handheld.dmi'
	icon_state = "survey"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	attachment_type = /obj/item/attachment/survey_scanner
	var/survey_mult = 1
	var/survey_delay = 4 SECONDS



/obj/item/gear_pack/powered/survey_pack/advanced //can be purchased, is Expendy.
	name = "Advanced Survey Pack"
	desc = "A high hech piece of scientific kit designed for thorough planetary survey"
	icon_state = "survey-adv"
	survey_mult = 1.5

/obj/item/gear_pack/powered/survey_pack/advanced/nt
	name = "Nanotrasen Survey Pack"
	desc = "A large, high tech piece of Nanotrasen kit, designed for mining survey."
	icon_state = "survey-nt"
	survey_mult = 1.6
	survey_delay = 3
	//give these meson view?

/obj/item/gear_pack/powered/survey_pack/Experimental //these should never be purchasable or manufacturable, loot only.
	name = "Experimental Survey Pack"
	desc = "An experimental survey pack, capable of analyzing entire regions in seconds."
	icon_state = "survey-elite"
	survey_mult = 2
	survey_delay = 2 SECONDS


/obj/item/attachment/survey_scanner
	name = "Survey Scanner"
	desc = "A wired tool designed to work in tandem with a survey pack"
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/item/survey_handheld.dmi'
	icon_state = "survey"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	pack = /obj/item/gear_pack/powered/survey_pack
	var/survey_mult
	var/survey_delay

/obj/item/attachment/survey_scanner/Initialize()
	. = ..()
	survey_mult = pack?:survey_mult
	survey_delay = pack?:survey_delay
	return ..()

/obj/structure/anomaly
	name = "Defaultic Bind"
	desc = "The truly unexpected anomaly. Let a coder know if you see this!"
	max_integrity = 300
