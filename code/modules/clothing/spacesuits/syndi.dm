//Regular syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate
	name = "coalition space helmet"
	icon_state = "syndicate-helm"
	item_state = "syndicate-helm"
	desc = "An advanced, lightweight space helmet made of durable composites. Almost matches integrated hardsuit helmets for protection. Almost."
	armor = list("melee" = 30, "bullet" = 20, "laser" = 30, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 30, "fire" = 75, "acid" = 75, "wound" = 15)
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/space/syndicate
	name = "coalition space suit"
	icon_state = "syndicate"
	item_state = "syndicate"
	desc = "A space suit made of high-grade ballistic fabric with integrated armor plates. More compact than a normal space suit while almost matching powered hardsuits for protection. Almost."
	w_class = WEIGHT_CLASS_NORMAL
	armor = list("melee" = 30, "bullet" = 20, "laser" = 30, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 30, "fire" = 75, "acid" = 75, "wound" = 15)

/obj/item/clothing/suit/space/syndicate/Initialize()
	. = ..()
	allowed = GLOB.security_hardsuit_allowed

//Generic indie
/obj/item/clothing/head/helmet/space/syndicate/generic
	name = "armored space helmet"
	icon_state = "syndicate-helm-generic"
	item_state = "syndicate-helm-generic"

/obj/item/clothing/suit/space/syndicate/generic
	name = "armored olive space suit"
	icon_state = "syndicate-generic"
	item_state = "syndicate-generic"
	unique_reskin = list("armored olive space suit" = "syndicate-generic",
						"armored grey space suit" = "syndicate-grey"
						)
	unique_reskin_changes_base_icon_state = TRUE
	unique_reskin_changes_name = TRUE

/obj/item/clothing/suit/space/syndicate/generic/grey
	name = "armored grey space suit"
	icon_state = "syndicate-grey"
	item_state = "syndicate-grey"

//Hardliner + Cybersun
/obj/item/clothing/head/helmet/space/syndicate/white_red
	name = "white-red space helmet"
	icon_state = "syndicate-helm-hardliner"
	item_state = "syndicate-helm-hardliner"

/obj/item/clothing/suit/space/syndicate/white_red
	name = "white-red space suit"
	icon_state = "syndicate-hardliner"
	item_state = "syndicate-hardliner"

//NGR
/obj/item/clothing/head/helmet/space/syndicate/ngr

	name = "biege-red space helmet"
	icon_state = "syndicate-helm-ngr"
	item_state = "syndicate-helm-ngr"

/obj/item/clothing/suit/space/syndicate/ngr

	name = "beige-red space suit"
	icon_state = "syndicate-ngr"
	item_state = "syndicate-ngr"

//Ramzi
/obj/item/clothing/head/helmet/space/syndicate/ramzi

	name = "worn-out space helmet"
	desc = "A worn, beaten up composite space helmet that still remains durable. The front has a fearsome skull painted on."
	icon_state = "syndicate-helm-ramzi"
	item_state = "syndicate-helm-ramzi"

/obj/item/clothing/suit/space/syndicate/ramzi

	name = "worn-out space suit"
	desc = "A worn, beaten up space suit with integrated armour plates. There are patches of ducttape covering damage."
	icon_state = "syndicate-ramzi"
	item_state = "syndicate-ramzi"

//Ramzi Surplus
/obj/item/clothing/head/helmet/space/syndicate/ramzi/surplus

	name = "worn-out surplus space helmet"
	desc = "A worn, beaten up surplus space helmet that has suffered intense damage. It has been haphazardously sealed with ducttape."
	icon_state = "syndicate-helm-ramzi-surplus"
	item_state = "syndicate-helm-ramzi-surplus"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70)

/obj/item/clothing/suit/space/syndicate/ramzi/surplus
	name = "worn-out surplus space suit"
	desc = "A worn, beaten up space suit composed of a flimsy, low-grade ballistic material. There are patches of ducttape covering extensive damage."
	icon_state = "syndicate-ramzi-surplus"
	item_state = "syndicate-ramzi-surplus"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70, "wound" = 10)

//GEC-graded
/obj/item/clothing/head/helmet/space/syndicate/engie
	name = "GEC-grade space helmet"
	icon_state = "syndicate-helm-engie"
	item_state = "syndicate-helm-engie"
	desc = "An advanced, lightweight space helmet made of fire and radiation-resistant materials, graded for use by the GEC."
	armor = list("melee" = 30, "bullet" = 10, "laser" = 10, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75, "wound" = 10)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/space/syndicate/engie
	name = "GEC-grade space suit"
	icon_state = "syndicate-engie"
	item_state = "syndicate-engie"
	desc = "A space suit made of high-grade ballistic fabric with thermal and radiation shielding. More compact than a normal space suit, graded for use by the GEC."
	siemens_coefficient = 0
	armor = list("melee" = 30, "bullet" = 10, "laser" = 10, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75, "wound" = 15)
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/tank/internals, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser)
	resistance_flags = FIRE_PROOF

//Same armour values as a normal space suit
/obj/item/clothing/head/helmet/space/syndicate/surplus
	name = "surplus space helmet"
	desc = "A space helmet made of completely unremarkable plastics. Just a cheap imitation of better helmets."
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70, "wound" = 10)

/obj/item/clothing/suit/space/syndicate/surplus
	name = "surplus space suit"
	desc = "A space suit made of completely unremarkable fabrics with plastic plates to reduce bulk. Just a cheap imitation, but it's still as compact as its better counterparts."
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70, "wound" = 10)
