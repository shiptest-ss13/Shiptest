/obj/item/melee/transforming/cleaving_saw/old
	name = "old cleaving saw"
	desc = "This saw, old and rusted, is still an effective tool at bleeding beasts and monsters."
	force = 10
	force_on = 15 //force when active
	throwforce = 15
	throwforce_on = 15
	faction_bonus_force = 5
	nemesis_factions = list("mining", "boss")
	bleed_stacks_per_hit = 1.5


/obj/structure/closet/secure_closet/medicalsrm
	name = "hunter doctor closet"
	desc = "Everything the Hunter Doctor needs to heal the hurting masses."
	icon_state = "med"
	req_access = list(ACCESS_MEDICAL)

/obj/structure/closet/secure_closet/shadow
	name = "shadow's locker"
	desc = "The closet of equipment and attire for the aspiring shadow."
	icon_door = "black"

/obj/structure/closet/secure_closet/hunter
	name = "hunter's locker"
	desc = "Everything a hunter will need, held in one secure closet."
	icon_door = "black"
	req_access = list(ACCESS_SECURITY)

/obj/structure/closet/secure_closet/montagnes
	name = "\proper head of security's locker"
	req_access = list(ACCESS_HOS)
	icon_state = "hos"

/obj/structure/closet/secure_closet/miningcloset
	name = "mining equipment locker"
	desc = "The closet of mining equipment."
	icon_state = "mining"
