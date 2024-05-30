/obj/item/clothing/under/suit/roumain
	name = "saint-roumain's worksuit"
	desc = "A simple, hard-wearing suit designed for the hardworking hunters of the Saint-Roumain Militia."
	icon = 'icons/obj/clothing/faction/roumain/uniforms.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/roumain/uniforms.dmi'
	icon_state = "rouma_work"
	item_state = "rouma_work"

/obj/item/clothing/suit/armor/roumain
	name = "saint-roumain duster"
	desc = "A coat made from hard leather. Meant to withstand long hunts in harsh wilderness."
	icon = 'icons/obj/clothing/faction/roumain/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/roumain/suits.dmi'
	icon_state = "armor_rouma"
	item_state = "rouma_coat"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS

/obj/item/clothing/suit/armor/roumain/shadow
	name = "saint-roumain shadow duster"
	desc = "A coat made from hard leather. Its rough, barely-treated finish is typical of one of the Saint-Roumain Militia's trainees."
	icon_state = "armor_rouma_shadow"
	item_state = "rouma_shadow_coat"

/obj/item/clothing/suit/armor/hos/roumain/montagne
	name = "saint-roumain montagne coat"
	desc = "A stylish red coat to indicate that you are, in fact, a Hunter Montagne. Made of extra hard exotic leather, treated with bullet-resistant materials, and lined with the fur of some unidentifiable creature."
	icon = 'icons/obj/clothing/faction/roumain/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/roumain/suits.dmi'
	icon_state = "armor_rouma_montagne"
	item_state = "rouma_montagne_coat"

/obj/item/clothing/suit/toggle/labcoat/roumain_med
	name = "saint-roumain medical duster"
	desc = "A coat made from hard leather and further treated with exotic sterilizing oils and wax. The treatment and its more closed design offers much better protection against biological hazards."
	icon = 'icons/obj/clothing/faction/roumain/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/roumain/suits.dmi'
	icon_state = "rouma_med_coat"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/suit/armor/roumain/flamebearer
	name = "flamebearer garb"
	desc = "This worn outfit saw much use back in the day."
	icon_state = "flamebearer_coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/storage/book/bible, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

/obj/item/clothing/head/cowboy/sec/roumain
	name = "hunter's hat"
	desc = "A fancy hat with a nice feather. The way it covers your eyes makes you feel like a badass."
	icon = 'icons/obj/clothing/faction/roumain/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/roumain/head.dmi'
	icon_state = "rouma_hat"

/obj/item/clothing/head/cowboy/sec/roumain/shadow
	name = "shadow's hat"
	desc = "A rough, simple hat. The way it covers your eyes makes you feel badass, but you just look like a wannabe hunter."
	icon_state = "rouma_shadow_hat"

/obj/item/clothing/head/cowboy/sec/roumain/med
	name = "medical hunter's hat"
	desc = "A very wide-brimmed, round hat treated with oil and wax. Somehow manages to look stylish and creepy at the same time."
	icon_state = "rouma_med_hat"

/obj/item/clothing/head/HoS/cowboy/montagne
	name = "montagne's hat"
	desc = "A very fancy hat with a large feather plume to signal that you are, in fact, a Hunter Montagne. The exotic fur lining is impeccably soft and bafflingly bulletproof."
	icon = 'icons/obj/clothing/faction/roumain/head.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/roumain/head.dmi'
	icon_state = "rouma_montagne_hat"

/obj/item/clothing/head/cowboy/sec/roumain/flamebearer
	name = "flamebearer hat"
	desc = "This hat saw much use back in the day."
	icon_state = "flamebearer_hat"
	/*
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEEYES|HIDEHAIR
	*/
