//Regular syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate
	name = "red space helmet"
	icon_state = "syndicate"
	item_state = "syndicate"
	desc = "An advanced, lightweight space helmet made of durable composites. Almost matches integrated hardsuit helmets for protection. Almost."
	armor = list("melee" = 30, "bullet" = 15, "laser" = 15, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 30, "fire" = 75, "acid" = 75)
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/space/syndicate
	name = "red space suit"
	icon_state = "syndicate"
	item_state = "space_suit_syndicate"
	desc = "A space suit made of high-grade ballistic fabric with integrated armor plates. More compact than a normal space suit while almost matching powered hardsuits for protection. Almost."
	w_class = WEIGHT_CLASS_NORMAL
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	armor = list("melee" = 30, "bullet" = 15, "laser" = 15, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 30, "fire" = 75, "acid" = 75)

//Green syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/green
	name = "green space helmet"
	icon_state = "syndicate-helm-green"
	item_state = "syndicate-helm-green"

/obj/item/clothing/suit/space/syndicate/green
	name = "green space suit"
	icon_state = "syndicate-green"
	item_state = "syndicate-green"


//Dark green syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/green/dark
	name = "dark green space helmet"
	icon_state = "syndicate-helm-green-dark"
	item_state = "syndicate-helm-green-dark"

/obj/item/clothing/suit/space/syndicate/green/dark
	name = "dark green space suit"
	icon_state = "syndicate-green-dark"
	item_state = "syndicate-green-dark"


//Orange syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/orange
	name = "orange space helmet"
	icon_state = "syndicate-helm-orange"
	item_state = "syndicate-helm-orange"

/obj/item/clothing/suit/space/syndicate/orange
	name = "orange space suit"
	icon_state = "syndicate-orange"
	item_state = "syndicate-orange"

//Blue syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/blue
	name = "blue space helmet"
	icon_state = "syndicate-helm-blue"
	item_state = "syndicate-helm-blue"

/obj/item/clothing/suit/space/syndicate/blue
	name = "blue space suit"
	icon_state = "syndicate-blue"
	item_state = "syndicate-blue"


//Black syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black
	name = "black space helmet"
	icon_state = "syndicate-helm-black"
	item_state = "syndicate-helm-black"

/obj/item/clothing/suit/space/syndicate/black
	name = "black space suit"
	icon_state = "syndicate-black"
	item_state = "syndicate-black"


//Black-green syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/green
	name = "black space helmet"
	icon_state = "syndicate-helm-black-green"
	item_state = "syndicate-helm-black-green"

/obj/item/clothing/suit/space/syndicate/black/green
	name = "black and green space suit"
	icon_state = "syndicate-black-green"
	item_state = "syndicate-black-green"


//Black-blue syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/blue
	name = "black space helmet"
	icon_state = "syndicate-helm-black-blue"
	item_state = "syndicate-helm-black-blue"

/obj/item/clothing/suit/space/syndicate/black/blue
	name = "black and blue space suit"
	icon_state = "syndicate-black-blue"
	item_state = "syndicate-black-blue"


//Black medical syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/med
	name = "black space helmet"
	icon_state = "syndicate-helm-black-med"
	item_state = "syndicate-helm-black"

/obj/item/clothing/suit/space/syndicate/black/med
	name = "green space suit"
	icon_state = "syndicate-black-med"
	item_state = "syndicate-black"
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/tank/internals, /obj/item/storage/firstaid, /obj/item/healthanalyzer, /obj/item/stack/medical)

//Black-orange syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/orange
	name = "black space helmet"
	icon_state = "syndicate-helm-black-orange"
	item_state = "syndicate-helm-black"

/obj/item/clothing/suit/space/syndicate/black/orange
	name = "black and orange space suit"
	icon_state = "syndicate-black-orange"
	item_state = "syndicate-black"


//Black-red syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/red
	name = "black space helmet"
	icon_state = "syndicate-helm-black-red"
	item_state = "syndicate-helm-black-red"

/obj/item/clothing/suit/space/syndicate/black/red
	name = "black and red space suit"
	icon_state = "syndicate-black-red"
	item_state = "syndicate-black-red"

//Black-red syndicate contract varient
/obj/item/clothing/head/helmet/space/syndicate/contract
	name = "contractor helmet"
	desc = "A specialised black and gold helmet that's more compact than its standard Syndicate counterpart. Can be ultra-compressed into even the tightest of spaces."
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "syndicate-contract-helm"
	item_state = "syndicate-contract-helm"

/obj/item/clothing/suit/space/syndicate/contract
	name = "contractor space suit"
	desc = "A specialised black and gold space suit that's quicker, and more compact than its standard Syndicate counterpart. Can be ultra-compressed into even the tightest of spaces."
	slowdown = 1
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "syndicate-contract"
	item_state = "syndicate-contract"

//Black with yellow/red engineering syndicate space suit
/obj/item/clothing/head/helmet/space/syndicate/black/engie
	name = "black space helmet"
	icon_state = "syndicate-helm-black-engie"
	item_state = "syndicate-helm-black"
	desc = "An advanced, lightweight space helmet made of fire and radiation-resistant materials. Almost matches integrated hardsuit helmets for protection. Almost."
	armor = list("melee" = 30, "bullet" = 10, "laser" = 10, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/space/syndicate/black/engie
	name = "black engineering space suit"
	icon_state = "syndicate-black-engie"
	item_state = "syndicate-black"
	desc = "A space suit made of high-grade ballistic fabric with thermal and radiation shielding. More compact than a normal space suit while amost matching powered hardsuits for protection. Almost."
	siemens_coefficient = 0
	armor = list("melee" = 30, "bullet" = 10, "laser" = 10, "energy" = 40, "bomb" = 20, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75)
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/tank/internals, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser)
	resistance_flags = FIRE_PROOF

//Same armour values as a normal space suit
/obj/item/clothing/head/helmet/space/syndicate/surplus
	name = "surplus red space helmet"
	desc = "A space helmet made of completely unremarkable plastics. Just a cheap imitation of better helmets."
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70)

/obj/item/clothing/suit/space/syndicate/surplus
	name = "surplus red space suit"
	desc = "A space suit made of completely unremarkable fabrics with plastic plates to reduce bulk. Just a cheap imitation, but it's still as compact as its better counterparts."
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 70)
