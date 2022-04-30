/obj/item/forging
	icon = 'icons/obj/forge_items.dmi'
	var/work_time = 2 SECONDS
	///whether the item is in use or not
	var/in_use = FALSE

/obj/item/forging/tongs
	name = "forging tongs"
	desc = "A set of tongs specifically crafted for use in forging. A wise man once said 'I lift things up and put them down.'"
	icon = 'icons/obj/forge_items.dmi'
	icon_state = "tong_empty"

/obj/item/forging/tongs/attack_self(mob/user, modifiers)
	. = ..()
	var/obj/search_obj = locate(/obj) in contents
	if(search_obj)
		search_obj.forceMove(get_turf(src))
		icon_state = "tong_empty"
		return

/obj/item/forging/hammer
	name = "forging hammer"
	desc = "A hammer specifically crafted for use in forging. Used to slowly shape metal; careful, you could break something with it!"
	icon_state = "hammer"

/obj/item/forging/billow
	name = "forging billow"
	desc = "A billow specifically crafted for use in forging. Used to stoke the flames and keep the forge lit."
	icon_state = "billow"

//incomplete pre-complete items
/obj/item/forging/incomplete
	name = "parent dev item"
	desc = "An incomplete forge item, continue to work hard to be rewarded for your efforts."
	//the time remaining that you can hammer before too cool
	COOLDOWN_DECLARE(heating_remainder)
	//the time between each strike
	COOLDOWN_DECLARE(striking_cooldown)
	///the amount of times it takes for the item to become ready
	var/average_hits = 30
	///the amount of times the item has been hit currently
	var/times_hit = 0
	///the required time before each strike to prevent spamming
	var/average_wait = 1 SECONDS
	///the path of the item that will be spawned upon completion
	var/spawn_item

/obj/item/forging/incomplete/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/forging/tongs))
		var/obj/search_obj = locate(/obj) in I.contents
		if(search_obj)
			to_chat(user, "<span class='warning'>The tongs are already holding something, make room.</span>")
			return
		forceMove(I)
		I.icon_state = "tong_full"
		return

/obj/item/forging/incomplete/chain
	name = "incomplete chain"
	icon_state = "hot_chain"
	average_hits = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/chain

/obj/item/forging/incomplete/plate
	name = "incomplete plate"
	icon_state = "hot_plate"
	average_hits = 10
	average_wait = 0.5 SECONDS
	spawn_item = /obj/item/forging/complete/plate

/obj/item/forging/incomplete/sword
	name = "incomplete sword blade"
	icon_state = "hot_blade"
	spawn_item = /obj/item/forging/complete/sword

/obj/item/forging/incomplete/katana
	name = "incomplete katana blade"
	icon_state = "hot_katanablade"
	spawn_item = /obj/item/forging/complete/katana

/obj/item/forging/incomplete/dagger
	name = "incomplete dagger blade"
	icon_state = "hot_daggerblade"
	spawn_item = /obj/item/forging/complete/dagger

/obj/item/forging/incomplete/staff
	name = "incomplete staff head"
	icon_state = "hot_staffhead"
	spawn_item = /obj/item/forging/complete/staff

/obj/item/forging/incomplete/spear
	name = "incomplete spear head"
	icon_state = "hot_spearhead"
	spawn_item = /obj/item/forging/complete/spear

/obj/item/forging/incomplete/axe
	name = "incomplete axe head"
	icon_state = "hot_axehead"
	spawn_item = /obj/item/forging/complete/axe

/obj/item/forging/incomplete/hammer
	name = "incomplete hammer head"
	icon_state = "hot_hammerhead"
	spawn_item = /obj/item/forging/complete/hammer

/obj/item/forging/incomplete/pickaxe
	name = "incomplete pickaxe head"
	icon_state = "hot_pickaxehead"
	spawn_item = /obj/item/forging/complete/pickaxe

/obj/item/forging/incomplete/shovel
	name = "incomplete shovel head"
	icon_state = "hot_shovelhead"
	spawn_item = /obj/item/forging/complete/shovel

//"complete" pre-complete items
/obj/item/forging/complete
	///the path of the item that will be created
	var/spawning_item

/obj/item/forging/complete/examine(mob/user)
	. = ..()
	if(spawning_item)
		. += "<span class='notice'><br>In order to finish this item, a workbench will be necessary!</span>"

/obj/item/forging/complete/chain
	name = "chain"
	desc = "A singular chain, best used in combination with multiple chains."
	icon_state = "chain"

/obj/item/forging/complete/plate
	name = "plate"
	desc = "A plate, best used in combination with multiple plates."
	icon_state = "plate"

/obj/item/forging/complete/sword
	name = "sword blade"
	desc = "A sword blade, ready to get some wood for completion."
	icon_state = "blade"
	spawning_item = /obj/item/forging/forged_weapon/sword

/obj/item/forging/complete/katana
	name = "katana blade"
	desc = "A katana blade, ready to get some wood for completion."
	icon_state = "katanablade"
	spawning_item = /obj/item/forging/forged_weapon/katana

/obj/item/forging/complete/dagger
	name = "dagger blade"
	desc = "A dagger blade, ready to get some wood for completion."
	icon_state = "daggerblade"
	spawning_item = /obj/item/forging/forged_weapon/dagger

/obj/item/forging/complete/staff
	name = "staff head"
	desc = "A staff head, ready to get some wood for completion."
	icon_state = "staffhead"
	spawning_item = /obj/item/forging/forged_weapon/staff

/obj/item/forging/complete/spear
	name = "spear head"
	desc = "A spear head, ready to get some wood for completion."
	icon_state = "spearhead"
	spawning_item = /obj/item/forging/forged_weapon/spear

/obj/item/forging/complete/axe
	name = "axe head"
	desc = "An axe head, ready to get some wood for completion."
	icon_state = "axehead"
	spawning_item = /obj/item/forging/forged_weapon/axe

/obj/item/forging/complete/hammer
	name = "hammer head"
	desc = "A hammer head, ready to get some wood for completion."
	icon_state = "hammerhead"
	spawning_item = /obj/item/forging/forged_weapon/hammer

/obj/item/forging/complete/pickaxe
	name = "pickaxe head"
	desc = "A pickaxe head, ready to get some wood for completion."
	icon_state = "pickaxehead"
	spawning_item = /obj/item/pickaxe/forged_weapon

/obj/item/forging/complete/shovel
	name = "shovel head"
	desc = "A shovel head, ready to get some wood for completion."
	icon_state = "shovelhead"
	spawning_item = /obj/item/shovel/forged_weapon

/obj/item/forging/coil
	name = "coil"
	desc = "A simple coil, comprised of coiled iron rods."
	icon_state = "coil"

/obj/item/stock_parts/cell/attackby(obj/item/attacking_item, mob/user, params)
    if(!istype(attacking_item, /obj/item/forging/coil))
      return ..()
    var/obj/item/stock_parts/cell/crank/new_crank = new(get_turf(src))
    new_crank.maxcharge = maxcharge
    new_crank.charge = charge
    qdel(attacking_item)
    qdel(src)
	return ..()
