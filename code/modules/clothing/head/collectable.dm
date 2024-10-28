
//Hat Station 13

/obj/item/clothing/head/collectable
	name = "collectable hat"
	desc = "A rare collectable hat."

/obj/item/clothing/head/collectable/chef
	name = "collectable chef's hat"
	desc = "A rare chef's hat meant for hat collectors!"
	icon_state = "chef"
	item_state = "chefhat"

	dog_fashion = /datum/dog_fashion/head/chef

/obj/item/clothing/head/collectable/tophat
	name = "collectable top hat"
	desc = "A top hat worn by only the most prestigious hat collectors."
	icon_state = "tophat"
	item_state = "that"

/obj/item/clothing/head/collectable/captain
	name = "collectable captain's hat"
	desc = "A collectable hat that'll make you look just like a real comdom!"
	icon_state = "captain"

	dog_fashion = /datum/dog_fashion/head/captain

/obj/item/clothing/head/collectable/police
	name = "collectable police officer's hat"
	desc = "A collectable police officer's Hat. This hat emphasizes that you are THE LAW."
	icon = 'icons/obj/clothing/head/armor.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/armor.dmi'
	icon_state = "policehelm"
	dog_fashion = /datum/dog_fashion/head/warden

/obj/item/clothing/head/collectable/beret
	name = "collectable beret"
	desc = "A collectable red beret. It smells faintly of garlic."
	icon_state = "beret"
	dog_fashion = /datum/dog_fashion/head/beret

/obj/item/clothing/head/collectable/welding
	name = "collectable welding helmet"
	desc = "A collectable welding helmet. Now with 80% less lead! Not for actual welding. Any welding done while wearing this helmet is done so at the owner's own risk!"
	icon_state = "welding"
	item_state = "welding"
	clothing_flags = SNUG_FIT

/obj/item/clothing/head/collectable/flatcap
	name = "collectable flat cap"
	desc = "A collectible laborer's flat cap! Smells like No. 9 coal..."
	icon_state = "flat_cap"
	item_state = "det_hat"

/obj/item/clothing/head/collectable/pirate
	name = "collectable pirate hat"
	desc = "You'd make a great Dread Syndie Roberts!"
	icon = 'icons/obj/clothing/head/spacesuits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/spacesuits.dmi'
	icon_state = "pirate"
	dog_fashion = /datum/dog_fashion/head/pirate

/obj/item/clothing/head/collectable/kitty
	name = "collectable kitty ears"
	desc = "The fur feels... a bit too realistic."
	icon_state = "kitty"

	dog_fashion = /datum/dog_fashion/head/kitty

/obj/item/clothing/head/collectable/wizard
	name = "collectable wizard's hat"
	desc = "NOTE: Any magical powers gained from wearing this hat are purely coincidental."
	icon_state = "wizard"
	dog_fashion = /datum/dog_fashion/head/blue_wizard

/obj/item/clothing/head/collectable/hardhat
	name = "collectable hard hat"
	desc = "WARNING! Offers no real protection, but damn, is it fancy!"
	clothing_flags = SNUG_FIT
	icon_state = "hardhat_standard"
	dog_fashion = /datum/dog_fashion/head


/obj/item/clothing/head/collectable/thunderdome
	name = "collectable Thunderdome helmet"
	desc = "Go Red! I mean Green! I mean Red! No Green!"
	icon = 'icons/obj/clothing/head/armor.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/armor.dmi'
	icon_state = "thunderdome"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEHAIR

/obj/item/clothing/head/collectable/swat
	name = "collectable SWAT helmet"
	desc = "That's not real blood. That's red paint." //Reference to the actual description
	icon = 'icons/obj/clothing/head/armor.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/armor.dmi'
	icon_state = "swat"
	item_state = "swat"
	clothing_flags = SNUG_FIT
	flags_inv = HIDEHAIR
