

///////////////////////////////////////////////Alchohol bottles! -Agouri //////////////////////////
//Functionally identical to regular drinks. The only difference is that the default bottle size is 100. - Darem
//Bottles now knockdown and break when smashed on people's heads. - Giacom

/obj/item/reagent_containers/food/drinks/bottle
	name = "glass bottle"
	desc = "This blank bottle is unyieldingly anonymous, offering no clues to its contents."
	icon_state = "glassbottle"
	fill_icon_thresholds = list(0, 10, 20, 30, 40, 50, 60, 70, 80, 90)
	custom_price = 15
	amount_per_transfer_from_this = 10
	volume = 100
	force = 15 //Smashing bottles over someone's head hurts.
	throwforce = 15
	item_state = "broken_beer" //Generic held-item sprite until unique ones are made.
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	pickup_sound =  'sound/items/handling/bottle_pickup.ogg'
	drop_sound = 'sound/items/handling/bottle_drop.ogg'
	var/const/duration = 13 //Directly relates to the 'knockdown' duration. Lowered by armor (i.e. helmets)
	isGlass = TRUE
	foodtype = ALCOHOL

/obj/item/reagent_containers/food/drinks/bottle/update_overlays()
	. = ..()
	. += "[initial(icon_state)]shine"

/obj/item/reagent_containers/food/drinks/bottle/small
	name = "small glass bottle"
	desc = "This blank bottle is unyieldingly anonymous, offering no clues to its contents."
	icon_state = "glassbottlesmall"
	volume = 50
	custom_price = 1

/obj/item/reagent_containers/food/drinks/bottle/attack(mob/living/target, mob/living/user)
	if(!target)
		return

	if(user.a_intent != INTENT_HARM || !isGlass)
		return ..()

	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='warning'>You don't want to harm [target]!</span>")
		return

	var/obj/item/bodypart/affecting = user.zone_selected //Find what the player is aiming at

	var/armor_block = 0 //Get the target's armor values for normal attack damage.
	var/armor_duration = 0 //The more force the bottle has, the longer the duration.

	//Calculating duration and calculating damage.
	if(ishuman(target))

		var/mob/living/carbon/human/H = target
		var/headarmor = 0 // Target's head armor
		armor_block = H.run_armor_check(affecting, "melee", armour_penetration, silent = TRUE) // For normal attack damage

		//If they have a hat/helmet and the user is targeting their head.
		if(istype(H.head, /obj/item/clothing/head) && affecting == BODY_ZONE_HEAD)
			headarmor = H.head.armor.melee
		else
			headarmor = 0

		//Calculate the knockdown duration for the target.
		armor_duration = (duration - headarmor) + force

	else
		//Only humans can have armor, right?
		armor_block = target.run_armor_check(affecting, "melee")
		if(affecting == BODY_ZONE_HEAD)
			armor_duration = duration + force

	//Apply the damage!
	armor_block = min(90,armor_block)
	target.apply_damage(force, BRUTE, affecting, armor_block)

	// You are going to knock someone down for longer if they are not wearing a helmet.
	var/head_attack_message = ""
	if(affecting == BODY_ZONE_HEAD && istype(target, /mob/living/carbon/))
		head_attack_message = " on the head"
		if(armor_duration)
			target.apply_effect(min(armor_duration, 200) , EFFECT_KNOCKDOWN)

	//Display an attack message.
	if(target != user)
		target.visible_message("<span class='danger'>[user] hits [target][head_attack_message] with a bottle of [src.name]!</span>", \
				"<span class='userdanger'>[user] hits you [head_attack_message] with a bottle of [src.name]!</span>")
	else
		target.visible_message("<span class='danger'>[target] hits [target.p_them()]self with a bottle of [src.name][head_attack_message]!</span>", \
				"<span class='userdanger'>You hit yourself with a bottle of [src.name][head_attack_message]!</span>")

	//Attack logs
	log_combat(user, target, "attacked", src)

	//The reagents in the bottle splash all over the target, thanks for the idea Nodrak
	SplashReagents(target)

	//Finally, smash the bottle. This kills (del) the bottle.
	smash(target, user)

	return

//Keeping this here for now, I'll ask if I should keep it here.
/obj/item/broken_bottle
	name = "broken bottle"
	desc = "A bottle with a sharp broken bottom."
	icon = 'icons/obj/drinks/drinks.dmi'
	icon_state = "broken_bottle"
	force = 9
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	item_state = "beer"
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("stabbed", "slashed", "attacked")
	sharpness = IS_SHARP
	var/static/icon/broken_outline = icon('icons/obj/drinks/drinks.dmi', "broken")

/obj/item/broken_bottle/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 200, 55)

/obj/item/reagent_containers/food/drinks/bottle/gin
	name = "Neue Wacholder Gin"
	desc = "A bottle of high quality gin, cultivated from juniper berries grown across the Solar cantons. Brewed in Stuteföhle."
	icon_state = "ginbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/gin = 100)

/obj/item/reagent_containers/food/drinks/bottle/whiskey
	name = "Kadi-Witka Reserve"
	desc = "An equivalent to single-malt whiskey, commonly enjoyed and brewed in a brewery originally founded Zohil. While different from traditionally used wheat, it can be safely enjoyed by every species."
	icon_state = "whiskeybottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 100)

/obj/item/reagent_containers/food/drinks/bottle/kong
	name = "Kong"
	desc = "Makes You Go Ape!"
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey/kong = 100)

/obj/item/reagent_containers/food/drinks/bottle/candycornliquor
	name = "candy corn liquor"
	desc = "Like they drank in 2D speakeasies."
	list_reagents = list(/datum/reagent/consumable/ethanol/whiskey/candycorn = 100)

/obj/item/reagent_containers/food/drinks/bottle/vodka
	name = "Triple Horned"
	desc = "Potato-based liquor commonly known as Vodka, distilled thrice to the standards of the PGF's requirements for their rations."
	icon_state = "vodkabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 100)

/obj/item/reagent_containers/food/drinks/bottle/vodka/badminka
	name = "Badminka vodka"
	desc = "The label's written in some unknown language. All you can make out is the name and a word that looks vaguely like 'Vodka'."
	icon_state = "badminka"
	list_reagents = list(/datum/reagent/consumable/ethanol/vodka = 100)

/obj/item/reagent_containers/food/drinks/bottle/tequila
	name = "Rimeki Letisa"
	desc = "Originally made from fermented succulents growing near Teceti's equator-deserts, this brand considers itself equivalent to the original tequila."
	icon_state = "tequilabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/tequila = 100)

/obj/item/reagent_containers/food/drinks/bottle/bottleofnothing
	name = "bottle of nothing"
	desc = "A bottle filled with nothing."
	icon_state = "bottleofnothing"
	list_reagents = list(/datum/reagent/consumable/nothing = 100)
	foodtype = NONE


/obj/item/reagent_containers/food/drinks/bottle/patron
	name = "Wrapp Artiste Patron"
	desc = "Tequila laced with silver, showy enough to impress when ordered in nightclubs across the galaxy."
	icon_state = "patronbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/patron = 100)

/obj/item/reagent_containers/food/drinks/bottle/rum
	name = "Ahkskra Spiced"
	desc = "Ahkskra Spiced - a spiced rum for the vox folkhero in everyone. Features a gallant-looking vox on the front of the bottle."
	icon_state = "rumbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/rum = 100)

/obj/item/reagent_containers/food/drinks/bottle/holywater
	name = "flask of holy water"
	desc = "A flask of water, sanctified in some way by the supertitious."
	icon_state = "holyflask"
	list_reagents = list(/datum/reagent/water/holywater = 100)
	foodtype = NONE

/obj/item/reagent_containers/food/drinks/bottle/holywater/hell
	desc = "A flask of holy water...it's been sitting in the Necropolis a while though."
	list_reagents = list(/datum/reagent/hellwater = 100)

/obj/item/reagent_containers/food/drinks/bottle/vermouth
	name = "Whitespear Dry"
	desc = "Dry and sweet vermouth, commonly used for mixed drinks. Some Solarians drink it as a digestive before meals."
	icon_state = "vermouthbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/vermouth = 100)

/obj/item/reagent_containers/food/drinks/bottle/kahlua
	name = "Keh'Lu'Tex Liqueur"
	desc = "An adapted recipe of a caffeine-mixed liqueur originating from Reh'himl, which replaces its original ingredient with coffee from Terra."
	icon_state = "kahluabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 100)
	foodtype = SUGAR | ALCOHOL //it's coffee and rum .

/obj/item/reagent_containers/food/drinks/bottle/goldschlager
	name = "Student-Union's Gold Standard"
	desc = "Extremely high-proof cinnamon schnapps, typically found in commemorative bottles by those in the Student-Union Association of Naturalistic Sciences. Nigh-undrinkable and with a tasteless amount of gold flakes floating within."
	icon_state = "goldschlagerbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/goldschlager = 100)

/obj/item/reagent_containers/food/drinks/bottle/cognac
	name = "Geheimnis Cognac"
	desc = "While the origins of the name 'cognac' are lost to time, this type of brandy is reserved as a high-class drink with particular methods of brewing."
	icon_state = "cognacbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/cognac = 100)

/obj/item/reagent_containers/food/drinks/bottle/wine
	name = "Waldstätte Sauvignon"
	desc = "A bottle of wine, brewed from grapes specifically grown in Neue Waldstätte. You've mostly seen these in bottles sold specifically for tourists."
	icon_state = "winebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 100)
	foodtype = FRUIT | ALCOHOL

/obj/item/reagent_containers/food/drinks/bottle/absinthe
	name = "Severtail Green"
	desc = "Strong absinthe brewed in the Pan-Gezenan Federation, with their own transplants of Wormwood gifted to them during the first contact with humankind. If the legend (and label) means anything, the first attempt at brewing this caused some poor sarathi's tail to fall off."
	icon_state = "absinthebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/absinthe = 100)

/obj/item/reagent_containers/food/drinks/bottle/absinthe/premium
	name = "Chacheyi Gold"
	desc = "A higher shelf absinthe, distributed primarily from The Shoal. Features the folkhero Chacheyi on the label, alongside their goldgrub companions."
	icon_state = "absinthepremium"

/obj/item/reagent_containers/food/drinks/bottle/lizardwine
	name = "bottle of Blueflame Pyrecask"
	desc = "An alcoholic beverage originating from isolated vineyards on Zohil, maintained by the reclusive religious sects of the Blueflame. Now considered so popular and high quality, imitation bottles can be found everywhere. Check the label for point of origin."
	icon_state = "lizardwine"
	list_reagents = list(/datum/reagent/consumable/ethanol/lizardwine = 100)
	foodtype = FRUIT | ALCOHOL

/obj/item/reagent_containers/food/drinks/bottle/hcider
	name = "Neue Hamburg Spiced"
	desc = "One of the main exports of Neue Hamburg - hard, spiced cider. Enjoyed all across the cantons and beyond."
	icon_state = "hcider"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/ethanol/hcider = 50)

/obj/item/reagent_containers/food/drinks/bottle/amaretto
	name = "Lu'Ni'Xer'Nan Amaretto"
	desc = "A popular Rachnid take on the recipe for Amaretto, which fell to obscurity after only being semi-rediscovered by Solarian historians. Features a semi-reconstructed depiction of a supposed origin story, with the painter Lu'Ni'Xer'Nan and her muse, an innkeeper."
	icon_state = "disaronno"
	list_reagents = list(/datum/reagent/consumable/ethanol/amaretto = 100)

/obj/item/reagent_containers/food/drinks/bottle/grappa
	name = "Neue Maynila Grappamiel"
	desc = "A bottle of Grappa, premixed with honey-based spirits. Commonly seen as a drink for recycling grapes after their use in winemaking, and commonly seen as a winter drink."
	icon_state = "grappabottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/grappa = 100)

/obj/item/reagent_containers/food/drinks/bottle/sake
	name = "Sakamai Sake"
	desc = "An alcoholic drink derived from rice, rediscovered by Solarian historians and reintroduced to the best of their ability to reproduce it."
	icon_state = "sakebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/sake = 100)

/obj/item/reagent_containers/food/drinks/bottle/sake/Initialize()
	. = ..()
	if(prob(10))
		name = "Fluffy Tail"
		desc += "This particular brand's mascot is a human with nine fox tails - which is an impressive amount of genemodding."
		icon_state = "sakebottle_k"
	else if(prob(10))
		name = "Inubashiri's Home Brew"
		desc += "This particular brand's mascot is a human with vaguely canine ears and a tail."
		icon_state = "sakebottle_i"

/obj/item/reagent_containers/food/drinks/bottle/fernet
	name = "Fernet Bronca"
	desc = "A bitter and aromatic drink, commonly enjoyed in the intersolar cantons due to relaxed alcoholic tariffs from being technically classified as a medicinal beverage. Commonly mixed with cola-based soft drinks."
	icon_state = "fernetbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/fernet = 100)

/obj/item/reagent_containers/food/drinks/bottle/triplesec
	name = "Teeka-Gih's triple sec liqueur"
	desc = "A bottle of triple sec originating from Bezuts."
	icon_state = "triplesecbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/triple_sec = 100)

//////////////////////////JUICES AND STUFF ///////////////////////

/obj/item/reagent_containers/food/drinks/bottle/orangejuice
	name = "orange juice"
	desc = "Sweet and tart orange juice. Usually found fortified to make it more nutritious. Full of vitamin C!"
	custom_price = 10
	icon_state = "orangejuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/orangejuice = 100)
	foodtype = FRUIT | BREAKFAST

/obj/item/reagent_containers/food/drinks/bottle/lemonjuice
	name = "lemon juice"
	desc = "Lemonade for everyone!"
	custom_price = 10
	icon_state = "lemonjuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/lemonjuice = 100)
	foodtype = FRUIT

/obj/item/reagent_containers/food/drinks/bottle/cream
	name = "milk cream"
	desc = "Cream made from milk. It's thicker than milk, which hopefully prevents any mixups."
	custom_price = 10
	icon_state = "cream"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/cream = 100)
	foodtype = DAIRY

/obj/item/reagent_containers/food/drinks/bottle/tomatojuice
	name = "tomato juice"
	desc = "Juice from tomatoes and salt. You'll often find some technicians soaking in this if they've been working with plasma."
	custom_price = 10
	icon_state = "tomatojuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/tomatojuice = 100)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/drinks/bottle/limejuice
	name = "lime juice"
	desc = "Lime juice. You might want to mix something with this instead of drinking it straight..."
	custom_price = 10
	icon_state = "limejuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/limejuice = 100)
	foodtype = FRUIT

/obj/item/reagent_containers/food/drinks/bottle/pineapplejuice
	name = "pineapple juice"
	desc = "Tart, sweet juice from the tropical pineapple."
	custom_price = 10
	icon_state = "pineapplejuice"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/pineapplejuice = 100)
	foodtype = FRUIT | PINEAPPLE


/obj/item/reagent_containers/food/drinks/bottle/menthol
	name = "menthol"
	desc = "Tastes naturally minty, and imparts a very mild numbing sensation."
	custom_price = 10
	icon_state = "mentholbox"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/menthol = 100)

/obj/item/reagent_containers/food/drinks/bottle/grenadine
	name = "Three-Star Grenadine"
	desc = "A commonly seen bottle of grenadine - or sweet fruit syrup. It might even contain real cherries, as well as some blackcurrant for color."
	custom_price = 10
	icon_state = "grenadine"
	isGlass = TRUE
	list_reagents = list(/datum/reagent/consumable/grenadine = 100)
	foodtype = FRUIT


/obj/item/reagent_containers/food/drinks/bottle/applejack
	name = "Mars Lightning"
	desc = "A strong brandy originating from apples, considered the older sibling to hard cider. Mars Lightning is often partnered with anti-gravity racing companies, leading to it often being served straight or for impromptu mixes."
	custom_price = 15
	icon_state = "applejack_bottle"
	isGlass = TRUE
	list_reagents = list(/datum/reagent/consumable/ethanol/applejack = 100)
	foodtype = FRUIT

/obj/item/reagent_containers/food/drinks/bottle/champagne
	name = "Treu Champagne"
	desc = "Finely sourced from entire canton planets dedicated to faithful reproduction of pre-Night Of Fire vineyards. Typically enjoyed for celebrations and the turn of new years."
	custom_premium_price = 25
	icon_state = "champagne_bottle"
	isGlass = TRUE
	list_reagents = list(/datum/reagent/consumable/ethanol/champagne = 100)

/obj/item/reagent_containers/food/drinks/bottle/blazaam
	name = "Hyperspace Highball"
	desc = "Infamously expensive, infamously contains bluespace 'flakes' for bragging rights, and infamously removed from most shelves due to accidents involving teleportation accidents upon ingestion."
	icon_state = "blazaambottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/blazaam = 100)

/obj/item/reagent_containers/food/drinks/bottle/trappist
	name = "Roumain Trapper's"
	desc = "Traditionally (and heavily monitored for authenticity) made beer brewed on Illestren. Trapper's beer must be brewed by Saint Roumain Hunters or Shadows, made to fit the needs of their community first, and must never be made for profit... which makes it a common sight in the Frontier."
	custom_premium_price = 17
	icon_state = "trappistbottle"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/ethanol/trappist = 50)

/obj/item/reagent_containers/food/drinks/bottle/hooch
	name = "hooch bottle"
	desc = "A bottle of homebrewed, low quality alcohol. The paper wrapping is covered in little signatures and messages - how many hands have passed this bottle before you came around?"
	icon_state = "hoochbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/hooch = 100)

/obj/item/reagent_containers/food/drinks/bottle/moonshine
	name = "moonshine jug"
	desc = "High-proof hard liquor, most likely made in the privacy of a bootlegger's ship. Permanent marker on packaging tape is the most you'll get for a label. Remember: if it doesn't burn blue, don't drink it!"
	icon_state = "moonshinebottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/moonshine = 100)

/obj/item/reagent_containers/food/drinks/bottle/coconut
	name = "T4l1's Pure Coconut Delight"
	desc = "A fanmade, promotional bottle of coconut cream liquor. There's a stylized picture of a synthetic kepori on the side, along with a blurb about whoever she is. You're pretty certain this stuff is synthetic, despite Teceti growing actual coconut trees..." //if i have to recognize rilena here, I'm going to have fun with it
	icon_state = "coconutbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/creme_de_coconut = 100)
	isGlass = TRUE

/obj/item/reagent_containers/food/drinks/bottle/cacao
	name = "Sharai's Pure Cacao Delight"
	desc = "Seems to be some promotional product for a Teceti video game. You're pretty certain this stuff is synthetic."
	icon_state = "cacaobottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/creme_de_cacao = 100)
	isGlass = TRUE

/obj/item/reagent_containers/food/drinks/bottle/menthe
	name = "Mora's Pure Mint Delight"
	desc = "Seems to be some promotional product for a Teceti video game. You're pretty certain this stuff is synthetic."
	icon_state = "mintbottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/creme_de_menthe = 100)
	isGlass = TRUE

////////////////////////// MOLOTOV ///////////////////////
/obj/item/reagent_containers/food/drinks/bottle/molotov
	name = "molotov cocktail"
	desc = "A throwing weapon used to ignite things, typically filled with an accelerant. Recommended highly by desperate militias and revolutionaries. Light and toss."
	icon_state = "vodkabottle"
	list_reagents = list()
	var/active = 0

/obj/item/reagent_containers/food/drinks/bottle/molotov/CheckParts(list/parts_list)
	..()
	var/obj/item/reagent_containers/food/drinks/bottle/B = locate() in contents
	if(B)
		icon_state = B.icon_state
		B.reagents.copy_to(src,100)
		if(!B.isGlass)
			desc += " You're not sure if making this out of a carton was the brightest idea."
			isGlass = FALSE
	return

/obj/item/reagent_containers/food/drinks/bottle/molotov/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/firestarter = FALSE
	for(var/datum/reagent/reagent as anything in reagents.reagent_list)
		if(reagent.accelerant_quality)
			firestarter = TRUE
			break
	if(firestarter && active)
		hit_atom.fire_act()
		var/turf/T = get_turf(hit_atom)
		T.IgniteTurf(30)
		var/turf/otherT
		for(var/direction in GLOB.cardinals)
			otherT = get_step(T, direction)
			otherT.IgniteTurf(30)
			new /obj/effect/hotspot(otherT)
	..()

/obj/item/reagent_containers/food/drinks/bottle/molotov/attackby(obj/item/I, mob/user, params)
	if(I.get_temperature() && !active)
		active = TRUE
		log_bomber(user, "has primed a", src, "for detonation")

		to_chat(user, "<span class='info'>You light [src] on fire.</span>")
		add_overlay(custom_fire_overlay ? custom_fire_overlay : GLOB.fire_overlay)
		if(!isGlass)
			addtimer(CALLBACK(src, PROC_REF(explode)), 5 SECONDS)

/obj/item/reagent_containers/food/drinks/bottle/molotov/proc/explode()
	if(!active)
		return
	if(get_turf(src))
		var/atom/target = loc
		for(var/i in 1 to 2)
			if(istype(target, /obj/item/storage))
				target = target.loc
		SplashReagents(target)
		target.fire_act()
	qdel(src)

/obj/item/reagent_containers/food/drinks/bottle/molotov/attack_self(mob/user)
	if(active)
		if(!isGlass)
			to_chat(user, "<span class='danger'>The flame's spread too far on it!</span>")
			return
		to_chat(user, "<span class='info'>You snuff out the flame on [src].</span>")
		cut_overlay(custom_fire_overlay ? custom_fire_overlay : GLOB.fire_overlay)
		active = 0

/obj/item/reagent_containers/food/drinks/bottle/pruno
	name = "pruno mix"
	desc = "A trash bag filled with fruit, sugar, yeast, and water, pulped together into a pungent slurry to be fermented in an enclosed space, traditionally the toilet."
	icon = 'icons/obj/janitor.dmi'
	icon_state = "trashbag"
	list_reagents = list(/datum/reagent/consumable/prunomix = 50)
	var/fermentation_time = 30 SECONDS /// time it takes to ferment
	var/fermentation_time_remaining /// for partial fermentation
	var/fermentation_timer 	/// store the timer id of fermentation

/obj/item/reagent_containers/food/drinks/bottle/pruno/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(check_fermentation))

/obj/item/reagent_containers/food/drinks/bottle/pruno/Destroy()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	return ..()

// Checks to see if the pruno can ferment, i.e. is it inside a structure (e.g. toilet), or a machine (e.g. washer)?
// TODO: make it so the washer spills reagents if a reagent container is in there, for now, you can wash pruno

/obj/item/reagent_containers/food/drinks/bottle/pruno/proc/check_fermentation()
	if (!(istype(loc, /obj/machinery) || istype(loc, /obj/structure)))
		if(fermentation_timer)
			fermentation_time_remaining = timeleft(fermentation_timer)
			deltimer(fermentation_timer)
			fermentation_timer = null
		return
	if(fermentation_timer)
		return
	if(!fermentation_time_remaining)
		fermentation_time_remaining = fermentation_time
	fermentation_timer = addtimer(CALLBACK(src, PROC_REF(do_fermentation)), fermentation_time_remaining, TIMER_UNIQUE|TIMER_STOPPABLE)
	fermentation_time_remaining = null

// actually ferment

/obj/item/reagent_containers/food/drinks/bottle/pruno/proc/do_fermentation()
	fermentation_time_remaining = null
	fermentation_timer = null
	if(prob(10))
		reagents.add_reagent(/datum/reagent/toxin/bad_food, 15) // closest thing we have to botulism
		reagents.add_reagent(/datum/reagent/consumable/ethanol/pruno, 35)
	else
		reagents.add_reagent(/datum/reagent/consumable/ethanol/pruno, 50)
	name = "bag of pruno"
	desc = "Fermented prison wine made from fruit, sugar, and despair."
	icon_state = "trashbag1" // pruno releases air as it ferments, we don't want to simulate this in atmos, but we can make it look like it did
	for (var/mob/living/M in view(2, get_turf(src))) // letting people and/or narcs know when the pruno is done
		to_chat(M, "<span class='info'>A pungent smell emanates from [src], like fruit puking out its guts.</span>")
		playsound(get_turf(src), 'sound/effects/bubbles2.ogg', 25, TRUE)

/obj/item/reagent_containers/food/drinks/colocup/lean
	name = "lean"
	desc = "Despite this mix of codeine-based cough syrup and a soft drink of choice being popular online, you're not sure anyone talking about ever tried it. First time for everything?"
	icon_state = "lean"
	list_reagents = list(/datum/reagent/consumable/lean = 50)
	random_sprite = FALSE

/obj/item/reagent_containers/food/drinks/bottle/sarsaparilla
	name = "Sandblast Sarsaparilla"
	desc = "Sealed for a guaranteed fresh taste in every bottle."
	icon_state = "sandbottle"
	volume = 50
	list_reagents = list(/datum/reagent/consumable/molten/sand = 50)
	reagent_flags = null //Cap's on

/obj/item/reagent_containers/food/drinks/bottle/sarsaparilla/attack_self(mob/user)
	if(!is_drainable()) // Uses the reagents.flags cause reagent_flags is only the init value
		playsound(src, 'sound/items/openbottle.ogg', 30, 1)
		user.visible_message("<span class='notice'>[user] takes the cap off \the [src].</span>", "<span class='notice'>You take the cap off [src].</span>")
		reagents.flags |= OPENCONTAINER //Cap's off
		if(prob(1)) //Lucky you
			var/S = new /obj/item/sandstar(src)
			user.put_in_hands(S)
			to_chat(user, "<span class='notice'>You found a Sandblast Star!</span>")
	else
		. = ..()

/obj/item/reagent_containers/food/drinks/bottle/sarsaparilla/examine(mob/user)
	. = ..()
	if(!is_drainable())
		. += "<span class='info'>The cap is still sealed.</span>"

/obj/item/sandstar
	name = "SandBlast Sarsaparilla star"
	desc = "Legend says something amazing happens when you collect enough of these."
	custom_price = 10
	custom_premium_price = 11
	icon = 'icons/obj/items.dmi'
	icon_state = "sandstar"
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/gold = 200)

/obj/item/storage/bottles
	name = "bottle crate"
	desc = "A small crate for storing bottles"
	icon = 'icons/obj/storage.dmi'
	icon_state = "bottlecrate"
	item_state = "deliverypackage"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	custom_materials = list(/datum/material/wood = 800)
	w_class = WEIGHT_CLASS_BULKY
	var/sealed = FALSE
	var/max_bottles = 6
	var/list/valid_bottles = list(/obj/item/reagent_containers/food/drinks/beer,
	/obj/item/reagent_containers/food/drinks/ale,
	/obj/item/reagent_containers/food/drinks/bottle)

/obj/item/storage/bottles/Initialize()
	. = ..()
	update_appearance()

/obj/item/storage/bottles/ComponentInitialize()
	. = ..()
	var/datum/component/storage/S = GetComponent(/datum/component/storage)
	S.max_w_class = WEIGHT_CLASS_NORMAL
	S.max_combined_w_class = 16
	S.max_items = max_bottles
	S.set_holdable(valid_bottles)
	S.locked = sealed

/obj/item/storage/bottles/update_icon_state()
	if(sealed)
		icon_state = "[initial(icon_state)]_seal"
	else
		icon_state = "[initial(icon_state)]_[contents.len]"
	return ..()

/obj/item/storage/bottles/examine(mob/user)
	. = ..()
	if(sealed)
		. += "<span class='info'>It is sealed. You could pry it open with a <i>crowbar</i> to access its contents.</span>"

/obj/item/storage/bottles/crowbar_act(mob/living/user, obj/item/I)
	. = ..()
	if(sealed)
		var/datum/component/storage/S = GetComponent(/datum/component/storage)
		user.visible_message("<span class='notice'>[user] pries open \the [src].</span>", "You pry open \the [src]")
		playsound(src, 'sound/machines/wooden_closet_close.ogg', 20, 1)
		sealed = FALSE
		S.locked = FALSE
		new /obj/item/stack/sheet/mineral/wood(get_turf(src), 1)
		update_appearance()
		return TRUE

/obj/item/storage/bottles/sandblast
	name = "sarsaparilla bottle crate"
	desc = "Holds six bottles of the finest sarsaparilla this side of the Frontier."
	sealed = TRUE

/obj/item/storage/bottles/sandblast/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/food/drinks/bottle/sarsaparilla(src)

/obj/item/storage/bottles/moonshine
	name = "moonshine bottle crate"
	desc = "Holds four bottles of the strongest hooch this side of the Frontier."
	icon_state = "hoochcrate"
	max_bottles = 4
	valid_bottles = list(/obj/item/reagent_containers/food/drinks/bottle/moonshine)

/obj/item/storage/bottles/moonshine/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/reagent_containers/food/drinks/bottle/moonshine(src)

/obj/item/storage/bottles/moonshine/sealed
	sealed = TRUE
