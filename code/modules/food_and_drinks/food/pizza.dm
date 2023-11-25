
/////////////////////////////////////////////////PIZZA////////////////////////////////////////

/obj/item/reagent_containers/food/snacks/pizza
	icon = 'icons/obj/food/pizza.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	slices_num = 6
	volume = 80
	list_reagents = list(/datum/reagent/consumable/nutriment = 30, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES

/obj/item/reagent_containers/food/snacks/pizzaslice
	icon = 'icons/obj/food/pizza.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	foodtype = GRAIN | DAIRY | VEGETABLES

/obj/item/reagent_containers/food/snacks/pizza/margherita
	name = "pizza margherita"
	desc = "The most cheezy pizza in galaxy."
	icon_state = "pizzamargherita"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/margherita
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/margherita/robo/Initialize()
	bonus_reagents += list(/datum/reagent/nanomachines = 70)
	return ..()

/obj/item/reagent_containers/food/snacks/pizzaslice/margherita
	name = "margherita slice"
	desc = "A slice of the most cheezy pizza in galaxy."
	icon_state = "pizzamargheritaslice"
	filling_color = "#FFA500"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/meat
	name = "meatpizza"
	desc = "Greasy pizza with delicious meat."
	icon_state = "meatpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/meat
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 8)
	list_reagents = list(/datum/reagent/consumable/nutriment = 30, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 8)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES| DAIRY | MEAT

/obj/item/reagent_containers/food/snacks/pizzaslice/meat
	name = "meatpizza slice"
	desc = "A nutritious slice of meatpizza."
	icon_state = "meatpizzaslice"
	filling_color = "#A52A2A"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT

/obj/item/reagent_containers/food/snacks/pizza/mushroom
	name = "mushroom pizza"
	desc = "Very special pizza."
	icon_state = "mushroompizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/mushroom
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 30, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizzaslice/mushroom
	name = "mushroom pizza slice"
	desc = "Maybe it is the last slice of pizza in your life."
	icon_state = "mushroompizzaslice"
	filling_color = "#FFE4C4"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "mushroom" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/vegetable
	name = "vegetable pizza"
	desc = "No one of Tomatos Sapiens were harmed during making this pizza."
	icon_state = "vegetablepizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/vegetable
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/medicine/oculine = 12, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizzaslice/vegetable
	name = "vegetable pizza slice"
	desc = "A slice of the most green pizza of all pizzas not containing green ingredients."
	icon_state = "vegetablepizzaslice"
	filling_color = "#FFA500"
	tastes = list("crust" = 1, "tomato" = 2, "cheese" = 1, "carrot" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/donkpocket
	name = "donkpocket pizza"
	desc = "Who thought this would be a good idea?"
	icon_state = "donkpocketpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/donkpocket
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/nutriment/vitamin = 5)
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/medicine/omnizine = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "laziness" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD

/obj/item/reagent_containers/food/snacks/pizzaslice/donkpocket
	name = "donkpocket pizza slice"
	desc = "Smells like donkpocket."
	icon_state = "donkpocketpizzaslice"
	filling_color = "#FFA500"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1, "laziness" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD

/obj/item/reagent_containers/food/snacks/pizza/dank
	name = "dank pizza"
	desc = "The hippie's pizza of choice."
	icon_state = "dankpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/dank
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 6)
	list_reagents = list(/datum/reagent/consumable/nutriment = 25, /datum/reagent/consumable/doctor_delight = 5, /datum/reagent/consumable/tomatojuice = 6, /datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizzaslice/dank
	name = "dank pizza slice"
	desc = "So good, man..."
	icon_state = "dankpizzaslice"
	filling_color = "#2E8B57"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/sassysage
	name = "sassysage pizza"
	desc = "You can really smell the sassiness."
	icon_state = "sassysagepizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/sassysage
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizzaslice/sassysage
	name = "sassysage pizza slice"
	desc = "Deliciously sassy."
	icon_state = "sassysagepizzaslice"
	filling_color = "#FF4500"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/pizza/pineapple
	name = "\improper Hawaiian pizza"
	desc = "The pizza equivalent of Einstein's riddle."
	icon_state = "pineapplepizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/pineapple
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE

/obj/item/reagent_containers/food/snacks/pizzaslice/pineapple
	name = "\improper Hawaiian pizza slice"
	desc = "A slice of delicious controversy."
	icon_state = "pineapplepizzaslice"
	filling_color = "#FF4500"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pineapple" = 2, "ham" = 2)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE

/obj/item/reagent_containers/food/snacks/pizza/arnold
	name = "\improper Arnold pizza"
	desc = "Hello, you've reached Arnold's pizza shop. I'm not here now, I'm out killing pepperoni."
	icon_state = "arnoldpizza"
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/arnold
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 30, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/iron = 10, /datum/reagent/medicine/omnizine = 30)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pepperoni" = 2, "9 millimeter bullets" = 2)

/obj/item/reagent_containers/food/snacks/proc/try_break_off(mob/living/M, mob/living/user) //maybe i give you a pizza maybe i break off your arm
	var/obj/item/bodypart/l_arm = user.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/r_arm = user.get_bodypart(BODY_ZONE_R_ARM)
	if(prob(50) && iscarbon(user) && M == user && (r_arm || l_arm))
		user.visible_message("<span class='warning'>\The [src] breaks off [user]'s arm!!</span>", "<span class='warning'>\The [src] breaks off your arm!</span>")
		if(l_arm)
			l_arm.dismember()
		else
			r_arm.dismember()
		playsound(user, "desceration" ,50, TRUE, -1)

/obj/item/reagent_containers/food/snacks/proc/i_kill_you(obj/item/I, mob/user)
	if(istype(I, /obj/item/reagent_containers/food/snacks/pineappleslice))
		to_chat(user, "<font color='red' size='7'>If you want something crazy like pineapple, I kill you.</font>")
		user.gib() //if you want something crazy like pineapple, i kill you

/obj/item/reagent_containers/food/snacks/pizza/arnold/attack(mob/living/M, mob/living/user)
	. = ..()
	try_break_off(M, user)

/obj/item/reagent_containers/food/snacks/pizza/arnold/attackby(obj/item/I, mob/user)
	i_kill_you(I, user)
	. = ..()


/obj/item/reagent_containers/food/snacks/pizzaslice/arnold
	name = "\improper Arnold pizza slice"
	desc = "I come over, maybe I give you a pizza, maybe I break off your arm."
	icon_state = "arnoldpizzaslice"
	filling_color = "#A52A2A"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "pepperoni" = 2, "9 millimeter bullets" = 2)
	foodtype = GRAIN | VEGETABLES | DAIRY | MEAT

/obj/item/reagent_containers/food/snacks/pizzaslice/arnold/attack(mob/living/M, mob/living/user)
	. =..()
	try_break_off(M, user)

/obj/item/reagent_containers/food/snacks/pizzaslice/arnold/attackby(obj/item/I, mob/user)
	i_kill_you(I, user)
	. = ..()


/obj/item/reagent_containers/food/snacks/pizzaslice/custom
	name = "pizza slice"
	icon_state = "pizzamargheritaslice"
	filling_color = "#FFFFFF"
	foodtype = GRAIN | VEGETABLES

/obj/item/reagent_containers/food/snacks/pizzaslice/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/kitchen/rollingpin))
		if(!isturf(loc))
			to_chat(user, "<span class='warning'>You need to put [src] on a surface to roll it out!</span>")
			return
		new /obj/item/stack/sheet/pizza(loc)
		to_chat(user, "<span class='notice'>You smoosh [src] into a cheesy sheet.</span>")
		qdel(src)
		return
	return ..()

//Pizza
/obj/item/reagent_containers/food/snacks/raw_mothic_margherita
	name = "raw Solar margherita pizza"
	desc = "A variation on a classic dish, Solar pizza is characterised by the use of fresh ingredients, \
		particularly fresh mozzarella, and the use of strong flour to produce a glutenous dough."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_margherita_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "tomato" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | RAW
	cooked_type = /obj/item/reagent_containers/food/snacks/pizza/mothic_margherita

/obj/item/reagent_containers/food/snacks/pizza/mothic_margherita
	name = "Solar margherita pizza"
	desc = "Margherita pizza, Solar-style. Known to cause arguments between people of different cultures about whose pizza is better."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "margherita_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/mothic_margherita

/obj/item/reagent_containers/food/snacks/pizzaslice/mothic_margherita
	name = "Solar margherita slice"
	desc = "A slice of Solar margherita pizza, the most humble of pizzas."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "margherita_slice"
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/raw_mothic_firecracker
	name = "raw Solar firecracker pizza"
	desc = "A favourite amongst the more adventurous Solarians, firecracker pizza is HOT HOT HOT!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_firecracker_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/bbqsauce = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("dough" = 1, "chili" = 1, "corn" = 1, "cheese" = 1, "bbq sauce" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | RAW
	cooked_type = /obj/item/reagent_containers/food/snacks/pizza/mothic_firecracker

/obj/item/reagent_containers/food/snacks/pizza/mothic_firecracker
	name = "Solar firecracker pizza"
	desc = "They're not kidding when they call this a hot pizza pie."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "firecracker_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/bbqsauce = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("crust" = 1, "chili" = 1, "corn" = 1, "cheese" = 1, "bbq sauce" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/mothic_firecracker

/obj/item/reagent_containers/food/snacks/pizzaslice/mothic_firecracker
	name = "Solar firecracker slice"
	desc = "A spicy slice of something quite nice."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "firecracker_slice"
	tastes = list("crust" = 1, "chili" = 1, "corn" = 1, "cheese" = 1, "bbq sauce" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/raw_mothic_five_cheese
	name = "raw Solar five-cheese pizza"
	desc = "For centuries, scholars have asked: how much cheese is too much cheese?"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_five_cheese_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | RAW
	cooked_type = /obj/item/reagent_containers/food/snacks/pizza/mothic_five_cheese

/obj/item/reagent_containers/food/snacks/pizza/mothic_five_cheese
	name = "Solar five-cheese pizza"
	desc = "A favourite amongst mice, rats, and English inventors."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "five_cheese_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/mothic_five_cheese

/obj/item/reagent_containers/food/snacks/pizzaslice/mothic_five_cheese
	name = "Solar five-cheese slice"
	desc = "It's the cheesiest slice in the galaxy!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "five_cheese_slice"
	tastes = list("crust" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/raw_mothic_white_pie
	name = "raw Solar white-pie pizza"
	desc = "A pizza made for the tomato haters."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_white_pie_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "cheese" = 1, "herbs" = 1, "garlic" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | RAW
	cooked_type = /obj/item/reagent_containers/food/snacks/pizza/mothic_white_pie

/obj/item/reagent_containers/food/snacks/pizza/mothic_white_pie
	name = "Solar white-pie pizza"
	desc = "You say to-may-to, I say to-mah-to, and we put neither on this pizza."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "white_pie_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "cheese" = 1, "herbs" = 1, "garlic" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/mothic_white_pie

/obj/item/reagent_containers/food/snacks/pizzaslice/mothic_white_pie
	name = "Solar white-pie slice"
	desc = "Cheesy, garlicky, herby, delicious!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "white_pie_slice"
	tastes = list("crust" = 1, "cheese" = 1, "more cheese" = 1, "excessive amounts of cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY

/obj/item/reagent_containers/food/snacks/raw_mothic_pesto
	name = "raw Solar pesto pizza"
	desc = "Pesto is most commonly seen on pasta, but pizza is a proving ground for all sorts of culinary innovation."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_pesto_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "pesto" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | NUTS | RAW
	cooked_type = /obj/item/reagent_containers/food/snacks/pizza/mothic_pesto

/obj/item/reagent_containers/food/snacks/pizza/mothic_pesto
	name = "Solar pesto pizza"
	desc = "Green as the grass in the garden. Not that there's many of those on spaceships."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "pesto_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "pesto" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | NUTS | RAW
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/mothic_pesto

/obj/item/reagent_containers/food/snacks/pizzaslice/mothic_pesto
	name = "Solar pesto slice"
	desc = "A slice of presto pesto pizza."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "pesto_slice"
	tastes = list("crust" = 1, "pesto" = 1, "cheese" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | NUTS

/obj/item/reagent_containers/food/snacks/raw_mothic_garlic
	name = "raw Solar garlic pizzabread"
	desc = "Ahh, garlic. A universally loved ingredient, except possibly by vampires."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_garlic_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/cooking_oil = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("dough" = 1, "garlic" = 1, "butter" = 1)
	foodtype = GRAIN | VEGETABLES | RAW
	cooked_type = /obj/item/reagent_containers/food/snacks/pizza/mothic_garlic

/obj/item/reagent_containers/food/snacks/pizza/mothic_garlic
	name = "Solar garlic pizzabread"
	desc = "The best food in the galaxy, hands down."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "garlic_pizza"
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/cooking_oil = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("crust" = 1, "garlic" = 1, "butter" = 1)
	foodtype = GRAIN | VEGETABLES | DAIRY | NUTS
	slice_path = /obj/item/reagent_containers/food/snacks/pizzaslice/mothic_garlic

/obj/item/reagent_containers/food/snacks/pizzaslice/mothic_garlic
	name = "Solar garlic pizzabread slice"
	desc = "The best combination of oily, garlicky, and crusty known to mothkind."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "garlic_slice"
	tastes = list("dough" = 1, "garlic" = 1, "butter" = 1)
	foodtype = GRAIN | VEGETABLES
