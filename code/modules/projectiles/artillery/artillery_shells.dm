/obj/item/mortal_shell
	name = "\improper 80mm mortar shell"
	desc = "An unlabeled 80mm mortar shell, probably a casing."
	icon = 'icons/obj/machines/mortar.dmi'
	icon_state = "mortar_ammo_he"
	w_class = WEIGHT_CLASS_SMALL
	///Ammo projectile typepath that the shell uses
	var/obj/projectile/bullet/ammo_type

/obj/item/mortal_shell/he
	name = "\improper 80mm high explosive mortar shell"
	desc = "An 80mm mortar shell, loaded with a high explosive charge."
	icon_state = "mortar_ammo_he"
	ammo_type = /obj/projectile/bullet/mortar/he

/obj/item/mortal_shell/incendiary
	name = "\improper 80mm incendiary mortar shell"
	desc = "An 80mm mortar shell, loaded with a napalm charge."
	icon_state = "mortar_ammo_inc"
	ammo_type = /obj/projectile/bullet/mortar/incend

/obj/item/mortal_shell/smoke
	name = "\improper 80mm smoke mortar shell"
	desc = "An 80mm mortar shell, loaded with smoke dispersal agents. Can be fired at friendlies more-or-less safely. Way slimmer than your typical 80mm."
	icon_state = "mortar_ammo_smoke"
	ammo_type = /obj/projectile/bullet/mortar/smoke

/obj/item/mortal_shell/flare
	name = "\improper 80mm flare mortar shell"
	desc = "An 80mm mortar shell, loaded with an illumination flare, far slimmer than your typical 80mm shell. Can be fired out of larger cannons."
	icon_state = "mortar_ammo_flare"
	ammo_type = /obj/projectile/bullet/mortar/flare

/obj/item/mortal_shell/airburst
	name = "\improper 80mm airburst mortar shell"
	desc = "An 80mm mortar shell, loaded with an a shrapnel payload, detonated midair for maximum infantry damage."
	icon_state = "mortar_ammo_airburst"
	ammo_type = /obj/projectile/bullet/mortar/airburst

/obj/item/mortal_shell/howitzer
	name = "\improper 150mm artillery shell"
	desc = "An unlabeled 150mm shell, probably a casing."
	icon = 'icons/obj/machines/howitzer.dmi'
	icon_state = "howitzer"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/mortal_shell/howitzer/incendiary
	name = "\improper 150mm incendiary artillery shell"
	desc = "An 150mm artillery shell, loaded with explosives to punch through light structures then burn out whatever is on the other side. Will ruin their day and skin."
	icon_state = "howitzer_ammo_incend"
	ammo_type = /obj/projectile/bullet/mortar/howi/incend

/obj/item/mortal_shell/howitzer/he
	name = "\improper 150mm artillery shell"
	desc = "An 150mm incendiary shell, loaded with a high explosive charge."
	icon = 'icons/obj/machines/howitzer.dmi'
	icon_state = "howitzer_ammo"
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = /obj/projectile/bullet/mortar/howi/he

/obj/item/mortal_shell/howitzer/smoke
	name = "\improper 150mm smoke artillery shell"
	desc = "An 150mm artillery shell, loaded with smoke dispersal agents. Can be fired at friendlies more-or-less safely."
	icon_state = "howitzer_ammo_smoke"
	ammo_type = /obj/projectile/bullet/mortar/smoke

/obj/item/mortal_shell/howitzer/flare
	name = "\improper 150mm flare artillery shell"
	desc = "An 150mm artillery shell, loaded with an illumination flare, lighting up large radius while dazzling anyone in the area."
	icon_state = "howitzer_ammo_flare"
	ammo_type = /obj/projectile/bullet/mortar/flare

/obj/item/mortal_shell/howitzer/airburst
	name = "\improper 150mm airburst artillery shell"
	desc = "An 150mm artillery shell, loaded with an a shrapnel payload, detonated midair for maximum infantry damage."
	icon_state = "howitzer_ammo_airburst"
	ammo_type = /obj/projectile/bullet/mortar/howi/airburst

//Rockets
/obj/item/mortal_shell/rocket/he
	name = "\improper 200mm rocket"
	desc = "A 200mm guided rocket loaded with explosives, meant to be used at long range."
	icon_state = "mortar_ammo_he"
	ammo_type = /obj/projectile/bullet/mortar/rocket/he

/obj/item/mortal_shell/rocket/incendiary
	name = "\improper 200mm incendiary rocket"
	desc = "A 200mm guided rocket loaded with an incendiary payload with a minor side of explosive."
	icon_state = "mortar_ammo_inc"
	ammo_type = /obj/projectile/bullet/mortar/rocket/incend
