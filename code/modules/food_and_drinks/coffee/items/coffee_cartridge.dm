//Coffee Cartridges: like toner, but for your coffee!
/obj/item/coffee_cartridge
	name = "coffeemaker cartridge - Solarian Coffee"
	desc = "A coffee cartridge for use with the Modello 3 system."
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "cartridge_basic"
	w_class = WEIGHT_CLASS_TINY
	var/charges = 4
	var/list/drink_type = list(/datum/reagent/consumable/coffee = 120)

/obj/item/coffee_cartridge/examine(mob/user)
	. = ..()
	if(charges)
		. += "<span class='warning'>The cartridge has [charges] portions of grounds remaining.</span>"
	else
		. += "<span class='warning'>The cartridge has no unspent grounds remaining.</span>"

/obj/item/coffee_cartridge/fancy
	name = "coffeemaker cartridge - Caffè Fantasioso"
	desc = "A fancy coffee cartridge manufactured by Piccionaia Coffee, for use with the Modello 3 system."
	icon_state = "cartridge_blend"
	drink_type = list(/datum/reagent/consumable/cafe_latte = 120)

//Here's the joke before I get 50 issue reports: they're all the same, and that's intentional
/obj/item/coffee_cartridge/fancy/Initialize(mapload)
	. = ..()
	var/coffee_type = pick("blend", "blue_mountain", "kilimanjaro", "mocha")
	switch(coffee_type)
		if("blend")
			name = "coffeemaker cartridge - Miscela di Piccione"
			icon_state = "cartridge_blend"
		if("blue_mountain")
			name = "coffeemaker cartridge - Montagna Blu"
			icon_state = "cartridge_blue_mtn"
		if("kilimanjaro")
			name = "coffeemaker cartridge - Kilimangiaro"
			icon_state = "cartridge_kilimanjaro"
		if("mocha")
			name = "coffeemaker cartridge - Moka Arabica"
			icon_state = "cartridge_mocha"

/obj/item/coffee_cartridge/decaf
	name = "coffeemaker cartridge - Caffè Decaffeinato"
	desc = "A decaf coffee cartridge manufactured by Piccionaia Coffee, for use with the Modello 3 system."
	icon_state = "cartridge_decaf"
	drink_type = list(/datum/reagent/consumable/soy_latte = 120)

// no you can't just squeeze the juice bag into a glass!
/obj/item/coffee_cartridge/bootleg
	name = "unmarked coffeemaker cartridge"
	desc = "A jury-rigged coffee cartridge. Should work with a Modello 3 system, though it might void the warranty."
	icon_state = "cartridge_bootleg"
	drink_type = list(/datum/reagent/consumable/coffee = 120)

// blank cartridge for crafting's sake, can be made at the service lathe
/obj/item/blank_coffee_cartridge
	name = "blank coffee cartridge"
	desc = "A blank coffee cartridge, ready to be filled with coffee paste."
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "cartridge_blank"
