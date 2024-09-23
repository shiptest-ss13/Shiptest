//Cloaks. No, not THAT kind of cloak.

/obj/item/clothing/neck/cloak
	name = "brown cloak"
	desc = "It's a cape that can be worn around your neck."
	icon = 'icons/obj/clothing/cloaks.dmi'
	icon_state = "qmcloak"
	item_state = "qmcloak"
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	flags_inv = HIDESUITSTORAGE
	greyscale_colors = list(list(11, 15), list(12, 22), list(12, 22))
	greyscale_icon_state = "cloak"

/obj/item/clothing/neck/cloak/hos
	name = "head of security's cloak"
	desc = "Worn by Securistan, ruling their watch with an iron fist."
	icon_state = "hoscloak"

/obj/item/clothing/neck/cloak/qm
	name = "quartermaster's cloak"
	desc = "Worn by Cargonia, supplying the frontier with the necessary tools for survival."

/obj/item/clothing/neck/cloak/cmo
	name = "chief medical officer's cloak"
	desc = "Worn by Meditopia, the valiant men and women keeping pestilence at bay."
	icon_state = "cmocloak"

/obj/item/clothing/neck/cloak/ce
	name = "chief engineer's cloak"
	desc = "Worn by Engitopia, wielders of an unlimited power."
	icon_state = "cecloak"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/neck/cloak/rd
	name = "research director's cloak"
	desc = "Worn by Sciencia, thaumaturges and researchers of the universe."
	icon_state = "rdcloak"

/obj/item/clothing/neck/cloak/cap
	name = "captain's cloak"
	desc = "Worn by the valiant vessel and station commanders of the Nanotrasen Corporation."
	icon_state = "capcloak"

/obj/item/clothing/neck/cloak/head_of_personnel
	name = "head of personnel's cloak"
	desc = "Worn by the Head of Personnel. It smells faintly of bureaucracy."
	icon_state = "hopcloak"

/obj/item/clothing/neck/cloak/overseer
	name = "SolGov overseer's cloak"
	desc = "Worn by the Overseer. It smells faintly of bureaucracy."
	icon_state = "solgov_cloak"

/obj/item/clothing/neck/cloak/solgov
	name = "SolGov weibel"
	desc = "Worn by SolGov officials. It smells faintly of bureaucracy."
	icon_state = "solgov_weibel"

/obj/item/clothing/neck/cloak/solgovcap
	name = "SolGov captain's cloak"
	desc = "Worn by SolGov captains. It smells faintly of bureaucracy."
	icon_state = "solgov_cap_cloak"

/obj/item/clothing/neck/cloak/trans
	name = "vampire cloak"
	desc = "Worn by high ranking vampires of the transylvanian society of vampires."
	icon_state = "trans"

/obj/item/clothing/neck/cloak/bi
	name = "solarian marine biologist cloak"
	desc = "Commonly worn by members of the Solarian Marine Biologist Society, dedicated to the study and preservation of marine wildlife."
	icon_state = "bi"

/obj/item/clothing/suit/hooded/cloak/goliath
	name = "goliath cloak"
	icon_state = "goliath_cloak"
	desc = "A staunch, practical cape made out of numerous monster materials, it is coveted amongst exiles & hermits."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/pickaxe, /obj/item/melee/spear, /obj/item/organ/regenerative_core/legion, /obj/item/melee/knife/bone, /obj/item/melee/knife/survival)
	armor = list("melee" = 35, "bullet" = 10, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60) //a fair alternative to bone armor, requiring alternative materials and gaining a suit slot
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/head/hooded/cloakhood/goliath
	name = "goliath cloak hood"
	icon_state = "golhood"
	desc = "A protective & concealing hood."
	armor = list("melee" = 35, "bullet" = 10, "laser" = 25, "energy" = 35, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	clothing_flags = SNUG_FIT
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	transparent_protection = HIDEMASK

/obj/item/clothing/suit/hooded/cloak/drake
	name = "drake armour"
	icon_state = "dragon"
	desc = "A suit of armour fashioned from the remains of an ash drake."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/melee/spear)
	armor = list("melee" = 50, "bullet" = 10, "laser" = 40, "energy" = 50, "bomb" = 50, "bio" = 60, "rad" = 50, "fire" = 100, "acid" = 100)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/drake
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	transparent_protection = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDESHOES

/obj/item/clothing/head/hooded/cloakhood/drake
	name = "drake helm"
	icon_state = "dragon"
	desc = "The skull of a dragon."
	armor = list("melee" = 50, "bullet" = 10, "laser" = 40, "energy" = 50, "bomb" = 50, "bio" = 60, "rad" = 50, "fire" = 100, "acid" = 100)
	clothing_flags = SNUG_FIT
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/neck/cloak/skill_reward
	var/associated_skill_path = /datum/skill
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE

/obj/item/clothing/neck/cloak/skill_reward/examine(mob/user)
	. = ..()
	. += "<span class='notice'>You notice a powerful aura about this cloak, suggesting that only the truly experienced may wield it.</span>"

/obj/item/clothing/neck/cloak/skill_reward/equipped(mob/user, slot)
	if (user.mind?.get_skill_level(associated_skill_path) < SKILL_LEVEL_LEGENDARY)
		to_chat(user, "<span class = 'notice'>You feel completely and utterly unworthy to even touch \the [src].</span>")
		user.dropItemToGround(src, TRUE)
		return FALSE
	return ..()

/obj/item/clothing/neck/cloak/skill_reward/attack_hand(mob/user)
	if (user.mind?.get_skill_level(associated_skill_path) < SKILL_LEVEL_LEGENDARY)
		to_chat(user, "<span class = 'notice'>You feel completely and utterly unworthy to even touch \the [src]!</span>")
		return FALSE
	return ..()

/obj/item/clothing/neck/cloak/skill_reward/gaming
	name = "legendary gamer's cloak"
	desc = "Worn only by the most skilled professional gamers in known space, this legendary cloak is only attainable by achieving true gaming enlightenment. This status symbol represents the awesome might of a being of focus, commitment, and sheer fucking will. Something casual gamers will never begin to understand."
	icon_state = "gamercloak"
	associated_skill_path = /datum/skill/gaming

/obj/item/clothing/neck/cloak/skill_reward/cleaning
	name = "legendary cleaner's cloak"
	desc = "Worn by the most skilled of custodians, this legendary cloak is only attainable by achieving janitorial enlightenment. This status symbol represents a being not only extensively trained in grime combat, but one who is willing to use an entire aresenal of cleaning supplies to its full extent to wipe grime's miserable ass off the face of the universe."
	icon_state = "cleanercloak"
	associated_skill_path = /datum/skill/cleaning

/obj/item/clothing/neck/cloak/skill_reward/healing
	name = "legendary healer's cloak"
	desc = "Worn by the most skilled healers, this legendary cloak is only attainable by achieving true medical enlightenment. This status symbol represents a being who has saved enough lives to repopulate a small country, a being who could transplant a monkey's brain into your skull faster than you could yell ;HELP SEC."
	icon_state = "healercloak"
	associated_skill_path = /datum/skill/healing

/obj/item/clothing/neck/cloak/skill_reward/mining
	name = "legendary miner's cloak"
	desc = "Worn by the most skilled miners, this legendary cloak is only attainable by achieving true mineral enlightenment. This status symbol represents a being who has forgotten more about rocks than most miners will ever know, a being who has moved mountains and filled valleys."
	icon_state = "minercloak"
	associated_skill_path = /datum/skill/mining

/obj/item/clothing/suit/hooded/cloak/bone
	name = "heavy bone armor"
	icon_state = "hbonearmor"
	desc = "A tribal armor plate, crafted from animal bone. A heavier variation of standard bone armor."
	armor = list("melee" = 40, "bullet" = 25, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/bone
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	resistance_flags = NONE
	transparent_protection = HIDEGLOVES|HIDESUITSTORAGE|HIDEJUMPSUIT|HIDESHOES

/obj/item/clothing/head/hooded/cloakhood/bone
	name = "bone helmet"
	icon_state = "hskull"
	desc = "An intimidating tribal helmet, it doesn't look very comfortable."
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	resistance_flags = NONE
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/suit/hooded/cloak/goliath/polar
	name = "polar cloak"
	icon_state = "polarcloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath/polar
	desc = "A tribal hood made from a polar bears pelt. Keeps it's wearer warm and looks badass while doing it."
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/head/hooded/cloakhood/goliath/polar
	name = "polar cloak"
	icon_state = "hoodie_gray"
	mob_overlay_state = "polhood"
	desc = "Wear bear on head show little man you big man, kill bear for cloak."
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = HEAD
