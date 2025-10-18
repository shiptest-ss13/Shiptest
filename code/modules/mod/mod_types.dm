/obj/item/mod/control/pre_equipped
	/// The skin we apply to the suit, defaults to the default_skin of the theme.
	var/applied_skin
	/// The MOD core we apply to the suit.
	var/applied_core = /obj/item/mod/core/standard
	/// The cell we apply to the core. Only applies to standard core suits.
	var/applied_cell = /obj/item/stock_parts/cell/high

/obj/item/mod/control/pre_equipped/Initialize(mapload, new_theme, new_skin, new_core)
	new_skin = applied_skin
	new_core = new applied_core(src)
	if(istype(new_core, /obj/item/mod/core/standard))
		var/obj/item/mod/core/standard/cell_core = new_core
		cell_core.cell = new applied_cell()
	return ..()

/obj/item/mod/control/pre_equipped/standard
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/flashlight,
	)

/obj/item/mod/control/pre_equipped/debug
	theme = /datum/mod_theme/debug
	applied_core = /obj/item/mod/core/infinite
	initial_modules = list(
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/injector,
	)

/obj/item/mod/control/pre_equipped/heavy //testing type thgvr todo fix
	theme = /datum/mod_theme/heavy
	applied_core = /obj/item/mod/core/infinite
	initial_modules = list(
		/obj/item/mod/module/storage/bluespace,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/injector,
	)

//these exist for the prefs menu
/obj/item/mod/control/pre_equipped/empty

INITIALIZE_IMMEDIATE(/obj/item/mod/control/pre_equipped/empty)
