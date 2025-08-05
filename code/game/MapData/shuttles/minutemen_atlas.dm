/obj/structure/closet/wardrobe/clip
	name = "CLIP spare uniforms locker"
	desc = "This locker stores spare CLIP uniforms."
	icon_door = "blue"

/obj/structure/closet/wardrobe/clip/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/clothing/under/clip(src)
	for(var/i in 1 to 4)
		new /obj/item/clothing/shoes/workboots(src)
	return

/obj/structure/closet/wardrobe/clip/wall
	icon = 'icons/obj/wallcloset.dmi'
	icon_state = "generic_wall"
	icon_door = null
	wall_mounted = TRUE
	anchored = TRUE
	density = TRUE
	can_be_unanchored = FALSE

/obj/structure/closet/wardrobe/clip/formal
	name = "formal CLIP spare uniforms locker"
	desc = "This locker stores spare formal CLIP uniforms."
	icon_door = "white"

/obj/structure/closet/wardrobe/clip/formal/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/clothing/under/clip/formal/with_shirt(src)
	for(var/i in 1 to 3)
		new /obj/item/clothing/under/clip/formal/with_shirt/alt(src)
	for(var/i in 1 to 6)
		new /obj/item/clothing/shoes/laceup(src)
	return

/obj/structure/closet/wardrobe/clip/formal/wall
	icon = 'icons/obj/wallcloset.dmi'
	icon_state = "generic_wall"
	icon_door = null
	wall_mounted = TRUE
	anchored = TRUE
	density = TRUE
	can_be_unanchored = FALSE

/obj/structure/closet/wardrobe/clip/minutemen
	name = "C-MM spare uniforms locker"
	desc = "This locker stores spare C-MM uniforms. Make sure any boots taken out are polished."

/obj/structure/closet/wardrobe/clip/minutemen/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/clothing/under/clip/minutemen(src)
	for(var/i in 1 to 4)
		new /obj/item/clothing/head/clip(src)
	for(var/i in 1 to 4)
		new /obj/item/clothing/head/soft/utility_navy(src)
	for(var/i in 1 to 4)
		new /obj/item/clothing/shoes/combat(src)
	return

/obj/structure/closet/wardrobe/clip/minutemen/wall
	icon = 'icons/obj/wallcloset.dmi'
	icon_state = "generic_wall"
	icon_door = null
	wall_mounted = TRUE
	anchored = TRUE
	density = TRUE
	can_be_unanchored = FALSE

/obj/structure/closet/secure_closet/clip
	name = "CLIP storage"
	desc = "dont use this type stinky"

/obj/structure/closet/secure_closet/clip/minutemen/captain
	name = "captain locker"
	desc = "This locker contains all (most of what) a cunning captain needs for day to day leadership."
	req_access = list(ACCESS_CAPTAIN)
	icon_state = "cap"

/obj/structure/closet/secure_closet/clip/minutemen/captain/PopulateContents()
	new /obj/item/clothing/head/clip/slouch/officer(src)
	new /obj/item/clothing/under/clip/officer(src)
	new /obj/item/clothing/under/clip/officer/alt(src)
	new /obj/item/clothing/suit/armor/clip_capcoat(src)
	new /obj/item/storage/belt/military/clip(src) // you know, just in case
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/gloves/color/captain(src)
	new /obj/item/storage/backpack/security/clip(src)
	new /obj/item/storage/backpack/satchel/sec/clip(src)
	new /obj/item/binoculars(src)
	new /obj/item/clipboard(src)
	new /obj/item/megaphone(src)
	return

/obj/structure/closet/secure_closet/clip/minutemen/bridge_officer
	name = "bridge officer locker"
	desc = "This locker contains all (most of what) a responsible bridge officer needs for keeping the ship efficient."
	req_access = list(ACCESS_HOP)
	icon_state = "hop"

/obj/structure/closet/secure_closet/clip/minutemen/bridge_officer/PopulateContents()
	new /obj/item/clothing/head/clip/slouch(src)
	new /obj/item/clothing/under/clip/officer(src)
	new /obj/item/clothing/under/clip/officer/alt(src)
	new /obj/item/clothing/suit/toggle/lawyer/clip(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/storage/belt/military/clip(src) // you know, just in case
	new /obj/item/binoculars(src)
	new /obj/item/clipboard(src)
	return

/obj/structure/closet/secure_closet/clip/minutemen/lead
	name = "team sergeant locker"
	desc = "This locker contains all (most of what) a bold team sergeant needs for keeping the frontier safe."
	req_access = list(ACCESS_ARMORY)
	icon_state = "blueshield"

/obj/structure/closet/secure_closet/clip/minutemen/lead/PopulateContents()
	new /obj/item/clothing/under/clip/minutemen(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/head/soft/utility_navy(src)
	new /obj/item/storage/belt/military/clip(src)
	new /obj/item/storage/pouch/squad(src)
	new /obj/item/megaphone(src)
	new /obj/item/binoculars(src)
	new /obj/item/clipboard(src)

/obj/structure/closet/secure_closet/clip/minutemen/combat_medic
	name = "combat medic locker"
	desc = "This locker contains all (most of what) a clever combat medic needs to keep the Minutemen fighting."
	req_access = list(ACCESS_MEDICAL)
	icon_state = "med_secure"

/obj/structure/closet/secure_closet/clip/minutemen/combat_medic/PopulateContents()
	new /obj/item/clothing/head/clip/corpsman(src)
	new /obj/item/clothing/accessory/armband/medblue(src)
	new /obj/item/clothing/under/clip/minutemen(src)
	new /obj/item/clothing/shoes/combat(src)
	new /obj/item/storage/belt/medical/webbing/clip(src)
	new /obj/item/storage/pouch/medical(src)


/obj/structure/closet/secure_closet/clip/minutemen/engineer
	name = "naval engineer locker"
	desc = "This locker contains all (most of what) a cunning engineer needs for ship maintenance."
	req_access = list(ACCESS_ENGINE)
	icon_state = "eng_secure"

/obj/structure/closet/secure_closet/clip/minutemen/engineer/PopulateContents()
	new /obj/item/clothing/under/clip/minutemen(src)
	new /obj/item/clothing/shoes/workboots(src)
	new /obj/item/storage/belt/utility/full/engi(src)
	new /obj/item/clothing/suit/hazardvest(src)
	new /obj/item/storage/backpack/satchel/eng(src)
	new /obj/item/clothing/head/clip(src)
	new /obj/item/clothing/head/hardhat/dblue(src)
	new /obj/item/clothing/head/hardhat/dblue(src)
	new /obj/item/holosign_creator/engineering(src)

/obj/structure/closet/secure_closet/clip/minutemen/correspondent
	name = "military correspondent locker"
	desc = "This locker contains all (most of what) a curious correspondent needs for informing the frontier."
	req_access = list(ACCESS_LIBRARY)

/obj/structure/closet/secure_closet/clip/minutemen/correspondent/PopulateContents()
	new /obj/item/clothing/under/clip/formal(src)
	new /obj/item/clothing/shoes/workboots(src)
	new /obj/item/clothing/head/helmet/bulletproof/m10/clip_correspondent(src)
	new /obj/item/clothing/suit/armor/vest/clip_correspondent(src)
	new /obj/item/bodycamera/broadcast_camera(src)
	new /obj/item/binoculars(src)
	new /obj/item/clipboard(src)
	new /obj/item/storage/photo_album/correspondent(src)

/obj/structure/fluff/overhead
	name = "overhead prop"
	layer = RIPPLE_LAYER
	deconstructible = FALSE
	mouse_opacity = FALSE

/obj/structure/fluff/overhead/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/largetransparency, _x_offset = -1, _y_offset = -1, _x_size = 2, _y_size = 2)

/obj/structure/fluff/overhead/lattice
	name = "lattice"
	desc = "A lightweight support lattice."
	icon = 'icons/obj/smooth_structures/lattice.dmi'
	icon_state = "lattice-255"

/obj/structure/fluff/overhead/pipe
	name = "overhead pipe segment"
	desc = "A pipe that carries water and other miscellaneous fluids throughout a ship or stucture."
	icon = 'icons/obj/atmospherics/pipes/simple.dmi'
	icon_state = "pipe11-1"
