/obj/structure/closet/crate/secure
	desc = "A secure crate."
	name = "secure crate"
	icon_state = "securecrate"
	secure = TRUE
	locked = TRUE
	max_integrity = 500
	armor = list("melee" = 30, "bullet" = 50, "laser" = 50, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 80)
	var/tamperproof = 0
	damage_deflection = 25

/obj/structure/closet/crate/secure/update_overlays()
	. = ..()
	if(broken)
		. += "securecrateemag"
		return
	if(locked)
		. += "securecrater"
		return
	. += "securecrateg"

/obj/structure/closet/crate/secure/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1)
	if(prob(tamperproof) && damage_amount >= DAMAGE_PRECISION)
		boom()
	else
		return ..()


/obj/structure/closet/crate/secure/proc/boom(mob/user)
	if(user)
		to_chat(user, span_danger("The crate's anti-tamper system activates!"))
		log_bomber(user, "has detonated a", src)
	for(var/atom/movable/AM as anything in src)
		qdel(AM)
	explosion(get_turf(src), 0, 1, 5, 5)
	qdel(src)

/obj/structure/closet/crate/secure/weapon
	desc = "A secure weapons crate."
	name = "weapons crate"
	icon_state = "weaponcrate"

/obj/structure/closet/crate/secure/engineering
	desc = "A secure engineering crate."
	name = "engineering crate"
	icon_state = "engi_secure_crate"

/obj/structure/closet/crate/secure/plasma
	desc = "A secure plasma crate."
	name = "plasma crate"
	icon_state = "plasmacrate"

/obj/structure/closet/crate/secure/gear
	desc = "A secure gear crate."
	name = "gear crate"
	icon_state = "secgearcrate"

/obj/structure/closet/crate/secure/hydroponics
	desc = "A crate with a lock on it, painted in the scheme of the Nanotrasen's hydroponics division."
	name = "secure hydroponics crate"
	icon_state = "hydrosecurecrate"

/obj/structure/closet/crate/secure/engineering
	desc = "A crate with a lock on it, painted in the scheme of the Nanotrasen's engineering division."
	name = "secure engineering crate"
	icon_state = "engi_secure_crate"

/obj/structure/closet/crate/secure/science
	name = "secure science crate"
	desc = "A crate with a lock on it, painted in the scheme of the Nanotrasen's research & development division."
	icon_state = "scisecurecrate"

/obj/structure/closet/crate/secure/owned
	name = "private crate"
	desc = "A crate cover designed to only open for who purchased its contents."
	icon_state = "privatecrate"
	var/datum/bank_account/buyer_account
	var/privacy_lock = TRUE

/obj/structure/closet/crate/secure/owned/examine(mob/user)
	. = ..()
	. += span_notice("It's locked with a privacy lock, and can only be unlocked by the buyer's ID.")

/obj/structure/closet/crate/secure/owned/Initialize(mapload, datum/bank_account/_buyer_account)
	. = ..()
	buyer_account = _buyer_account

/obj/structure/closet/crate/secure/owned/togglelock(mob/living/user, silent)
	if(privacy_lock)
		if(!broken)
			var/obj/item/card/bank/bank_card = user.get_bankcard()
			if(bank_card)
				if(bank_card.registered_account)
					if(bank_card.registered_account == buyer_account)
						if(iscarbon(user))
							add_fingerprint(user)
						locked = !locked
						user.visible_message(span_notice("[user] unlocks [src]'s privacy lock."),
										span_notice("You unlock [src]'s privacy lock."))
						privacy_lock = FALSE
						update_appearance()
					else if(!silent)
						to_chat(user, span_notice("Bank account does not match with buyer!"))
				else if(!silent)
					to_chat(user, span_notice("No linked bank account detected!"))
			else if(!silent)
				to_chat(user, span_notice("No ID detected!"))
		else if(!silent)
			to_chat(user, span_warning("[src] is broken!"))
	else ..()

/obj/structure/closet/crate/secure/exo
	desc = "A lock-enabled crate used to carry EXOCOM merchandise destined for export to potential buyers."
	name = "EXOCOM storage crate"
	icon = 'icons/obj/crates.dmi'
	icon_state = "exocrate"
