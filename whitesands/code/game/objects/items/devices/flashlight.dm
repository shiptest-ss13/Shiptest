/obj/item/flashlight/lantern/lanternbang
	name = "suspicious lantern"
	desc = "A mining lantern with some odd electronics inside the glass. Manufactured by LepiCorp."
	icon_state = "syndilantern"
	item_state = "syndilantern"
	actions_types = list(/datum/action/item_action/activate_lanternbang)
	var/cooldown = 0

/obj/item/flashlight/lantern/lanternbang/proc/activate()
	if(cooldown)
		return
	src.visible_message("<span class='warning'>\The [src]'s light overloads!</span>")
	new /obj/effect/dummy/lighting_obj (get_turf(src), 10, 4, COLOR_WHITE, 2)
	playsound(get_turf(src), 'sound/weapons/flash.ogg', 50, TRUE, 3)
	for(var/mob/living/M in get_hearers_in_view(7, get_turf(src)))
		if(M.stat == DEAD)
			continue
		var/distance = max(0, get_dist(get_turf(src), M.loc))
		if(distance == 0) //We won't affect ourselves
			continue
		if(M.flash_act(affect_silicon = 1))
			M.Knockdown(10/(max(1, distance)))
			M.confused += 15
	cooldown = TRUE
	addtimer(VARSET_CALLBACK(src, cooldown, FALSE), 20 SECONDS)
