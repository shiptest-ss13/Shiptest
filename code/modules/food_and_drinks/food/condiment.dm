
///////////////////////////////////////////////Condiments
//Notes by Darem: The condiments food-subtype is for stuff you don't actually eat but you use to modify existing food. They all
//	leave empty containers when used up and can be filled/re-filled with other items. Formatting for first section is identical
//	to mixed-drinks code. If you want an object that starts pre-loaded, you need to make it in addition to the other code.

//Food items that aren't eaten normally and leave an empty container behind.
/obj/item/reagent_containers/condiment
	name = "condiment bottle"
	desc = "Just your average condiment bottle."
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "emptycondiment"
	reagent_flags = OPENCONTAINER
	obj_flags = UNIQUE_RENAME
	possible_transfer_amounts = list(1, 5, 10, 15, 20, 25, 30, 50)
	volume = 50
	//Possible_states has the reagent type as key and a list of, in order, the icon_state, the name and the desc as values. Used in the on_reagent_change(changetype) to change names, descs and sprites.
	var/list/possible_states = list(
		/datum/reagent/consumable/enzyme = list("icon_state" = "enzyme", "item_state" = "", "icon_empty" = "", "name" = "universal enzyme bottle", "desc" = "Used in cooking various dishes."),
		/datum/reagent/consumable/flour = list("icon_state" = "flour", "item_state" = "flour", "icon_empty" = "", "name" = "flour sack", "desc" = "A big bag of flour. Good for baking!"),
		/datum/reagent/consumable/mayonnaise = list("icon_state" = "mayonnaise", "item_state" = "", "icon_empty" = "", "name" = "mayonnaise jar", "desc" = "An oily condiment made from egg yolks."),
		/datum/reagent/consumable/milk = list("icon_state" = "milk", "carton", "item_state" = "", "icon_empty" = "", "name" = "space milk", "desc" = "It's milk. White and nutritious goodness!"),
		/datum/reagent/consumable/blackpepper = list("icon_state" = "peppermillsmall", "item_state" = "", "icon_empty" = "emptyshaker", "name" = "pepper mill", "desc" = "Often used to flavor food or make people sneeze."),
		/datum/reagent/consumable/rice = list("icon_state" = "rice", "item_state" = "flour", "icon_empty" = "", "name" = "rice sack", "desc" = "A big bag of rice. Good for cooking!"),
		/datum/reagent/consumable/sodiumchloride = list("icon_state" = "saltshakersmall", "item_state" = "", "icon_empty" = "emptyshaker", "name" = "salt shaker", "desc" = "Salt. From dead crew, presumably."),
		/datum/reagent/consumable/soymilk = list("icon_state" = "soymilk", "item_state" = "carton", "icon_empty" = "", "name" = "soy milk", "desc" = "It's soy milk. White and nutritious goodness!"),
		/datum/reagent/consumable/soysauce = list("icon_state" = "soysauce", "item_state" = "", "icon_empty" = "", "name" = "soy sauce bottle", "desc" = "A salty soy-based flavoring."),
		/datum/reagent/consumable/sugar = list("icon_state" = "sugar", "item_state" = "flour", "icon_empty" = "", "name" = "sugar sack", "desc" = "Tasty spacey sugar!"),
		/datum/reagent/consumable/ketchup = list("icon_state" = "ketchup", "item_state" = "", "icon_empty" = "", "name" = "ketchup bottle", "desc" = "You feel more American already."),
		/datum/reagent/consumable/capsaicin = list("icon_state" = "hotsauce", "item_state" = "", "icon_empty" = "", "name" = "hotsauce bottle", "desc" = "You can almost TASTE the stomach ulcers!"),
		/datum/reagent/consumable/frostoil = list("icon_state" = "coldsauce", "item_state" = "", "icon_empty" = "", "name" = "coldsauce bottle", "desc" = "Leaves the tongue numb from its passage."),
		/datum/reagent/consumable/cornoil = list("icon_state" = "oliveoil", "item_state" = "", "icon_empty" = "", "name" = "corn oil bottle", "desc" = "A delicious oil used in cooking. Made from corn."),
		/datum/reagent/consumable/bbqsauce = list("icon_state" = "bbqsauce", "item_state" = "", "icon_empty" = "", "name" = "bbq sauce bottle", "desc" = "Hand wipes not included."),
		/datum/reagent/consumable/tiris_sale = list("icon_state" = "tiris-sauce", "item_state" = "", "icon_empty" = "", "name" = "tiris sale", "desc" = "An intense reduction made from tiris blood."),
		/datum/reagent/consumable/tiris_sele = list("icon_state" = "tiris-sauce", "item_state" = "", "icon_empty" = "", "name" = "tiris sele", "desc" = "An gravy made from tiris blood."),
		/datum/reagent/consumable/tiris_milk = list("icon_state" = "tiris-milk", "item_state" = "", "icon_empty" = "", "name" = "tiris milk", "desc" = "A rich and heavy milk taken from a Tiris!"),
	)
	var/originalname = "condiment" //Can't use initial(name) for this. This stores the name set by condimasters.
	var/icon_empty = ""
	fill_icon_thresholds = list(0, 10, 25, 50, 75, 100)

/obj/item/reagent_containers/condiment/Initialize()
	. = ..()
	possible_states = typelist("possible_states", possible_states)

	update_appearance()

/obj/item/reagent_containers/condiment/update_icon()
	cut_overlays()

	if(reagents.reagent_list.len > 0 && possible_states.len)

		var/datum/reagent/main_reagent_ref = reagents.get_master_reagent()
		var/main_reagent_id = main_reagent_ref.type
		if(main_reagent_id in possible_states)
			icon_state = possible_states[main_reagent_id]["icon_state"]
			item_state = possible_states[main_reagent_id]["item_state"]
			icon_empty = possible_states[main_reagent_id]["icon_empty"]
			name = possible_states[main_reagent_id]["name"]
			desc = possible_states[main_reagent_id]["desc"]
			return ..(TRUE) // Don't fill normally
		else
			name = "condiment bottle"
			desc = "Just your average condiment bottle."
			icon_state = "emptycondiment"

	else if(icon_empty)
		icon_state = icon_empty

	. = ..()

/obj/item/reagent_containers/condiment/attack(mob/M, mob/user, def_zone)

	if(!reagents || !reagents.total_volume)
		to_chat(user, span_warning("None of [src] left, oh no!"))
		return 0

	if(!canconsume(M, user))
		return 0

	if(M == user)
		user.visible_message(span_notice("[user] swallows some of the contents of \the [src]."), \
			span_notice("You swallow some of the contents of \the [src]."))
	else
		M.visible_message(span_warning("[user] attempts to feed [M] from [src]."), \
			span_warning("[user] attempts to feed you from [src]."))
		if(!do_after(user, target = M))
			return
		if(!reagents || !reagents.total_volume)
			return // The condiment might be empty after the delay.
		M.visible_message(span_warning("[user] fed [M] from [src]."), \
			span_warning("[user] fed you from [src]."))
		log_combat(user, M, "fed", reagents.log_list())
	reagents.trans_to(M, 10, transfered_by = user, method = INGEST)
	playsound(M.loc,'sound/items/drink.ogg', rand(10,50), TRUE)
	return 1

/obj/item/reagent_containers/condiment/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!proximity)
		return
	if(istype(target, /obj/structure/reagent_dispensers)) //A dispenser. Transfer FROM it TO us.

		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty!"))
			return

		if(reagents.total_volume >= reagents.maximum_volume)
			to_chat(user, span_warning("[src] is full!"))
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, span_notice("You fill [src] with [trans] units of the contents of [target]."))

	//Something like a glass or a food item. Player probably wants to transfer TO it.
	else if(target.is_drainable() || istype(target, /obj/item/food))
		if(!reagents.total_volume)
			to_chat(user, span_warning("[src] is empty!"))
			return
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_warning("you can't add anymore to [target]!"))
			return
		var/trans = src.reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
		to_chat(user, span_notice("You transfer [trans] units of the condiment to [target]."))
		playsound(src, 'sound/items/glass_transfer.ogg', 50, 1)

/obj/item/reagent_containers/condiment/on_reagent_change(changetype)
	update_appearance()

/obj/item/reagent_containers/condiment/enzyme
	name = "universal enzyme"
	desc = "Used in cooking various dishes."
	icon_state = "enzyme"
	list_reagents = list(/datum/reagent/consumable/enzyme = 50)

/obj/item/reagent_containers/food/condiment/enzyme/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/cheesewheel]
	var/milk_required = recipe.required_reagents[/datum/reagent/consumable/milk]
	var/enzyme_required = recipe.required_catalysts[/datum/reagent/consumable/enzyme]

	. += span_notice("[milk_required] milk, [enzyme_required] enzyme will make cheese.")

/obj/item/reagent_containers/condiment/sugar
	name = "sugar sack"
	desc = "A bag of sugar. Used for sweetening, typically. There's nothing stopping you from eating it straight..."
	icon_state = "sugar"
	item_state = "flour"
	list_reagents = list(/datum/reagent/consumable/sugar = 50)

/obj/item/reagent_containers/food/condiment/sugar/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/cakebatter]
	var/flour_required = recipe.required_reagents[/datum/reagent/consumable/flour]
	var/eggyolk_required = recipe.required_reagents[/datum/reagent/consumable/eggyolk]
	var/sugar_required = recipe.required_reagents[/datum/reagent/consumable/sugar]

	. += span_notice(">[flour_required] flour, [eggyolk_required] egg yolk (or soy milk), [sugar_required] sugar makes cake dough. You can make pie dough from it.")

/obj/item/reagent_containers/condiment/saltshaker// Separate from above since it's a small shaker rather then
	name = "salt shaker" //a large one.
	desc = "A shaker full of salt. Make sure the cap is on tight!"
	icon_state = "saltshakersmall"
	icon_empty = "emptyshaker"
	possible_transfer_amounts = list(1,20) //for turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20
	list_reagents = list(/datum/reagent/consumable/sodiumchloride = 20)

/obj/item/reagent_containers/condiment/saltshaker/afterattack(obj/target, mob/living/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(isturf(target))
		if(!reagents.has_reagent(/datum/reagent/consumable/sodiumchloride, 2))
			to_chat(user, span_warning("You don't have enough salt to make a pile!"))
			return
		user.visible_message(span_notice("[user] shakes some salt onto [target]."), span_notice("You shake some salt onto [target]."))
		reagents.remove_reagent(/datum/reagent/consumable/sodiumchloride, 2)
		new/obj/effect/decal/cleanable/food/salt(target)
		return

/obj/item/reagent_containers/condiment/peppermill
	name = "pepper mill"
	desc = "A handheld mill to grind down peppercorn. Often used to flavor food... or make people sneeze."
	icon_state = "peppermillsmall"
	icon_empty = "emptyshaker"
	possible_transfer_amounts = list(1,20) //for turning the lid off
	amount_per_transfer_from_this = 1
	volume = 20
	list_reagents = list(/datum/reagent/consumable/blackpepper = 20)

/obj/item/reagent_containers/condiment/milk
	name = "space milk"
	desc = "A carton full of milk. Freshly supplied from a mammal, a biogenerator, or chemically reproduced in a lab."
	icon_state = "milk"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/milk = 50)

/obj/item/reagent_containers/food/condiment/milk/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/cheesewheel]
	var/milk_required = recipe.required_reagents[/datum/reagent/consumable/milk]
	var/enzyme_required = recipe.required_catalysts[/datum/reagent/consumable/enzyme]
	. += "<span class='notice'>[milk_required] milk, [enzyme_required] enzyme will make cheese.</span>"
	. += "<span class='warning'>Remember, the enzyme isn't used up, so return it to the bottle.</span>"

/obj/item/reagent_containers/condiment/tiris_milk
	name = "Dimidiso's Tiris"
	desc = "Prepackaged Tiris milk made from pastures within CLIP space. The flavor is usually too strong for humans to drink straight."
	icon_state = "tiris-milk"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/tiris_milk = 50)

/obj/item/reagent_containers/food/condiment/tiris_milk/examine(mob/user)
	. = ..()
	var/datum/chemical_reaction/recipe = GLOB.chemical_reactions_list[/datum/chemical_reaction/cheesewheel]
	var/milk_required = recipe.required_reagents[/datum/reagent/consumable/tiris_milk]
	var/enzyme_required = recipe.required_catalysts[/datum/reagent/consumable/enzyme]
	. += "<span class='notice'>[milk_required] tiris milk, [enzyme_required] enzyme will make cheese.</span>"
	. += "<span class='warning'>Remember, the enzyme isn't used up, so return it to the bottle.</span>"

/obj/item/reagent_containers/condiment/flour
	name = "flour sack"
	desc = "A big bag of flour. Good for baking!"
	icon_state = "flour"
	item_state = "flour"
	list_reagents = list(/datum/reagent/consumable/flour = 30)

/obj/item/reagent_containers/condiment/soymilk
	name = "soy milk"
	desc = "A carton full of soy milk. Freshly supplied from soybeans."
	icon_state = "soymilk"
	item_state = "carton"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	list_reagents = list(/datum/reagent/consumable/soymilk = 50)

/obj/item/reagent_containers/condiment/rice
	name = "rice sack"
	desc = "A bag of dried, bleached rice. Don't go feeding birds these."
	icon_state = "rice"
	item_state = "flour"
	list_reagents = list(/datum/reagent/consumable/rice = 30)

/obj/item/reagent_containers/condiment/soysauce
	name = "soy sauce"
	desc = "A glass bottle of soy sauce. Known for being salty and savory."
	icon_state = "soysauce"
	list_reagents = list(/datum/reagent/consumable/soysauce = 50)

/obj/item/reagent_containers/condiment/mayonnaise
	name = "mayonnaise"
	desc = "An oily condiment made from egg yolks."
	icon_state = "mayonnaise"
	list_reagents = list(/datum/reagent/consumable/mayonnaise = 50)

//Food packs. To easily apply deadly toxi... delicious sauces to your food!

/obj/item/reagent_containers/condiment/pack
	name = "condiment pack"
	desc = "A small plastic pack with condiments to put on your food."
	icon_state = "condi_empty"
	volume = 10
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list()
	possible_states = list(
		/datum/reagent/consumable/ketchup = list("condi_ketchup", "Ketchup", "A packet of ketchup. The old standby, given by the fistful."),
		/datum/reagent/consumable/capsaicin = list("condi_hotsauce", "Hotsauce", "A packet of hotsauce. Good for spicing up food."),
		/datum/reagent/consumable/soysauce = list("condi_soysauce", "Soy Sauce", "A packet of soy sauce. Good on rice."),
		/datum/reagent/consumable/frostoil = list("condi_frostoil", "Coldsauce", "A packet of coldsauce. Good for... cooling down food?"),
		/datum/reagent/consumable/sodiumchloride = list("condi_salt", "Salt Shaker", "A shaker full of salt. Make sure the cap is on tight!"),
		/datum/reagent/consumable/blackpepper = list("condi_pepper", "Pepper Mill", "A handheld mill to grind down peppercorn. Often used to flavor food... or make people sneeze."),
		/datum/reagent/consumable/cornoil = list("condi_cornoil", "Corn Oil", "A (presumably) corn-sourced oil. Good for cooking."),
		/datum/reagent/consumable/sugar = list("condi_sugar", "Sugar", "A packet of sugar. Used for sweetening, typically."),
		/datum/reagent/consumable/astrotame = list("condi_astrotame", "Astrotame", "An artificial sweetener. Just be careful to not give yourself a headache with too much!"),
		/datum/reagent/consumable/bbqsauce = list("condi_bbq", "BBQ sauce", "A sweet and savory packet of barbeque sauce. It's sticky!"),
		/datum/reagent/consumable/creamer = list("condi_creamer", "Coffee Creamer", "A packet of coffee creamer. Better not to think about what they are making this from."),
		/datum/reagent/consumable/chocolatepudding = list("condi_chocolate", "Chocolate Pudding", "A packet of chocolate pudding. The amount of sugar that's already there wasn't enough for you?"),
		)

/obj/item/reagent_containers/condiment/pack/create_reagents(max_vol, flags)
	. = ..()
	RegisterSignals(reagents, list(COMSIG_REAGENTS_NEW_REAGENT, COMSIG_REAGENTS_ADD_REAGENT, COMSIG_REAGENTS_REM_REAGENT), PROC_REF(on_reagent_add), TRUE)
	RegisterSignal(reagents, COMSIG_REAGENTS_DEL_REAGENT, PROC_REF(on_reagent_del), TRUE)

/obj/item/reagent_containers/condiment/pack/update_icon()
	SHOULD_CALL_PARENT(FALSE)
	return

/obj/item/reagent_containers/condiment/pack/attack(mob/M, mob/user, def_zone) //Can't feed these to people directly.
	return

/obj/item/reagent_containers/condiment/pack/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!proximity)
		return

	//You can tear the bag open above food to put the condiments on it, obviously.
	if(IS_EDIBLE(target))
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_warning("You tear open [src], but [target] is stacked so high that it just drips off!") )
			qdel(src)
			return
		else
			to_chat(user, span_notice("You tear open [src] above [target] and the condiments drip onto it."))
			src.reagents.trans_to(target, amount_per_transfer_from_this, transfered_by = user)
			qdel(src)

/// Handles reagents getting added to the condiment pack.
/obj/item/reagent_containers/condiment/pack/proc/on_reagent_add(datum/reagents/reagents)
	SIGNAL_HANDLER

	var/datum/reagent/main_reagent = reagents.get_master_reagent()

	var/main_reagent_type = main_reagent?.type
	if(main_reagent_type in possible_states)
		var/list/temp_list = possible_states[main_reagent_type]
		icon_state = temp_list[1]
		desc = temp_list[3]
	else
		icon_state = "condi_mixed"
		desc = "A small condiment pack. The label says it contains [originalname]"

/// Handles reagents getting removed from the condiment pack.
/obj/item/reagent_containers/condiment/pack/proc/on_reagent_del(datum/reagents/reagents)
	SIGNAL_HANDLER
	icon_state = "condi_empty"
	desc = "A small condiment pack. It is empty."

//Ketchup
/obj/item/reagent_containers/condiment/pack/ketchup
	name = "ketchup pack"
	originalname = "ketchup"
	list_reagents = list(/datum/reagent/consumable/ketchup = 10)

//Hot sauce
/obj/item/reagent_containers/condiment/pack/hotsauce
	name = "hotsauce pack"
	originalname = "hotsauce"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 10)

/obj/item/reagent_containers/condiment/pack/astrotame
	name = "astrotame pack"
	originalname = "astrotame"
	list_reagents = list(/datum/reagent/consumable/astrotame = 5)

/obj/item/reagent_containers/condiment/pack/bbqsauce
	name = "bbq sauce pack"
	originalname = "bbq sauce"
	list_reagents = list(/datum/reagent/consumable/bbqsauce = 10)

/obj/item/reagent_containers/condiment/ketchup
	name = "ketchup bottle"
	desc = "Tomato ketchup, the old standby condiment."
	icon_state = "ketchup"
	list_reagents = list(/datum/reagent/consumable/ketchup = 50)

/obj/item/reagent_containers/condiment/bbqsauce
	name = "bbq sauce bottle"
	desc = "A bottle of sweet, savory barbeque sauce. It's sticky!"
	icon_state = "bbqsauce"
	list_reagents = list(/datum/reagent/consumable/bbqsauce = 50)

/obj/item/reagent_containers/condiment/hotsauce
	name = "hot sauce bottle"
	desc = "A bottle of hot sauce, made from chili peppers. Good for spicing up food!"
	icon_state = "hotsauce"
	list_reagents = list(/datum/reagent/consumable/capsaicin = 50)

/obj/item/reagent_containers/condiment/coldsauce
	name = "cold sauce bottle"
	desc = "A bottle of cold sauce, made from... chilly peppers Good for cooling down food(?)."
	icon_state = "coldsauce"
	list_reagents = list(/datum/reagent/consumable/frostoil = 50)

/obj/item/reagent_containers/condiment/oliveoil
	name = "olive oil bottle"
	desc = "Oil made from pressed olives. Great for cooking."
	icon_state = "oliveoil"
	list_reagents = list(/datum/reagent/consumable/cornoil = 50)

/obj/item/reagent_containers/condiment/tiris_sele
	name = "tiris sele"
	desc = "A thick gravy made with the blood of a Tiris. Flour is used to soak up the earthiness, leaving an intensely umami covering behind."
	icon_state = "tiris-sauce"
	list_reagents = list(/datum/reagent/consumable/tiris_sele = 50)

/obj/item/reagent_containers/condiment/tiris_sale
	name = "tiris sale"
	desc = "A reduction made from the blood of a Tiris and a mixture of savory herbs. The flavor is very intense, and best used to augment a dish."
	icon_state = "tiris-sauce"
	list_reagents = list(/datum/reagent/consumable/tiris_sale = 50)
