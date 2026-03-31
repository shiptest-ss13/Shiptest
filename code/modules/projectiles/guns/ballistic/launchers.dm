//KEEP IN MIND: These are different from gun/grenadelauncher. These are designed to shoot premade rocket and grenade projectiles, not flashbangs or chemistry casings etc.
//Put handheld rocket launchers here if someone ever decides to make something so hilarious ~Paprika

/obj/item/gun/ballistic/revolver/grenadelauncher//this is only used for underbarrel grenade launchers at the moment, but admins can still spawn it if they feel like being assholes
	desc = "A break-action, single-shot grenade launcher. A compact way to deliver a big boom."
	name = "grenade launcher"
	default_ammo_type = /obj/item/ammo_box/magazine/internal/grenadelauncher
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/grenadelauncher,
	)
	fire_sound = 'sound/weapons/gun/general/grenade_launch.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	bolt_type = BOLT_TYPE_NO_BOLT
	fire_delay = 1 SECONDS
	semi_auto = TRUE
	has_safety = FALSE
	safety = FALSE
	gate_offset = 0

/obj/item/gun/ballistic/revolver/grenadelauncher/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		chamber_round()

/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg
	desc = "A heavy grenade launcher with an oversized 6-shot cylinder."
	name = "multi grenade launcher"
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_grenadelnchr"
	bad_type = /obj/item/gun/ballistic/revolver/grenadelauncher/cyborg
	default_ammo_type = /obj/item/ammo_box/magazine/internal/cylinder/grenademulti
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/cylinder/grenademulti,
	)

/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg/attack_self()
	return

GLOBAL_LIST_INIT(rpg_scrawlings, list(
	"\"FRONT TOWARDS ENEMY\"",
	"\"MY WIFE LEFT ME\"",
	"A Kepori inset in a stylized crimson heart",
	"\"Eat lead psychohazard!\"",
	"\"Portable Demotion\"",
	"A drawing of the Rilena character 'T4L1' smoking a boof",
	"\"Eat it corpo!\"",
	"A Sarathi woman in a suggestive pose",
	"A masculine Sarathi shouldering a launcher",
	"A Vox woman with a sledgehammer over their shoulder",
	"A man in a floral patterned shirt and nothing else, drawn leaning against the rocket's tube",
	"A crudely-drawn picture of a Gorlex Marauder exploding",
	"A scratched-out link to some kind of website",
	".:|:;",
	"\"SPEAR TO THE SHOAL, FOR A FREE FRONTIER!\"",
	"\"Arm this!\"",
))


/obj/item/gun/ballistic/rocketlauncher
	name = "\improper PML-9"
	desc = "A reusable rocket-propelled grenade launcher."

	icon_state = "rocketlauncher"
	item_state = "rocketlauncher"
	default_ammo_type = /obj/item/ammo_box/magazine/internal/rocketlauncher
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/rocketlauncher,
	)
	fire_sound = 'sound/weapons/gun/general/rocket_launch.ogg'
	load_sound = 'sound/weapons/gun/general/rocket_load.ogg'
	gun_firemodes = list(FIREMODE_SEMIAUTO)
	burst_size = 1
	fire_delay = 0.4 SECONDS

	weapon_weight = WEAPON_HEAVY
	w_class = WEIGHT_CLASS_BULKY

	//Bolt
	bolt_type = BOLT_TYPE_NO_BOLT
	doesnt_keep_bullet = TRUE

	///Magazine stuff
	cartridge_wording = "rocket"
	internal_magazine = TRUE
	empty_indicator = TRUE
	tac_reloads = FALSE
	casing_ejector = FALSE

	manufacturer = MANUFACTURER_SCARBOROUGH

	attack_verb = list("bludgeoned", "hit", "slammed", "whacked")

	valid_attachments = list()
	slot_available = list()

	var/rpg_scribble = null

/obj/item/gun/ballistic/rocketlauncher/Initialize()
	. = ..()
	rpg_scribble = pick(GLOB.rpg_scrawlings)
	desc += " [rpg_scribble] is scrawled on the tube"

/obj/item/gun/ballistic/rocketlauncher/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(istype(A, /obj/item/pen))
		rpg_scribble = stripped_input(user, "What are you putting on [src]?", "Rocket Launcher Doodle")
		if(!rpg_scribble || !length(rpg_scribble))
			desc = "[src::desc]"
			return
		desc = "[src::desc] [rpg_scribble] is scribbled on the body."


/obj/item/gun/ballistic/rocketlauncher/afterattack()
	. = ..()
	magazine.get_round(FALSE) //Hack to clear the mag after it's fired

/obj/item/gun/ballistic/rocketlauncher/attack_self_tk(mob/user)
	return //too difficult to remove the rocket with TK

/obj/item/gun/ballistic/rocketlauncher/solgov
	name = "Panzerfaust XII"
	desc = "The standard recoiless rifle of the Solarian Confederation. Barely varies from previous models."

	icon = 'icons/obj/guns/manufacturer/solararmories/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/solararmories/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/solararmories/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/solararmories/onmob.dmi'

	//recoiless rifles use shells
	cartridge_wording = "shell"

	icon_state = "panzerfaust"
	item_state = "panzerfaust"
	manufacturer = MANUFACTURER_SOLARARMORIES
