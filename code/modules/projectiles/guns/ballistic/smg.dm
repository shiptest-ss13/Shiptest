/obj/item/gun/ballistic/automatic/smg
	burst_size = 1
	actions_types = list()

/obj/item/gun/ballistic/automatic/smg/proto
	name = "\improper Nanotrasen Saber SMG"
	desc = "A prototype full auto 9mm submachine gun, designated 'SABR'. Has a threaded barrel for suppressors and a folding stock."
	icon_state = "saber"
	actions_types = list()
	mag_type = /obj/item/ammo_box/magazine/smgm9mm
	pin = null
	bolt_type = BOLT_TYPE_LOCKING
	mag_display = TRUE

/obj/item/gun/ballistic/automatic/smg/proto/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.25 SECONDS)

/obj/item/gun/ballistic/automatic/smg/proto/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/smg/c20r
	name = "\improper C-20r SMG"
	desc = "A bullpup .45 SMG, designated 'C-20r'. Has a 'Scarborough Arms - Per falcis, per pravitas' buttstamp."
	icon_state = "c20r"
	item_state = "c20r"
	mag_type = /obj/item/ammo_box/magazine/smgm45
	can_bayonet = TRUE
	can_suppress = FALSE
	knife_x_offset = 26
	knife_y_offset = 12
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE

/obj/item/gun/ballistic/automatic/smg/c20r/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.25 SECONDS)

/obj/item/gun/ballistic/automatic/smg/c20r/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/smg/c20r/Initialize()
	. = ..()
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/c20r/cobra
	name = "\improper Cobra 20"
	desc = "An older model of SMG manufactured by Scarborough Arms, a predecessor to the military C-20 series. Chambered in .45. "
	can_bayonet = FALSE

	icon_state = "cobra20"
	item_state = "cobra20"

/obj/item/gun/ballistic/automatic/smg/inteq
	name = "\improper SkM-44(k)"
	desc = "An extreme modification of an obsolete assault rifle, converted into a compact submachine gun by IRMG. Chambered in 10mm."
	icon_state = "inteqsmg"
	item_state = "inteqsmg"
	mag_type = /obj/item/ammo_box/magazine/smgm10mm
	can_bayonet = FALSE
	can_flashlight = TRUE
	flight_x_offset = 15
	flight_y_offset = 13
	can_suppress = TRUE
	mag_display = TRUE

/obj/item/gun/ballistic/automatic/smg/inteq/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.25 SECONDS)

/obj/item/gun/ballistic/automatic/smg/wt550
	name = "\improper WT-550 Automatic Rifle"
	desc = "An outdated personal defence weapon. Uses 4.6x30mm rounds and is designated the WT-550 Automatic Rifle."
	icon_state = "wt550"
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/wt550m9
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 1
	actions_types = list()
	can_bayonet = TRUE
	knife_x_offset = 25
	knife_y_offset = 12
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE

/obj/item/gun/ballistic/automatic/smg/wt550/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.25 SECONDS)

/obj/item/gun/ballistic/automatic/smg/mini_uzi
	name = "\improper Type U3 Uzi"
	desc = "A lightweight submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "uzi"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	burst_size = 2
	bolt_type = BOLT_TYPE_OPEN
	mag_display = TRUE
	rack_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'

/obj/item/gun/ballistic/automatic/smg/mini_uzi/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.25 SECONDS)

/obj/item/gun/ballistic/automatic/smg/vector
	name = "\improper Vector carbine"
	desc = "A police carbine based off of an SMG design, with most of the complex workings removed for reliability. Chambered in 9mm."
	icon_state = "vector"
	item_state = "vector"
	mag_type = /obj/item/ammo_box/magazine/smgm9mm/rubbershot //you guys remember when the autorifle was chambered in 9mm
	bolt_type = BOLT_TYPE_LOCKING
	mag_display = TRUE
	weapon_weight = WEAPON_LIGHT

/obj/item/gun/ballistic/automatic/smg/vector/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.25 SECONDS)

/obj/item/gun/ballistic/automatic/smg/m90
	name = "\improper M-90gl Carbine"
	desc = "A three-round burst 5.56 toploading carbine, designated 'M-90gl'. Has an attached underbarrel grenade launcher which can be toggled on and off."
	icon_state = "m90"
	item_state = "m90"
	mag_type = /obj/item/ammo_box/magazine/m556
	can_suppress = FALSE
	actions_types = list(/datum/action/item_action/toggle_firemode)
	var/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel
	burst_size = 3
	fire_delay = 2
	pin = /obj/item/firing_pin/implant/pindicate
	mag_display = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/weapons/gun/rifle/shot_alt.ogg'

/obj/item/gun/ballistic/automatic/smg/m90/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/m90/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/smg/m90/unrestricted/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted(src)
	update_appearance()

/obj/item/gun/ballistic/automatic/smg/m90/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		underbarrel.afterattack(target, user, flag, params)
	else
		return ..()

/obj/item/gun/ballistic/automatic/smg/m90/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.magazine.ammo_type))
			underbarrel.attack_self()
			underbarrel.attackby(A, user, params)
	else
		..()

/obj/item/gun/ballistic/automatic/smg/m90/update_overlays()
	. = ..()
	switch(select)
		if(0)
			. += "[initial(icon_state)]_semi"
		if(1)
			. += "[initial(icon_state)]_burst"
		if(2)
			. += "[initial(icon_state)]_gren"

/obj/item/gun/ballistic/automatic/smg/m90/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select = 1
			burst_size = initial(burst_size)
			fire_delay = initial(fire_delay)
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select = 2
			to_chat(user, "<span class='notice'>You switch to grenades.</span>")
		if(2)
			select = 0
			burst_size = 1
			fire_delay = 0
			to_chat(user, "<span class='notice'>You switch to semi-auto.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, TRUE)
	update_appearance()
	return

/obj/item/gun/ballistic/automatic/smg/thompson
	name = "\improper Thompson"
	desc = "A old submachinegun design. Chambered in .45."
	icon_state = "tommygun"
	item_state = "tommygun"
	icon = 'icons/obj/guns/48x32guns.dmi'
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/smgm45
	can_suppress = FALSE
	burst_size = 1
	actions_types = list()
	fire_delay = 1
	bolt_type = BOLT_TYPE_OPEN

/obj/item/gun/ballistic/automatic/smg/thompson/Initialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.25 SECONDS)

/obj/item/gun/ballistic/automatic/smg/thompson/drum
	name = "\improper Chicago Typewriter"
	desc = "A gun for good fellas. Chambered in .45."
	mag_type = /obj/item/ammo_box/magazine/smgm45/drum

/obj/item/gun/ballistic/automatic/smg/cm5
	name = "\improper CM-5"
	desc = "The standard issue SMG of the CMM. One of the few firearm designs that were left mostly intact from the designs found on the UNSV Lichtenstein. Chambered in 9mm."
	icon_state = "cm5"
	item_state = "cm5"
	mag_type = /obj/item/ammo_box/magazine/smgm9mm
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'sound/weapons/gun/smg/smg_light.ogg'

/obj/item/gun/ballistic/automatic/smg/cm5/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.25 SECONDS)

/obj/item/gun/ballistic/automatic/smg/aks74u
	name = "\improper AKS-74U"
	desc = "A pre-FTL era carbine, the \"curio\" status of the weapon and its extreme fire rate make it perfect for bandits, pirates and colonists on a budget."
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon_state = "aks74u"
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	item_state = "aks74u"
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/aks74u

/obj/item/gun/ballistic/automatic/smg/aks74u/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/automatic_fire, 0.15 SECONDS) //last autofire system made the fire rate REALLY fucking fast, but because of how poor it was, it was normal speed.
