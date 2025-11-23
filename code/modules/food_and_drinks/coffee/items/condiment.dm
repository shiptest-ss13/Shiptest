/obj/item/reagent_containers/condiment/pack/sugar
	name = "sugar pack"
	originalname = "sugar"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/sugar = 5)

///Technically condiment packs but they are non transparent
/obj/item/reagent_containers/condiment/pack/creamer
	name = "coffee creamer pack"
	desc = "Better not to think about what they are making this from."
	icon_state = "condi_creamer"
	volume = 5
	list_reagents = list(/datum/reagent/consumable/creamer = 5)
	fill_icon_thresholds = null

/obj/item/reagent_containers/condiment/pack/chocolate
	name = "chocolate sprinkle pack"
	desc = "The amount of sugar that's already there wasn't enough for you?"
	icon_state = "condi_chocolate"
	list_reagents = list(/datum/reagent/consumable/chocolatepudding = 10)

/*
 *	Syrup bottles, basically a unspillable cup that transfers reagents upon clicking on it with a cup
 *	Exclusive, can only be ordered from cargo, you cant refill them.
 */

/obj/item/reagent_containers/glass/bottle/syrup_bottle
	name = "syrup bottle"
	desc = "A bottle with a syrup pump to dispense the delicious substance directly into your coffee cup."
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "syrup"
	fill_icon_state = "syrup"
	fill_icon_thresholds = list(0, 20, 40, 60, 80, 100)
	possible_transfer_amounts = list(5, 10)
	reagent_flags = DRAINABLE | TRANSPARENT
	volume = 50
	amount_per_transfer_from_this = 5
	spillable = FALSE
	///variable to tell if the bottle can be refilled
	cap_on = TRUE

/obj/item/reagent_containers/glass/bottle/syrup_bottle/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to toggle the pump cap.")
	return

//when you attack the syrup bottle with a container it refills it
/obj/item/reagent_containers/glass/bottle/syrup_bottle/attackby(obj/item/attacking_item, mob/user, params)
	SHOULD_CALL_PARENT(FALSE)
	if(!cap_on)
		return ..()

	if(!check_allowed_items(attacking_item, target_self = TRUE))
		return

	if(attacking_item.is_refillable())
		if(!reagents.total_volume)
			to_chat(user, span_warning("[src] is empty!</span>"))
			return

		if(attacking_item.reagents.holder_full())
			to_chat(user, span_warning("[attacking_item] is full.</span>"))

		var/trans = reagents.trans_to(attacking_item, amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, span_notice("You transfer [trans] unit\s of the solution to [attacking_item]."))
		flick("syrup_anim", src)
	attacking_item.update_icon()
	return TRUE

/obj/item/reagent_containers/glass/bottle/syrup_bottle/afterattack(obj/target, mob/user, proximity)
	SHOULD_CALL_PARENT(FALSE)
	return TRUE

/obj/item/reagent_containers/glass/bottle/syrup_bottle/AltClick(mob/user)
	if(!cap_on)
		icon_state = "syrup_open"
		to_chat(user, span_notice("You remove the pump cap."))
	else
		icon_state = "syrup"
		to_chat(user, span_notice("You put the pump cap on."))
	update_icon_state()
	return ..()

//types of syrups

/obj/item/reagent_containers/glass/bottle/syrup_bottle/caramel
	name = "bottle of caramel syrup"
	desc = "A pump bottle containing a syrup made of caramelized sugar."
	list_reagents = list(/datum/reagent/consumable/caramel = 50)

/obj/item/reagent_containers/glass/bottle/syrup_bottle/liqueur
	name = "bottle of coffee liqueur syrup"
	desc = "A pump bottle containing coffee-flavoured liqueur."
	list_reagents = list(/datum/reagent/consumable/ethanol/kahlua = 50)

/obj/item/reagent_containers/glass/bottle/syrup_bottle/honey
	name = "bottle of honey syrup"
	desc = "A pump bottle containing honey, very sticky."
	list_reagents = list(/datum/reagent/consumable/honey = 50)

/obj/item/reagent_containers/glass/bottle/syrup_bottle/vanilla
	name = "bottle of vanilla syrup"
	desc = "A pump bottle containing vanilla syrup."
	list_reagents = list(/datum/reagent/consumable/vanilla = 50)

/obj/item/reagent_containers/glass/bottle/syrup_bottle/tea
	name = "bottle of tea-flavored syrup"
	desc = "A pump bottle containing tea-flavored syrup."
	list_reagents = list(/datum/reagent/consumable/tea = 50)

/obj/item/reagent_containers/glass/bottle/syrup_bottle/creme_de_cacao
	name = "bottle of Creme de Cacao syrup"
	desc = "A pump bottle containing Creme de Cacao."
	list_reagents = list(/datum/reagent/consumable/ethanol/creme_de_cacao = 50)

/obj/item/reagent_containers/glass/bottle/syrup_bottle/creme_de_menthe
	name = "bottle of Creme de Menthe syrup"
	desc = "A pump bottle containing Creme de Menthe."
	list_reagents = list(/datum/reagent/consumable/ethanol/creme_de_menthe = 50)
