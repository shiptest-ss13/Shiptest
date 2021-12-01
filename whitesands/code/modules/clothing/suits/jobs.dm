//Lieutenant
/obj/item/clothing/suit/lieutenant_trenchcoat
	name = "lieutenant's trenchcoat"
	desc = "A design taken from a war over 500 years ago. Makes you look like a badass."



	icon_state = "trenchcoat_blueshield"
	item_state = "trenchcoat_blueshield"
	blood_overlay_type = "coat"
	allowed = list(/obj/item/gun/energy, /obj/item/reagent_containers/spray/pepper, /obj/item/ammo_box, /obj/item/ammo_casing,/obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/flashlight/seclite, /obj/item/melee/classic_baton)
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|ARMS|HANDS
	cold_protection = CHEST|LEGS|ARMS
	heat_protection = CHEST|LEGS|ARMS

// SolGov Rep //

/obj/item/clothing/suit/solgov_trenchcoat
	name = "solgov trenchcoat"
	desc = "A solgov official's trenchcoat. Has a lot of pockets."


	icon_state = "trenchcoat_solgov"
	item_state = "trenchcoat_solgov"
	body_parts_covered = CHEST|LEGS|ARMS
	allowed = list(/obj/item/gun/energy, /obj/item/reagent_containers/spray/pepper, /obj/item/ammo_box, /obj/item/ammo_casing,/obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/flashlight/seclite, /obj/item/melee/classic_baton)
	armor = list("melee" = 25, "bullet" = 10, "laser" = 25, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	cold_protection = CHEST|LEGS|ARMS
	heat_protection = CHEST|LEGS|ARMS

// Security //

/obj/item/clothing/suit/armor/vest/security


	item_state = "armor"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS|HANDS
	heat_protection = CHEST|GROIN|ARMS|HANDS
	strip_delay = 70
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/vest/security/officer
	name = "security officer's jacket"
	desc = "This jacket is for those special occasions when a security officer isn't required to wear their armor."
	icon_state = "officerjacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/security/brig_phys
	name = "brig physician's jacket"
	desc = "A black jacket with dark blue and silver accents, for the brig physician to prove they're a real member of security in style."
	icon_state = "brigphysjacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/security/warden
	name = "warden's jacket"
	desc = "Perfectly suited for the warden that wants to leave an impression of style on those who visit the brig."
	icon_state = "wardenjacket"

/obj/item/clothing/suit/armor/vest/security/warden/alt
	name = "warden's armored jacket"
	desc = "A white jacket with silver rank pips and body armor strapped on top."
	icon_state = "warden_jacket"

/obj/item/clothing/suit/armor/vest/security/hos
	name = "head of security's jacket"
	desc = "This piece of clothing was specifically designed for asserting superior authority."
	icon_state = "hosjacket"

//AdMech

/obj/item/clothing/suit/hooded/enginseer
	name = "enginseer regalia"
	desc = "You hold the secrets of the Machine."


	icon_state = "enginseer"
	item_state = "enginseer"
	hoodtype = /obj/item/clothing/head/hooded/enginseer
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDESHOES|HIDEJUMPSUIT|HIDEGLOVES
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/gun, /obj/item/melee, /obj/item/nullrod, /obj/item/radio, /obj/item/storage/book)

/obj/item/clothing/head/hooded/enginseer
	name = "enginseer's hood"
	desc = "You are honored that they require your skills."
	icon_state = "enginseerhood"
	item_state = "enginseerhood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACE|HIDEFACIALHAIR
