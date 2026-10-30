/obj/item/gun/ballistic/automatic/pistol
	bad_type = /obj/item/gun/ballistic/automatic/pistol
	bolt_type = BOLT_TYPE_LOCKING
	w_class = WEIGHT_CLASS_NORMAL

	vary_fire_sound = FALSE
	fire_sound_volume = 90
	bolt_wording = "slide"
	weapon_weight = WEAPON_LIGHT
	pickup_sound =  'sound/items/handling/gun_pickup.ogg'

	//recoil = 0.5 // apogee wants bloom, this is a placeholder until then to simulate the same concept. //UPDATE ive changed my mind on this, however i would
	recoil_unwielded = 3
	recoil_backtime_multiplier = 1

	zoom_amt = PISTOL_ZOOM

	wield_delay = 0.2 SECONDS
	fire_delay = 0.2 SECONDS
	spread = 5
	spread_unwielded = 5

	wield_slowdown = PISTOL_SLOWDOWN
	aimed_wield_slowdown = PISTOL_AIM_SLOWDOWN

	muzzleflash_iconstate = "muzzle_flash_light"
	light_range = 1

	refused_attachments = list(
		/obj/item/attachment/gun,
		)

/obj/item/gun/ballistic/automatic/pistol/commissar
	name = "\improper Commissar"
	desc = "A Makosso-Warra-issue handgun, modified with a voice box to further enhance its effectiveness in troop discipline."
	icon_state = "challenger"
	icon = 'icons/obj/guns/manufacturer/warra_sharplite/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/warra_sharplite/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/warra_sharplite/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/warra_sharplite/onmob.dmi'

	w_class = WEIGHT_CLASS_NORMAL
	default_ammo_type = /obj/item/ammo_box/magazine/co9mm
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/co9mm,
	)
	var/funnysounds = TRUE
	var/cooldown = 0
	load_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release.ogg'

	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'

	autowiki_hidden = TRUE

/obj/item/gun/ballistic/automatic/pistol/commissar/equipped(mob/living/user, slot)
	..()
	if(slot == ITEM_SLOT_HANDS && funnysounds) // We do this instead of equip_sound as we only want this to play when it's wielded
		playsound(src, 'sound/weapons/gun/commissar/pickup.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	. = ..()
	if(prob(50) && funnysounds)
		playsound(src, 'sound/weapons/gun/commissar/shot.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/shoot_with_empty_chamber(mob/living/user)
	. = ..()
	if(prob(50) && funnysounds)
		playsound(src, 'sound/weapons/gun/commissar/dry.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message)
	. = ..()
	if(bolt_locked)
		drop_bolt(user)
		if(. && funnysounds)
			playsound(src, 'sound/weapons/gun/commissar/magazine.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	funnysounds = !funnysounds
	to_chat(user, span_notice("You toggle [src]'s vox audio functions."))

/obj/item/gun/ballistic/automatic/pistol/commissar/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if((cooldown < world.time - 200) && funnysounds)
		user.audible_message("<font color='red' size='5'><b>DON'T TURN AROUND!</b></font>")
		playsound(src, 'sound/weapons/gun/commissar/dontturnaround.ogg', 50, 0, 4)
		cooldown = world.time

/obj/item/gun/ballistic/automatic/pistol/commissar/examine(mob/user)
	. = ..()
	if(funnysounds)
		. += span_info("Alt-click to use \the [src] vox hailer.")

/obj/item/gun/ballistic/automatic/pistol/disposable
	name = "disposable gun"
	desc = "An extraordinarily flimsy single-use gun manufactured out of molded plastic. While the origins of this particular design are unknown, the schematics can be found just about everywhere on the intranet. A popular choice among the particularly desperate. Chambered in .22 LR, and has ten shots - make them count."
	icon = 'icons/obj/guns/zippy.dmi'
	icon_state = "zippy"
	fire_sound = 'sound/weapons/gun/pistol/himehabu.ogg'

	w_class = WEIGHT_CLASS_SMALL
	default_ammo_type = /obj/item/ammo_box/magazine/disposable
	allowed_ammo_types = list(/obj/item/ammo_box/magazine/disposable)
	custom_materials = list(/datum/material/plastic = 2000)
	manufacturer = MANUFACTURER_NONE
	has_safety = FALSE // you get what you pay for
	safety = FALSE
	no_bolt_overlay = TRUE

	var/trigger_pull_fail = 33 // funny snowflake jam chance
	var/desc_more = null // for appending variant descriptions

/obj/item/gun/ballistic/automatic/pistol/disposable/Initialize()
	. = ..()
	if(desc_more)
		desc += " [desc_more]"

/obj/item/gun/ballistic/automatic/pistol/disposable/eject_magazine(mob/user, display_message = TRUE)
	to_chat(user, span_warning("Theres no magazine to eject!"))
	return

/obj/item/gun/ballistic/automatic/pistol/disposable/insert_magazine(mob/user)
	to_chat(user, span_warning("Theres no magazine to replace!"))
	return

/obj/item/gun/ballistic/automatic/pistol/disposable/fire_gun(atom/target, mob/living/user, flag, params)
	if(prob(trigger_pull_fail))
		balloon_alert(user, "stuck!")
		playsound(src, 'sound/weapons/gun/general/dry_fire.ogg', 50, TRUE, -15)
		return
	return ..()

// now available in fun colors
/obj/item/gun/ballistic/automatic/pistol/disposable/red
	name = "red disposable gun"
	icon_state = "zippy_red"
	desc_more = "This one is made out of a bright red plastic."

/obj/item/gun/ballistic/automatic/pistol/disposable/purple
	name = "purple disposable gun"
	icon_state = "zippy_purple"
	desc_more = "This one is made out of a bold purple plastic."

/obj/item/gun/ballistic/automatic/pistol/disposable/blue
	name = "blue disposable gun"
	icon_state = "zippy_blue"
	desc_more = "This one is made out of a deep blue plastic."

/obj/item/gun/ballistic/automatic/pistol/disposable/gold
	name = "golden disposable gun"
	icon_state = "zippy_gold"
	desc_more = "This one has an exceptionally tacky gold finish. Lucky you."

/obj/item/gun/ballistic/automatic/pistol/disposable/pink
	name = "pink disposable gun"
	icon_state = "zippy_pink"
	desc_more = "This one is made out of a rosy pink plastic."

/obj/item/gun/ballistic/automatic/pistol/disposable/green
	name = "green disposable gun"
	icon_state = "zippy_green"
	desc_more = "This one is made out of an earthy green plastic."

/obj/item/gun/ballistic/automatic/pistol/disposable/black
	name = "tactical disposable gun"
	icon_state = "zippy_black"
	desc_more = "This one is made out of a dark black plastic."

/obj/item/gun/ballistic/automatic/pistol/disposable/silver
	name = "silver disposable gun"
	icon_state = "zippy_silver"
	desc_more = "This one has a matte silver finish."

/obj/item/gun/ballistic/automatic/pistol/disposable/beige
	name = "beige disposable gun"
	icon_state = "zippy_beige"
	desc_more = "This one is made out of a dull beige plastic."

/obj/item/gun/ballistic/automatic/pistol/disposable/phenex
	name = "disposable phenex"
	icon_state = "zippy_phenex"
	desc_more = "This one has a paint job resembling the infamous HP Phenex, though you suspect its make is nowhere matching the quality."

/obj/item/gun/ballistic/automatic/pistol/disposable/inteq
	name = "PS-22 Pug"
	icon_state = "zippy_inteq"
	desc_more = "This one has a paint job resembling IRMG's weapons, though it is very clearly not official."

/obj/item/gun/ballistic/automatic/pistol/disposable/sharplite
	name = "SL X22 “Spark” Disposable Handgun"
	icon_state = "zarplite"
	desc_more = "This one has a paint job resembling a Sharplite electroplasma gun, barely disguising its true nature."

// ASPAWN INFINITE AMMO VARIANT //
/obj/item/gun/ballistic/automatic/pistol/disposable/infinite_ammo
	name = "true disposable gun"
	desc = "The brutal conclusion of arms development research. Gaze upon it and despair. Chambered in .22 LR."
	fire_delay = 0.09 SECONDS
	gun_firemodes = list(FIREMODE_FULLAUTO)
	default_firemode = FIREMODE_FULLAUTO
	wear_rate = 0
	trigger_pull_fail = 0

/obj/item/gun/ballistic/automatic/pistol/disposable/infinite_ammo/process_fire()
	. = ..()
	magazine.top_off(null, TRUE) // experimental bluespace magazine

// CHOCOLATE GUN - YOU CAN EAT IT //
/obj/item/gun/ballistic/automatic/pistol/disposable/chocolate
	name = "chocolate gun"
	desc = "What appears to be a brick of chocolate cast into the shape of a gun. Concerningly, the mechanical components still seem to be made of plastic, suggesting that this is capable of firing at least once."
	icon_state = "zippy_chocolate"
	spread = 30 // it's made of chocolate...
	spread_unwielded = 30

/obj/item/gun/ballistic/automatic/pistol/disposable/chocolate/Initialize()
	. = ..()
	AddComponent(/datum/component/edible,\
		initial_reagents = list(/datum/reagent/consumable/nutriment = 10),\
		volume = 10,\
		eat_time = 1 SECONDS,\
		tastes = list("single-use plastics" = 10, "expired chocolate" = 10, "gun" = 5),\
		foodtypes = TOXIC | GROSS,\
		bite_consumption = 2,\
		after_eat = CALLBACK(src, PROC_REF(crunchy)))

// called when we eat the chocolate gun by ^ that callback right there
/obj/item/gun/ballistic/automatic/pistol/disposable/chocolate/proc/crunchy(mob/eater, mob/feeder)
	process_fire(eater, feeder, FALSE, null, BODY_ZONE_HEAD) // hope it isn't loaded

/obj/item/gun/ballistic/automatic/pistol/disposable/chocolate/attack(mob/victim, mob/user)
	var/datum/component/edible/my_component = GetComponent(/datum/component/edible)
	my_component.TryToEat(victim, user) // abhorrent! but it works
	return ..()

//not technically a pistol but whatever
/obj/item/gun/ballistic/automatic/pistol/derringer
	name = "HP Spark"
	desc = "An easily concealable derringer. Its simple design and modest demand make the Spark a common project for trainee HP gunsmiths. Chambered in .38."
	icon_state = "derringer"
	item_state = "hp_generic"

	icon = 'icons/obj/guns/manufacturer/hunterspride/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/hunterspride/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/hunterspride/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/hunterspride/onmob.dmi'
	manufacturer = MANUFACTURER_HUNTERSPRIDE

	default_ammo_type = /obj/item/ammo_box/magazine/internal/derr38
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/derr38,
	)
	fire_sound = 'sound/weapons/gun/revolver/shot.ogg'
	load_sound = 'sound/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/weapons/gun/revolver/empty.ogg'
	fire_sound_volume = 60
	dry_fire_sound = 'sound/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	w_class = WEIGHT_CLASS_TINY
	gun_firemodes = list(FIREMODE_SEMIAUTO, FIREMODE_BURST)

/obj/item/gun/ballistic/automatic/pistol/derringer/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //legacy var name maturity
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/automatic/pistol/derringer/examine(mob/user)
	. = ..()
	var/live_ammo = get_ammo(FALSE, FALSE)
	. += "[live_ammo ? live_ammo : "None"] of those are live rounds."

/obj/item/gun/ballistic/automatic/pistol/derringer/traitor
	name = "D-9 \"Temblor\""
	desc = "An easily concealable derriger. It was rarely used as an alternative to the PC-81 \"Himehabu\" during covert operations. Chambered in .357."

	icon = 'icons/obj/guns/manufacturer/scarborough/48x32.dmi'
	lefthand_file = 'icons/obj/guns/manufacturer/scarborough/lefthand.dmi'
	righthand_file = 'icons/obj/guns/manufacturer/scarborough/righthand.dmi'
	mob_overlay_icon = 'icons/obj/guns/manufacturer/scarborough/onmob.dmi'
	manufacturer = MANUFACTURER_SCARBOROUGH

	icon_state = "derringer_syndie"
	item_state = "sa_generic"
	default_ammo_type = /obj/item/ammo_box/magazine/internal/derr357
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/derr357,
	)
	fire_sound_volume = 50 //Tactical stealth firing

/obj/item/gun/ballistic/automatic/pistol/derringer/gold
	name = "golden derringer"
	desc = "The golden sheen is somewhat counter-intuitive on a holdout weapon, but it looks cool. Uses .357 ammo."
	icon_state = "derringer_gold"
	default_ammo_type = /obj/item/ammo_box/magazine/internal/derr357
	allowed_ammo_types = list(
		/obj/item/ammo_box/magazine/internal/derr357,
	)
	manufacturer = MANUFACTURER_NONE

EMPTY_GUN_HELPER(automatic/pistol/derringer)
