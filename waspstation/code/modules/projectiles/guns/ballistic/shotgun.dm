/obj/item/gun/ballistic/shotgun/automatic/combat/compact/compact
	name = "compact compact combat shotgun"
	desc = "A compact version of the compact version of the semi automatic combat shotgun. For when you want a gun the same size as your brain."
	icon = 'waspstation/icons/obj/guns/projectile.dmi'
	icon_state = "cshotguncc"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com/compact/compact
	w_class = WEIGHT_CLASS_SMALL
	sawn_desc = "You know, this isn't funny anymore."
	can_be_sawn_off  = TRUE

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/compact/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(prob(0 + (magazine.ammo_count() * 20)))	//minimum probability of 20, maximum of 60
		playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
		to_chat(user, "<span class='userdanger'>[src] blows up in your face!</span>")
		if(prob(25))
			user.gib()
			user.dropItemToGround(src)
		else
			user.take_bodypart_damage(0,50)
			user.dropItemToGround(src)
		return 0
	..()

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/compact/compact
	name = "compact compact compact combat shotgun"
	desc = "A compact version of the compact version of the compact version of the semi automatic combat shotgun. <i>It's a miracle it works...</i>"
	icon = 'waspstation/icons/obj/guns/projectile.dmi'
	icon_state = "cshotgunccc"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com/compact/compact/compact
	w_class = WEIGHT_CLASS_TINY
	sawn_desc = "<i>Sigh.</i> This is a trigger attached to a bullet."
	can_be_sawn_off  = TRUE

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/compact/compact/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(prob(50))	//It's going to blow up.
		playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
		if(prob(50))
			to_chat(user, "<span class='userdanger'>Fu-</span>")
			user.gib()
			user.dropItemToGround(src)
		else
			to_chat(user, "<span class='userdanger'>[src] blows up in your face! What a surprise.</span>")
			user.take_bodypart_damage(100)
			user.dropItemToGround(src)
		return 0
	..()

//////////////
//QUADVOLGUE//
//////////////
/obj/item/gun/ballistic/shotgun/doublebarrel/quad
	name = "quadvolgue shotgun"
	desc = "I've got my quad damage right here!"
	icon_state = "qshotgun"
	icon = 'waspstation/icons/obj/guns/projectile.dmi'
	lefthand_file = 'waspstation/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'waspstation/icons/mob/inhands/weapons/64x_guns_right.dmi'
	item_state = "shotgun_qb"
	w_class = WEIGHT_CLASS_BULKY
	force = 14 //blunt edge and really heavy
	attack_verb = list("bludgeoned", "smashed")
	mag_type = /obj/item/ammo_box/magazine/internal/shot/quad
	burst_size = 4
	pb_knockback = 6
	unique_reskin = null
	recoil = 1
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'waspstation/sound/weapons/gun/shotgun/quadfire.ogg'
	rack_sound = "waspstation/sound/weapons/gun/shotgun/quadrack.ogg"
	load_sound = "waspstation/sound/weapons/gun/shotgun/quadinsert.ogg"
	fire_sound_volume = 35
	rack_sound_volume = 50

/obj/item/gun/ballistic/shotgun/doublebarrel/quad/sawn
	name = "sawn-off quadvolgue shotgun"
	desc = "I've got my quad damage right here! Now with backpacks!"
	icon_state = "qshotgun_sawn"
	item_state = "shotgun_qb_sawn"
	w_class = WEIGHT_CLASS_NORMAL
	sawn_off = TRUE
	slot_flags = ITEM_SLOT_BELT

/obj/item/gun/ballistic/shotgun/doublebarrel/quad/sawoff(mob/user)
	update_icon()

/obj/item/gun/ballistic/shotgun/doublebarrel/quad/gold
	name = "golden quadvolgue shotgun"
	desc = "It looks heavily worn-down, as if it has been used extensively for many years."
	icon_state = "qshotgungold"
	item_state = "shotgun_qbgold"
	burst_size = 2
	pb_knockback = 4
	fire_sound_volume = 45

/obj/item/gun/ballistic/shotgun/doublebarrel/quad/gold/sawn
	icon_state = "qshotgungold_sawn"
	item_state = "shotgun_qbgold_sawn"
	desc = "All miracles require sacrifices."

/obj/item/gun/ballistic/shotgun/doublebarrel/quad/dual
	name = "dual quadvolgue shotgun"
	desc = "You think God stays in heaven, because he too, lives in fear of what he's created here on Earth?"
	icon_state = "qshotgun_dual"
	item_state = "shotgun_qb_dual"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/quad/dual
	burst_size = 8
	pb_knockback = 12
	recoil = 2
	fire_sound_volume = 50
