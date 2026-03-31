/obj/item/clothing/under/misc
	icon = 'icons/obj/clothing/under/misc.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/misc.dmi'

/obj/item/clothing/under/misc/pj
	name = "\improper PJs"
	desc = "A comfy set of sleepwear, for taking naps or being lazy instead of working."
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
	resistance_flags = FIRE_PROOF | ACID_PROOF
	cuttable = FALSE

/obj/item/clothing/under/misc/assistantformal
	name = "assistant's formal uniform"
	desc = "An assistant's formal-wear. Why an assistant needs formal-wear is still unknown."
	icon_state = "assistant_formal"
	item_state = "gy_suit"

/obj/item/clothing/under/plasmaman
	name = "plasma envirosuit"
	desc = "A special containment suit that allows plasma-based lifeforms to exist safely in an oxygenated environment, and automatically extinguishes them in a crisis. Despite being airtight, it's not spaceworthy."
	icon_state = "plasmaman"
	item_state = "plasmaman"
	icon = 'icons/obj/clothing/under/plasmaman.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/plasmaman.dmi'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 95, "acid" = 95)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	strip_delay = 80
	var/next_extinguish = 0
	var/extinguish_cooldown = 100
	var/extinguishes_left = 5
	cuttable = FALSE

	//remove when phorids suck less
	equip_delay_self = null

/obj/item/clothing/under/plasmaman/skirt //WS edit plasmaman customization
	name = "plasma enviroskirt"
	icon_state = "plasmaskirt"
	item_state = "plasmaskirt"


/obj/item/clothing/under/plasmaman/examine(mob/user)
	. = ..()
	. += span_notice("There are [extinguishes_left] extinguisher charges left in this suit.")

/obj/item/clothing/under/plasmaman/proc/Extinguish(mob/living/carbon/human/H)
	if(!istype(H))
		return

	if(H.on_fire)
		if(extinguishes_left)
			if(next_extinguish > world.time)
				return
			next_extinguish = world.time + extinguish_cooldown
			extinguishes_left--
			H.visible_message(span_warning("[H]'s suit automatically extinguishes [H.p_them()]!"),span_warning("Your suit automatically extinguishes you."))
			H.extinguish_mob()
			new /obj/effect/particle_effect/water(get_turf(H))
	return 0

/obj/item/clothing/under/plasmaman/attackby(obj/item/E, mob/user, params)
	..()
	if (istype(E, /obj/item/extinguisher_refill))
		if (extinguishes_left == 5)
			to_chat(user, span_notice("The inbuilt extinguisher is full."))
		else
			extinguishes_left = 5
			to_chat(user, span_notice("You refill the suit's built-in extinguisher, using up the cartridge."))
			qdel(E)

/obj/item/extinguisher_refill
	name = "envirosuit extinguisher cartridge"
	desc = "A cartridge loaded with a compressed extinguisher mix, used to refill the automatic extinguisher on plasma envirosuits."
	icon_state = "plasmarefill"
	icon = 'icons/obj/device.dmi'

/obj/item/clothing/under/misc/durathread
	name = "durathread jumpsuit"
	desc = "A jumpsuit made from durathread. Its resilient fibres preserve it from certain destructive forces. These forces do not include bullets."
	icon_state = "durathread"
	item_state = "durathread"
	armor = list("melee" = 0, "laser" = 0, "fire" = 40, "acid" = 10, "bomb" = 0)
	cuttable = FALSE

/obj/item/clothing/under/utility
	icon = 'icons/obj/clothing/under/misc.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/misc.dmi'
	name = "utility jumpsuit"
	desc = "A somewhat uncomfortable suit designed to be as cheap as possible to manufacture."
	icon_state = "utility"
	item_state = "utility"
	roll_down = TRUE

/obj/item/clothing/under/utility/skirt
	name = "utility jumpskirt"
	desc = "A somewhat uncomfortable suit designed to be as cheap as possible to manufacture. This one has a skirt."
	body_parts_covered = CHEST|GROIN|ARMS
	icon_state = "utility_skirt"
	item_state = "utility_skirt"
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/overalls
	icon = 'icons/obj/clothing/under/misc.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/misc.dmi'
	name = "denim overalls"
	desc = "A durable pair of overalls with a removable white work shirt. Perfect for outdoor labor."
	icon_state = "overalls"
	item_state = "overalls"
	roll_down = TRUE
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/overalls/black
	name = "black overalls"
	icon_state = "overalls_black"
	item_state = "overalls_black"

/obj/item/clothing/under/overalls/olive
	name = "olive overalls"
	icon_state = "overalls_olive"
	item_state = "overalls_olive"

/obj/item/clothing/under/overalls/brown
	name = "brown overalls"
	icon_state = "overalls_brown"
	item_state = "overalls_brown"
