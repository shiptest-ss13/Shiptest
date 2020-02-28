/obj/item/gun/ballistic/shotgun/automatic/combat/compact/compact
	name = "compact compact combat shotgun"
	desc = "A compact version of the compact version of the semi automatic combat shotgun. For when you want a gun the same size as your brain."
	icon = 'waspstation/icons/obj/guns/projectile.dmi'
	icon_state = "cshotguncc"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com/compact/compact
	w_class = WEIGHT_CLASS_BULKY

/obj/item/gun/ballistic/shotgun/automatic/combat/compact/compact/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	if(prob(0 + (magazine.ammo_count() * 10)))	//minimum probability of 10, maximum of 30
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
