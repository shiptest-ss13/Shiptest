/obj/item/gun/ballistic/automatic/solar
	name = "SolGov assault rifle"
	desc = "The end result of 12 years of work by SolarGarrison's R&D division. Chambered in 4.73×33mm caseless ammunition."
	icon_state = "solar"
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	item_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/rifle47x33mm
	can_suppress = FALSE
	fire_rate = 5
	actions_types = list()
	can_bayonet = FALSE
	mag_display = TRUE
	w_class = WEIGHT_CLASS_BULKY

/obj/item/gun/ballistic/automatic/pistol/commander
	name = "\improper Commander"
	desc = "A modification on the classic 1911 handgun, this one is chambered in 9mm. Much like its predecessor, it suffers from low capacity."
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
	icon_state = "commander"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/co9mm
	can_suppress = FALSE
/obj/item/gun/ballistic/automatic/pistol/commander/no_mag
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/commissar
	name = "\improper Commissar"
	desc = "A custom-designed 1911 handgun to further enhance it's effectiveness in troop discipline."
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
	icon_state = "commander"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/co9mm
	can_suppress = FALSE
	var/funnysounds = TRUE
	var/cooldown = 0

/obj/item/gun/ballistic/automatic/pistol/commissar/equipped(mob/living/user, slot)
	..()
	if(slot == ITEM_SLOT_HANDS && funnysounds) // We do this instead of equip_sound as we only want this to play when it's wielded
		playsound(src, 'whitesands/sound/weapons/gun/commissar/pickup.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	. = ..()
	if(prob(50) && funnysounds)
		playsound(src, 'whitesands/sound/weapons/gun/commissar/shot.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/shoot_with_empty_chamber(mob/living/user)
	. = ..()
	if(prob(50) && funnysounds)
		playsound(src, 'whitesands/sound/weapons/gun/commissar/dry.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/insert_magazine(mob/user, obj/item/ammo_box/magazine/AM, display_message)
	. = ..()
	if(bolt_locked)
		drop_bolt(user)
		if(. && funnysounds)
			playsound(src, 'whitesands/sound/weapons/gun/commissar/magazine.ogg', 30, 0)

/obj/item/gun/ballistic/automatic/pistol/commissar/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	funnysounds = !funnysounds
	to_chat(user, "<span class='notice'>You toggle [src]'s vox audio functions.</span>")

/obj/item/gun/ballistic/automatic/pistol/commissar/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if((cooldown < world.time - 200) && funnysounds)
		user.audible_message("<font color='red' size='5'><b>DON'T TURN AROUND!</b></font>")
		playsound(src, 'whitesands/sound/weapons/gun/commissar/dontturnaround.ogg', 50, 0, 4)
		cooldown = world.time

/obj/item/gun/ballistic/automatic/pistol/commissar/examine(mob/user)
	. = ..()
	if(funnysounds)
		. += "<span class='info'>Alt-click to use \the [src] vox hailer.</span>"

/obj/item/gun/ballistic/automatic/pistol/solgov
	name = "SolGov M9C"
	desc = "Known formally as the M9A5C, this is a compact caseless ammo handgun made for switching to when your primary runs empty on it's mag."
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
	icon_state = "solm9c"
	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/pistol556mm

/obj/item/gun/ballistic/automatic/aks74u
	name = "AKS-74U"
	desc = {"
	A pre-FTL era carbine, the \"curio\" status of the weapon and its relative cheap cost to manufacture make it
	perfect for colonists on a budget looking to license firearms for local manufacture.
	"}
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon_state = "aks74u"
	fire_rate = 10
	lefthand_file = 'whitesands/icons/mob/inhands/weapons/guns_left.dmi'
	righthand_file = 'whitesands/icons/mob/inhands/weapons/guns_right.dmi'
	item_state = "aks74u"
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/aks74u

/obj/item/gun/ballistic/automatic/ak47
	name = "AK-47"
	desc = {"A favorite among both the soldiers of the Russian Colonial Army and civilians out on the edges of explored space, the AK-47 is a reliable rifle designed and sold by a Space Russian company and remains one of the most common automatic rifles in the known galaxy."}
	icon = 'whitesands/icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon_state = "ak47"
	item_state = "arg"
	fire_rate = 2
	mag_display = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/ak47

/obj/item/gun/ballistic/automatic/pistol/tec9
	name = "TEC9 Machine Pistol"
	desc = "A new take on an old classic, firing 9mm rounds at unprecedented firerates. Perfect for gatting people down, especially considering how plentiful ammo is."
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
	icon_state = "tec9"
	weapon_weight = WEAPON_LIGHT
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/tec9
	fire_rate = 6
	automatic = 1
	mag_display = TRUE

/obj/item/gun/ballistic/automatic/ebr
	name = "M514 EBR"
	desc = {"A cheap, reliable rifle often found in the hands of low-ranking Syndicate personnel. It's known for rather high stopping power and mild armor-piercing capabilities."}
	icon = 'whitesands/icons/obj/guns/48x32guns.dmi'
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	icon_state = "ebr"
	item_state = "ebr"
	fire_rate = 2
	mag_display = TRUE
	weapon_weight = WEAPON_MEDIUM
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/ebr


/obj/item/gun/ballistic/automatic/vector
	name = "Vector Carbine"
	desc = "A police carbine based off of an SMG design, with most of the complex workings removed for reliability. Chambered in 9mm."
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
	icon_state = "vector"
	item_state = "vector"
	mag_type = /obj/item/ammo_box/magazine/smgm9mm/rubbershot //you guys remember when the autorifle was chambered in 9mm
	bolt_type = BOLT_TYPE_LOCKING
	mag_display = TRUE
	weapon_weight = WEAPON_LIGHT
	fire_rate = 4
/obj/item/gun/ballistic/automatic/ZipPistol
	name = "Makeshift Pistol"
	desc = "A makeshift janky pistol, its a miracle it even works."
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
	icon_state = "ZipPistol"
	lefthand_file = 'whitesands/icons/mob/inhands/weapons/guns_left.dmi'
	righthand_file = 'whitesands/icons/mob/inhands/weapons/guns_right.dmi'
	item_state = "ZipPistol"
	mag_type = /obj/item/ammo_box/magazine/ZipAmmo9mm
	can_suppress = FALSE
	actions_types = list()
	can_bayonet = FALSE
	mag_display = TRUE
	weapon_weight = WEAPON_LIGHT
	fire_rate = 3
