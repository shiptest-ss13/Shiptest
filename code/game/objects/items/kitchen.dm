/* Kitchen tools
 * Contains:
 *		Fork
 *		Butcher's cleaver
 *		Rolling Pins
 *		Plastic Utensils
 */

/obj/item/kitchen
	icon = 'icons/obj/kitchen.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'

/obj/item/kitchen/fork
	name = "fork"
	desc = "Pointy."
	icon_state = "fork"
	force = 5
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=80)
	flags_1 = CONDUCT_1
	attack_verb = list("attacked", "stabbed", "poked")
	hitsound = 'sound/weapons/bladeslice.ogg'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	item_flags = EYE_STAB
	var/datum/reagent/forkload //used to eat omelette

/obj/item/kitchen/fork/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!istype(M))
		return ..()

	if(forkload)
		if(M == user)
			M.visible_message("<span class='notice'>[user] eats a delicious forkful of omelette!</span>")
			M.reagents.add_reagent(forkload.type, 1)
		else
			M.visible_message("<span class='notice'>[user] feeds [M] a delicious forkful of omelette!</span>")
			M.reagents.add_reagent(forkload.type, 1)
		icon_state = "fork"
		forkload = null
	else
		return ..()

/obj/item/kitchen/fork/plastic
	name = "plastic fork"
	desc = "Really takes you back to highschool lunch."
	icon_state = "plastic_fork"
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	custom_materials = list(/datum/material/plastic=80)
	custom_price = 50
	var/break_chance = 25

/obj/item/kitchen/fork/plastic/afterattack(mob/living/carbon/user)
	.=..()
	if(prob(break_chance))
		user.visible_message("<span class='danger'>[user]'s fork snaps into tiny pieces in their hand.</span>")
		qdel(src)

/obj/item/kitchen/rollingpin
	name = "rolling pin"
	desc = "Used to knock out the Bartender."
	icon_state = "rolling_pin"
	force = 8
	throwforce = 5
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 1.5)
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "whacked")
	custom_price = 200

/obj/item/kitchen/spoon/plastic
	name = "plastic spoon"
	desc = "Just be careful your food doesn't melt the spoon first."
	icon_state = "plastic_spoon"
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	custom_materials = list(/datum/material/plastic=120)
	custom_price = 50
	var/break_chance = 25
