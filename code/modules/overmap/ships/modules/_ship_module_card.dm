/obj/item/ship_module_card
	name = "module installation card"
	desc = "A card used to install a module into a ship's mainframe."
	icon_state = "data_3"
	icon = 'icons/obj/card.dmi'

	/// Path of the shipmodule this card installs.
	var/datum/ship_module/module_path

	/// Is this card multi-use?
	var/card_multi_use = FALSE

/obj/item/ship_module_card/Initialize()
	. = ..()

	if(isnull(module_path) || !ispath(module_path, /datum/ship_module))
		log_mapping("tried to create '[type]' at [loc_name(src)] with invalid module_path '[module_path]'")
		return INITIALIZE_HINT_QDEL

/obj/item/ship_module_card/pre_attack(atom/target, mob/living/user, params)
	if(!istype(target, /obj/machinery/computer/ship_modules))
		return ..()

	if(!user.Adjacent(target))
		return ..()

	var/obj/machinery/computer/ship_modules/console = target
	if(isnull(console.current_ship))
		console.balloon_alert(user, "console corrupted!")
		return TRUE

	if(console.current_ship.owner_mob != user)
		console.balloon_alert(user, "no access!")
		return TRUE

	var/result = console.current_ship.install_module(module_path)
	switch(result)
		if(MODULE_INSTALL_FAILED)
			console.balloon_alert(user, "failed!")

		if(MODULE_INSTALL_SUCCESS)
			console.balloon_alert(user, "installed.")
			playsound(user, 'sound/machines/whirr_beep.ogg')
			if(!card_multi_use)
				qdel(src)

		if(MODULE_INSTALL_PATH_INVALID)
			message_debug("[loc_name(src)][ADMIN_JMP(src)] invalid module path! [module_path]")
			console.balloon_alert(user, "corrupted!")

	return TRUE
