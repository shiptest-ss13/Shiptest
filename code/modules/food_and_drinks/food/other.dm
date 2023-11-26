
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
	addtimer(CALLBACK(src, PROC_REF(spamcheck)), 1200)

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
	addtimer(CALLBACK(src, PROC_REF(spamcheck)), 1200)

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
	icon = 'icons/obj/food/canned.dmi'
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

/obj/item/reagent_containers/food/snacks/canned/tomatoes
	name = "canned San Marzano tomatoes"
	desc = "A can of premium San Marzano tomatoes, from the hills of Southern Italy."
	icon_state = "tomatoescan"
	trash = /obj/item/trash/can/food/tomatoes
	list_reagents = list(/datum/reagent/consumable/tomatojuice = 20, /datum/reagent/consumable/sodiumchloride = 2)
	tastes = list("tomato" = 7, "tin" = 1)
	foodtype = VEGETABLES //fuck you, real life!

/obj/item/reagent_containers/food/snacks/canned/pine_nuts
	name = "canned pine nuts"
	desc = "A small can of pine nuts. Can be eaten on their own, if you're into that."
	icon_state = "pinenutscan"
	trash = /obj/item/trash/can/food/pine_nuts
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("pine nuts" = 1)
	foodtype = NUTS
	w_class = WEIGHT_CLASS_SMALL

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

//Curd cheese, a general term which I will now proceed to stretch as thin as the toppings on a supermarket sandwich:
//I'll use it as a substitute for ricotta, cottage cheese and quark, as well as any other non-aged, soft grainy cheese
/obj/item/reagent_containers/food/snacks/curd_cheese
	name = "curd cheese"
	desc = "Known by many names throughout human cuisine, curd cheese is useful for a wide variety of dishes."
	icon_state = "curd_cheese"
	cooked_type = /obj/item/reagent_containers/food/snacks/cheese_curds
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 3, /datum/reagent/consumable/cream = 1)
	tastes = list("cream" = 1, "cheese" = 1)
	foodtype = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/cheese_curds
	name = "cheese curds"
	desc = "Not to be mistaken for curd cheese. Tasty deep fried."
	icon_state = "cheese_curds"
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 3)
	tastes = list("cheese" = 1)
	foodtype = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	dried_type = /obj/item/reagent_containers/food/snacks/firm_cheese

/obj/item/reagent_containers/food/snacks/firm_cheese
	name = "firm cheese"
	desc = "Firm aged cheese, similar in texture to firm tofu. Due to its lack of moisture it's particularly useful for cooking with, as it doesn't melt easily."
	icon_state = "firm_cheese"
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 3)
	tastes = list("aged cheese" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	slice_path = /obj/item/reagent_containers/food/snacks/firm_cheese_slice
	slices_num = 3

/obj/item/reagent_containers/food/snacks/firm_cheese_slice
	name = "firm cheese slice"
	desc = "A slice of firm cheese. Perfect for grilling or making into delicious pesto."
	icon_state = "firm_cheese_slice"
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 3)
	tastes = list("aged cheese" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	cooked_type = /obj/item/reagent_containers/food/snacks/grilled_cheese

/obj/item/reagent_containers/food/snacks/mozzarella
	name = "mozzarella cheese"
	desc = "Delicious, creamy, and cheesy, all in one simple package."
	icon_state = "mozzarella"
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 3)
	tastes = list("mozzarella" = 1)
	foodtype = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/griddle_toast
	name = "griddle toast"
	desc = "Thick cut bread, griddled to perfection."
	icon_state = "griddle_toast"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("toast" = 1)
	foodtype = GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/pesto
	name = "pesto"
	desc = "A combination of firm cheese, salt, herbs, garlic, oil, and pine nuts. Frequently used as a sauce for pasta or pizza, or eaten on bread."
	icon_state = "pesto"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("pesto" = 1)
	foodtype = VEGETABLES | DAIRY | NUTS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/tomato_sauce
	name = "tomato sauce"
	desc = "Tomato sauce, perfect for pizza or pasta. Mamma mia!"
	icon_state = "tomato_sauce"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("tomato" = 1, "herbs" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/bechamel_sauce
	name = "béchamel sauce"
	desc = "A classic white sauce common to several European cultures."
	icon_state = "bechamel_sauce"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("cream" = 1)
	foodtype = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/roasted_bell_pepper
	name = "roasted bell pepper"
	desc = "A blackened, blistered bell pepper. Great for making sauces."
	icon_state = "roasted_bell_pepper"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 5, /datum/reagent/consumable/char = 1)
	tastes = list("bell pepper" = 1, "char" = 1)
	foodtype = VEGETABLES

//DONK DINNER: THE INNOVATIVE WAY TO GET YOUR DAILY RECOMMENDED ALLOWANCE OF SALT... AND THEN SOME!
/obj/item/reagent_containers/food/snacks/ready_donk
	name = "\improper Ready-Donk: Bachelor Chow"
	desc = "A quick Donk-dinner: now with flavour!"
	icon_state = "ready_donk"
	trash = /obj/item/trash/ready_donk
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	cooked_type = /obj/item/reagent_containers/food/snacks/ready_donk/warm
	tastes = list("food?" = 2, "laziness" = 1)
	foodtype = MEAT | JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/ready_donk/examine_more(mob/user)
	var/list/msg = list(span_notice("<i>You browse the back of the box...</i>"))
	msg += "\t[span_info("Ready-Donk: a product of Donk Co.")]"
	msg += "\t[span_info("Heating instructions: open box and pierce film, heat in microwave on high for 2 minutes. Allow to stand for 60 seconds prior to eating. Product will be hot.")]"
	msg += "\t[span_info("Per 200g serving contains: 8g Sodium; 25g Fat, of which 22g are saturated; 2g Sugar.")]"
	return msg

/obj/item/reagent_containers/food/snacks/ready_donk/warm
	name = "warm Ready-Donk: Bachelor Chow"
	desc = "A quick Donk-dinner, now with flavour! And it's even hot!"
	icon = 'icons/obj/food/donk.dmi'
	icon_state = "ready_donk_warm"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/medicine/omnizine = 3)
	cooked_type = null
	tastes = list("food?" = 2, "laziness" = 1)

/obj/item/reagent_containers/food/snacks/ready_donk/mac_n_cheese
	name = "\improper Ready-Donk: Donk-a-Roni"
	desc = "Neon-orange mac n' cheese in seconds!"
	cooked_type = /obj/item/reagent_containers/food/snacks/ready_donk/warm/mac_n_cheese
	tastes = list("cheesy pasta" = 2, "laziness" = 1)
	foodtype = GRAIN | DAIRY | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ready_donk/warm/mac_n_cheese
	name = "warm Ready-Donk: Donk-a-Roni"
	desc = "Neon-orange mac n' cheese, ready to eat!"
	icon_state = "ready_donk_warm_mac"
	tastes = list("cheesy pasta" = 2, "laziness" = 1)
	foodtype = GRAIN | DAIRY | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ready_donk/donkhiladas
	name = "\improper Ready-Donk: Donkhiladas"
	desc = "Donk Co's signature Donkhiladas with Donk sauce, for an 'authentic' taste of Mexico."
	cooked_type = /obj/item/reagent_containers/food/snacks/ready_donk/warm/donkhiladas
	tastes = list("enchiladas" = 2, "laziness" = 1)
	foodtype = GRAIN | DAIRY | MEAT | VEGETABLES | JUNKFOOD

/obj/item/reagent_containers/food/snacks/ready_donk/warm/donkhiladas
	name = "warm Ready-Donk: Donkhiladas"
	desc = "Donk Co's signature Donkhiladas with Donk sauce, served as hot as the Mexican sun."
	icon_state = "ready_donk_warm_mex"
	tastes = list("enchiladas" = 2, "laziness" = 1)
	foodtype = GRAIN | DAIRY | JUNKFOOD

/obj/item/reagent_containers/food/snacks/herby_cheese
	name = "herby cheese"
	desc = "As a staple of spacer cuisine, cheese is often augmented with various flavours to keep variety in their diet whilst traveling without reliable access to refrigeration. \
		Herbs are one such addition, and are particularly beloved."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "herby_cheese"
	list_reagents = list(/datum/reagent/consumable/cooking_oil = 6)
	tastes = list("cheese" = 1, "herbs" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/grilled_cheese
	name = "grilled cheese"
	desc = "A staple sandwich, the classic grilled cheese consists simply of griddled bread and cheese. Anything else, *and it's a melt*."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "grilled_cheese"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("cheese" = 1, "char" = 1)
	foodtype = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mothic_salad
	name = "basic salad"
	desc = "A basic salad of cabbage, red onion and tomato. Can serve as a perfect base for a million different salads."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_salad"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("salad" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/toasted_seeds
	name = "toasted seeds"
	desc = "While they're far from filling, toasted seeds are a popular snack amongst travelers. \
		Salt, sugar, or even some more exotic flavours may be added for some extra pep."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "toasted_seeds"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("seeds" = 1)
	foodtype = GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/engine_fodder
	name = "comet trail"
	desc = "A common snack for engineers on modern military vessels, made of seeds, nuts, chocolate, popcorn, and potato chips- \
		designed to be dense with calories and easy to snack on when an extra boost is needed."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "engine_fodder"
	list_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sodiumchloride = 2,
	)
	tastes = list("seeds" = 1, "nuts" = 1, "chocolate" = 1, "salt" = 1, "popcorn" = 1, "potato" = 1)
	foodtype = GRAIN | NUTS | VEGETABLES | SUGAR
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mothic_pizza_dough
	name = "Solar pizza dough"
	desc = "A strong, glutenous dough, made with cornmeal and flour, designed to hold up to cheese and sauce."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_pizza_dough"
	list_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("raw flour" = 1)
	foodtype = GRAIN
	w_class = WEIGHT_CLASS_SMALL

//Entrees: categorising food that is 90% cheese and salad is not easy
/obj/item/reagent_containers/food/snacks/squeaking_stir_fry
	name = "squeaking stir fry"
	desc = "A Solarian classic made with cheese curds and tofu (amongst other things). \
		It gets its name from the distinctive squeak of the proteins."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "squeaking_stir_fry"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("cheese" = 1, "tofu" = 1, "veggies" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/sweet_chili_cabbage_wrap
	name = "sweet chili cabbage wrap"
	desc = "Grilled cheese and salad in a cabbage wrap, topped with delicious sweet chili sauce."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "sweet_chili_cabbage_wrap"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("cheese" = 1, "salad" = 1, "sweet chili" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/loaded_curds
	name = "chili poutine"
	desc = "What's better than cheese curds? Deep fried cheese curds! What's better than deep fried cheese curds? \
		Deep fried cheese curds with chili (and more cheese) on top! And what's better than that? Putting it on fries!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "loaded_curds"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("cheese" = 1, "oil" = 1, "chili" = 1, "fries" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/baked_cheese
	name = "baked cheese wheel"
	desc = "A baked cheese wheel, melty and delicious."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nutriment = 5,
	)
	tastes = list("cheese" = 1)
	foodtype = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/baked_cheese_platter
	name = "oven-baked cheese"
	desc = "A baked cheese wheel: a Solarian favourite for sharing. Usually served with crispy bread slices for dipping, \
		because the only thing better than good cheese is good cheese on bread. A popular fixture at SolGov office parties."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese_platter"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("cheese" = 1, "bread" = 1)
	foodtype = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL

//Baked Green Lasagna at the Whistlestop Cafe
/obj/item/reagent_containers/food/snacks/raw_green_lasagne
	name = "raw green lasagne al forno"
	desc = "A fine lasagne made with pesto and a herby white sauce, ready to bake. Good for multiple servings."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_green_lasagne"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtype = VEGETABLES | GRAIN | NUTS | RAW
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = /obj/item/reagent_containers/food/snacks/green_lasagne

/obj/item/reagent_containers/food/snacks/green_lasagne
	name = "green lasagne al forno"
	desc = "A fine lasagne made with pesto and a herby white sauce. Good for multiple servings."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 24,
		/datum/reagent/consumable/nutriment/vitamin = 18,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtype = VEGETABLES | GRAIN | NUTS
	w_class = WEIGHT_CLASS_NORMAL
	slice_path = /obj/item/reagent_containers/food/snacks/green_lasagne_slice
	slices_num = 6

/obj/item/reagent_containers/food/snacks/green_lasagne_slice
	name = "green lasagne al forno slice"
	desc = "A slice of herby, pesto-y lasagne."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne_slice"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("cheese" = 1, "pesto" = 1, "pasta" = 1)
	foodtype = VEGETABLES | GRAIN | NUTS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/raw_baked_rice
	name = "big rice pan"
	desc = "A big pan of layered potatoes topped with rice and vegetable stock, ready to be baked into a delicious sharing meal."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_baked_rice"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 4,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtype = VEGETABLES | GRAIN | RAW
	w_class = WEIGHT_CLASS_NORMAL
	cooked_type = /obj/item/reagent_containers/food/snacks/big_baked_rice

/obj/item/reagent_containers/food/snacks/big_baked_rice
	name = "big baked rice"
	desc = "A Solarian favourite, baked rice can be filled with a variety of vegetable fillings to make a delicious meal to share. \
		Potatoes are also often layered on the bottom of the cooking vessel to create a flavourful crust which is hotly contested amongst diners. Originates from the flotillas formed in Polynesia after the Night of Fire."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "big_baked_rice"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 18,
		/datum/reagent/consumable/nutriment/vitamin = 42,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtype = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_NORMAL
	slice_path = /obj/item/reagent_containers/food/snacks/lil_baked_rice
	slices_num = 6

/obj/item/reagent_containers/food/snacks/lil_baked_rice
	name = "lil baked rice"
	desc = "A single portion of baked rice, perfect as a side dish, or even as a full meal."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "lil_baked_rice"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 3,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("rice" = 1, "potato" = 1, "veggies" = 1)
	foodtype = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/oven_baked_corn
	name = "oven-baked corn"
	desc = "A cob of corn, baked in the roasting heat of an oven until it blisters and blackens. \
		Beloved as a quick yet flavourful and filling component for dishes on the Fleet."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "oven_baked_corn"
	list_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "char" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/buttered_baked_corn
	name = "buttered baked corn"
	desc = "What's better than baked corn? Baked corn with butter!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "buttered_baked_corn"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "char" = 1)
	foodtype = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/fiesta_corn_skillet
	name = "fiesta corn skillet"
	desc = "Sweet, spicy, saucy, and all kinds of corny."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fiesta_corn_skillet"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("corn" = 1, "chili" = 1, "char" = 1)
	foodtype = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/raw_ratatouille
	name = "raw ratatouille" //rawtatouille?
	desc = "Sliced vegetables with a roasted pepper sauce. Delicious, for such a simple food."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_ratatouille"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("veggies" = 1, "roasted peppers" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	cooked_type = /obj/item/reagent_containers/food/snacks/ratatouille

/obj/item/reagent_containers/food/snacks/ratatouille
	name = "ratatouille"
	desc = "The perfect dish to save your restaurant from a vindictive food critic. Bonus points if you've got a rat in your hat."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "ratatouille"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("veggies" = 1, "roasted peppers" = 1, "char" = 1)
	foodtype = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mozzarella_sticks
	name = "mozzarella sticks"
	desc = "Little sticks of mozzarella, breaded and fried."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mozzarella_sticks"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cooking_oil = 6,
	)
	tastes = list("creamy cheese" = 1, "breading" = 1, "oil" = 1)
	foodtype = DAIRY | GRAIN | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/raw_stuffed_peppers
	name = "raw stuffed pepper"
	desc = "A pepper with the top removed and a herby cheese and onion mix stuffed inside. Probably shouldn't be eaten raw."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_stuffed_pepper"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cooking_oil = 6,
	)
	tastes = list("creamy cheese" = 1, "herbs" = 1, "onion" = 1, "bell pepper" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	cooked_type = /obj/item/reagent_containers/food/snacks/stuffed_peppers

/obj/item/reagent_containers/food/snacks/stuffed_peppers
	name = "baked stuffed pepper"
	desc = "A soft yet still crisp bell pepper, with a wonderful melty cheesy interior."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "stuffed_pepper"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cooking_oil = 8,
	)
	tastes = list("creamy cheese" = 1, "herbs" = 1, "onion" = 1, "bell pepper" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/fueljacks_lunch
	name = "Astrengi's lunch"
	desc = "A dish made from fried vegetables, popular amongst astrengis - the brave technicans who repair damaged hulls from asteroid impacts or ship-to-ship weapons whilst in transit. \
		Given the constant need for repair during protracted conflict, and the limited windows in which a lull in the fields or fire provides time for patching, \
		they'll often take packed meals to save on trips to the mess, which they heat using their welding torches."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fueljacks_lunch"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/cooking_oil = 8,
	)
	tastes = list("cabbage" = 1, "potato" = 1, "onion" = 1, "chili" = 1, "cheese" = 1)
	foodtype = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/reagent_containers/food/snacks/mac_balls
	name = "macheronirölen"
	desc = "Fried balls of macaroni cheese dipped in corn batter, served with tomato sauce. \
		A popular snack across the galaxy, and especially on ex-Syndicate-majority Inteq vessels - where they tend to use Ready-Donk as the base, as a holdover from their ICW days."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mac_balls"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/cooking_oil = 10,
	)
	tastes = list("pasta" = 1, "cornbread" = 1, "cheese" = 1)
	foodtype = DAIRY | VEGETABLES | FRIED | GRAIN
	w_class = WEIGHT_CLASS_SMALL

//Sweets
/obj/item/reagent_containers/food/snacks/moth_cheese_cakes
	name = "\improper ælorölen" //ælo = cheese, rölen = balls
	desc = "Ælorölen (cheese balls) are a traditional Solar dessert, made of soft cheese, powdered sugar and flour, rolled into balls, battered and then deep fried. They're often served with either chocolate sauce or honey, or sometimes both!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "moth_cheese_cakes"
	list_reagents = list(
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/sugar = 12,
	)
	tastes = list("cheesecake" = 1, "chocolate" = 1, "honey" = 1)
	foodtype = SUGAR | FRIED | DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL

//misc food
/obj/item/reagent_containers/food/snacks/bubblegum/wake_up
	name = "wake-up gum"
	desc = "A rubbery strip of gum. It's stamped with the emblem of the Solar Fleet."
	list_reagents = list(
		/datum/reagent/consumable/sugar = 13,
		/datum/reagent/drug/methamphetamine = 2,
	)
	tastes = list("herbs" = 1)
	color = "#567D46"

/obj/item/storage/box/gum/wake_up
	name = "\improper Activin 12 Hour medicated gum packet"
	desc = "Stay awake during long shifts in the maintenance tunnels with Activin! The approval seal of the Solar Fleet \
		is emblazoned on the packaging, alongside a litany of health and safety disclaimers in both Solar and Galactic Common."
	icon_state = "bubblegum_wake_up"
	custom_premium_price = 50 * 1.5

/obj/item/storage/box/gum/wake_up/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You read some of the health and safety information...</i>")
	. += "\t[span_info("For the relief of tiredness and drowsiness while working.")]"
	. += "\t[span_info("Do not chew more than one strip every 12 hours. Do not use as a complete substitute for sleep.")]"
	. += "\t[span_info("Do not give to children under 16. Do not exceed the maximum dosage. Do not ingest. Do not take for more than 3 days consecutively. Do not take in conjunction with other medication. May cause adverse reactions in patients with pre-existing heart conditions.")]"
	. += "\t[span_info("Side effects of Activin use may include twitchy antennae, overactive wings, loss of keratin sheen, loss of setae coverage, arrythmia, blurred vision, and euphoria. Cease taking the medication if side effects occur.")]"
	. += "\t[span_info("Repeated use may cause addiction.")]"
	. += "\t[span_info("If the maximum dosage is exceeded, inform a member of your assigned vessel's medical staff immediately. Do not induce vomiting.")]"
	. += "\t[span_info("Ingredients: each strip contains 500mg of Activin (dextro-methamphetamine). Other ingredients include Green Dye 450 (Verdant Meadow) and artificial herb flavouring.")]"
	. += "\t[span_info("Storage: keep in a cool dry place. Do not use after the use-by date: 32/4/350.")]"
	return .

/obj/item/storage/box/gum/wake_up/PopulateContents()
	for(var/i in 1 to 4)
		new/obj/item/reagent_containers/food/snacks/bubblegum/wake_up(src)

/obj/item/reagent_containers/food/snacks/spacers_sidekick
	name = "\improper Spacer's Sidekick mints"
	desc = "Spacer's Sidekick: Breathe easy with a friend at your side!"
	icon_state = "spacers_sidekick"
	trash = /obj/item/trash/spacers_sidekick
	list_reagents = list(
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/menthol = 1,
		/datum/reagent/medicine/salbutamol = 1,
	)
	tastes = list("strong mint" = 1)
	junkiness = 15
	foodtype = JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL
