/obj/item/grenade/smokebomb
	name = "smoke grenade"
	desc = "A smoke grenade pattern, used to screen unit movements, and signal landing zones, widely used by military forces on the frontier and beyond."
	icon = 'icons/obj/grenade.dmi'
	icon_state = "smokewhite"
	item_state = "smoke"
	slot_flags = ITEM_SLOT_BELT

///Here we generate some smoke and also damage blobs??? for some reason. Honestly not sure why we do that.
/obj/item/grenade/smokebomb/prime()
	. = ..()
	update_mob()
	playsound(src, 'sound/effects/smoke.ogg', 50, TRUE, -3)
	var/datum/effect_system/smoke_spread/bad/smoke = new
	smoke.set_up(4, src)
	smoke.start()
	qdel(smoke) //And deleted again. Sad really.
	resolve()
