/obj/structure/closet/secure_closet
	name = "secure locker"
	desc = "It's a card-locked storage unit."
	locked = TRUE
	anchored = TRUE
	icon_state = "secure"
	max_integrity = 250
	armor = list("melee" = 30, "bullet" = 50, "laser" = 50, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	secure = TRUE
	damage_deflection = 20

/obj/structure/closet/secure_closet/cabinet
	icon_state = "cabinet"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50

/obj/structure/closet/secure_closet/miningcloset
	name = "mining equipment locker"
	icon_state = "mining"

/obj/structure/closet/secure_closet/quartermaster
	name = "\proper quartermaster's locker"
	req_access = list(ACCESS_QM)
	icon_state = "qm"

/obj/structure/closet/secure_closet/hydroponics
	name = "botanist's locker"
	req_access = list(ACCESS_HYDROPONICS)
	icon_state = "hydro"

/obj/structure/closet/secure_closet/medical
	name = "medicine closet"
	desc = "Filled to the brim with medical junk."
	icon_state = "med"
	req_access = list(ACCESS_MEDICAL)

/obj/structure/closet/secure_closet/CMO
	name = "\proper chief medical officer's locker"
	req_access = list(ACCESS_CMO)
	icon_state = "cmo"

/obj/structure/closet/secure_closet/chemical
	name = "chemical closet"
	desc = "Store dangerous chemicals in here."
	req_access = list(ACCESS_CHEMISTRY)
	icon_door = "chemical"

/obj/structure/closet/secure_closet/captains
	name = "\proper captain's locker"
	req_access = list(ACCESS_CAPTAIN)
	icon_state = "cap"

/obj/structure/closet/secure_closet/hos
	name = "\proper head of security's locker"
	req_access = list(ACCESS_HOS)
	icon_state = "hos"

/obj/structure/closet/secure_closet/suns
	name = "SUNS locker"
	icon_state = "suns"

/obj/structure/closet/secure_closet/personal
	desc = "It's a secure locker for personnel."
	name = "personal closet"

/obj/structure/closet/secure_closet/personal/cabinet
	icon_state = "cabinet"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50

/obj/structure/closet/secure_closet/RD
	name = "\proper research director's locker"
	req_access = list(ACCESS_RD)
	icon_state = "rd"

/obj/structure/closet/secure_closet/head_of_personnel
	name = "\proper head of personnel's locker"
	req_access = list(ACCESS_HOP)
	icon_state = "hop"

/obj/structure/closet/secure_closet/warden
	name = "\proper warden's locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "warden"

/obj/structure/closet/secure_closet/security
	name = "security officer's locker"
	req_access = list(ACCESS_SECURITY)
	icon_state = "sec"

/obj/structure/closet/secure_closet/armorycage
	name = "armory locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "shotguncase"

/obj/structure/closet/secure_closet/armory
	name = "armory gear locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "armory"

/obj/structure/closet/secure_closet/tac
	name = "armory tac locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "tac"

/obj/structure/closet/secure_closet/engineering_chief
	name = "\proper chief engineer's locker"
	req_access = list(ACCESS_CE)
	icon_state = "ce"
