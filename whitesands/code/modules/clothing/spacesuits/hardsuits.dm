/obj/item/clothing/head/helmet/space/hardsuit/solgov
	name = "\improper SolGov hardsuit helmet"
	desc = "An armored spaceproof helmet. The glass has a metallic shine on it."
	icon_state = "hardsuit0-solgov"
	item_state = "hardsuit0-solgov"
	hardsuit_type = "solgov"
	armor = list("melee" = 50, "bullet" = 45, "laser" = 40,"energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 90, "fire" = 85, "acid" = 75)

/obj/item/clothing/suit/space/hardsuit/solgov
	icon_state = "hardsuit_solgov"
	name = "\improper SolGov hardsuit"
	desc = "An armored spaceproof suit. An exoskeleton helps the user not have slowdown, allowing full mobility with the suit."
	item_state = "hardsuit_solgov"
	armor = list("melee" = 50, "bullet" = 45, "laser" = 40, "energy" = 30, "bomb" = 60, "bio" = 100, "rad" = 90, "fire" = 85, "acid" = 75) //intentionally the fucking strong, this is master chief-tier armor //is this really what you call the strong?? is this the best solgov has to offer??????
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/solgov
	slowdown = 0

/obj/item/clothing/head/helmet/space/hardsuit/quixote
	name = "\improper Quixote mobility hardsuit helmet"
	desc = "The integrated helmet of a Quixote mobility hardsuit."
	icon_state = "hardsuit0-quixote"
	item_state = "quixote-helm"
	max_integrity = 300
	armor = list("melee" = 50, "bullet" = 40, "laser" = 40, "energy" = 25, "bomb" = 50, "bio" = 100, "rad" = 60, "fire" = 50, "acid" = 100)
	hardsuit_type = "quixote"
	max_heat_protection_temperature = 20000

/obj/item/clothing/suit/space/hardsuit/quixote
	name = "\improper Quixote mobility hardsuit"
	desc = "The Quixote mobility suit is the magnum opus of Phorsman equipment, combining durable composite armor with high mobility thrusters."
	icon_state = "quixotesuit"
	item_state = "quixotesuit"
	max_integrity = 300
	armor = list("melee" = 50, "bullet" = 40, "laser" = 40, "energy" = 25, "bomb" = 50, "bio" = 100, "rad" = 60, "fire" = 50, "acid" = 100)
	allowed = list(/obj/item/gun, /obj/item/flashlight, /obj/item/tank/internals, /obj/item/ammo_box)
	actions_types = list(/datum/action/item_action/toggle_helmet)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/quixote
	jetpack = /obj/item/tank/jetpack/suit
	slowdown = 0
	max_heat_protection_temperature = 20000
	var/datum/action/innate/quixotejump/jump

/obj/item/clothing/suit/space/hardsuit/quixote/Initialize()
	. = ..()
	jump = new(src)

/obj/item/clothing/suit/space/hardsuit/quixote/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_OCLOTHING)
		jump.Grant(user)
		user.update_icons()
	else //If it is equipped in any slot except for our outer clothing, we can't dash
		jump.Remove(user)
		user.update_icons()

/obj/item/clothing/suit/space/hardsuit/quixote/dropped(mob/user)
	. = ..()
	jump.Remove(user)
	user.update_icons()

/obj/item/clothing/suit/space/hardsuit/quixote/ui_action_click(mob/user, action)
	if(action == /datum/action/innate/quixotejump)
		jump.Activate()
	else
		return ..()

/obj/item/clothing/head/helmet/space/hardsuit/quixote/dimensional
	name = "Quixote metaspacial hardsuit helmet"
	desc = "The integrated helmet of a Quixote metaspace navigation hardsuit."
	armor = list("melee" = 50, "bullet" = 40, "laser" = 40, "energy" = 35, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)

/obj/item/clothing/suit/space/hardsuit/quixote/dimensional
	name = "Quixote metaspacial hardsuit"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 40, "energy" = 35, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	desc = "The Quixote metaspacial mobility suit is the magnum opus of dimensional navigation equipment, combining durable composite armor with high mobility thrusters and defensive plating rated for all manner of exotic particles."
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/quixote/dimensional
