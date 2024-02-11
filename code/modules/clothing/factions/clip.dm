//under

/obj/item/clothing/under/clip
	name = "clip deck worker jumpsuit"
	desc = "A jumpsuit worn by deck workers in the CLIP Minutemen Navy vessels."

	icon_state = "clip_deck"
	item_state = "b_suit"

	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE
	dying_key = DYE_REGISTRY_UNDER //???

	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION // a new record!

/obj/item/clothing/under/clip/minutemen
	name = "clip minutemen fatigues"
	desc = "Fatigues worn by the CLIP Minutemen."

	icon_state = "clip_minutemen"

	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	strip_delay = 50

	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/clip/formal
	name = "formal clip outfit"
	desc = "A formal outfit containing a white shirt and navy slacks issued to CLIP government workers. Commonly seen on more white collar CLIP bureaucrats, low ranking CLIP Minutemen officers."

	icon_state = "clip_formal"

	armor = null
	supports_variations = null

/obj/item/clothing/under/clip/formal/alt
	name = "formal clip outfit"
	desc = "A formal outfit containing a white shirt and a navy skirt issued to CLIP government workers. Commonly seen on more white collar CLIP bureaucrats, low ranking CLIP Minutemen officers."

	icon_state = "clip_formal_skirt"

/obj/item/clothing/under/clip/medic
	name = "medical clip uniform"
	desc = "A uniform with navy slacks and a CLIP blue buttondown shirt. The shoulder markings have a medical symbol. "

	icon_state = "clip_medic"

/obj/item/clothing/under/clip/officer
	name = "clip minutemen officer uniform"
	desc = "A uniform used by higher ranking officers of the CLIP Minutemen."
	icon_state = "clip_officer"
	item_state = "g_suit"
	can_adjust = FALSE


//suit

/obj/item/clothing/suit/toggle/lawyer/minutemen
	name = "CLIP Minutemen suit jacket"
	desc = "An enterprising dress jacket used by officers of the CLIP Minutemen."
	icon_state = "suitjacket_clip"
	item_state = "suitjacket_navy"

/obj/item/clothing/suit/toggle/lawyer/minutemen/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed //it's hop-equivalent gear after all

//armor

/obj/item/clothing/suit/armor/vest/capcarapace/clip
	name = "CLIP Minutemen general coat"
	desc = "A very fancy coat used by generals of the CLIP Minutemen."
	icon_state = "clip_general"
	item_state = "clip_general"

/obj/item/clothing/suit/armor/riot/clip
	name = "black riot suit"
	desc = "Designed to protect against close range attacks. This one is painted black. Mainly used by the CM-BARD against hostile xenofauna, it also sees prolific by some CLIP members."
	icon_state = "riot_clip"

/obj/item/clothing/suit/armor/clip_trenchcoat
	name = "\improper CLIP trenchcoat"
	desc = "A CLIP trenchcoat. Despite it's reputation as a officer coat, it's actually issued to the entire CLIP government and it's branches. Has a lot of pockets."
	icon_state = "armor_solgov_trenchcoat"
	item_state = "trenchcoat_solgov"
	body_parts_covered = CHEST|LEGS|ARMS
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	cold_protection = CHEST|LEGS|ARMS
	heat_protection = CHEST|LEGS|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

//spacesuits
/obj/item/clothing/suit/space/hardsuit/security/independent/clip
	name = "\improper CMM Patroller hardsuit"
	desc = "A hardsuit used by the Minutemen. To reduce costs, its a modified version of a more popular model from a independent manufacturer, and given to patrol vessels. As should be obvious, it's not extremely armored, as it's made for reconnaissance and speed."
	icon_state = "hardsuit-clip-patrol"
	hardsuit_type = "hardsuit-clip-patrol"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/independent/clip

/obj/item/clothing/head/helmet/space/hardsuit/security/independent/clip
	name = "\improper CMM Patroller hardsuit helmet"
	desc = "A hardsuit used by the Minutemen. To reduce costs, its a modified version of a more popular model from a independent manufacturer, and given to patrol vessels. As should be obvious, it's not extremely armored, as it's made for reconnaissance and speed."
	icon_state = "hardsuit0-clip-patrol"
	hardsuit_type = "clip-patrol"

//hats
/obj/item/clothing/head/clip
	name = "\improper CLIP Minutemen service cap"
	desc = "A standard issue soft cap dating back to the original Zohil colonial peroid. While usually given to recruits and volunteers, it's sometimes used by occasionally by some Minutemen."
//	icon = 'icons/obj/clothing/faction/clip/head.dmi'
//	mob_overlay_icon = 'icons/mob/clothing/faction/clip/head.dmi'
//	lefthand_file = 'icons/mob/inhands/faction/clip/gezena_lefthand.dmi'
//	righthand_file = 'icons/mob/inhands/faction/clip/gezena_righthand.dmi'
	icon_state = "clip_cap"
	item_state = "bluecloth"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/clip/slouch
	name = "CLIP Minutemen officer's slouch hat"
	desc = "A commanding slouch hat adorned with a officer's badge, used by the CLIP Minutemen."
	icon_state = "clip_officer_hat"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	strip_delay = 60

/obj/item/clothing/head/clip/boonie
	name = "CLIP Minutemen boonie hat"
	desc = "A a wide brimmed cap to keep yourself cool during blistering hot weather."
	icon_state = "clip_boonie"

/obj/item/clothing/head/clip/bicorne
	name = "general's bicorne"
	desc = "A fancy bicorne used by generals of the CLIP Minutemen."
	icon_state = "minuteman_general_hat"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/helmet/bulletproof/clip
	name = "\improper Minutemen ballistic helmet"
	desc = "A bulletproof helmet that is worn by members of the CLIP Minutemen."
	icon_state = "antichristhelm"
	allow_post_reskins = TRUE
	unique_reskin = null

/obj/item/clothing/head/helmet/riot/clip
	name = "\improper Minutemen riot helmet"
	desc = "Designed to protect against close range attacks. Mainly used by the CMM-BARD against hostile xenofauna, it also sees prolific use on some Minutemen member worlds."
	icon_state = "riot_clip"

//GOLD
/obj/item/clothing/head/fedora/det_hat/clip
	name = "GOLD fedora"
	icon_state = "clip_fedora"
	item_state = "detective"
	desc = "A hat issued by the GOLD division of the CLIP Minutemen. Designed to look more casual than the standard CLIP military equipment, yet fashionable"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50) //dets hat is armored for some reaon

/obj/item/clothing/head/flatcap
	name = "GOLD flatcap"
	desc = "A hat issued by the GOLD division of the CLIP Minutemen. A office worker's hat."
	icon_state = "clip_flat_cap"
	item_state = "detective"
//mask

/obj/item/clothing/mask/gas/clip
	name = "CM-20 gas mask"
	desc = "A close-fitting gas mask that can be connected to an air supply. Created in 420 FS during the Xenofauna war after it was discovered that 20 year old gas masks weren't going cut it against Xenofauna."
	icon_state = "clip-gasmask"
	strip_delay = 60

//gloves

//boots

//belt
/obj/item/storage/belt/military/clip
	name = "CLIP Minutemen chest rig"
	desc = "A chest rig worn by the CLIP Minutemen of the League."
	icon_state = "clipwebbing"
	item_state = "clipwebbing"

/obj/item/storage/belt/military/clip/p16/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/p16(src)

/obj/item/storage/belt/military/clip/gal/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/gal(src)

/obj/item/storage/belt/military/clip/cm5/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/smgm9mm(src)


//neck
