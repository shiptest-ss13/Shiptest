
/obj/item/melee/sword/sabre
	name = "officer's sabre"
	desc = "An elegant weapon, its monomolecular edge is capable of cutting through flesh and bone with ease."
	icon_state = "sabre"
	item_state = "sabre"
	force = 25
	throwforce = 10
	block_chance = 30
	armour_penetration = 75
	wound_bonus = 10
	bare_wound_bonus = 25
	attack_verb = list("slashed", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 1000)

/obj/item/melee/sword/sabre/on_enter_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/sabre/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, TRUE)

/obj/item/melee/sword/sabre/solgov
	name = "solarian sabre"
	desc = "A refined ceremonial blade often given to soldiers and high ranking officials of SolGov."
	icon_state = "sabresolgov"
	item_state = "sabresolgov"

/obj/item/melee/sword/sabre/pgf
	name = "\improper boarding cutlass"
	desc = "When beam and bullet puncture the hull, a trustworthy blade will carry you through the fight"
	icon_state = "pgf-sabre"
	block_chance = 15
	force = 28
	demolition_mod = 1.25
	attack_cooldown = 6
