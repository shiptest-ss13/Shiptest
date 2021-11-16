//Security

/obj/item/clothing/head/hos/syndicate
	name = "syndicate cap"
	desc = "A black cap fit for a high ranking syndicate officer."
//Captain
/obj/item/clothing/head/caphat/nt
	name = "captain's hat"
	desc = "It's good being the king."
	icon_state = "captain_nt"
	item_state = "captain_nt"

//Cowboy Hats below

/obj/item/clothing/head/caphat/cowboy
	name = "general's hat"
	desc = "A commanding white stetson adorned with a general's badge. Why this belongs to a captain is anybody's guess."
	icon_state = "cowboycap"

/obj/item/clothing/head/cowboy/sec
	name = "deputy hat"
	desc = "A robust stetson adorned with a deputy's badge. It has a reinforced lining under the imitation leather."
	icon_state = "cowboysec"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30,"energy" = 40, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	strip_delay = 60

/obj/item/clothing/head/warden/cowboy
	name = "jailor's hat"
	desc = "A menacing black stetson adorned with a jailor's badge. It has a heavily reinforced lining under the imitation leather."
	icon_state = "cowboywarden"

	dog_fashion = /datum/dog_fashion/head/cowboy

/obj/item/clothing/head/HoS/cowboy
	name = "sheriff's hat"
	desc = "A stalwart white stetson adorned with a sheriff's badge. A symbol of excellence, authority, and old-fashioned style."
	icon = 'whitesands/icons/obj/clothing/hats.dmi'
	icon_state = "cowboyhos"

	dog_fashion = /datum/dog_fashion/head/cowboy
