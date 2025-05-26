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
