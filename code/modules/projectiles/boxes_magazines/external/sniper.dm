/obj/item/ammo_box/magazine/sniper_rounds
	name = "anti-materiel rifle magazine (.50)"
	icon_state = ".50mag"
	base_icon_state = ".50mag"
	desc = "A large, heavy box magazine designed to chamber massive .50 BMG rounds."
	ammo_type = /obj/item/ammo_casing/p50
	max_ammo = 6
	caliber = ".50 BMG"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine/sniper_rounds/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][ammo_count() ? "-ammo" : ""]"

/obj/item/ammo_box/magazine/sniper_rounds/soporific
	name = "anti-materiel rifle magazine (Zzzzz)"
	desc = "A lower-capacity anti-materiel rifle magazine designed for specialized, soporific .50 BMG rounds."
	icon_state = "soporific"
	ammo_type = /obj/item/ammo_casing/p50/soporific
	max_ammo = 3

/obj/item/ammo_box/magazine/sniper_rounds/penetrator
	name = "anti-materiel rifle magazine (penetrator)"
	desc = "A box magazine loaded with armor-piercing .50 BMG rounds powerful enough to punch through multiple targets and structures."
	ammo_type = /obj/item/ammo_casing/p50/penetrator
	max_ammo = 5
