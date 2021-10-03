/obj/item/caution
	desc = "Caution! Wet Floor!"
	name = "wet floor sign"
	icon = 'icons/obj/janitor.dmi'
	icon_state = "caution"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	force = 1
	throwforce = 3
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("warned", "cautioned", "smashed")

/obj/item/choice_beacon
	name = "choice beacon"
	desc = "Hey, why are you viewing this?!! Please let CentCom know about this odd occurrence."
	icon = 'icons/obj/device.dmi'
	icon_state = "gangtool-blue"
	item_state = "radio"
	var/uses = 1

/obj/item/choice_beacon/attack_self(mob/user)
	if(canUseBeacon(user))
		generate_options(user)

/obj/item/choice_beacon/proc/generate_display_names() // return the list that will be used in the choice selection. entries should be in (type.name = type) fashion. see choice_beacon/hero for how this is done.
	return list()

/obj/item/choice_beacon/proc/canUseBeacon(mob/living/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return TRUE
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 40, TRUE)
		return FALSE

/obj/item/choice_beacon/proc/generate_options(mob/living/M)
	var/list/display_names = generate_display_names()
	if(!display_names.len)
		return
	var/choice = input(M,"Which item would you like to order?","Select an Item") as null|anything in sortList(display_names)
	if(!choice || !M.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	spawn_option(display_names[choice],M)
	uses--
	if(!uses)
		qdel(src)
	else
		to_chat(M, "<span class='notice'>[uses] use[uses > 1 ? "s" : ""] remaining on the [src].</span>")

/obj/item/choice_beacon/proc/spawn_option(obj/choice,mob/living/M)
	var/obj/new_item = new choice()
	var/obj/structure/closet/supplypod/bluespacepod/pod = new()
	pod.explosionSize = list(0,0,0,0)
	new_item.forceMove(pod)
	var/msg = "<span class=danger>After making your selection, you notice a strange target on the ground. It might be best to step back!</span>"
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(istype(H.ears, /obj/item/radio/headset))
			msg = "You hear something crackle in your ears for a moment before a voice speaks.  \"Please stand by for a message from Central Command.  Message as follows: <span class='bold'>Item request received. Your package is inbound, please stand back from the landing site.</span> Message ends.\""
	to_chat(M, msg)

	new /obj/effect/DPtarget(get_turf(src), pod)

/obj/item/choice_beacon/hero
	name = "heroic beacon"
	desc = "To summon heroes from the past to protect the future."

/obj/item/choice_beacon/hero/generate_display_names()
	var/static/list/hero_item_list
	if(!hero_item_list)
		hero_item_list = list()
		var/list/templist = typesof(/obj/item/storage/box/hero) //we have to convert type = name to name = type, how lovely!
		for(var/V in templist)
			var/atom/A = V
			hero_item_list[initial(A.name)] = A
	return hero_item_list


/obj/item/storage/box/hero
	name = "Courageous Tomb Raider - 1940's."
	desc = "This legendary figure of still dubious historical accuracy is thought to have been a world-famous archeologist who embarked on countless adventures in far away lands, along with his trademark whip and fedora hat."

/obj/item/storage/box/hero/PopulateContents()
	new /obj/item/clothing/head/fedora/curator(src)
	new /obj/item/clothing/suit/curator(src)
	new /obj/item/clothing/under/rank/civilian/curator/treasure_hunter(src)
	new /obj/item/clothing/shoes/workboots/mining(src)
	new /obj/item/melee/curator_whip(src)

/obj/item/storage/box/hero/astronaut
	name = "First Man on the Moon - 1960's."
	desc = "One small step for a man, one giant leap for mankind. Relive the beginnings of space exploration with this fully functional set of vintage EVA equipment."

/obj/item/storage/box/hero/astronaut/PopulateContents()
	new /obj/item/clothing/suit/space/nasavoid(src)
	new /obj/item/clothing/head/helmet/space/nasavoid(src)
	new /obj/item/tank/internals/oxygen(src)
	new /obj/item/gps(src)

/obj/item/storage/box/hero/scottish
	name = "Braveheart, the Scottish rebel - 1300's."
	desc = "Seemingly a legendary figure in the battle for Scottish independence, this historical figure is closely associated with blue facepaint, big swords, strange man skirts, and his ever enduring catchphrase: 'FREEDOM!!'"

/obj/item/storage/box/hero/scottish/PopulateContents()
	new /obj/item/clothing/under/costume/kilt(src)
	new /obj/item/claymore/weak/ceremonial(src)
	new /obj/item/toy/crayon/spraycan(src)
	new /obj/item/clothing/shoes/sandal(src)

/obj/item/storage/box/hero/carphunter
	name = "Carp Hunter, Wildlife Expert - 2506."
	desc = "Despite his nickname, this wildlife expert was mainly known as a passionate enviromentalist and conservationist, often coming in contact with dangerous wildlife to teach about the beauty of nature."

/obj/item/storage/box/hero/carphunter/PopulateContents()
	new /obj/item/clothing/suit/space/hardsuit/carp/old(src)
	new /obj/item/clothing/mask/gas/carp(src)
	new /obj/item/kitchen/knife/hunting(src)
	new /obj/item/storage/box/papersack/meat(src)

/obj/item/storage/box/hero/ghostbuster
	name = "Spectre Inspector - 1980's."

/obj/item/storage/box/hero/ghostbuster/PopulateContents()
	new /obj/item/choice_beacon/ouija(src)
	new /obj/item/clothing/glasses/welding/ghostbuster(src)
	new /obj/item/storage/belt/fannypack/bustin(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/shoes/jackboots(src)
	new /obj/item/clothing/under/color/khaki/buster(src)
	new /obj/item/grenade/chem_grenade/ghostbuster(src)
	new /obj/item/grenade/chem_grenade/ghostbuster(src)
	new /obj/item/grenade/chem_grenade/ghostbuster(src)

/obj/item/choice_beacon/augments
	name = "augment beacon"
	desc = "Summons augmentations. Can be used 3 times!"
	uses = 3

/obj/item/choice_beacon/augments/generate_display_names()
	var/static/list/augment_list
	if(!augment_list)
		augment_list = list()
		var/list/templist = list(
		/obj/item/organ/cyberimp/brain/anti_drop,
		/obj/item/organ/cyberimp/arm/toolset,
		/obj/item/organ/cyberimp/arm/surgery,
		/obj/item/organ/cyberimp/chest/thrusters,
		/obj/item/organ/lungs/cybernetic/tier3,
		/obj/item/organ/liver/cybernetic/tier3) //cyberimplants range from a nice bonus to fucking broken bullshit so no subtypesof
		for(var/V in templist)
			var/atom/A = V
			augment_list[initial(A.name)] = A
	return augment_list

/obj/item/choice_beacon/augments/spawn_option(obj/choice,mob/living/M)
	new choice(get_turf(M))
	to_chat(M, "<span class='hear'>You hear something crackle from the beacon for a moment before a voice speaks. \"Please stand by for a message from S.E.L.F. Message as follows: <b>Item request received. Your package has been transported, use the autosurgeon supplied to apply the upgrade.</b> Message ends.\"</span>")

/obj/item/skub
	desc = "It's skub."
	name = "skub"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "skub"
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("skubbed")

/obj/item/skub/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] has declared themself as anti-skub! The skub tears them apart!</span>")

	user.gib()
	playsound(src, 'sound/items/eatfood.ogg', 50, TRUE, -1)
	return MANUAL_SUICIDE

/obj/item/virgin_mary
	name = "\proper a picture of the virgin mary"
	desc = "A small, cheap icon depicting the virgin mother."
	icon = 'icons/obj/blackmarket.dmi'
	icon_state = "madonna"
	resistance_flags = FLAMMABLE
	///Has this item been used already.
	var/used_up = FALSE
	///List of mobs that have already been mobbed.
	var/static/list/mob_mobs = list()

#define NICKNAME_CAP (MAX_NAME_LEN/2)
/obj/item/virgin_mary/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(resistance_flags & ON_FIRE)
		return
	if(!burn_paper_product_attackby_check(W, user, TRUE))
		return
	if(used_up)
		return
	if(!isliving(user) || !user.mind) //A sentient mob needs to be burning it, ya cheezit.
		return
	var/mob/living/joe = user

	if(joe in mob_mobs) //Only one nickname fuckhead
		to_chat(joe, "<span class='warning'>You have already been initiated into the mafioso life.</span>")
		return

	to_chat(joe, "<span class='notice'>As you burn the picture, a nickname comes to mind...</span>")
	var/nickname = stripped_input(joe, "Pick a nickname", "Mafioso Nicknames", null, NICKNAME_CAP, TRUE)
	nickname = reject_bad_name(nickname, allow_numbers = FALSE, max_length = NICKNAME_CAP, ascii_only = TRUE)
	if(!nickname)
		return
	var/new_name
	var/space_position = findtext(joe.real_name, " ")
	if(space_position)//Can we find a space?
		new_name = "[copytext(joe.real_name, 1, space_position)] \"[nickname]\" [copytext(joe.real_name, space_position)]"
	else //Append otherwise
		new_name = "[joe.real_name] \"[nickname]\""
	joe.real_name = new_name
	used_up = TRUE
	mob_mobs += joe
	joe.say("My soul will burn like this saint if I betray my family. I enter alive and I will have to get out dead.", forced = /obj/item/virgin_mary)
	to_chat(joe, "<span class='userdanger'>Being inducted into the mafia does not grant antagonist status.</span>")

#undef NICKNAME_CAP

/obj/item/virgin_mary/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] starts saying their Hail Mary's at a terrifying pace! It looks like [user.p_theyre()] trying to enter the afterlife!</span>")
	user.say("Hail Mary, full of grace, the Lord is with thee. Blessed are thou amongst women, and blessed is the fruit of thy womb, Jesus. Holy Mary, mother of God, pray for us sinners, now and at the hour of our death. Amen. ", forced = /obj/item/virgin_mary)
	addtimer(CALLBACK(src, .proc/manual_suicide, user), 75)
	addtimer(CALLBACK(user, /atom/movable/proc/say, "O my Mother, preserve me this day from mortal sin..."), 50)
	return MANUAL_SUICIDE

/obj/item/virgin_mary/proc/manual_suicide(mob/living/user)
	user.adjustOxyLoss(200)
	user.death(0)

/obj/item/choice_beacon/ouija
	name = "spirit board delivery beacon"
	desc = "Ghost communication on demand! It is unclear how this thing is still operational."

/obj/item/choice_beacon/ouija/generate_display_names()
	var/static/list/ouija_spaghetti_list
	if(!ouija_spaghetti_list)
		ouija_spaghetti_list = list()
		var/list/templist = list(/obj/structure/spirit_board)
		for(var/V in templist)
			var/atom/A = V
			ouija_spaghetti_list[initial(A.name)] = A
	return ouija_spaghetti_list

/obj/structure/legionpike
	name = "legion on a stick"
	desc = "EXTREME interior decorating. You can feel it watching you."
	icon = 'icons/obj/structures.dmi'
	icon_state = "headpike-legion"
	density = FALSE
	anchored = TRUE
	light_color = "#8B0000"
	light_power = 2
	light_range = 2

//rare and valulable gems- designed to eventually be used for archeology, or to be given as opposed to money as loot. Auctioned off at export, or kept as a trophy.
/obj/item/gem/rupee
	name = "\improper Ruperium Crystal"
	desc = "An exotic crystalline compound rarely found all over the frontier of known space. Has few practical uses, but the resonating properties it possesses make it highly valued in the creation of designer instruments."
	icon = 'icons/obj/gems.dmi'
	icon_state = "rupee"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gem/fdiamond
	name = "\improper Frost Diamond"
	desc = "A rare form of crystalline carbon, most commonly found in the inner stone of crashed comets. Though asteroid mining long devalued more common forms of diamond, this one remains exclusive."
	icon = 'icons/obj/gems.dmi'
	icon_state = "diamond"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gem/amber
	name = "\improper Draconic Amber"
	desc = "The final decompositional result of a dragon's white-hot blood. Cherished by inner-world gemcutters for its soft warmth and faint glow."
	icon = 'icons/obj/gems.dmi'
	icon_state = "amber"
	light_range = 2
	light_power = 2
	light_color = "#FFBF00"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gem/bloodstone
	name = "\improper Ichorium"
	desc = "A strange substance, known to coalesce in the presence of otherwordly phenomena. Could probably fetch a good price for this."
	icon = 'icons/obj/gems.dmi'
	icon_state = "ruby"
	light_range = 2
	light_power = 3
	light_color = "#800000"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gem/phoron
	name = "\improper Stabilized Phoron"
	desc = "When under incredible pressure during formation, plasma crystal is occasionally known to transform into this substance. Famed both for exceptional durability and uncommon beauty."
	icon = 'icons/obj/gems.dmi'
	icon_state = "phoron"
	light_range = 2
	light_power = 2
	light_color = "#62326a"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gem/void
	name = "\improper Null Crystal"
	desc = "A shard of stellar energy, shaped into crystal. These strange objects occasionally appear spontaneously in the deepest, darkest depths of space. Despite it's incredible value, it seems far lighter than it should be."
	icon = 'icons/obj/gems.dmi'
	icon_state ="void"
	light_range = 2
	light_power = 1
	light_color = "#4785a4"
	w_class = WEIGHT_CLASS_SMALL
