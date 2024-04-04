/obj/item/gun/magic/wand
	name = "wand"
	desc = "You shouldn't have this."
	ammo_type = /obj/item/ammo_casing/magic
	icon_state = "nothingwand"
	item_state = "wand"
	base_icon_state = "nothingwand"
	w_class = WEIGHT_CLASS_SMALL
	can_charge = FALSE
	max_charges = 100 //100, 50, 50, 34 (max charge distribution by 25%ths)
	var/variable_charges = TRUE

/obj/item/gun/magic/wand/Initialize()
	if(prob(75) && variable_charges) //25% chance of listed max charges, 50% chance of 1/2 max charges, 25% chance of 1/3 max charges
		if(prob(33))
			max_charges = CEILING(max_charges / 3, 1)
		else
			max_charges = CEILING(max_charges / 2, 1)
	return ..()

/obj/item/gun/magic/wand/examine(mob/user)
	. = ..()
	. += "Has [charges] charge\s remaining."

/obj/item/gun/magic/wand/update_icon_state()
	icon_state = "[base_icon_state][charges ? null : "-drained"]"
	return ..()

/obj/item/gun/magic/wand/attack(atom/target, mob/living/user)
	if(target == user)
		return
	..()

/obj/item/gun/magic/wand/afterattack(atom/target, mob/living/user)
	var/wrested = FALSE
	if(!charges)
		wrested = shoot_with_empty_chamber(user)
		if(!wrested)
			return
	if(target == user)
		if(no_den_usage)
			var/area/A = get_area(user)
			if(istype(A, /area/wizard_station))
				to_chat(user, "<span class='warning'>You know better than to violate the security of The Den, best wait until you leave to use [src].</span>")
				return
			else
				no_den_usage = 0
		zap_self(user)
	else
		. = ..()
	if(wrested)
		to_chat(user,"<span class='danger'>[src] overloads and disintegrates.</span>")
		qdel(src)
		return
	update_appearance()

/obj/item/gun/magic/wand/proc/zap_self(mob/living/user)
	user.visible_message("<span class='danger'>[user] zaps [user.p_them()]self with [src].</span>")
	playsound(user, fire_sound, 50, TRUE)
	user.log_message("zapped [user.p_them()]self with a <b>[src]</b>", LOG_ATTACK)

/obj/item/gun/magic/wand/death
	name = "wand of death"
	desc = "This deadly wand overwhelms the victim's body with pure energy, slaying them without fail."
	fire_sound = 'sound/magic/wandodeath.ogg'
	ammo_type = /obj/item/ammo_casing/magic/death
	icon_state = "deathwand"
	base_icon_state = "deathwand"
	max_charges = 3 //3, 2, 2, 1

/obj/item/gun/magic/wand/death/zap_self(mob/living/user)
	..()
	charges--
	if(user.anti_magic_check())
		user.visible_message("<span class='warning'>[src] has no effect on [user]!</span>")
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.mob_biotypes & MOB_UNDEAD) //negative energy heals the undead
			user.revive(full_heal = TRUE, admin_revive = TRUE)
			to_chat(user, "<span class='notice'>You feel great!</span>")
			return
	to_chat(user, "<span class='warning'>You irradiate yourself with pure negative energy! \
	[pick("Do not pass go. Do not collect 200 zorkmids.","You feel more confident in your spell casting skills.","You Die...","Do you want your possessions identified?")]\
	</span>")
	user.death(FALSE)

/obj/item/gun/magic/wand/death/debug
	desc = "In some obscure circles, this is known as the 'cloning tester's friend'."
	max_charges = 500
	variable_charges = FALSE
	can_charge = TRUE
	recharge_rate = 1

/obj/item/gun/magic/wand/resurrection
	name = "wand of healing"
	desc = "This wand uses healing magics to heal and revive. They are rarely utilized within the Wizard Federation for some reason."
	ammo_type = /obj/item/ammo_casing/magic/heal
	fire_sound = 'sound/magic/staff_healing.ogg'
	icon_state = "revivewand"
	base_icon_state = "revivewand"
	max_charges = 10 //10, 5, 5, 4

/obj/item/gun/magic/wand/resurrection/zap_self(mob/living/user)
	..()
	charges--
	if(user.anti_magic_check())
		user.visible_message("<span class='warning'>[src] has no effect on [user]!</span>")
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			to_chat(user, "<span class='warning'>You irradiate yourself with pure positive energy! \
			[pick("Do not pass go. Do not collect 200 zorkmids.","You feel more confident in your spell casting skills.","You Die...","Do you want your possessions identified?")]\
			</span>")
			user.death(0)
			return
	user.revive(full_heal = TRUE, admin_revive = TRUE)
	to_chat(user, "<span class='notice'>You feel great!</span>")

/obj/item/gun/magic/wand/resurrection/debug //for testing
	desc = "Is it possible for something to be even more powerful than regular magic? This wand is."
	max_charges = 500
	variable_charges = FALSE
	can_charge = TRUE
	recharge_rate = 1
