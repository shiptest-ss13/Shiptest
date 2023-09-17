/obj/item/gun/ballistic/automatic/hmg
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = 0
	weapon_weight = WEAPON_HEAVY
	burst_size = 1
	actions_types = list()
	slowdown = 1
	drag_slowdown = 1.5


// L6 SAW //

/obj/item/gun/ballistic/automatic/hmg/l6_saw
	name = "\improper L6 SAW"
	desc = "A heavy machine gun, designated 'L6 SAW'. Has 'Aussec Armoury - 490 FS' engraved on the receiver below the designation. Chambered in 7.12x82mm."
	icon_state = "l6"
	item_state = "l6closedmag"
	base_icon_state = "l6"
	mag_type = /obj/item/ammo_box/magazine/mm712x82
	can_suppress = FALSE
	spread = 7
	bolt_type = BOLT_TYPE_OPEN
	mag_display = TRUE
	mag_display_ammo = TRUE
	tac_reloads = FALSE
	fire_sound = 'sound/weapons/gun/l6/shot.ogg'
	rack_sound = 'sound/weapons/gun/l6/l6_rack.ogg'
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	var/cover_open = FALSE

/obj/item/gun/ballistic/automatic/hmg/l6_saw/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)

/obj/item/gun/ballistic/automatic/hmg/l6_saw/examine(mob/user)
	. = ..()
	. += "<b>alt + click</b> to [cover_open ? "close" : "open"] the dust cover."
	if(cover_open && magazine)
		. += "<span class='notice'>It seems like you could use an <b>empty hand</b> to remove the magazine.</span>"


/obj/item/gun/ballistic/automatic/hmg/l6_saw/AltClick(mob/user)
	cover_open = !cover_open
	to_chat(user, "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>")
	playsound(user, 'sound/weapons/gun/l6/l6_door.ogg', 60, TRUE)
	update_appearance()


/obj/item/gun/ballistic/automatic/hmg/l6_saw/update_overlays()
	. = ..()
	. += "l6_door_[cover_open ? "open" : "closed"]"


/obj/item/gun/ballistic/automatic/hmg/l6_saw/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(cover_open)
		to_chat(user, "<span class='warning'>[src]'s cover is open! Close it before firing!</span>")
		return
	else
		. = ..()
		update_appearance()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/gun/ballistic/automatic/hmg/l6_saw/attack_hand(mob/user)
	if (loc != user)
		..()
		return
	if (!cover_open)
		to_chat(user, "<span class='warning'>[src]'s cover is closed! Open it before trying to remove the magazine!</span>")
		return
	..()

/obj/item/gun/ballistic/automatic/hmg/l6_saw/attackby(obj/item/A, mob/user, params)
	if(!cover_open && istype(A, mag_type))
		to_chat(user, "<span class='warning'>[src]'s dust cover prevents a magazine from being fit.</span>")
		return
	..()

/obj/item/gun/ballistic/automatic/hmg/solar
	name = "\improper Solar"
	desc = "The TerraGov HMG-169, designed in 169 FS, nicknamed 'Solar.' A inscription reads: 'PROPERTY OF TERRAGOV', with 'TERRAGOV' poorly scribbled out, and replaced by 'SOLAR ARMORIES.' Chambered in 4.73×33mm caseless ammunition."
	icon_state = "solar"
	fire_sound = 'sound/weapons/gun/l6/shot.ogg'
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/rifle47x33mm
	spread = 7
	can_suppress = FALSE
	can_bayonet = FALSE
	mag_display = TRUE
	w_class = WEIGHT_CLASS_BULKY

/obj/item/gun/ballistic/automatic/hmg/solar/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.2 SECONDS)
