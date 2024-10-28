/obj/item/melee/knife
	icon_state = "kitchenknife"
	item_state = "kitchenknife"
	icon = 'icons/obj/weapon/knives/knife.dmi'
	world_file = 'icons/obj/weapon/knives/knife_world.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/knifes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/knifes_righthand.dmi'
	pickup_sound =  'sound/items/handling/knife1_pickup.ogg'
	drop_sound = 'sound/items/handling/knife3_drop.ogg'
	flags_1 = CONDUCT_1
	force = 10
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 6
	custom_materials = list(/datum/material/iron=12000)
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = IS_SHARP_ACCURATE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	item_flags = EYE_STAB
	tool_behaviour = TOOL_KNIFE

/obj/item/melee/knife/ComponentInitialize()
	. = ..()
	set_butchering()

///Adds the butchering component, used to override stats for special cases
/obj/item/melee/knife/proc/set_butchering()
	AddComponent(/datum/component/butchering, 80 - force, 100, force - 10) //bonus chance increases depending on force

/obj/item/melee/knife/kitchen
	name = "kitchen knife"
	icon_state = "kitchenknife"
	item_state = "kitchenknife"
	desc = "A general purpose Chef's Knife made by SpaceCook Incorporated. Guaranteed to stay sharp for years to come."

/obj/item/melee/knife/plastic
	name = "plastic knife"
	icon_state = "plastic_knife"
	desc = "A very safe, barely sharp knife made of plastic. Good for cutting food and not much else."
	force = 0
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_range = 5
	custom_materials = list(/datum/material/plastic = 100)
	attack_verb = list("prodded", "whiffed","scratched", "poked")
	sharpness = IS_SHARP
	custom_price = 50
	var/break_chance = 25

/obj/item/melee/knife/plastic/afterattack(mob/living/carbon/user)
	.=..()
	if(prob(break_chance))
		user.visible_message("<span class='danger'>[user]'s spoon snaps into tiny pieces in their hand.</span>")
		qdel(src)


/obj/item/melee/knife/plastic/afterattack(mob/living/carbon/user)
	.=..()
	if(prob(break_chance))
		user.visible_message("<span class='danger'>[user]'s knife snaps into tiny pieces in their hand.</span>")
		qdel(src)

/obj/item/melee/knife/pizza_cutter
	name = "pizza cutter"
	icon_state = "pizza_cutter"
	desc = "A knife edge bent around a circle using the power of science. Perfect for safely cutting pizza."
	force = 1
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 1
	throw_range = 6
	custom_materials = list(/datum/material/iron=4000)
	attack_verb = list("prodded", "whiffed","rolled", "poked")
	sharpness = IS_SHARP

/obj/item/melee/knife/butcher
	name = "butcher's cleaver"
	icon_state = "cleaver"
	item_state = "cleaver"
	desc = "A huge thing used for chopping and chopping up meat."
	flags_1 = CONDUCT_1
	force = 15
	throwforce = 10
	custom_materials = list(/datum/material/iron=18000)
	attack_verb = list("cleaved", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	w_class = WEIGHT_CLASS_NORMAL
	custom_price = 600

/obj/item/melee/knife/hunting
	name = "hunting knife"
	desc = "Despite its name, it's mainly used for cutting meat from dead prey rather than actual hunting."
	item_state = "huntingknife"
	icon_state = "huntingknife"

/obj/item/melee/knife/hunting/set_butchering()
	AddComponent(/datum/component/butchering, 80 - force, 100, force + 10)

/obj/item/melee/knife/combat
	name = "combat knife"
	icon_state = "combatknife"
	item_state = "combatknife"
	desc = "A military combat utility survival knife."
	embedding = list("pain_mult" = 4, "embed_chance" = 65, "fall_chance" = 10, "ignore_throwspeed_threshold" = TRUE)
	force = 20
	throwforce = 20
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "cut")

/obj/item/melee/knife/survival
	name = "survival knife"
	icon_state = "survivalknife"
	item_state = "survivalknife"
	embedding = list("pain_mult" = 4, "embed_chance" = 35, "fall_chance" = 10)
	desc = "A hunting grade survival knife."
	force = 15
	throwforce = 15
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "cut")

/obj/item/melee/knife/bone
	name = "bone dagger"
	item_state = "bone_dagger"
	icon_state = "bone_dagger"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	desc = "A sharpened bone. The bare minimum in survival."
	embedding = list("pain_mult" = 4, "embed_chance" = 35, "fall_chance" = 10)
	force = 15
	throwforce = 15
	custom_materials = null

/obj/item/melee/knife/combat/cyborg
	name = "cyborg knife"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "knife_cyborg"
	desc = "A cyborg-mounted plasteel knife. Extremely sharp and durable."

/obj/item/melee/knife/shiv
	name = "glass shiv"
	icon = 'icons/obj/shards.dmi'
	icon_state = "shiv"
	item_state = "shiv"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	desc = "A makeshift glass shiv."
	force = 8
	throwforce = 12
	attack_verb = list("shanked", "shivved")
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	custom_materials = list(/datum/material/glass=400)

/obj/item/melee/knife/shiv/carrot
	name = "carrot shiv"
	icon_state = "carrotshiv"
	item_state = "carrotshiv"
	icon = 'icons/obj/kitchen.dmi'
	desc = "Unlike other carrots, you should probably keep this far away from your eyes."
	custom_materials = null

/obj/item/melee/knife/switchblade
	name = "switchblade"
	icon_state = "switchblade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	desc = "A sharp, concealable, spring-loaded knife."
	flags_1 = CONDUCT_1
	force = 3
	w_class = WEIGHT_CLASS_SMALL
	sharpness = IS_BLUNT
	throwforce = 5
	throw_speed = 3
	throw_range = 6
	custom_materials = list(/datum/material/iron=12000)
	hitsound = 'sound/weapons/genhit.ogg'
	attack_verb = list("stubbed", "poked")
	resistance_flags = FIRE_PROOF

/obj/item/melee/knife/switchblade/ComponentInitialize()
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = 20, \
		throwforce_on = 23, \
		throw_speed_on = 4, \
		sharpness_on = IS_SHARP, \
		hitsound_on = 'sound/weapons/bladeslice.ogg', \
		w_class_on = WEIGHT_CLASS_NORMAL, \
		attack_verb_on = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut"), \
	)

/obj/item/melee/knife/letter_opener
	name = "letter opener"
	icon = 'icons/obj/items.dmi'
	icon_state = "letter_opener"
	desc = "A military combat utility survival knife."
	embedding = list("pain_mult" = 4, "embed_chance" = 65, "fall_chance" = 10, "ignore_throwspeed_threshold" = TRUE)
	force = 15
	throwforce = 15
	unique_reskin = list("Traditional" = "letter_opener",
						"Boxcutter" = "letter_opener_b",
						"Corporate" = "letter_opener_a"
						)
