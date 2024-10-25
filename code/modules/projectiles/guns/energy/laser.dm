/obj/item/gun/energy/laser
	name = "SL L-204 laser gun"
	desc = "A basic energy-based laser gun that fires concentrated beams of light which pass through glass and thin metal."

	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=2000)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	ammo_x_offset = 1
	shaded_charge = TRUE
	supports_variations = VOX_VARIATION
	manufacturer = MANUFACTURER_SHARPLITE_NEW

	spread = 0
	spread_unwielded = 10

/obj/item/gun/energy/laser/empty_cell
	spawn_no_ammo = TRUE

/obj/item/gun/energy/laser/practice
	name = "practice laser gun"
	desc = "A modified version of the L-204 laser gun, this one fires less concentrated energy bolts designed for target practice."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/practice)
	item_flags = NONE

/obj/item/gun/energy/laser/retro
	name ="SL L-104 retro laser gun"
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "retro"
	desc = "An antiquated model of the basic lasergun, no longer used or sold by Sharplite. Nevertheless, the sheer popularity of this model makes it a somewhat common sight to this day."
	ammo_x_offset = 3
	manufacturer = MANUFACTURER_SHARPLITE


/obj/item/gun/energy/laser/captain
	name = "antique laser gun"
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "caplaser"
	item_state = null
	desc = "This is the SL X-00, an antique laser gun, out of production for decades and well beyond anyone's capacity to recreate. All craftsmanship is of the highest quality. It is decorated with ashdrake leather and chrome. The gun menaces with spikes of energy. On the item is an image of a space station. The station is exploding."
	force = 10
	ammo_x_offset = 3
	selfcharge = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	manufacturer = MANUFACTURER_SHARPLITE

/obj/item/gun/energy/laser/captain/brazil
	icon_state = "capgun_brazil"
	item_state = "caplaser"
	desc = "This is the SL X-00, an antique laser gun, out of production for decades and well beyond anyone's capacity to recreate. It seems all the high quality materials it was once made of are now scratched up and torn. The nuclear power cell has been removed, and the gun will no longer automatically recharge."
	selfcharge = FALSE

/obj/item/gun/energy/laser/captain/scattershot
	name = "scatter shot laser rifle"
	desc = "An industrial-grade heavy-duty laser rifle with a modified laser lens to scatter its shot into multiple smaller lasers. The inner-core can self-charge for theoretically infinite use."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)
	shaded_charge = FALSE

/obj/item/gun/energy/laser/cyborg
	can_charge = FALSE
	desc = "An energy-based laser gun that draws power from the cyborg's internal energy cell directly. So this is what freedom looks like?"
	use_cyborg_cell = TRUE
	manufacturer = MANUFACTURER_NONE

/obj/item/gun/energy/laser/cyborg/emp_act()
	return

/obj/item/gun/energy/laser/scatter
	name = "scatter laser gun"
	desc = "A laser gun equipped with a refraction kit that spreads bolts."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)
	manufacturer = MANUFACTURER_NONE

/obj/item/gun/energy/laser/scatter/shotty
	name = "energy shotgun"
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "cshotgun"
	item_state = "shotgun"
	desc = "A combat shotgun gutted and refitted with an internal laser system. Can switch between taser and scattered disabler shots."
	shaded_charge = FALSE
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/scatter, /obj/item/ammo_casing/energy/electrode)
	manufacturer = MANUFACTURER_NONE

///Laser Cannon

/obj/item/gun/energy/lasercannon
	name = "accelerator laser cannon"
	desc = "An advanced laser cannon that does more damage the farther away the target is."
	icon_state = "lasercannon"
	item_state = "laser"
	w_class = WEIGHT_CLASS_BULKY
	default_ammo_type = /obj/item/stock_parts/cell/gun/large
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/large,
	)
	force = 10
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/laser/accelerator)
	ammo_x_offset = 3
	manufacturer = MANUFACTURER_SHARPLITE

/obj/item/ammo_casing/energy/laser/accelerator
	projectile_type = /obj/projectile/beam/laser/accelerator
	select_name = "accelerator"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'
	e_cost = 5000

/obj/projectile/beam/laser/accelerator
	name = "accelerator laser"
	icon_state = "scatterlaser"
	range = 255
	damage = 6

/obj/projectile/beam/laser/accelerator/Range()
	..()
	damage += 7
	transform *= 1 + ((damage/7) * 0.2)//20% larger per tile

/obj/item/gun/energy/xray
	name = "\improper X-ray laser gun"
	desc = "A high-power laser gun capable of expelling concentrated X-ray blasts that pass through multiple soft targets and heavier materials."
	icon_state = "xray"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/xray)
	ammo_x_offset = 3

////////Laser Tag////////////////////

/obj/item/gun/energy/laser/bluetag
	name = "laser tag gun"
	icon_state = "bluetag"
	desc = "A retro laser gun modified to fire harmless blue beams of light. Sound effects included!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag)
	item_flags = NONE
	ammo_x_offset = 2
	selfcharge = TRUE
	manufacturer = MANUFACTURER_NONE

/obj/item/gun/energy/laser/bluetag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag/hitscan)

/obj/item/gun/energy/laser/redtag
	name = "laser tag gun"
	icon_state = "redtag"
	desc = "A retro laser gun modified to fire harmless beams red of light. Sound effects included!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag)
	item_flags = NONE
	ammo_x_offset = 2
	selfcharge = TRUE
	manufacturer = MANUFACTURER_NONE

/obj/item/gun/energy/laser/redtag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag/hitscan)

/obj/item/gun/energy/laser/iot
	name = "\improper SL E-255 Ultimate"
	desc = "An energy shotgun with an integrated computer system for surveillance and statistics tracking."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'

	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	icon_state = "iotshotgun"
	item_state = "shotgun_combat"
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/scatter/ultima)
	var/obj/item/modular_computer/integratedNTOS
	var/NTOS_type = /obj/item/modular_computer/internal
	manufacturer = MANUFACTURER_SHARPLITE_NEW

/obj/item/gun/energy/laser/iot/Initialize()
	. = ..()
	if(NTOS_type)
		integratedNTOS = new NTOS_type(src)
		integratedNTOS.physical = src

/obj/item/gun/energy/laser/iot/attack_self(mob/user)
	. = ..()
	if(!integratedNTOS)
		return
	integratedNTOS.interact(user)

/obj/item/gun/energy/laser/iot/lethal
	desc = "An energy shotgun with an integrated computer system for surveillance and statistics tracking. This one appears to be modified to fire lethal beams."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/ultima)

/obj/item/gun/energy/laser/hitscanpistol
	name = "experimental laser gun"
	desc = "A highly experimental laser gun, with unknown inner workings. It has no markings besides a \"GROUP A\" inscription on the barrel."
	icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/nanotrasen_sharplite/onmob.dmi'
	icon_state = "hitscangun"
	item_state = "gun"
	ammo_x_offset = 2
	charge_sections = 4
	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/stock_parts/cell/gun/mini
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/mini,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/hitscan)
	manufacturer = MANUFACTURER_SHARPLITE_NEW

/obj/item/gun/energy/laser/hitscanpistol/examine_more(mob/user)
	if(in_range(src, user) || isobserver(user))
		. = list("<span class='notice'>You examine [src] closer. Under the grip is a small inscription: \"NT CN SVALINN 462\".</span>")
	else
		. = list("<span class='warning'>You try to examine [src] closer, but you're too far away.</span>")

/obj/item/gun/energy/laser/e10
	name = "E-10 laser pistol"
	desc = "A very old laser weapon. Despite the extreme age of some of these weapons, they are sometimes preferred to newer, mass-produced Nanotrasen laser weapons."
	icon = 'icons/obj/guns/manufacturer/eoehoma/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/eoehoma/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/eoehoma/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/eoehoma/onmob.dmi'
	icon_state = "e10"
	w_class = WEIGHT_CLASS_SMALL

	wield_delay = 0.2 SECONDS
	wield_slowdown = 0.15

	spread = 2
	spread_unwielded = 5

	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/eoehoma)
	manufacturer = MANUFACTURER_EOEHOMA

/obj/item/gun/energy/laser/e50
	name = "E-50 energy emitter"
	desc = "A heavy and extremely powerful laser. Sets targets on fire and kicks ass, but it uses a massive amount of energy per shot and is generally awkward to handle."

	icon = 'icons/obj/guns/manufacturer/eoehoma/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/eoehoma/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/eoehoma/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/eoehoma/onmob.dmi'
	icon_state = "e50"
	item_state = "e50"

	default_ammo_type = /obj/item/stock_parts/cell/gun/large
	allowed_ammo_types = list(
		/obj/item/stock_parts/cell/gun/large,
	)
	ammo_type = list(/obj/item/ammo_casing/energy/laser/eoehoma/e50)
	weapon_weight = WEAPON_HEAVY
	manufacturer = MANUFACTURER_EOEHOMA

	wield_delay = 0.7 SECONDS
	wield_slowdown = 0.6
	spread_unwielded = 20

	shaded_charge = FALSE
	ammo_x_offset = 4
	charge_sections = 2
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = 0


