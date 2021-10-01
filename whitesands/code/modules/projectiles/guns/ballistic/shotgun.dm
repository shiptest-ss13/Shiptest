/obj/item/gun/ballistic/shotgun/automatic/combat/compact/compact
	name = "compact compact combat shotgun"
	desc = "A compact version of the compact version of the semi automatic combat shotgun. For when you want a gun the same size as your brain."
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
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
	icon = 'whitesands/icons/obj/guns/projectile.dmi'
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

//god fucking bless brazil
/obj/item/gun/ballistic/shotgun/doublebarrel/brazil
	name = "six-barreled \"TRABUCO\" shotgun"
	desc = "Dear fucking god, what the fuck even is this!? Theres a green flag with a blue circle and a yellow diamond around it. Some text in the circle says: \"ORDEM E PROGRESSO.\""
	icon_state = "shotgun_brazil"
	icon = 'whitesands/icons/obj/guns/48x32guns.dmi'
	lefthand_file = 'whitesands/icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'whitesands/icons/mob/inhands/weapons/64x_guns_right.dmi'
	item_state = "shotgun_qb"
	w_class = WEIGHT_CLASS_BULKY
	force = 15 //blunt edge and really heavy
	attack_verb = list("bludgeoned", "smashed")
	mag_type = /obj/item/ammo_box/magazine/internal/shot/sex
	burst_size = 6
	pb_knockback = 12
	unique_reskin = null
	recoil = 10
	weapon_weight = WEAPON_LIGHT
	fire_sound = 'whitesands/sound/weapons/gun/shotgun/quadfire.ogg'
	rack_sound = 'whitesands/sound/weapons/gun/shotgun/quadrack.ogg'
	load_sound = 'whitesands/sound/weapons/gun/shotgun/quadinsert.ogg'
	fire_sound_volume = 50
	rack_sound_volume = 50
	can_be_sawn_off = FALSE

/obj/item/gun/ballistic/shotgun/doublebarrel/brazil/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(prob(0 + (magazine.ammo_count() * 10)))	//minimum probability of 10, maximum of 60 only procs if theres more than 4 shells
//		playsound(user, fire_sound, fire_sound_volume, vary_fire_sound)
		if(prob(50))
			to_chat(user, "<span class='userdanger'>Holy shit! [src] hurts your hand from trying to control it!</span>")
			user.take_bodypart_damage(0,50)
			..()
		else
			if(prob(10))
				to_chat(user, "<span class='userdanger'>Something isn't right. \the [src] doesn't fire for a brief moment. Then, the following words come to mind: \
				Ó Pátria amada, \
				Idolatrada, \
				Salve! Salve!</span>")
				explosion(src, 0, 2, 4, 6, TRUE, TRUE)
				user.gib()
			else
				to_chat(user, "<span class='userdanger'>[src] flies out of your hand!</span>")
				user.dropItemToGround(src)
	..()
