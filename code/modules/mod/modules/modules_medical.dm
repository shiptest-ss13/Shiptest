//Medical modules for MODsuits

///Quick Carry - Lets the user carry bodies quicker.
/obj/item/mod/module/quick_carry
	name = "MOD quick carry module"
	desc = "A suite of advanced servos, redirecting power from the suit's arms to help carry the wounded; \
		or simply for fun. However, Nanotrasen has locked the module's ability to assist in hand-to-hand combat."
	icon_state = "carry"
	complexity = 1
	idle_power_cost = DEFAULT_CHARGE_DRAIN * 0.3
	incompatible_modules = list(/obj/item/mod/module/quick_carry)

/obj/item/mod/module/quick_carry/on_suit_activation()
	ADD_TRAIT(mod.wearer, TRAIT_QUICK_CARRY, MOD_TRAIT)

/obj/item/mod/module/quick_carry/on_suit_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_QUICK_CARRY, MOD_TRAIT)

/obj/item/mod/module/quick_carry/advanced
	name = "MOD advanced quick carry module"
	removable = FALSE
	complexity = 0

/obj/item/mod/module/quick_carry/on_suit_activation()
	ADD_TRAIT(mod.wearer, TRAIT_QUICKER_CARRY, MOD_TRAIT)
	ADD_TRAIT(mod.wearer, TRAIT_FASTMED, MOD_TRAIT)

/obj/item/mod/module/quick_carry/on_suit_deactivation(deleting = FALSE)
	REMOVE_TRAIT(mod.wearer, TRAIT_QUICKER_CARRY, MOD_TRAIT)
	REMOVE_TRAIT(mod.wearer, TRAIT_FASTMED, MOD_TRAIT)

///Injector - Gives the suit an extendable large-capacity piercing syringe.
/obj/item/mod/module/injector
	name = "MOD injector module"
	desc = "A module installed into the wrist of the suit, this functions as a high-capacity syringe, \
		with a tip fine enough to locate the emergency injection ports on any suit of armor, \
		penetrating it with ease. Even yours."
	icon_state = "injector"
	module_type = MODULE_ACTIVE
	complexity = 1
	active_power_cost = MODULE_CHARGE_DRAIN_LOW
	device = /obj/item/reagent_containers/syringe/mod
	incompatible_modules = list(/obj/item/mod/module/injector)
	cooldown_time = 0.5 SECONDS

/obj/item/reagent_containers/syringe/mod
	name = "MOD injector syringe"
	desc = "A high-capacity syringe, with a tip fine enough to locate \
		the emergency injection ports on any suit of armor, penetrating it with ease. Even yours."
	amount_per_transfer_from_this = 30
	possible_transfer_amounts = list(5, 10, 15, 20, 30)
	volume = 30

/obj/item/mod/module/opset
	name = "MOD mobile surgery module"
	desc = "A module installed in the forearm of the suit, featuring a complete suite of integrated surgical tools."
	module_type = MODULE_ACTIVE
	complexity = 4
	active_power_cost = MODULE_CHARGE_DRAIN_MEDIUM
	toolset = TRUE
	tools_to_create = list(/obj/item/retractor/augment, /obj/item/hemostat/augment, /obj/item/cautery/augment, /obj/item/surgicaldrill/augment, /obj/item/scalpel/augment, /obj/item/circular_saw/augment)
	incompatible_modules = list(/obj/item/mod/module/opset)
	cooldown_time = 0
	allowed_inactive = TRUE

