/obj/item/clothing/under/misc
	icon = 'icons/obj/clothing/under/misc.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/misc.dmi'

/obj/item/clothing/under/misc/pj
	name = "\improper PJs"
	desc = "A comfy set of sleepwear, for taking naps or being lazy instead of working."
	can_adjust = FALSE
	item_state = "w_suit"

/obj/item/clothing/under/misc/pj/red
	icon_state = "red_pyjamas"

/obj/item/clothing/under/misc/pj/blue
	icon_state = "blue_pyjamas"

/obj/item/clothing/under/misc/patriotsuit
	name = "Patriotic Suit"
	desc = "Motorcycle not included."
	icon_state = "ek"
	item_state = "ek"
	can_adjust = FALSE

/obj/item/clothing/under/misc/adminsuit
	name = "administrative cybernetic jumpsuit"
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	icon_state = "syndicate"
	item_state = "bl_suit"
	mob_overlay_icon = 'icons/mob/clothing/under/syndicate.dmi'
	desc = "A cybernetically enhanced jumpsuit used for administrative duties."
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	can_adjust = FALSE
	resistance_flags = FIRE_PROOF | ACID_PROOF
	cuttable = FALSE

/obj/item/clothing/under/misc/assistantformal
	name = "assistant's formal uniform"
	desc = "An assistant's formal-wear. Why an assistant needs formal-wear is still unknown."
	icon_state = "assistant_formal"
	item_state = "gy_suit"
	can_adjust = FALSE

/obj/item/clothing/under/plasmaman
	name = "plasma envirosuit"
	desc = "A special containment suit that allows plasma-based lifeforms to exist safely in an oxygenated environment, and automatically extinguishes them in a crisis. Despite being airtight, it's not spaceworthy."
	icon_state = "plasmaman"
	item_state = "plasmaman"
	icon = 'icons/obj/clothing/under/plasmaman.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/plasmaman.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 95, "acid" = 95)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	can_adjust = FALSE
	strip_delay = 80
	var/next_extinguish = 0
	var/extinguish_cooldown = 100
	var/extinguishes_left = 5
	cuttable = FALSE

/obj/item/clothing/under/plasmaman/skirt //WS edit plasmaman customization
	name = "plasma enviroskirt"
	icon_state = "plasmaskirt"
	item_state = "plasmaskirt"


/obj/item/clothing/under/plasmaman/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There are [extinguishes_left] extinguisher charges left in this suit.</span>"

/obj/item/clothing/under/plasmaman/proc/Extinguish(mob/living/carbon/human/H)
	if(!istype(H))
		return

	if(H.on_fire)
		if(extinguishes_left)
			if(next_extinguish > world.time)
				return
			next_extinguish = world.time + extinguish_cooldown
			extinguishes_left--
			H.visible_message("<span class='warning'>[H]'s suit automatically extinguishes [H.p_them()]!</span>","<span class='warning'>Your suit automatically extinguishes you.</span>")
			H.ExtinguishMob()
			new /obj/effect/particle_effect/water(get_turf(H))
	return 0

/obj/item/clothing/under/plasmaman/attackby(obj/item/E, mob/user, params)
	..()
	if (istype(E, /obj/item/extinguisher_refill))
		if (extinguishes_left == 5)
			to_chat(user, "<span class='notice'>The inbuilt extinguisher is full.</span>")
		else
			extinguishes_left = 5
			to_chat(user, "<span class='notice'>You refill the suit's built-in extinguisher, using up the cartridge.</span>")
			qdel(E)

/obj/item/extinguisher_refill
	name = "envirosuit extinguisher cartridge"
	desc = "A cartridge loaded with a compressed extinguisher mix, used to refill the automatic extinguisher on plasma envirosuits."
	icon_state = "plasmarefill"
	icon = 'icons/obj/device.dmi'

/obj/item/clothing/under/misc/durathread
	name = "durathread jumpsuit"
	desc = "A jumpsuit made from durathread, its resilient fibres provide some protection to the wearer."
	icon_state = "durathread"
	item_state = "durathread"
	can_adjust = FALSE
	armor = list("melee" = 10, "laser" = 10, "fire" = 40, "acid" = 10, "bomb" = 5)
	cuttable = FALSE

/obj/item/clothing/under/misc/coordinator
	name = "coordinator jumpsuit"
	desc = "A jumpsuit made by party people, from party people, for party people."
	icon = 'icons/obj/clothing/under/command.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/command.dmi'
	icon_state = "captain_parade"
	item_state = "by_suit"
	can_adjust = FALSE

/obj/item/clothing/under/utility
	icon = 'icons/obj/clothing/under/misc.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/misc.dmi'
	name = "utility jumpsuit"
	desc = "A somewhat uncomfortable suit designed to be as cheap as possible to manufacture."
	icon_state = "utility"
	item_state = "utility"
	can_adjust = TRUE

/obj/item/clothing/under/utility/skirt //trolled.
	name = "utility jumpskirt"
	desc = "A somewhat uncomfortable suit designed to be as cheap as possible to manufacture. This one has a skirt."
	body_parts_covered = CHEST|GROIN|ARMS
	icon_state = "utility_skirt"
	item_state = "utility_skirt"
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/misc/gown //Clothing for medical ships
	name = "patient gown"
	desc = "A light white gown that allows easy access to any patient who wears this."
	icon = 'icons/obj/clothing/patient.dmi'
	mob_overlay_icon = 'icons/mob/clothing/patient.dmi'
	lefthand_file = 'icons/mob/inhands/patient_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/patient_righthand.dmi'
	icon_state = "gownwhite"
	item_state = "gownwhite"
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/misc/gown/green
	desc = "A mint green gown that allows medics to save time."
	icon_state = "gowngreen"
	item_state = "gowngreen"

/obj/item/clothing/under/misc/gown/blue
	desc = "A baby blue gown medics give to their patients. For when the patient wants to be EXTRA manly."
	icon_state = "gownblue"
	item_state = "gownblue"

/obj/item/clothing/under/misc/gown/pink
	desc = "Hospital grade pink garments. For when the patient wants to feel pretty in pink."
	icon_state = "gownpink"
	icon_state = "gownpink"

