/obj/item/clothing/suit/toggle/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat"
	item_state = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS|GROIN
	allowed = MEDICAL_SUIT_ALLOWED_ITEMS
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	togglename = "buttons"

/obj/item/clothing/suit/toggle/labcoat/cmo
	name = "chief medical officer's labcoat"
	desc = "Bluer than the standard model."
	icon_state = "labcoat_cmo"
	item_state = "labcoat_cmo"

/obj/item/clothing/suit/toggle/labcoat/paramedic
	name = "paramedic's jacket"
	desc = "A dark blue jacket for paramedics with reflective stripes."
	icon_state = "labcoat_paramedic"
	item_state = "labcoat_paramedic"

/obj/item/clothing/suit/toggle/labcoat/mad
	name = "\proper The Mad's labcoat"
	desc = "It makes you look capable of konking someone on the noggin and shooting them into space."
	icon_state = "labgreen"
	item_state = "labgreen"

/obj/item/clothing/suit/toggle/labcoat/genetics
	name = "geneticist labcoat"
	desc = "A suit that protects against minor chemical spills. Has a blue stripe on the shoulder."
	icon_state = "labcoat_gen"

/obj/item/clothing/suit/toggle/labcoat/chemist
	name = "chemist labcoat"
	desc = "A suit that protects against minor chemical spills. Has an orange stripe on the shoulder."
	icon_state = "labcoat_chem"

/obj/item/clothing/suit/toggle/labcoat/chemist/side
	name = "pharmacologist labcoat"
	desc = "A lab coat that buttons on the side, which provides some protection from chemical spills. It in chemistry colors."
	icon_state = "labcoat_side_chem"

/obj/item/clothing/suit/toggle/labcoat/virologist
	name = "virologist labcoat"
	desc = "A suit that protects against minor chemical spills. Offers slightly more protection against biohazards than the standard model. Has a green stripe on the shoulder."
	icon_state = "labcoat_vir"

/obj/item/clothing/suit/toggle/labcoat/science
	name = "scientist labcoat"
	desc = "A suit that protects against minor chemical spills. Has a purple stripe on the shoulder."
	icon_state = "labcoat_tox"

/obj/item/clothing/suit/toggle/labcoat/brig_phys
	name = "security medic's labcoat"
	desc = "A lightly armoured suit that protects against minor chemical spills and rogue patients. Has a dark red stripe on the shoulder."
	icon_state = "labcoat_brig"
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0, fire = 50, acid = 50)

/obj/item/clothing/suit/toggle/labcoat/raincoat
	name = "translucent labcoat"
	desc = {"A uniquely designed, translucent labcoat. It's made from a special material that actively repels fluids.
You're pretty sure this is just a raincoat.

<i>Wearing a raincoat inside is like wearing sunglasses at night. A good chemist does both.</i>
"}
	icon_state = "raincoat"
	item_state = "raincoat"

/obj/item/clothing/suit/longcoat
	name = "longcoat"
	desc = "A long, victorian styled labcoat."
	icon = 'icons/obj/clothing/suits/utility.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suits/utility.dmi'
	icon_state = "labcoat_long"
	item_state = "labcoat"
	allowed = MEDICAL_SUIT_ALLOWED_ITEMS
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 50, "acid" = 50)
	togglename = "buttons"

/obj/item/clothing/suit/longcoat/virologist
	name = "virologist longcoat"
	desc = "A long labcoat with a green stripe. Perfect for creating bioweapons while laughing like a cartoon villian."
	icon_state = "labcoat_viro_long"

/obj/item/clothing/suit/longcoat/genetics
	name = "geneticist longcoat"
	desc = "A long labcoat with a blue stripe. Perfect for creating genetic abombinations while laughing like a cartoon villian."
	icon_state = "labcoat_gene_long"

/obj/item/clothing/suit/longcoat/cmo
	name = "chief medical officer's longcoat"
	desc = "A long labcoat colored blue to match a chief medical officer."
	icon_state = "labcoat_cmo_long"

/obj/item/clothing/suit/longcoat/chemist
	name = "chemist longcoat"
	desc = "A long labcoat with a orange stripe. Perfect for creating chemical weapons while laughing like a cartoon villian."
	icon_state = "labcoat_chem_long"

/obj/item/clothing/suit/longcoat/science
	name = "scientist longcoat"
	desc = "A long labcoat with a purple stripe. Perfect for laughing like a cartoon villian, yet being indecisive on what weapon you want to create."
	icon_state = "labcoat_sci_long"

/obj/item/clothing/suit/longcoat/brig_phys
	name = "security medic's longcoat"
	desc = "A long labcoat with a red stripe. Perfect for laughing like a cartoon villian, while using already created weapons."
	icon_state = "labcoat_brig_long"
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 10, rad = 0, fire = 50, acid = 50)

//we actually don't have the robotcist labcoats here, but since these are made anyways, might as well put them in
/obj/item/clothing/suit/longcoat/roboblack
	name = "roboticist's black labcoat"
	desc = "A long labcoat colored black with a red stripe. The sleves appear to be cut off with scizors. Perfect for creating mechanical exosuit weapons while laughing like a cartoon villian."
	icon_state = "labcoat_roboblack_long"

/obj/item/clothing/suit/longcoat/robowhite
	name = "roboticist's white labcoat"
	desc = "A long labcoat with a black stripe and sleves. Perfect for creating mechanical exosuit weapons while laughing like a cartoon villian."
	icon_state = "labcoat_robowhite_long"
