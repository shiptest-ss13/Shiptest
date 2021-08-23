/datum/blackmarket_item/smuggled
	category = "Smuggled Items"
	//These items aren't *exactly* illegal, but you can get items that would otherwise be hard to get.
	//These items also will be more expensive than if you make it yourself
	//Ah... quality of life....
/*
/datum/blackmarket_item/smuggled/centcom
	name = "Nanotrasen Intern Costume"
	desc = "Can get you out of a situation in a pinch, beware of SSV vessels (Please, just beware)"
	item = /obj/item/storage/box/syndie_kit/centcom_costume
	price_min = 1300
	price_max = 1600
	availability_prob = 40
*/
/datum/blackmarket_item/smuggled/surgery
	name = "Syndicate Surgery Bag"
	desc = "Syndicate surgery kit that has all the stuff required to preform surgery."
	item = /obj/item/storage/backpack/duffelbag/syndie/surgery
	price_min = 1500
	price_max = 1650
	availability_prob = 40
	stock_max = 2

/datum/blackmarket_item/smuggled/voice_changing
	name = "Voice changing mask"
	desc = "Changes your voice to match your ID, can also change into any mask."
	item = /obj/item/clothing/mask/gas/syndicate
	price = 900
	availability_prob = 40
	stock_max = 3
/datum/blackmarket_item/smuggled/flamies_owies
	name="FT-24"
	desc = "Super dangerous flamethrower that was a HUGE risk to get"
	item = /obj/item/flamethrower/full/tank
	price = 5000
	stock_max = 2
	availability_prob = 70
/datum/blackmarket_item/smuggled/bigboomboom
	name = "C4"
	desc = "The gods gave us fire, but blowing stuff up... that was *our* idea."
	item = /obj/item/grenade/c4
	price = 1000
	stock = 4
	availability_prob = 50
