// Shotgun

/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A 12-gauge lead slug."
	icon_state = "slug"
	caliber = "12ga"
	custom_materials = list(/datum/material/iron=4000)
	projectile_type = /obj/projectile/bullet/slug
	stack_size = 8 //Make sure this matches max_ammo variable on prefilled stacks (magazine/ammo_stack/prefilled)

	bounce_sfx_override = 'sound/weapons/gun/general/bulletcasing_shotgun_bounce.ogg'

/obj/item/ammo_casing/shotgun/update_icon_state()
	icon_state = "[initial(icon_state)][BB ? "" : "-spent"]"
	return ..()

/obj/item/ammo_casing/shotgun/buckshot
	name = "buckshot shell"
	desc = "A 12-gauge buckshot shell."
	icon_state = "buckshot"
	projectile_type = /obj/projectile/bullet/pellet/buckshot
	pellets = 8
	variance = 25

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag slug"
	desc = "A weak beanbag slug for riot control."
	icon_state = "beanbag"
	custom_materials = list(/datum/material/iron=250)
	projectile_type = /obj/projectile/bullet/slug/beanbag

/obj/item/ammo_casing/shotgun/rubbershot
	name = "rubber shot"
	desc = "A shotgun casing filled with densely-packed rubber balls, used to incapacitate crowds from a distance."
	icon_state = "rubber"
	projectile_type = /obj/projectile/bullet/pellet/rubbershot
	pellets = 8
	variance = 25
	custom_materials = list(/datum/material/iron=4000)

/obj/item/ammo_casing/shotgun/incendiary
	name = "incendiary slug"
	desc = "An incendiary-coated shotgun slug."
	icon_state = "incendiary"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun

/obj/item/ammo_casing/shotgun/blank
	name = "blank shell"
	desc = "A shell packed with powder but no projectile."
	icon_state = "blank"
	projectile_type = /obj/projectile/bullet/pellet/blank
	custom_materials = list(/datum/material/iron=250)

/obj/item/ammo_casing/shotgun/improvised
	name = "improvised shell"
	desc = "An extremely weak shotgun shell with multiple small pellets made out of metal shards."
	icon_state = "improvised"
	projectile_type = /obj/projectile/bullet/pellet/improvised
	custom_materials = list(/datum/material/iron=250)
	pellets = 10
	variance = 25

/obj/item/ammo_casing/shotgun/incapacitate
	name = "custom incapacitating shot"
	desc = "A shotgun casing filled with... something. Used to incapacitate targets."
	icon_state = "bounty"
	projectile_type = /obj/projectile/bullet/pellet/rubbershot/incapacitate
	pellets = 12//double the pellets, but half the stun power of each, which makes this best for just dumping right in someone's face.
	variance = 25
	custom_materials = list(/datum/material/iron=4000)

/obj/item/ammo_casing/shotgun/stunslug
	name = "taser slug"
	desc = "A stunning taser slug."
	icon_state = "taser"
	projectile_type = /obj/projectile/bullet/slug/stun
	custom_materials = list(/datum/material/iron=250)

/obj/item/ammo_casing/shotgun/dart
	name = "shotgun dart"
	desc = "A dart for use in shotguns. Can be injected with up to thirty units of any chemical."
	icon_state = "dart"
	projectile_type = /obj/projectile/bullet/dart
	var/reagent_amount = 30

/obj/item/ammo_casing/shotgun/dart/Initialize()
	. = ..()
	create_reagents(reagent_amount, OPENCONTAINER)

/obj/item/ammo_casing/shotgun/dart/attackby()
	return

/obj/item/ammo_casing/shotgun/dart/bioterror
	desc = "A shotgun dart filled with deadly toxins."

/obj/item/ammo_casing/shotgun/dart/bioterror/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/neurotoxin, 6)
	reagents.add_reagent(/datum/reagent/toxin/spore, 6)
	reagents.add_reagent(/datum/reagent/toxin/mutetoxin, 6) //;HELP OPS IN MAINT
	reagents.add_reagent(/datum/reagent/toxin/coniine, 6)
	reagents.add_reagent(/datum/reagent/toxin/sodium_thiopental, 6)

/*
		Tech Shells
*/

/obj/item/ammo_casing/shotgun/techshell
	name = "unloaded technological shell"
	desc = "A high-tech shotgun shell which can be loaded with materials to produce unique effects."
	icon_state = "techblank"
	projectile_type = null

/obj/item/ammo_casing/shotgun/dragonsbreath
	name = "dragonsbreath shell"
	desc = "A shotgun shell which fires a spread of incendiary pellets."
	icon_state = "dragonsbreath"
	projectile_type = /obj/projectile/bullet/incendiary/shotgun/dragonsbreath
	pellets = 8
	variance = 45

/obj/item/ammo_casing/shotgun/meteorslug
	name = "meteorslug shell"
	desc = "A shotgun shell rigged with CMC technology, which launches a massive slug when fired."
	icon_state = "meteor"
	projectile_type = /obj/projectile/bullet/slug/meteor

/obj/item/ammo_casing/shotgun/frag12
	name = "FRAG-12 slug"
	desc = "A high explosive breaching round for a 12 gauge shotgun."
	icon_state = "frag12"
	projectile_type = /obj/projectile/bullet/slug/frag12

/obj/item/ammo_casing/shotgun/ion
	name = "ion shell"
	desc = "An advanced shotgun shell which uses a micro laser to focus the effects of an EMP reaction to produce an effect similar to a standard ion rifle. \
	The more uncontrolled nature of the reaction causes the pulse to spread into multiple individually weaker bolts."
	icon_state = "ion"
	projectile_type = /obj/projectile/ion/weak
	pellets = 8
	variance = 25

/obj/item/ammo_casing/shotgun/laserscatter
	name = "scatter laser shell"
	desc = "An advanced shotgun shell that uses a micro laser to replicate the effects of a scatter laser weapon in a ballistic package."
	icon_state = "laser"
	projectile_type = /obj/projectile/beam/weak
	pellets = 8
	variance = 25

/obj/item/ammo_casing/shotgun/pulseslug
	name = "pulse slug"
	desc = "A delicate device which can be loaded into a shotgun. The primer acts as a button which triggers the gain medium and fires a powerful \
	energy blast. While the heat and power drain limit it to one use, it can still allow an operator to engage targets that ballistic ammunition \
	would have difficulty with."
	icon_state = "pulse"
	projectile_type = /obj/projectile/beam/pulse/shotgun

/obj/item/ammo_casing/shotgun/buckshot/twobore
	name = "two-bore shell"
	desc = "A massive fucking two-bore shell."
	caliber = "twobore"
	projectile_type = /obj/projectile/bullet/pellet/buckshot/twobore
	pellets = 6
	variance = 20
	transform = matrix(2, 0, 0, 0, 2, 0)
