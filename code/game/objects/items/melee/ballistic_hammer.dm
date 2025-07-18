/obj/item/melee/sledgehammer/gorlex/blasting
	name = "blasting hammer"
	icon_state = "blasting"
	base_icon_state = "blasting"
	item_state = "blasting"

	desc = "A heavily modified breaching hammer with a ammo loader welded on used by the Ramzi Clique. A brutishly powerful tool for breaking both hull and heads. Loads 12g blanks as propellent to increase it's destructive power."
	toolspeed = 0.5
	wall_decon_damage = MINERAL_WALL_INTEGRITY
	usesound = list('sound/effects/picaxe1.ogg', 'sound/effects/picaxe2.ogg', 'sound/effects/picaxe3.ogg')
	var/obj/item/ammo_box/magazine/internal/shot/blasting_hammer/magazine
	var/obj/item/ammo_casing/chambered

/obj/item/melee/sledgehammer/gorlex/blasting/Initialize()
	. = ..()
	magazine = new /obj/item/ammo_box/magazine/internal/shot/blasting_hammer(src)
	update_appearance()

/obj/item/melee/sledgehammer/gorlex/blasting/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/ammo_casing) || istype(I, /obj/item/ammo_box/magazine/ammo_stack))
		magazine.attackby(I,user)
		playsound(src,'sound/weapons/gun/shotgun/insert_shell.ogg',100)
		update_appearance()

/obj/item/melee/sledgehammer/gorlex/blasting/unique_action(mob/living/user)
	. = ..()
	if(chambered)
		chambered.on_eject(user)
	playsound(src,'sound/weapons/gun/shotgun/rack.ogg',100)
	to_chat(user, span_notice("You rack \the [src]."))
	chambered = magazine.get_round()
	update_appearance()

/obj/item/melee/sledgehammer/gorlex/blasting/attack(mob/living/target, mob/living/user)
	. = ..()
	if(chambered && HAS_TRAIT(src, TRAIT_WIELDED)) // HEY YOSHIHIDE
		if(chambered.BB)
			chambered.BB = null
			chambered.update_appearance()
			playsound(src,'sound/weapons/gun/shotgun/brimstone.ogg',100)
			target.adjust_fire_stacks(4)
			target.IgniteMob()
			target.apply_damage(40, BRUTE, user.zone_selected)
			throw_min = 5
			throw_max = 6
		else
			throw_min = initial(throw_min)
			throw_max = initial(throw_max)
	else
		throw_min = initial(throw_min)
		throw_max = initial(throw_max)

/obj/item/melee/sledgehammer/gorlex/blasting/update_icon_state()
	. = ..()
	var/is_loaded = chambered ? 1 : 0
	icon_state = "[base_icon_state]-[min((is_loaded + magazine.ammo_count()), 3)]"
	item_state = "blasting"

/obj/item/ammo_box/magazine/internal/shot/blasting_hammer
	name = "blasting hammer magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/blank
	caliber = "12ga"
	max_ammo = 2
	start_empty = TRUE
