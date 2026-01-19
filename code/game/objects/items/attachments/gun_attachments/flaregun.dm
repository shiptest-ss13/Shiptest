/obj/item/attachment/gun/flare
	name = "underbarrel flaregun"
	desc = "An underbarrel flaregun for lighting the path ahead."
	icon_state = "riotlauncher"
	weapon_type = null
	var/obj/item/flashlight/flare/loaded_flare
	has_safety = FALSE

/obj/item/attachment/gun/flare/Destroy()
	. = ..()
	QDEL_NULL(loaded_flare)

/obj/item/attachment/gun/flare/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I,/obj/item/flashlight/flare))
		if(!loaded_flare)
			var/obj/item/flashlight/flare/flare_to_load = I
			if(flare_to_load.on)
				to_chat(user, span_warning("You can't load a lit flare into the [name]!"))
				return FALSE
			if(!flare_to_load.fuel)
				to_chat(user, span_warning("You can't load a used flare into the [name]!"))
				return FALSE
			loaded_flare = flare_to_load
			if(!user.transferItemToLoc(flare_to_load, src))
				return FALSE
			playsound(src,'sound/weapons/gun/shotgun/insert_shell.ogg',100)
			to_chat(user, span_notice("You load a flare into \the [name]."))
		else
			to_chat(user, span_warning("\The [name] already has a flare loaded!"))
			return FALSE

/obj/item/attachment/gun/flare/on_fire_gun(obj/item/gun/gun, mob/living/user, atom/target, flag, params)
	var/list/modifiers = params2list(params)
	if(!gun.safety && LAZYACCESS(modifiers, RIGHT_CLICK))
		if(loaded_flare)
			user.visible_message(span_warning("[user] fires a flare!"), span_warning("You fire the [name] at \the [target]!"))
			var/obj/item/flashlight/flare/flare_to_fire = loaded_flare
			loaded_flare = null
			flare_to_fire.attack_self(user)
			flare_to_fire.forceMove(user.loc)
			flare_to_fire.throw_at(target,30,2,user)
			playsound(src,'sound/weapons/gun/general/rocket_launch.ogg',100)
		else
			to_chat(user,span_warning("\The [name] doesn't have a flare loaded!"))
			playsound(src,'sound/weapons/gun/pistol/dry_fire.ogg')
		return COMPONENT_CANCEL_GUN_FIRE

/obj/item/attachment/gun/flare/on_unique_action(obj/item/gun/gun, mob/user)
	. = ..()
	if(loaded_flare)
		user.put_in_hands(loaded_flare)
		to_chat(user, span_notice("You unload the flare from \the [name]."))
		loaded_flare = null
	playsound(src,'sound/weapons/gun/shotgun/rack.ogg',100)
	return OVERRIDE_UNIQUE_ACTION

/obj/item/attachment/gun/flare/on_examine(obj/item/gun/gun, mob/user, list/examine_list)
	. = ..()
	examine_list += span_notice("-\The [name] [loaded_flare ? "has a flare loaded." : "is empty."]")
	examine_list += span_notice("-You can unload \the [name] by pressing the <b>secondary action</b> key. By default, this is <b>shift + space</b>")
	return examine_list
