//Coffee Cartridges: like toner, but for your coffee!
/obj/item/coffee_cartridge
	name = "coffeemaker cartridge - Solar's Best"
	desc = "A coffee cartridge for use with the Attention model coffeemakers."
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "cartridge_basic"
	w_class = WEIGHT_CLASS_TINY
	var/charges = 4
	var/list/drink_type = list(/datum/reagent/consumable/coffee = 120)

/obj/item/coffee_cartridge/examine(mob/user)
	. = ..()
	if(charges)
		. += span_warning("The cartridge has [charges] portions of grounds remaining.")
	else
		. += span_warning("The cartridge has no unspent grounds remaining.")

/obj/item/coffee_cartridge/fancy
	name = "coffeemaker cartridge - Solar's Bestest"
	desc = "A high-quality coffee cartridge for use with the Attention model coffeemakers."
	icon_state = "cartridge_blend"
	drink_type = list(/datum/reagent/consumable/cafe_latte = 120)

//Here's the joke before I get 50 issue reports: they're all the same, and that's intentional // probably going to change this later
/obj/item/coffee_cartridge/fancy/Initialize(mapload)
	. = ..()
	var/coffee_type = pick("blend", "blue_mountain", "kilimanjaro", "mocha")
	switch(coffee_type)
		if("blend")
			name = "coffeemaker cartridge - Sirere Mix"
			desc = "A high-quality coffee cartridge for use with the Attention model coffeemakers. This one is based on a popular blend from the northern side of the United Teceti Coalition."
			icon_state = "cartridge_blend"
		if("blue_mountain")
			name = "coffeemaker cartridge - Serene Blue"
			desc = "A high-quality coffee cartridge for use with the Attention model coffeemakers. This one claims to be a speciality mix from Serene, a member planet of C.L.I.P, remarkable for its cold weather."
			icon_state = "cartridge_blue_mtn"
		if("kilimanjaro")
			name = "coffeemaker cartridge - Kalix Roast"
			desc = "A high-quality coffee cartridge for use with the Attention model coffeemakers. This one contains coffee beans roasted with a patented Kalixcian technique."
			icon_state = "cartridge_kilimanjaro"
		if("mocha")
			name = "coffeemaker cartridge - Deu’Texe Mocha"
			desc = "A high-quality coffee cartridge for use with the Attention model coffeemakers. This one claims to be a specially concocted caffè mocha by a Rachnid culinary guild."
			icon_state = "cartridge_mocha"

/obj/item/coffee_cartridge/decaf
	name = "coffeemaker cartridge - Decaffeinated"
	desc = "A coffee cartridge for use with the Attention model coffeemakers. This one contains no caffeine."
	icon_state = "cartridge_decaf"
	drink_type = list(/datum/reagent/consumable/soy_latte = 120)

// no you can't just squeeze the juice bag into a glass!
/obj/item/coffee_cartridge/bootleg
	name = "unmarked coffeemaker cartridge"
	desc = "A jury-rigged coffee cartridge. Should work with a Attention coffeemaker, though it might void the warranty."
	icon_state = "cartridge_bootleg"
	drink_type = list(/datum/reagent/consumable/coffee = 120)

// blank cartridge for crafting's sake, can be made at the service lathe
/obj/item/blank_coffee_cartridge
	name = "blank coffee cartridge"
	desc = "A blank coffee cartridge, ready to be filled with coffee paste."
	icon = 'icons/obj/item/coffee.dmi'
	icon_state = "cartridge_blank"
