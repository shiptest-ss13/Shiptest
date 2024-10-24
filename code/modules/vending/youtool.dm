/obj/machinery/vending/tool
	name = "\improper YouTool"
	desc = "Tools for tools."
	icon_state = "tool"
	icon_deny = "tool-deny"
	light_mask = "tool-light-mask"
	products = list(/obj/item/stack/cable_coil/random = 5, //WS Edit - Random added from Smartwire Revert
					/obj/item/crowbar = 3,
					/obj/item/weldingtool = 3,
					/obj/item/wirecutters = 3,
					/obj/item/wrench = 3,
					/obj/item/analyzer = 3,
					/obj/item/t_scanner = 3,
					/obj/item/screwdriver = 3,
					/obj/item/flashlight/glowstick = 3,
					/obj/item/flashlight/glowstick/red = 3,
					/obj/item/flashlight = 3,
					/obj/item/clothing/ears/earmuffs = 1,
					/obj/item/clothing/gloves/color/fyellow = 2
					)
	premium = list(/obj/item/storage/belt/utility = 2,
					/obj/item/multitool = 2,
					/obj/item/weldingtool/hugetank = 1,
					/obj/item/clothing/head/welding = 1,
					/obj/item/clothing/gloves/color/yellow = 1)
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 70)
	resistance_flags = FIRE_PROOF
	default_price = 75
	extra_price = 250
