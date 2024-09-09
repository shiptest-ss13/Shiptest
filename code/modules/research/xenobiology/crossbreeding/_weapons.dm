/*
Slimecrossing Weapons
	Weapons added by the slimecrossing system.
	Collected here for clarity.
*/

//Boneblade - Burning Green
/obj/item/melee/arm_blade/slime
	name = "slimy boneblade"
	desc = "What remains of the bones in your arm. Incredibly sharp, and painful for both you and your opponents."
	force = 22.5
	force_string = "painful"

/obj/item/melee/arm_blade/slime/attack(mob/living/L, mob/user)
	. = ..()
	if(prob(20))
		user.force_scream()

//Rainbow knife - Burning Rainbow
/obj/item/kitchen/knife/rainbowknife
	name = "rainbow knife"
	desc = "A strange, transparent knife which constantly shifts color. It hums slightly when moved."
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "rainbowknife"
	item_state = "rainbowknife"
	force = 18
	throwforce = 15
	damtype = BRUTE

/obj/item/kitchen/knife/rainbowknife/afterattack(atom/O, mob/user, proximity)
	if(proximity && istype(O, /mob/living))
		damtype = pick(BRUTE, BURN, TOX, OXY)
	switch(damtype)
		if(BRUTE)
			hitsound = 'sound/weapons/bladeslice.ogg'
			attack_verb = list("slashed","sliced","cut")
		if(BURN)
			hitsound = 'sound/weapons/sear.ogg'
			attack_verb = list("burned","singed","heated")
		if(TOX)
			hitsound = 'sound/weapons/pierce.ogg'
			attack_verb = list("poisoned","dosed","toxified")
		if(OXY)
			hitsound = 'sound/effects/space_wind.ogg'
			attack_verb = list("suffocated","winded","vacuumed")
	return ..()

//Adamantine shield - Chilling Adamantine
/obj/item/shield/adamantineshield
	name = "adamantine shield"
	desc = "A gigantic shield made of solid adamantium."
	icon = 'icons/obj/slimecrossing.dmi'
	icon_state = "adamshield"
	item_state = "adamshield"
	w_class = WEIGHT_CLASS_HUGE
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70)
	slot_flags = ITEM_SLOT_BACK
	block_chance = 50
	force = 0
	throw_range = 1 //How far do you think you're gonna throw a solid crystalline shield...?
	throw_speed = 2
	attack_verb = list("bashed","pounded","slammed")
	item_flags = SLOWS_WHILE_IN_HAND

/obj/item/shield/adamantineshield/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE, force_wielded=15)
