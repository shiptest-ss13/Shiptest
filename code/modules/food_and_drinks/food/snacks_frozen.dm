
/////////////////
//Misc. Frozen.//
/////////////////

/obj/item/reagent_containers/food/snacks/icecreamsandwich
	name = "icecream sandwich"
	desc = "A small slab of vanilla ice cream, sandwiched between two soft cookies."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "icecreamsandwich"
	w_class = WEIGHT_CLASS_TINY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/ice = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/ice = 2)
	tastes = list("ice cream" = 1)
	foodtype = GRAIN | DAIRY | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/

/obj/item/reagent_containers/food/snacks/strawberryicecreamsandwich
	name = "strawberry ice cream sandwich"
	desc = "A small slab of strawberry ice cream, sandwiched between two soft cookies."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "strawberryicecreamsandwich"
	w_class = WEIGHT_CLASS_TINY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/ice = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/ice = 2)
	tastes = list("ice cream" = 2, "berry" = 2)
	foodtype = FRUIT | DAIRY | SUGAR
	/*food_flags = FOOD_FINGER_FOOD*/


/obj/item/reagent_containers/food/snacks/spacefreezy
	name = "blue cherry icecream cone"
	desc = "An ice cream with specially-prepared \"blue cherry\" ice cream, a flavor that has since been made by genetic engineers into reality in the passing centuries."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "spacefreezy"
	w_class = WEIGHT_CLASS_TINY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/bluecherryjelly = 5, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#87CEFA"
	tastes = list("blue cherries" = 2, "ice cream" = 2)
	foodtype = FRUIT | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/sundae
	name = "sundae"
	desc = "A classic dessert, featuring multiple scoops of vanilla ice cream, topped with syrup, cuts of banana, and a cherry."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "sundae"
	w_class = WEIGHT_CLASS_SMALL
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/banana = 5, /datum/reagent/consumable/nutriment/vitamin = 2)
	filling_color = "#FFFACD"
	tastes = list("ice cream" = 1, "banana" = 1)
	foodtype = FRUIT | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/honkdae
	name = "banana split sundae"
	desc = "A banana-loaded addition to the sundae."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "sundae" // Same sprite for now I hate that fucking clown
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/vitamin = 2)
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/banana = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	filling_color = "#FFFACD"
	tastes = list("ice cream" = 1, "banana" = 1)
	foodtype = FRUIT | DAIRY | SUGAR

/////////////
//SNOWCONES//
/////////////

/obj/item/reagent_containers/food/snacks/snowcones //We use this as a base for all other snowcones
	name = "flavorless snowcone"
	desc = "Finely shaved ice, put atop a paper cone. Usually added with flavored syrup, but..."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "flavorless_sc"
	w_class = WEIGHT_CLASS_SMALL
	trash = /obj/item/reagent_containers/food/drinks/sillycup //We dont eat paper cups
	bonus_reagents = list(/datum/reagent/water = 10) //Base line will allways give water
	list_reagents = list(/datum/reagent/water = 1) // We dont get food for water/juices
	filling_color = "#FFFFFF" //Ice is white
	tastes = list("ice" = 1, "water" = 1)
	foodtype = SUGAR //We use SUGAR as a base line to act in as junkfood, other wise we use fruit
	/*food_flags = FOOD_FINGER_FOOD*/

/obj/item/reagent_containers/food/snacks/snowcones/lime
	name = "lime snowcone"
	desc = "Lime syrup drizzled over a snowball in a paper cup."
	icon_state = "lime_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/limejuice = 5)
	tastes = list("ice" = 1, "water" = 1, "limes" = 5)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/snowcones/lemon
	name = "lemon snowcone"
	desc = "Lemon syrup drizzled over a snowball in a paper cup."
	icon_state = "lemon_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/lemonjuice = 5)
	tastes = list("ice" = 1, "water" = 1, "lemons" = 5)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/snowcones/apple
	name = "apple snowcone"
	desc = "Apple syrup drizzled over a snowball in a paper cup."
	icon_state = "amber_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/applejuice = 5)
	tastes = list("ice" = 1, "water" = 1, "apples" = 5)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/snowcones/grape
	name = "grape snowcone"
	desc = "Grape syrup drizzled over a snowball in a paper cup."
	icon_state = "grape_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/grapejuice = 5)
	tastes = list("ice" = 1, "water" = 1, "grape" = 5)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/snowcones/orange
	name = "orange snowcone"
	desc = "Orange syrup drizzled over a snowball in a paper cup."
	icon_state = "orange_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/orangejuice = 5)
	tastes = list("ice" = 1, "water" = 1, "orange" = 5)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/snowcones/blue
	name = "bluecherry snowcone"
	desc = "Blue cherry syrup drizzled over a snowball in a paper cup."
	icon_state = "blue_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/bluecherryjelly = 5)
	tastes = list("ice" = 1, "water" = 1, "blue" = 5, "cherries" = 5)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/snowcones/red
	name = "cherry snowcone"
	desc = "Cherry syrup drizzled over a snowball in a paper cup."
	icon_state = "red_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/cherryjelly = 5)
	tastes = list("ice" = 1, "water" = 1, "red" = 5, "cherries" = 5)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/snowcones/berry
	name = "berry snowcone"
	desc = "Berry syrup drizzled over a snowball in a paper cup."
	icon_state = "berry_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/berryjuice = 5)
	tastes = list("ice" = 1, "water" = 1, "berries" = 5)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/snowcones/fruitsalad
	name = "triple citrus snowcone"
	desc = "A delightful mix of citrus syrups drizzled over a snowball in a paper cup."
	icon_state = "fruitsalad_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/lemonjuice = 5, /datum/reagent/consumable/limejuice = 5, /datum/reagent/consumable/orangejuice = 5)
	tastes = list("ice" = 1, "water" = 1, "oranges" = 5, "limes" = 5, "lemons" = 5, "citrus" = 5, "salad" = 5)
	foodtype = FRUIT

/obj/item/reagent_containers/food/snacks/snowcones/pineapple
	name = "pineapple snowcone"
	desc = "Pineapple syrup drizzled over a snowball in a paper cup."
	icon_state = "pineapple_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/pineapplejuice = 5)
	tastes = list("ice" = 1, "water" = 1, "pineapples" = 5)
	foodtype = PINEAPPLE //Pineapple to allow all that like pineapple to enjoy

/obj/item/reagent_containers/food/snacks/snowcones/soda
	name = "space cola snowcone"
	desc = "Space Cola drizzled over a snowball in a paper cup."
	icon_state = "soda_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/space_cola = 5)
	tastes = list("ice" = 1, "water" = 1, "cola" = 5)

/obj/item/reagent_containers/food/snacks/snowcones/spacemountainwind
	name = "Comet Trail snowcone"
	desc = "Comet Trail drizzled over a snowball in a paper cup."
	icon_state = "mountainwind_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/comet_trail = 5)
	tastes = list("ice" = 1, "water" = 1, "mountain wind" = 5)


/obj/item/reagent_containers/food/snacks/snowcones/pwrgame
	name = "PAC-Fuel snowcone"
	desc = "PAC-Fuel soda drizzled over a snowball in a paper cup."
	icon_state = "pwrgame_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/pacfuel = 5)
	tastes = list("ice" = 1, "water" = 1, "valid" = 5, "salt" = 5, "wats" = 5)

/obj/item/reagent_containers/food/snacks/snowcones/honey
	name = "honey snowcone"
	desc = "Honey drizzled over a snowball in a paper cup."
	icon_state = "amber_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/honey = 5)
	tastes = list("ice" = 1, "water" = 1, "flowers" = 5, "sweetness" = 5, "wax" = 1)

/obj/item/reagent_containers/food/snacks/snowcones/rainbow
	name = "rainbow snowcone"
	desc = "A very colorful snowball in a paper cup."
	icon_state = "rainbow_sc"
	list_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/honey = 5, /datum/reagent/consumable/sugar = 10)
	tastes = list("ice" = 1, "water" = 1, "sunlight" = 5, "light" = 5, "slime" = 5, "paint" = 3, "clouds" = 3)

/obj/item/reagent_containers/food/snacks/popsicle
	name = "bug popsicle"
	desc = "Mmmm, this should not exist."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "popsicle_stick_s"
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 2, /datum/reagent/consumable/sugar = 4)
	tastes = list("beetlejuice")
	trash = /obj/item/popsicle_stick
	w_class = WEIGHT_CLASS_SMALL
	var/overlay_state = "creamsicle_o" //This is the edible part of the popsicle.
	var/bite_states = 4 //This value value is used for correctly setting the bitesize to ensure every bite changes the sprite. Do not set to zero.
	foodtype = DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/popsicle/Initialize()
	. = ..()
	bitesize = reagents.total_volume / bite_states

/obj/item/reagent_containers/food/snacks/popsicle/update_overlays()
	. = ..()
	if(!bitecount)
		. += initial(overlay_state)
		return
	. += "[initial(overlay_state)]_[min(bitecount, 3)]"

/obj/item/reagent_containers/food/snacks/popsicle/On_Consume(mob/living/eater)
	. = ..()
	update_appearance()

/obj/item/popsicle_stick
	name = "popsicle stick"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "popsicle_stick"
	desc = "This humble little stick usually carries a frozen treat, at the moment it seems freed from this atlassian burden."
	custom_materials = list(/datum/material/wood=20)
	w_class = WEIGHT_CLASS_TINY
	force = 0

/obj/item/reagent_containers/food/snacks/popsicle/creamsicle_orange
	name = "orange creamsicle"
	desc = "A classic orange creamsicle. A sunny frozen treat."
	list_reagents = list(/datum/reagent/consumable/orangejuice = 4, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 2, /datum/reagent/consumable/sugar = 4)
	bonus_reagents = list(/datum/reagent/consumable/orangejuice = 4, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 2, /datum/reagent/consumable/sugar = 4)
	foodtype = FRUIT | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/popsicle/creamsicle_berry
	name = "berry creamsicle"
	desc = "A vibrant berry creamsicle. A berry good frozen treat."
	list_reagents = list(/datum/reagent/consumable/berryjuice = 4, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 2, /datum/reagent/consumable/sugar = 4)
	bonus_reagents = list(/datum/reagent/consumable/berryjuice = 4, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 2, /datum/reagent/consumable/sugar = 4)
	overlay_state = "creamsicle_m"
	foodtype = FRUIT | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/popsicle/jumbo
	name = "Je'Tir'Nix bar"
	desc = "A luxurious, chocolate-covered bar of vanilla ice cream. Made by the rachnid culinarian guild."
	list_reagents = list(/datum/reagent/consumable/hot_coco = 4, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 3, /datum/reagent/consumable/sugar = 4)
	bonus_reagents = list(/datum/reagent/consumable/hot_coco = 4, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 3, /datum/reagent/consumable/sugar = 2)
	overlay_state = "jumbo"

/obj/item/reagent_containers/food/snacks/popsicle/licorice
	name = "licorice icecream"
	desc = "A salty licorice icecream."
	list_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sodiumchloride = 1,  /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/sodiumchloride = 1,  /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)
	tastes = list("salty liquorice")
	overlay_state = "licorice"

/obj/item/reagent_containers/food/snacks/cornuto
	name = "cornuto"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "cornuto"
	desc = "A solarian vanilla and chocolate icecream cone. It menaces with a sprinkling of caramelized nuts."
	tastes = list("chopped hazelnuts", "waffle")
	list_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/hot_coco = 4, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 4, /datum/reagent/consumable/sugar = 2)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/hot_coco = 4, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 4, /datum/reagent/consumable/sugar = 1)
	foodtype = DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/miras_parfait
	name = "miras parfait"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "miras-parfait"
	desc = "Miras eggs can be whisked together with milk cream and fruit syrup, making a delightfully flavorful tecetian dessert."
	tastes = list("sweet berries", "a hint of egg", "heavy cream")
	list_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/eggyolk = 1, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/dote_juice = 4, /datum/reagent/consumable/sugar = 2)
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/dote_juice = 4, /datum/reagent/consumable/sugar = 1)
	foodtype = MEAT | DAIRY | SUGAR
