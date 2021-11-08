/obj/item/weaponcrafting/gunkit/capgun_ugrade_kit
	name = "experimental gun upgrade kit"
	desc = "A suitcase containing the necessary gun parts to tranform a antique laser gun into something even better. A faded Nanotrasen Security symbol is on the side."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "kitsuitcase"

/obj/item/weaponcrafting/gunkit/capgun_ugrade_kit/afterattack(atom/target, mob/user, proximity, params)
	. = ..()
	if(!proximity)
		return
	if(istype(target, /obj/item/gun)) //checks if they really clicked on a gun
		var/created_gun
		if(istype(target, /obj/item/gun/energy/laser/captain/brazil)) //the gun that comes with the ruin
			created_gun = /obj/item/gun/energy/e_gun/hos/brazil // hos gun with a fancy skin
		else if(istype(target, /obj/item/gun/energy/laser/captain)) //a actual antique gun, only on the skipper as of writing and a lavaland ruin
			created_gun = /obj/item/gun/energy/e_gun/hos/brazil/true // hos gun with a fancy skin, but also recharging!!
		else
			to_chat(user, "<span class='warning'>You can't upgrade this gun!.</span>") //wrong gun
			return
		playsound(src, 'sound/items/drill_use.ogg', 50, FALSE)
		if(do_after(user, 60, target = target))
			new created_gun(get_turf(src))
			to_chat(user, "<span class='notice'>With the [src], you upgrade the [target]!</span>")
			qdel(target)
			qdel(src)
			return
	else
		return
