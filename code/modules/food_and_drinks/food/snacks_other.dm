
////////////////////////////////////////////OTHER////////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/store/cheesewheel
	name = "cheese wheel"
	desc = "A big wheel of delcious Cheddar."
	icon_state = "cheesewheel"
	slice_path = /obj/item/reagent_containers/food/snacks/cheesewedge
	slices_num = 5
	list_reagents = list(/datum/reagent/consumable/nutriment = 15, /datum/reagent/consumable/nutriment/vitamin = 5)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cheese" = 1)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/royalcheese
	name = "royal cheese"
	desc = "Ascend the throne. Consume the wheel. Feel the POWER."
	icon_state = "royalcheese"
	list_reagents = list(/datum/reagent/consumable/nutriment = 15, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/gold = 20, /datum/reagent/toxin/mutagen = 5)
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("cheese" = 4, "royalty" = 1)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/cheesewedge
	name = "cheese wedge"
	desc = "A wedge of delicious Cheddar. The cheese wheel it was cut from can't have gone far."
	icon_state = "cheesewedge"
	filling_color = "#FFD700"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("cheese" = 1)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/watermelonslice
	name = "watermelon slice"
	desc = "A slice of watery goodness."
	icon_state = "watermelonslice"
	filling_color = "#FF1493"
	tastes = list("watermelon" = 1)
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/watermelonjuice = 5)

/obj/item/reagent_containers/food/snacks/candy_corn
	name = "candy corn"
	desc = "It's a handful of candy corn. Can be stored in a detective's hat."
	icon_state = "candy_corn"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sugar = 2)
	filling_color = "#FF8C00"
	tastes = list("candy corn" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/candy_corn/prison
	name = "desiccated candy corn"
	desc = "If this candy corn were any harder Security would confiscate it for being a potential shiv."
	force = 1 // the description isn't lying
	throwforce = 1 // if someone manages to bust out of jail with candy corn god bless them
	tastes = list("bitter wax" = 1)
	foodtype = GROSS

/obj/item/reagent_containers/food/snacks/chocolatebar
	name = "chocolate bar"
	desc = "Such, sweet, fattening food."
	icon_state = "chocolatebar"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 2)
	filling_color = "#A0522D"
	tastes = list("chocolate" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/hugemushroomslice
	name = "huge mushroom slice"
	desc = "A slice from a huge mushroom."
	icon_state = "hugemushroomslice"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("mushroom" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/popcorn
	name = "popcorn"
	desc = "Now let's find some cinema."
	icon_state = "popcorn"
	trash = /obj/item/trash/popcorn
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bitesize = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	filling_color = "#FFEFD5"
	tastes = list("popcorn" = 3, "butter" = 1)
	foodtype = JUNKFOOD

/obj/item/reagent_containers/food/snacks/popcorn/Initialize()
	. = ..()
	eatverb = pick("bite","nibble","gnaw","gobble","chomp")

/obj/item/reagent_containers/food/snacks/loadedbakedpotato
	name = "loaded baked potato"
	desc = "Totally baked."
	icon_state = "loadedbakedpotato"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#D2B48C"
	tastes = list("potato" = 1)
	foodtype = VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/fries
	name = "space fries"
	desc = "AKA: French Fries, Freedom Fries, etc."
	icon_state = "fries"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	filling_color = "#FFD700"
	tastes = list("fries" = 3, "salt" = 1)
	foodtype = VEGETABLES | GRAIN | FRIED

/obj/item/reagent_containers/food/snacks/fries/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/tatortot
	name = "tator tot"
	desc = "A large fried potato nugget that may or may not try to valid you."
	icon_state = "tatortot"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	filling_color = "FFD700"
	tastes = list("potato" = 3, "valids" = 1)
	foodtype = FRIED | VEGETABLES

/obj/item/reagent_containers/food/snacks/tatortot/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/soydope
	name = "soy dope"
	desc = "Dope from a soy."
	icon_state = "soydope"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 2)
	filling_color = "#DEB887"
	tastes = list("soy" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/cheesyfries
	name = "cheesy fries"
	desc = "Fries. Covered in cheese. Duh."
	icon_state = "cheesyfries"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	filling_color = "#FFD700"
	tastes = list("fries" = 3, "cheese" = 1)
	foodtype = VEGETABLES | GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/cheesyfries/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/badrecipe
	name = "burned mess"
	desc = "Someone should be demoted from cook for this."
	icon_state = "badrecipe"
	list_reagents = list(/datum/reagent/toxin/bad_food = 30)
	filling_color = "#8B4513"
	foodtype = GROSS

/obj/item/reagent_containers/food/snacks/carrotfries
	name = "carrot fries"
	desc = "Tasty fries from fresh Carrots."
	icon_state = "carrotfries"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/medicine/oculine = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#FFA500"
	tastes = list("carrots" = 3, "salt" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/carrotfries/Initialize()
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/reagent_containers/food/snacks/candiedapple
	name = "candied apple"
	desc = "An apple coated in sugary sweetness."
	icon_state = "candiedapple"
	bitesize = 3
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/sugar = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/caramel = 5)
	filling_color = "#FF4500"
	tastes = list("apple" = 2, "caramel" = 3)
	foodtype = JUNKFOOD | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/mint
	name = "mint"
	desc = "It is only wafer thin."
	icon_state = "mint"
	bitesize = 1
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/toxin/minttoxin = 2)
	filling_color = "#800000"
	foodtype = TOXIC | SUGAR

/obj/item/reagent_containers/food/snacks/eggwrap
	name = "egg wrap"
	desc = "The precursor to Pigs in a Blanket."
	icon_state = "eggwrap"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#F0E68C"
	tastes = list("egg" = 1)
	foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/spidereggs
	name = "spider eggs"
	desc = "A cluster of juicy spider eggs. A great side dish for when you care not for your health."
	icon_state = "spidereggs"
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin = 2)
	filling_color = "#008000"
	tastes = list("cobwebs" = 1)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/spiderling
	name = "spiderling"
	desc = "It's slightly twitching in your hand. Ew..."
	icon_state = "spiderling"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin = 4)
	filling_color = "#00800"
	tastes = list("cobwebs" = 1, "guts" = 2)
	foodtype = MEAT | TOXIC

/obj/item/reagent_containers/food/snacks/spiderlollipop
	name = "spider lollipop"
	desc = "Still gross, but at least it has a mountain of sugar on it."
	icon_state = "spiderlollipop"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin = 1, /datum/reagent/iron = 10, /datum/reagent/consumable/sugar = 5, /datum/reagent/medicine/omnizine = 2) //lollipop, but vitamins = toxins
	filling_color = "#00800"
	tastes = list("cobwebs" = 1, "sugar" = 2)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/chococoin
	name = "chocolate coin"
	desc = "A completely edible but nonflippable festive coin."
	icon_state = "chococoin"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/coco = 1)
	filling_color = "#A0522D"
	tastes = list("chocolate" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/fudgedice
	name = "fudge dice"
	desc = "A little cube of chocolate that tends to have a less intense taste if you eat too many at once."
	icon_state = "chocodice"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/coco = 1)
	filling_color = "#A0522D"
	trash = /obj/item/dice/fudge
	tastes = list("fudge" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/chocoorange
	name = "chocolate orange"
	desc = "A festive chocolate orange."
	icon_state = "chocoorange"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 1)
	filling_color = "#A0522D"
	tastes = list("chocolate" = 3, "oranges" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/eggplantparm
	name = "eggplant parmigiana"
	desc = "The only good recipe for eggplant."
	icon_state = "eggplantparm"
	trash = /obj/item/trash/plate
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#BA55D3"
	tastes = list("eggplant" = 3, "cheese" = 1)
	foodtype = VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/tortilla
	name = "tortilla"
	desc = "The base for all your burritos."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "tortilla"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#FFEFD5"
	tastes = list("tortilla" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/burrito
	name = "burrito"
	desc = "Tortilla wrapped goodness."
	icon_state = "burrito"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#FFEFD5"
	tastes = list("torilla" = 2, "meat" = 3)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/cheesyburrito
	name = "cheesy burrito"
	desc = "It's a burrito filled with cheese."
	icon_state = "cheesyburrito"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#FFD800"
	tastes = list("torilla" = 2, "meat" = 3, "cheese" = 1)
	foodtype = GRAIN | MEAT | DAIRY

/obj/item/reagent_containers/food/snacks/carneburrito
	name = "carne asada burrito"
	desc = "The best burrito for meat lovers."
	icon_state = "carneburrito"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 1)
	filling_color = "#A0522D"
	tastes = list("torilla" = 2, "meat" = 4)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/fuegoburrito
	name = "fuego plasma burrito"
	desc = "A super spicy burrito."
	icon_state = "fuegoburrito"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/capsaicin = 5, /datum/reagent/consumable/nutriment/vitamin = 3)
	filling_color = "#FF2000"
	tastes = list("torilla" = 2, "meat" = 3, "hot peppers" = 1)
	foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/yakiimo
	name = "yaki imo"
	desc = "Made with roasted sweet potatoes!"
	icon_state = "yakiimo"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#8B1105"
	tastes = list("sweet potato" = 1)
	foodtype = GRAIN | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/roastparsnip
	name = "roast parsnip"
	desc = "Sweet and crunchy."
	icon_state = "roastparsnip"
	trash = /obj/item/trash/plate
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#FF5500"
	tastes = list("parsnip" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/melonfruitbowl
	name = "melon fruit bowl"
	desc = "For people who wants edible fruit bowls."
	icon_state = "melonfruitbowl"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#FF5500"
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("melon" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/nachos
	name = "nachos"
	desc = "Chips from Space Mexico."
	icon_state = "nachos"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#F4A460"
	tastes = list("nachos" = 1)
	foodtype = VEGETABLES | FRIED

/obj/item/reagent_containers/food/snacks/cheesynachos
	name = "cheesy nachos"
	desc = "The delicious combination of nachos and melting cheese."
	icon_state = "cheesynachos"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 3)
	filling_color = "#FFD700"
	tastes = list("nachos" = 2, "cheese" = 1)
	foodtype = VEGETABLES | FRIED | DAIRY

/obj/item/reagent_containers/food/snacks/cubannachos
	name = "Cuban nachos"
	desc = "That's some dangerously spicy nachos."
	icon_state = "cubannachos"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 7, /datum/reagent/consumable/capsaicin = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#DC143C"
	tastes = list("nachos" = 2, "hot pepper" = 1)
	foodtype = VEGETABLES | FRIED | DAIRY

/obj/item/reagent_containers/food/snacks/melonkeg
	name = "melon keg"
	desc = "Who knew vodka was a fruit?"
	icon_state = "melonkeg"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 3)
	list_reagents = list(/datum/reagent/consumable/nutriment = 9, /datum/reagent/consumable/ethanol/vodka = 15, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#FFD700"
	volume = 80
	bitesize = 5
	tastes = list("grain alcohol" = 1, "fruit" = 1)
	foodtype = FRUIT | ALCOHOL

/obj/item/reagent_containers/food/snacks/honeybar
	name = "honey nut bar"
	desc = "Oats and nuts compressed together into a bar, held together with a honey glaze."
	icon_state = "honeybar"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/honey = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/honey = 5)
	filling_color = "#F2CE91"
	tastes = list("oats" = 3, "nuts" = 2, "honey" = 1)
	foodtype = GRAIN | SUGAR

/obj/item/reagent_containers/food/snacks/stuffedlegion
	name = "stuffed legion"
	desc = "The former skull of a damned human, filled with goliath meat. It has a decorative lava pool made of ketchup and hotsauce."
	icon_state = "stuffed_legion"
	bonus_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3, /datum/reagent/consumable/capsaicin = 1, /datum/reagent/medicine/tricordrazine = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/capsaicin = 2, /datum/reagent/medicine/tricordrazine = 10)
	tastes = list("death" = 2, "rock" = 1, "meat" = 1, "hot peppers" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/powercrepe
	name = "Powercrepe"
	desc = "With great power, comes great crepes.  It looks like a pancake filled with jelly but packs quite a punch."
	icon_state = "powercrepe"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 3, /datum/reagent/iron = 10)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/cherryjelly = 5)
	force = 30
	throwforce = 15
	block_chance = 55
	armour_penetration = 80
	attack_verb = list("slapped", "slathered")
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("cherry" = 1, "crepe" = 1)
	foodtype = GRAIN | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/chewable
	slot_flags = ITEM_SLOT_MASK
	///How long it lasts before being deleted
	var/succ_dur = 180
	///The delay between each time it will handle reagents
	var/succ_int = 100
	///Stores the time set for the next handle_reagents
	var/next_succ = 0

	//makes snacks actually wearable as masks and still edible the old fashioned way.
/obj/item/reagent_containers/food/snacks/chewable/proc/handle_reagents()
	if(reagents.total_volume)
		if(iscarbon(loc))
			var/mob/living/carbon/C = loc
			if (src == C.wear_mask) // if it's in the human/monkey mouth, transfer reagents to the mob
				if(!reagents.trans_to(C, REAGENTS_METABOLISM, method = INGEST))
					reagents.remove_any(REAGENTS_METABOLISM)
				return
		reagents.remove_any(REAGENTS_METABOLISM)

/obj/item/reagent_containers/food/snacks/chewable/process()
	if(iscarbon(loc))
		if(succ_dur < 1)
			qdel(src)
			return
		succ_dur--
		if((reagents && reagents.total_volume) && (next_succ <= world.time))
			handle_reagents()
			next_succ = world.time + succ_int

/obj/item/reagent_containers/food/snacks/chewable/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_MASK)
		START_PROCESSING(SSobj, src)
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/chewable/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/reagent_containers/food/snacks/chewable/lollipop
	name = "lollipop"
	desc = "A delicious lollipop. Makes for a great Valentine's present."
	icon = 'icons/obj/lollipop.dmi'
	icon_state = "lollipop_stick"
	item_state = "lollipop_stick"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1, /datum/reagent/iron = 10, /datum/reagent/consumable/sugar = 5, /datum/reagent/medicine/omnizine = 2)	//Honk
	var/mutable_appearance/head
	var/headcolor = rgb(0, 0, 0)
	succ_dur = 180
	succ_int = 100
	next_succ = 0
	tastes = list("candy" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/chewable/lollipop/Initialize()
	. = ..()
	head = mutable_appearance('icons/obj/lollipop.dmi', "lollipop_head")
	change_head_color(rgb(rand(0, 255), rand(0, 255), rand(0, 255)))

/obj/item/reagent_containers/food/snacks/chewable/lollipop/proc/change_head_color(C)
	headcolor = C
	cut_overlay(head)
	head.color = C
	add_overlay(head)

/obj/item/reagent_containers/food/snacks/chewable/lollipop/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..(hit_atom)
	throw_speed = 1
	throwforce = 0

/obj/item/reagent_containers/food/snacks/chewable/lollipop/cyborg
	var/spamchecking = TRUE

/obj/item/reagent_containers/food/snacks/chewable/lollipop/cyborg/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/spamcheck), 1200)

/obj/item/reagent_containers/food/snacks/chewable/lollipop/cyborg/equipped(mob/living/user, slot)
	. = ..(user, slot)
	spamchecking = FALSE

/obj/item/reagent_containers/food/snacks/chewable/lollipop/cyborg/proc/spamcheck()
	if(spamchecking)
		qdel(src)

/obj/item/reagent_containers/food/snacks/chewable/bubblegum
	name = "bubblegum"
	desc = "A rubbery strip of gum. Not exactly filling, but it keeps you busy."
	icon_state = "bubblegum"
	item_state = "bubblegum"
	color = "#E48AB5" // craftable custom gums someday?
	list_reagents = list(/datum/reagent/consumable/sugar = 5)
	tastes = list("candy" = 1)

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/nicotine
	name = "nicotine gum"
	list_reagents = list(/datum/reagent/drug/nicotine = 10, /datum/reagent/consumable/menthol = 5)
	tastes = list("mint" = 1)
	color = "#60A584"

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/happiness
	name = "HP+ gum"
	desc = "A rubbery strip of gum. It smells funny."
	list_reagents = list(/datum/reagent/drug/happiness = 15)
	tastes = list("paint thinner" = 1)
	color = "#EE35FF"

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum
	name = "bubblegum gum"
	desc = "A rubbery strip of gum. You don't feel like eating it is a good idea."
	color = "#913D3D"
	list_reagents = list(/datum/reagent/blood = 15)
	tastes = list("hell" = 1)

/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum/process()
	. = ..()
	if(iscarbon(loc))
		hallucinate(loc)


/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum/On_Consume(mob/living/eater)
	. = ..()
	if(iscarbon(eater))
		hallucinate(eater)

///This proc has a 5% chance to have a bubblegum line appear, with an 85% chance for just text and 15% for a bubblegum hallucination and scarier text.
/obj/item/reagent_containers/food/snacks/chewable/bubblegum/bubblegum/proc/hallucinate(mob/living/carbon/victim)
	if(!prob(5)) //cursed by bubblegum
		return
	if(prob(15))
		new /datum/hallucination/oh_yeah(victim)
		to_chat(victim, "<span class='colossus'><b>[pick("I AM IMMORTAL.","I SHALL TAKE YOUR WORLD.","I SEE YOU.","YOU CANNOT ESCAPE ME FOREVER.","NOTHING CAN HOLD ME.")]</b></span>")
	else
		to_chat(victim, "<span class='warning'>[pick("You hear faint whispers.","You smell ash.","You feel hot.","You hear a roar in the distance.")]</span>")

/obj/item/reagent_containers/food/snacks/gumball
	name = "gumball"
	desc = "A colorful, sugary gumball."
	icon = 'icons/obj/lollipop.dmi'
	icon_state = "gumball"
	list_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/medicine/bicaridine = 2, /datum/reagent/medicine/kelotane = 2)	//Kek
	tastes = list("candy")
	foodtype = JUNKFOOD

/obj/item/reagent_containers/food/snacks/gumball/Initialize()
	. = ..()
	color = rgb(rand(0, 255), rand(0, 255), rand(0, 255))

/obj/item/reagent_containers/food/snacks/gumball/cyborg
	var/spamchecking = TRUE

/obj/item/reagent_containers/food/snacks/gumball/cyborg/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/spamcheck), 1200)

/obj/item/reagent_containers/food/snacks/gumball/cyborg/equipped(mob/living/user, slot)
	. = ..(user, slot)
	spamchecking = FALSE

/obj/item/reagent_containers/food/snacks/gumball/cyborg/proc/spamcheck()
	if(spamchecking)
		qdel(src)

/obj/item/reagent_containers/food/snacks/taco
	name = "taco"
	desc = "A traditional taco with meat, cheese, and lettuce."
	icon_state = "taco"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "F0D830"
	tastes = list("taco" = 4, "meat" = 2, "cheese" = 2, "lettuce" = 1)
	foodtype = MEAT | DAIRY | GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/taco/plain
	desc = "A traditional taco with meat and cheese, minus the rabbit food."
	icon_state = "taco_plain"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("taco" = 4, "meat" = 2, "cheese" = 2)
	foodtype = MEAT | DAIRY | GRAIN

/obj/item/reagent_containers/food/snacks/branrequests
	name = "Bran Requests Cereal"
	desc = "A dry cereal that satiates your requests for bran. Tastes uniquely like raisins and salt."
	icon_state = "bran_requests"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/sodiumchloride = 5)
	bonus_reagents = list(/datum/reagent/consumable/sodiumchloride = 10)
	tastes = list("bran" = 4, "raisins" = 3, "salt" = 1)
	foodtype = GRAIN | FRUIT | BREAKFAST

/obj/item/reagent_containers/food/snacks/butter
	name = "stick of butter"
	desc = "A stick of delicious, golden, fatty goodness."
	icon_state = "butter"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#FFD700"
	tastes = list("butter" = 1)
	foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/butter/examine(mob/user)
	. = ..()
	. += "<span class='notice'>If you had a rod you could make <b>butter on a stick</b>.</span>"

/obj/item/reagent_containers/food/snacks/butter/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = W
		if(!R.use(1))//borgs can still fail this if they have no metal
			to_chat(user, "<span class='warning'>You do not have enough metal to put [src] on a stick!</span>")
			return ..()
		to_chat(user, "<span class='notice'>You stick the rod into the stick of butter.</span>")
		var/obj/item/reagent_containers/food/snacks/butter/on_a_stick/new_item = new(usr.loc)
		var/replace = (user.get_inactive_held_item() == R)
		if(!R && replace)
			user.put_in_hands(new_item)
		qdel(src)
		return TRUE
	..()

/obj/item/reagent_containers/food/snacks/butter/on_a_stick //there's something so special about putting it on a stick.
	name = "butter on a stick"
	desc = "delicious, golden, fatty goodness on a stick."
	icon_state = "butteronastick"
	trash = /obj/item/stack/rods

/obj/item/reagent_containers/food/snacks/onionrings
	name = "onion rings"
	desc = "Onion slices coated in batter."
	icon_state = "onionrings"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	filling_color = "#C0C9A0"
	gender = PLURAL
	tastes = list("batter" = 3, "onion" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/pineappleslice
	name = "pineapple slice"
	desc = "A sliced piece of juicy pineapple."
	icon_state = "pineapple_slice"
	filling_color = "#F6CB0B"
	juice_results = list(/datum/reagent/consumable/pineapplejuice = 3)
	tastes = list("pineapple" = 1)
	foodtype = FRUIT | PINEAPPLE

/obj/item/reagent_containers/food/snacks/tinychocolate
	name = "chocolate"
	desc = "A tiny and sweet chocolate."
	icon_state = "tiny_chocolate"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/coco = 1)
	filling_color = "#A0522D"
	tastes = list("chocolate" = 1)
	foodtype = JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/canned
	name = "Canned Air"
	desc = "If you ever wondered where air came from..."
	list_reagents = list(/datum/reagent/oxygen = 6, /datum/reagent/nitrogen = 24)
	icon_state = "peachcan"
	in_container = TRUE
	reagent_flags = NONE
	spillable = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	volume = 30

/obj/item/reagent_containers/food/snacks/canned/proc/open_can(mob/user)
	to_chat(user, "<span class='notice'>You pull back the tab of \the [src].</span>")
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	reagents.flags |= OPENCONTAINER
	spillable = TRUE

/obj/item/reagent_containers/food/snacks/canned/attack_self(mob/user)
	if(!is_drainable())
		open_can(user)
		icon_state = "[icon_state]_open"
	return ..()

/obj/item/reagent_containers/food/snacks/canned/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'>[src]'s lid hasn't been opened!</span>")
		return 0
	return ..()

/obj/item/reagent_containers/food/snacks/canned/beans
	name = "tin of beans"
	desc = "Musical fruit in a slightly less musical container."
	icon_state = "beans"
	trash = /obj/item/trash/can/food/beans
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#B22222"
	tastes = list("beans" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/canned/peaches
	name = "canned peaches"
	desc = "Just a nice can of ripe peaches swimming in their own juices."
	icon_state = "peachcan"
	trash = /obj/item/trash/can/food/peaches
	list_reagents = list(/datum/reagent/consumable/peachjuice = 20, /datum/reagent/consumable/sugar = 8, /datum/reagent/consumable/nutriment = 2)
	filling_color = "#ffdf26"
	tastes = list("peaches" = 7, "tin" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/canned/peaches/maint
	name = "maintenance peaches"
	desc = "I have a mouth and I must eat."
	icon_state = "peachcanmaint"
	trash = /obj/item/trash/can/food/peaches/maint
	tastes = list("peaches" = 1, "tin" = 7)

/obj/item/reagent_containers/food/snacks/crab_rangoon
	name = "crab rangoon"
	desc = "Has many names, like crab puffs, cheese wontons, crab dumplings? Whatever you call them, they're a fabulous blast of cream cheesy crab."
	icon_state = "crabrangoon"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	filling_color = "#f2efdc"
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("cream cheese" = 4, "crab" = 3, "crispiness" = 2)
	foodtype = MEAT | DAIRY | GRAIN

/obj/item/reagent_containers/food/snacks/cornchips
	name = "boritos corn chips"
	desc = "Triangular corn chips. They do seem a bit bland but would probably go well with some kind of dipping sauce."
	icon_state = "boritos"
	trash = /obj/item/trash/boritos
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/cooking_oil = 2, /datum/reagent/consumable/sodiumchloride = 3)
	junkiness = 20
	filling_color = "#ECA735"
	tastes = list("fried corn" = 1)
	foodtype = JUNKFOOD | FRIED

/obj/item/reagent_containers/food/snacks/ration
	name = "Rationed Air"
	desc = "standerd issue ration"
	list_reagents = list(/datum/reagent/oxygen = 6, /datum/reagent/nitrogen = 24)
	icon_state = "peachcan"
	in_container = TRUE
	reagent_flags = NONE
	spillable = FALSE
	w_class = WEIGHT_CLASS_SMALL
	volume = 50

/obj/item/reagent_containers/food/snacks/ration/proc/open_ration(mob/user)
	to_chat(user, "<span class='notice'>You tear open \the [src].</span>")
	playsound(user.loc, 'sound/effects/rip3.ogg', 50)
	reagents.flags |= OPENCONTAINER
	spillable = TRUE
	desc += "\nIt's been opened."

/obj/item/reagent_containers/food/snacks/ration/attack_self(mob/user)
	if(!is_drainable())
		open_ration(user)
		icon_state = "[icon_state]_open"
	return ..()

/obj/item/reagent_containers/food/snacks/ration/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'> The [src] is sealed shut!</span>")
		return 0
	return ..()

/obj/item/reagent_containers/food/snacks/ration/vegan_chili
	name = "vegan chili with beans"
	desc = "A hearty and flavorful vegan chili made with beans. It's so delicious, you won't believe it's not meat!"
	icon_state = "beans"
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#B22222"
	tastes = list("beans" = 1, "off" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/vegan_crackers
	name = "vegetable 'crackers'"
	desc = "Delicious vegetable-based crackers that are the perfect crunchy and nutritious snack."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3)
	filling_color = "#9ED41B"
	tastes = list("cracker" = 1)
	foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/vegan_crackers/open_ration(mob/user)
	.=..()
	to_chat(user, "<span class='notice'>\the [src] makes a nice hiss.</span>")

/obj/item/reagent_containers/food/snacks/ration/cornbread
	name = "cornbread"
	desc = "Deliciously crumbly cornbread, a delightful blend of sweet and savory flavors."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#DDB63B"
	tastes = list("corn" = 1)
	foodtype = VEGETABLES | GRAIN

/obj/item/reagent_containers/food/snacks/ration/pizza_crackers
	name = "pepperoni pizza cheese filled crackers"
	desc = "Irresistible cheese-filled crackers with a savory pepperoni pizza flavor. A delicious and addictive snack."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#b82121"
	tastes = list("pizza" = 3, "pepperoni" = 1, "cheese" = 1)
	foodtype = MEAT | DAIRY | GRAIN | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/shredded_beef
	name = "shredded beef in barbecue sauce"
	desc = "Tender, juicy shredded beef coated in smoky barbecue sauce. A savory treat that satisfies your hunger."
	list_reagents = list(/datum/reagent/consumable/nutriment = 10)
	filling_color = "#b82121"
	tastes = list("beef" = 1)
	foodtype = MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/fruit_puree
	name = "apple, strawberry, and carrot fruit puree squeeze"
	desc = "A delightful blend of fresh apple, succulent strawberry, and nutritious carrot, all pureed into a convenient squeeze pouch. A burst of fruity goodness in every bite."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sugar = 3)
	filling_color = "#b82121"
	tastes = list("apple" = 1, "strawberry" = 1, "carrot" = 1)
	foodtype = VEGETABLES | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/jerky_wrap
	name = "jerky wraps"
	desc = "Thin slices of flavorful beef jerky, carefully wrapped to create a portable and protein-packed snack. Ideal for satisfying your hunger on the go."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#b82121"
	tastes = list("dry" = 1, "jerky" = 1, "beef" = 1)
	foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/cinnamon_bun
	name = "cinnamon bun"
	desc = "A delectable pastry swirled with cinnamon and drizzled with a sweet glaze. Warm and fluffy, this cinnamon bun is a delightful treat to enjoy with your favorite beverage."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3)
	filling_color = "#b82121"
	tastes = list("cinnamon" = 3, "airy" = 1, "sweet" = 1)
	foodtype = GRAIN | SUGAR

/obj/item/reagent_containers/food/snacks/ration/pork_spaghetti
	name = "spaghetti with pork and sauce"
	desc = "A hearty dish of spaghetti with tender pork and a savory sauce. A filling and delicious meal to satisfy your hunger."
	list_reagents = list(/datum/reagent/consumable/nutriment = 8)
	filling_color = "#b82121"
	tastes = list("pork" = 1, "spaghetti" = 1, "sauce" = 1)
	foodtype = MEAT | GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/toaster_pastry
	name = "chocolate chip toaster pastry"
	desc = "A delicious chocolate chip toaster pastry, perfect for a quick breakfast or a tasty snack. Indulge in the delightful blend of chocolate and pastry."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sugar = 5)
	filling_color = "#b82121"
	tastes = list("chocolate" = 1, "pastry" = 1, "sweet" = 1)
	foodtype = SUGAR | GRAIN | JUNKFOOD | BREAKFAST

/obj/item/reagent_containers/food/snacks/ration/bread_sticks
	name = "seasoned bread sticks"
	desc = "Crunchy and flavorful seasoned bread sticks, a delightful accompaniment to your meal or a satisfying snack on their own."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#b82121"
	tastes = list("bread" = 1, "seasoned" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/dried_raisins
	name = "dried raisins"
	desc = "Sweet and chewy dried raisins, a natural and healthy snack option. Packed with natural sugars and nutrients for a burst of energy."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sugar = 3)
	filling_color = "#b82121"
	tastes = list("raisins" = 1, "sweet" = 1)
	foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/fried_fish
	name = "fried fish chunks"
	desc = "Crispy and delicious fried fish chunks, perfect for seafood lovers. Satisfy your cravings with this delightful fried treat."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#b82121"
	tastes = list("fish" = 1, "fried" = 1)
	foodtype = FRIED

/obj/item/reagent_containers/food/snacks/ration/energy_bar
	name = "quik-energy bar, apple-cinnamon"
	desc = "A power-packed quik-energy bar infused with the flavors of apple and cinnamon. Ideal for a quick energy boost on the go."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#b82121"
	tastes = list("apple" = 1, "cinnamon" = 1)
	foodtype = FRUIT | GRAIN

/obj/item/reagent_containers/food/snacks/ration/tortilla
	name = "tortillas"
	desc = "Soft and pliable tortillas, a versatile staple that complements various fillings and flavors. A great choice for a quick and satisfying meal."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#b82121"
	tastes = list("tortilla" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/corn_kernels
	name = "toasted corn kernels, barbecue"
	desc = "Toasted corn kernels with a savory barbecue flavor. A crunchy and flavorful snack to enjoy anytime."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sugar = 3)
	filling_color = "#b82121"
	tastes = list("corn" = 1, "barbecue" = 1)
	foodtype = SUGAR | VEGETABLES | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/beef_sticks
	name = "teriyaki beef sticks"
	desc = "Savory teriyaki-flavored beef sticks, a protein-packed snack that satisfies your taste buds. Ideal for meat lovers."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#b82121"
	tastes = list("beef" = 1, "teriyaki" = 1)
	foodtype = MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/beef_strips
	name = "beef strips in tomato sauce"
	desc = "Tender beef strips cooked in a rich tomato sauce, creating a delightful and comforting combination. A hearty and delicious meal to enjoy."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#b82121"
	tastes = list("beef" = 1, "tomato" = 1)
	foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/chocolate_pudding
	name = "chocolate pudding"
	desc = "Creamy and decadent chocolate pudding, a delightful dessert to indulge your sweet tooth."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3)
	filling_color = "#b82121"
	tastes = list("chocolate" = 3, "pudding" = 1, "sweet" = 1)
	foodtype = SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ration/wheat_bread
	name = "white wheat snack bread"
	desc = "Soft and fluffy white wheat snack bread, a versatile snack or accompaniment to your meals. Enjoy the wholesome goodness of wheat."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	filling_color = "#b82121"
	tastes = list("wheat" = 1, "bread" = 1)
	foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/blackberry_preserves
	name = "blackberry preserves"
	desc = "Sweet and tangy blackberry preserves, perfect for spreading on toast or pairing with your favorite snacks."
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sugar = 3)
	filling_color = "#b82121"
	tastes = list("blackberry" = 1, "sweet" = 1)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/candy_rings
	name = "peppermint candy rings"
	desc = "Colorful and refreshing peppermint candy rings, a sweet and delightful treat that brings a burst of coolness to your taste buds."
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3)
	filling_color = "#b82121"
	tastes = list("peppermint" = 3, "sweet" = 1)
	foodtype = SUGAR | JUNKFOOD

//NEW RATIONS

/obj/item/reagent_containers/food/snacks/ration/chili_macaroni
    name = "chili macaroni"
    desc = "A comforting dish of macaroni combined with flavorful chili, providing a hearty and satisfying meal."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#994d00"
    tastes = list("chili" = 1, "macaroni" = 1)
    foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/ration/lemon_pound_cake
    name = "lemon pound cake"
    desc = "A zesty and moist lemon pound cake that delivers a burst of citrus flavor in every bite. A delightful dessert to enjoy."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffff99"
    tastes = list("lemon" = 1, "cake" = 1)
    foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/cherry_snackers
    name = "cherry snackers"
    desc = "Juicy and plump cherries, perfectly preserved and packed for a delightful and refreshing snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff0066"
    tastes = list("cherry" = 1)
    foodtype = FRUIT

//

/obj/item/reagent_containers/food/snacks/ration/chicken_wings_hot_sauce
    name = "chicken wings with hot sauce"
    desc = "Crispy and flavorful chicken wings tossed in a spicy hot sauce, delivering a bold and satisfying taste."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff3300"
    tastes = list("chicken" = 1, "hot sauce" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/garlic_mashed_potatoes
    name = "garlic mashed potatoes"
    desc = "Creamy mashed potatoes infused with aromatic garlic, creating a comforting and savory side dish."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#e6e600"
    tastes = list("garlic" = 1, "potatoes" = 1)
    foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/mint_chocolate_snack_cake
    name = "mint chocolate snack cake"
    desc = "A delectable snack cake featuring the perfect blend of refreshing mint and rich chocolate flavors."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#00cc66"
    tastes = list("mint" = 1, "chocolate" = 1, "cake" = 1)
    foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/strawberry_preserves
    name = "strawberry preserves"
    desc = "Sweet and tangy strawberry preserves, perfect for spreading on bread or adding a fruity twist to your meals."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff6666"
    tastes = list("strawberry" = 1)
    foodtype = FRUIT

//

/obj/item/reagent_containers/food/snacks/ration/fish_stew
    name = "fish stew"
    desc = "A hearty fish stew featuring a rich broth and tender pieces of fish, creating a flavorful and comforting meal."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#336699"
    tastes = list("fish" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/soup_crackers
    name = "soup crackers"
    desc = "Crunchy and satisfying crackers, perfect for dipping into a warm bowl of soup or enjoying on their own."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#663300"
    tastes = list("crackers" = 1)
    foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/griddled_mushrooms_chili
    name = "griddled mushrooms with chili"
    desc = "Savory mushrooms griddled to perfection and topped with a spicy chili sauce, offering a delightful burst of flavors."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#b82121"
    tastes = list("mushrooms" = 1, "chili" = 1)
    foodtype = VEGETABLES | MEAT

/obj/item/reagent_containers/food/snacks/ration/sour_gummy_worms
    name = "sour gummy worms"
    desc = "Tangy and chewy gummy worms coated in a sour sugar blend, providing a fun and flavorful snacking experience."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff9900"
    tastes = list("sour" = 1, "gummy" = 1)
    foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/lemon_pepper_chicken
    name = "lemon pepper chicken"
    desc = "Tender chicken seasoned with zesty lemon and fragrant pepper, offering a flavorful and satisfying dish."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffff66"
    tastes = list("lemon" = 1, "pepper" = 1, "chicken" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/jellied_eels
    name = "jellied eels"
    desc = "A classic dish of jellied eels, offering a unique combination of flavors and textures for a nostalgic treat."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#669999"
    tastes = list("jellied eels" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/pretzel_sticks_honey_mustard
    name = "pretzel sticks with honey mustard"
    desc = "Crunchy pretzel sticks served with a delectable honey mustard dipping sauce, creating a delightful snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#996633"
    tastes = list("pretzel" = 1, "honey mustard" = 1)
    foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/blue_raspberry_candies
    name = "blue raspberry candies"
    desc = "Sweet and vibrant blue raspberry-flavored candies, perfect for indulging your sweet tooth."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#3399ff"
    tastes = list("blue raspberry" = 1)
    foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/peanut_cranberry_mix
    name = "peanut cranberry mix"
    desc = "A satisfying mix of crunchy peanuts and tangy dried cranberries, offering a balanced and flavorful snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#cc3300"
    tastes = list("peanut" = 1, "cranberry" = 1)
    foodtype = FRUIT

//

/obj/item/reagent_containers/food/snacks/ration/sausage_peppers_onions
    name = "sausage with peppers and onions"
    desc = "Grilled sausage served with sautéed peppers and onions, creating a flavorful and satisfying dish."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#cc3300"
    tastes = list("sausage" = 1, "peppers" = 1, "onions" = 1)
    foodtype = MEAT | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/white_sandwich_bread
    name = "white sandwich bread"
    desc = "Soft and fluffy white bread, perfect for making sandwiches or enjoying as a quick and simple snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffffff"
    tastes = list("bread" = 1)
    foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/channeler_meat_candy
    name = "channeler meat candy"
    desc = "A traditional meat-candy from the Antechannel League on Kalixcis, offering an unusual and captivating flavor experience."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#9933ff"
    tastes = list("channeler meat" = 1, "candy" = 1)
    foodtype = MEAT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/baked_cheddarcheese_chips
    name = "baked cheddar cheese chips"
    desc = "Crispy and savory cheddar cheese chips, baked to perfection for a flavorful and satisfying snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffcc00"
    tastes = list("cheddar cheese" = 1, "chips" = 1)
    foodtype = DAIRY

/obj/item/reagent_containers/food/snacks/ration/chocolate_orange_snack_cake
    name = "chocolate orange snack cake"
    desc = "A delightful snack cake combining rich chocolate and zesty orange flavors for a mouthwatering treat."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff6600"
    tastes = list("chocolate" = 1, "orange" = 1, "cake" = 1)
    foodtype = SUGAR


//

/obj/item/reagent_containers/food/snacks/ration/dumplings_chili_sauce
    name = "dumplings with chili sauce"
    desc = "Delicious dumplings served with a flavorful chili sauce, providing a hearty and satisfying meal."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#b8711b"
    tastes = list("dumplings" = 1, "chili sauce" = 1)
    foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/ration/fried_potato_curls
    name = "fried potato curls"
    desc = "Crispy and golden potato curls, fried to perfection and seasoned for a delightful and savory snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffcc00"
    tastes = list("potato" = 1)
    foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/rationers_guild_chocolate_bar
    name = "Rationer's Guild chocolate bar"
    desc = "A chocolate bar made by the Rationer's Guild, offering a rich and indulgent treat for a quick pick-me-up."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#663300"
    tastes = list("chocolate" = 1)
    foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/pick_me_up_energy_gum
    name = "Pick-Me-Up energy gum"
    desc = "Energy-boosting gum that provides a quick and refreshing burst of vitality when you need it the most."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#00cc66"
    tastes = list("energy gum" = 1)
    foodtype = SUGAR

//

/obj/item/reagent_containers/food/snacks/ration/battered_fish_sticks
    name = "battered fish sticks"
    desc = "Crispy battered fish sticks, deep-fried to perfection and offering a delicious seafood snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#336699"
    tastes = list("fish" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/stewed_asparagus_butter
    name = "stewed asparagus with butter"
    desc = "Tender stewed asparagus served with a generous drizzle of melted butter, creating a delightful and savory side."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#99cc00"
    tastes = list("asparagus" = 1, "butter" = 1)
    foodtype = VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/fried_potato_curls
    name = "fried potato curls"
    desc = "Crispy and golden potato curls, fried to perfection and seasoned for a delightful and savory snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffcc00"
    tastes = list("potato" = 1)
    foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/chocolate_orange_cake
    name = "chocolate orange cake"
    desc = "A delectable cake combining the rich taste of chocolate with the citrusy notes of orange for a delightful treat."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff6600"
    tastes = list("chocolate" = 1, "orange" = 1, "cake" = 1)
    foodtype = SUGAR

/obj/item/reagent_containers/food/snacks/ration/apple_slices
    name = "apple slices"
    desc = "Fresh and crisp apple slices, perfect for a refreshing and healthy snack option."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff3300"
    tastes = list("apple" = 1)
    foodtype = FRUIT


//

/obj/item/reagent_containers/food/snacks/ration/assorted_salted_offal
    name = "assorted salted offal"
    desc = "A mix of various salted offal, providing a unique and flavorful snack for those with adventurous tastes."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#cc3300"
    tastes = list("assorted offal" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/broth_tuna_rice
    name = "broth with tuna and rice"
    desc = "A warm and comforting broth with tender tuna and rice, offering a nourishing and satisfying meal."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#669999"
    tastes = list("broth" = 1, "tuna" = 1, "rice" = 1)
    foodtype = MEAT | GRAIN

/obj/item/reagent_containers/food/snacks/ration/trail_crackers
    name = "trail crackers"
    desc = "Nutritious and energy-packed crackers, perfect for on-the-go snacking during outdoor adventures."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffcc00"
    tastes = list("crackers" = 1)
    foodtype = GRAIN | FRUIT

/obj/item/reagent_containers/food/snacks/ration/tropical_energy_bar
    name = "tropical energy bar"
    desc = "An energy-boosting bar packed with tropical flavors and essential nutrients for sustained vitality."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff9900"
    tastes = list("tropical" = 1, "energy bar" = 1)
    foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/candied_pineapple_chunks
    name = "candied pineapple chunks"
    desc = "Sweet and chewy candied pineapple chunks, offering a burst of tropical flavor in every bite."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff6600"
    tastes = list("candied pineapple" = 1)
    foodtype = SUGAR | FRUIT

//

/obj/item/reagent_containers/food/snacks/ration/maple_pork_sausage_patty
    name = "maple pork sausage patty"
    desc = "Juicy pork sausage patty infused with the sweetness of maple, offering a hearty and flavorful snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#b8711b"
    tastes = list("maple" = 1, "pork sausage" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/hash_brown_bacon
    name = "hash brown with bacon"
    desc = "Crispy hash brown paired with savory bacon, creating a satisfying and indulgent snack option."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffcc00"
    tastes = list("hash brown" = 1, "bacon" = 1)
    foodtype = GRAIN | MEAT

/obj/item/reagent_containers/food/snacks/ration/granola_milk_blueberries
    name = "granola with milk and blueberries"
    desc = "Nutrient-rich granola served with creamy milk and plump blueberries, providing a wholesome and delicious snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#6699ff"
    tastes = list("granola" = 1, "milk" = 1, "blueberries" = 1)
    foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/ration/maple_muffin
    name = "maple muffin"
    desc = "A delightful muffin infused with the rich flavor of maple, offering a sweet and satisfying treat."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#b8711b"
    tastes = list("maple" = 1, "muffin" = 1)
    foodtype = SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/ration/smoked_almonds
    name = "smoked almonds"
    desc = "Savory smoked almonds, offering a flavorful and protein-packed snack option."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#663300"
    tastes = list("smoked almonds" = 1)
    foodtype = FRUIT

//

/obj/item/reagent_containers/food/snacks/ration/jalapeno_pepper_jack_beef_patty
    name = "jalapeno pepper jack beef patty"
    desc = "Spicy jalapeno and pepper jack-infused beef patty, offering a bold and flavorful snack option."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff9900"
    tastes = list("jalapeno" = 1, "pepper jack" = 1, "beef patty" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/au_gratin_potatoes
    name = "au gratin potatoes"
    desc = "Creamy au gratin potatoes topped with a golden cheesy crust, providing a comforting and satisfying side dish."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffcc00"
    tastes = list("au gratin potatoes" = 1)
    foodtype = GRAIN | DAIRY | VEGETABLES

/obj/item/reagent_containers/food/snacks/ration/chocolate_chunk_oatmeal_cookie
    name = "chocolate chunk oatmeal cookie"
    desc = "A scrumptious oatmeal cookie studded with rich chocolate chunks for a delightful and indulgent treat."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#663300"
    tastes = list("chocolate" = 1, "oatmeal cookie" = 1)
    foodtype = SUGAR | GRAIN

/obj/item/reagent_containers/food/snacks/ration/jerky_wraps
    name = "jerky wraps"
    desc = "Savory jerky wrapped around a flavorful filling, offering a protein-packed and convenient snack option."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#cc3300"
    tastes = list("jerky" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/peanut_candies
    name = "peanut candies"
    desc = "Sweet and nutty peanut candies, providing a delightful and energy-boosting snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff9900"
    tastes = list("peanut" = 1)
    foodtype = SUGAR | FRUIT


//

/obj/item/reagent_containers/food/snacks/ration/beef_goulash
    name = "beef goulash"
    desc = "A hearty and flavorful beef goulash, combining tender pieces of beef with savory spices for a satisfying meal."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#b82121"
    tastes = list("beef" = 1)
    foodtype = MEAT

/obj/item/reagent_containers/food/snacks/ration/applesauce_carb_enhanced
    name = "carb-enhanced applesauce"
    desc = "Applesauce enriched with carbohydrates, providing a quick and energy-boosting snack option."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff9900"
    tastes = list("applesauce" = 1)
    foodtype = FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/ration/strawberry_preserves
    name = "strawberry preserves"
    desc = "Sweet and luscious strawberry preserves, perfect for spreading on bread or enjoying as a tasty topping."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff3300"
    tastes = list("strawberry" = 1)
    foodtype = SUGAR | FRUIT

/obj/item/reagent_containers/food/snacks/ration/white_bread_mini_loaf
    name = "mini loaf of white bread"
    desc = "A small loaf of soft and fluffy white bread, perfect for making sandwiches or enjoying as a simple snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffffff"
    tastes = list("bread" = 1)
    foodtype = GRAIN

/obj/item/reagent_containers/food/snacks/ration/patriotic_sugar_cookies
    name = "patriotic sugar cookies"
    desc = "Colorful sugar cookies with patriotic designs, providing a festive and sweet treat for special occasions."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ffcc00"
    tastes = list("sugar cookies" = 1)
    foodtype = SUGAR


//

/obj/item/reagent_containers/food/snacks/ration/pepperoni_pizza_slice
    name = "pepperoni pizza slice"
    desc = "A classic pepperoni pizza slice topped with melted cheese and savory pepperoni, offering a delicious snack."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#cc3300"
    tastes = list("pepperoni" = 1, "pizza" = 1)
    foodtype = GRAIN | DAIRY | MEAT

/obj/item/reagent_containers/food/snacks/ration/apples_in_spiced_sauce
    name = "apples in spiced sauce"
    desc = "Tender apple slices coated in a spiced sauce, creating a flavorful and comforting snack option."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#ff3300"
    tastes = list("apples" = 1, "spiced sauce" = 1)
    foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/ration/oatmeal_cookie
    name = "oatmeal cookie"
    desc = "A delicious oatmeal cookie, offering a wholesome and satisfying treat for any time of day."
    list_reagents = list(/datum/reagent/consumable/nutriment = 5)
    filling_color = "#663300"
    tastes = list("oatmeal cookie" = 1)
    foodtype = SUGAR | GRAIN

