/datum/action/item_action/activate_lanternbang
	name = "Activate Lanternbang"
	check_flags = AB_CHECK_HANDS_BLOCKED | AB_CHECK_IMMOBILE

/datum/action/item_action/activate_lanternbang/Trigger()
	if(istype(target, /obj/item/flashlight/lantern/lanternbang))
		var/obj/item/flashlight/lantern/lanternbang/L = target
		if(L.cooldown)
			to_chat(owner, "<span class='warning'>The lanternbang is still on cooldown!</span>")
			return
		to_chat(owner, "<span class='warning'>You overload the lanternbang!</span>")
		L.activate()
		return
