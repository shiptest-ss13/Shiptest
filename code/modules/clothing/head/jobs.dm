//defines the drill hat's yelling setting
#define DRILL_DEFAULT "default"
#define DRILL_SHOUTING "shouting"
#define DRILL_YELLING "yelling"

//Chef
/obj/item/clothing/head/chefhat
	name = "chef's hat"
	item_state = "chef"
	icon_state = "chef"
	desc = "The commander in chef's head wear."
	strip_delay = 10
	equip_delay_other = 10
	dog_fashion = /datum/dog_fashion/head/chef

//Captain
/obj/item/clothing/head/caphat
	name = "captain's peaked cap"
	desc = "It's good being the king."
	icon_state = "captain"
	item_state = "that"
	flags_inv = 0
	dog_fashion = /datum/dog_fashion/head/captain

/obj/item/clothing/head/caphat/parade
	name = "captain's parade cap"
	desc = "Worn only by Captains with an abundance of class."
	icon_state = "capcap"

/obj/item/clothing/head/caphat/cowboy
	name = "general's hat"
	desc = "A commanding white stetson adorned with a general's badge. Why this belongs to a captain is anybody's guess."
	icon_state = "cowboycap"

/obj/item/clothing/head/frontier/peaked
	name = "\improper Frontiersmen commander's cap"
	desc = "An imposing peaked cap, meant for a commander of the Frontiersmen."
	icon_state = "frontier_cap"

/obj/item/clothing/head/frontier/peaked/admiral
	name = "\improper Frontiersmen admiral's cap"
	desc = "An imposing peaked cap meant for only the highest of officers of the Frontiersmen pirate fleet."
	icon_state = "frontier_admiral_cap"

//Detective
/obj/item/clothing/head/fedora/det_hat
	name = "detective's fedora"
	desc = "There's only one man who can sniff out the dirty stench of crime, and he's likely wearing this hat."
	icon_state = "detective"
	var/candy_cooldown = 0
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/fedora/detective
	dog_fashion = /datum/dog_fashion/head/detective

/obj/item/clothing/head/fedora/det_hat/Initialize()
	. = ..()
	new /obj/item/reagent_containers/food/drinks/flask/det(src)

/obj/item/clothing/head/fedora/det_hat/examine_more(mob/user)
	. = ..()
	if(!in_range(src, user) || !isobserver(user)) //hide the easter egg a little more
		. += span_warning("You try to examine [src] closer, but you're too far away.")
		return
	. += span_notice("Alt-click to take a candy corn.")

/obj/item/clothing/head/fedora/det_hat/AltClick(mob/user)
	if(user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		..()
		if(loc == user)
			if(candy_cooldown < world.time)
				var/obj/item/food/candy_corn/CC = new /obj/item/food/candy_corn(src)
				user.put_in_hands(CC)
				to_chat(user, span_notice("You slip a candy corn from your hat."))
				candy_cooldown = world.time+1200
			else
				to_chat(user, span_warning("You just took a candy corn! You should wait a couple minutes, lest you burn through your stash."))

//Curator
/obj/item/clothing/head/fedora/curator
	name = "treasure hunter's fedora"
	desc = "You got red text today kid, but it doesn't mean you have to like it."
	icon_state = "curator"

//Security

/obj/item/clothing/head/HoS
	name = "head of security cap"
	desc = "The robust standard-issue cap of the Head of Security. For showing the officers who's in charge."
	icon_state = "hoscap"

/obj/item/clothing/head/HoS/cowboy
	name = "sheriff's hat"
	desc = "A stalwart white stetson adorned with a sheriff's badge. A symbol of excellence, authority, and old-fashioned style."
	icon_state = "cowboyhos"

	dog_fashion = /datum/dog_fashion/head/cowboy

/obj/item/clothing/head/cowboy/sec
	name = "deputy hat"
	desc = "A robust stetson adorned with a deputy's badge. Its imitation leather is thick and worn."
	icon_state = "cowboysec"

/obj/item/clothing/head/HoS/syndicate
	name = "syndicate cap"
	desc = "A black cap fit for a high ranking syndicate officer."

/obj/item/clothing/head/HoS/cybersun
	name = "cybersun hat"
	desc = "A crimson-red hat fit for a high ranking cybersun officer."
	icon_state = "cybersunhat"
	item_state = "cybersunhat"

/obj/item/clothing/head/HoS/beret/syndicate
	name = "syndicate beret"
	desc = "A nondescript black beret. Stylish and robust."
	icon_state = "beret_officer"
	item_state = "beret_officer"

/obj/item/clothing/head/warden
	name = "warden's police hat"
	desc = "It's a special hat issued to the Warden of a security force. A classic symbol of middling authority."
	icon = 'icons/obj/clothing/head/armor.dmi'
	mob_overlay_icon = 'icons/mob/clothing/head/armor.dmi'
	icon_state = "policehelm"
	dog_fashion = /datum/dog_fashion/head/warden

/obj/item/clothing/head/warden/red
	name = "warden's red hat"
	desc = "A warden's red hat. Looking at it gives you the feeling of wanting to keep people in cells for as long as possible."
	icon_state = "wardenhat"
	dog_fashion = /datum/dog_fashion/head/warden_red

/obj/item/clothing/head/warden/cowboy
	name = "jailor's hat"
	desc = "A menacing black stetson adorned with a jailor's badge. Made of thick imitation leather."
	icon_state = "cowboywarden"

	dog_fashion = /datum/dog_fashion/head/cowboy

/obj/item/clothing/head/warden/drill
	name = "warden's campaign hat"
	desc = "A special campaign hat with the security insignia emblazoned on it."
	icon_state = "wardendrill"
	item_state = "wardendrill"
	dog_fashion = null
	var/mode = DRILL_DEFAULT

/obj/item/clothing/head/warden/drill/screwdriver_act(mob/living/carbon/human/user, obj/item/I)
	if(..())
		return TRUE
	switch(mode)
		if(DRILL_DEFAULT)
			to_chat(user, span_notice("You set the voice circuit to the middle position."))
			mode = DRILL_SHOUTING
		if(DRILL_SHOUTING)
			to_chat(user, span_notice("You set the voice circuit to the last position."))
			mode = DRILL_YELLING
		if(DRILL_YELLING)
			to_chat(user, span_notice("You set the voice circuit to the first position."))
			mode = DRILL_DEFAULT
	return TRUE

#undef DRILL_DEFAULT
#undef DRILL_SHOUTING
#undef DRILL_YELLING
