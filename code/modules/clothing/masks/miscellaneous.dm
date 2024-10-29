/obj/item/clothing/mask/muzzle
	name = "muzzle"
	desc = "To stop that awful noise."
	icon_state = "muzzle"
	item_state = "blindfold"
	flags_cover = MASKCOVERSMOUTH
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.9
	equip_delay_other = 20

/obj/item/clothing/mask/muzzle/attack_paw(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.wear_mask)
			to_chat(user, "<span class='warning'>You need help taking this off!</span>")
			return
	..()

/obj/item/clothing/mask/surgical
	name = "sterile mask"
	desc = "A sterile mask designed to help prevent the spread of diseases."
	icon_state = "sterile"
	item_state = "sterile"
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEFACE
	flags_cover = MASKCOVERSMOUTH
	visor_flags_inv = HIDEFACE
	visor_flags_cover = MASKCOVERSMOUTH
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.01
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 25, "rad" = 0, "fire" = 0, "acid" = 0)
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/surgical/attack_self(mob/user)
	adjustmask(user)

/obj/item/clothing/mask/fakemoustache
	name = "fake moustache"
	desc = "Warning: moustache is fake."
	icon_state = "fake-moustache"
	flags_inv = HIDEFACE

/obj/item/clothing/mask/fakemoustache/italian
	name = "italian moustache"
	desc = "Made from authentic Italian moustache hairs. Gives the wearer an irresistable urge to gesticulate wildly."
	modifies_speech = TRUE

/obj/item/clothing/mask/fakemoustache/italian/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = " [message]"
		var/list/italian_words = strings("italian_replacement.json", "italian")

		for(var/key in italian_words)
			var/value = italian_words[key]
			if(islist(value))
				value = pick(value)

			message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
			message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
			message = replacetextEx(message, " [key]", " [value]")

		if(prob(3))
			message += pick(" Ravioli, ravioli, give me the formuoli!"," Mamma-mia!"," Mamma-mia! That's a spicy meat-ball!", " La la la la la funiculi funicula!")
	speech_args[SPEECH_MESSAGE] = trim(message)

/obj/item/clothing/mask/joy
	name = "joy mask"
	desc = "Express your happiness or hide your sorrows with this laughing face with crying tears of joy cutout."
	icon_state = "joy"

/obj/item/clothing/mask/spamton
	name = "Cursed Businessman's Mask"
	icon_state = "big_shot"
	item_state = "big_shot"
	clothing_flags = ALLOWINTERNALS
	visor_flags = ALLOWINTERNALS
	desc = "The porcelain mask of a now-forgotten business mogul, said to have made an impossible fortune long ago. Are you big enough to wear it?"
	modifies_speech = TRUE
	actions_types = list(/datum/action/item_action/lifesavings)

/datum/action/item_action/lifesavings
	name = "LIFE_SAVINGS"
	desc = "Shipping and handling not included."

/obj/item/clothing/mask/spamton/attack_self(mob/user)
	if(cooldown < world.time)
		SSblackbox.record_feedback("amount", "saving_uses", 1)
		cooldown = world.time + 1600
		var/mob/living/U = user
		U.apply_damage(25, BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		to_chat(user, "<span class='warning'>BLOOD PRICE ACCEPTED. WITHDRAWING KRONOR FROM OFFSHORE FUND...</span>")
		pick(
						new /obj/item/spacecash/bundle/mediumrand(user.drop_location()),
						new /obj/item/spacecash/bundle/smallrand(user.drop_location()),
						new /obj/item/holochip(user.drop_location(), 5000))
	else
		to_chat(user, "<span class='warning'>[src]'s savings account can't yet be accessed!</span>")

/obj/item/clothing/mask/spamton/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = " [message]"
		var/list/spamton_words = strings("spamton_replacement.json", "spamton")

		for(var/key in spamton_words)
			var/value = spamton_words[key]
			if(islist(value))
				value = pick(value)

			message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
			message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
			message = replacetextEx(message, " [key]", " [value]")

	speech_args[SPEECH_MESSAGE] = trim(message)

/obj/item/clothing/mask/spamton/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_MASK_TRAIT)
