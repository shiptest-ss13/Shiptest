/****************Explorer's Suit and Mask****************/
/obj/item/clothing/suit/hooded/explorer
	name = "explorer suit"
	desc = "A light, armor-plated softsuit, designed for exploration of dangerous planetary enviroments. An NT design by origin, later reappropriated by EXOCOM for mass retail production."
	icon_state = "explorer"
	item_state = "explorer"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	cold_protection = CHEST|GROIN|LEGS|ARMS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/explorer
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 50, "wound" = 10)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/pinpointer/mineral, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe)
	resistance_flags = FIRE_PROOF
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/head/hooded/explorer
	name = "explorer hood"
	desc = "A snug armoured hood for exploring dangerous locales. May chafe."
	icon_state = "explorer"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 50, "wound" = 10)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/hooded/explorer/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/hooded/explorer/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/mask/gas/explorer
	name = "explorer gas mask"
	desc = "An advanced atmospheric scrubbing mask with a built-in pressure seal, manufactured by EXOCOM. Can be connected to an air supply."
	icon_state = "gas_mining"
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS
	visor_flags_inv = HIDEFACIALHAIR
	visor_flags_cover = MASKCOVERSMOUTH
	armor = list("melee" = 0, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 50, "rad" = 0, "fire" = 20, "acid" = 40)
	resistance_flags = FIRE_PROOF
	supports_variations = SNOUTED_VARIATION | KEPORI_VARIATION

/obj/item/clothing/suit/space/hostile_environment
	name = "H.E.C.K. suit"
	desc = "Hostile Environment Cross-Kinetic Suit: A suit overdesigned at great expense to withstand the wide variety of hazards from the outer frontier. It wasn't enough for its last owner."
	icon_state = "hostile_env"
	item_state = "hostile_env"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	slowdown = 0
	armor = list("melee" = 70, "bullet" = 40, "laser" = 30, "energy" = 45, "bomb" = 70, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/pinpointer/mineral, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe)

/obj/item/clothing/suit/space/hostile_environment/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/space/hostile_environment/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/suit/space/hostile_environment/process(seconds_per_tick)
	var/mob/living/carbon/C = loc
	if(istype(C) && SPT_PROB(1, seconds_per_tick)) //cursed by bubblegum
		if(SPT_PROB(7.5, seconds_per_tick))
			new /datum/hallucination/oh_yeah(C)
			to_chat(C, span_colossus("<b>[pick("I AM IMMORTAL.","I SHALL TAKE BACK WHAT'S MINE.","I SEE YOU.","YOU CANNOT ESCAPE ME FOREVER.","DEATH CANNOT HOLD ME.")]</b>"))
		else
			to_chat(C, span_warning("[pick("You hear faint whispers.","You smell ash.","You feel hot.","You hear a roar in the distance.")]"))

/obj/item/clothing/head/helmet/space/hostile_environment
	name = "H.E.C.K. helmet"
	desc = "Hostile Environiment Cross-Kinetic Helmet: A helmet overdesigned at great expense to withstand the wide variety of hazards from the outer frontier. It wasn't enough for its last owner."
	icon_state = "hostile_env"
	item_state = "hostile_env"
	w_class = WEIGHT_CLASS_NORMAL
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = list("melee" = 75, "bullet" = 40, "laser" = 35, "energy" = 45, "bomb" = 70, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/obj/item/clothing/head/helmet/space/hostile_environment/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	update_appearance()

/obj/item/clothing/head/helmet/space/hostile_environment/update_overlays()
	. = ..()
	var/mutable_appearance/glass_overlay = mutable_appearance(icon, "hostile_env_glass")
	glass_overlay.appearance_flags = RESET_COLOR
	. += glass_overlay

/obj/item/clothing/head/helmet/space/hostile_environment/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/M = mutable_appearance('icons/mob/clothing/head.dmi', "hostile_env_glass")
		M.appearance_flags = RESET_COLOR
		. += M

//the legacy NT exploration gear, flavoured to be old but reliable.
/obj/item/clothing/gloves/explorer
	name = "explorer gloves"
	desc = "Thick, fire-resistant gloves with a small bracer, sold by EXOCOM to protect your precious fingers from the rigours of planetary exploration."
	icon_state = "explorer"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	resistance_flags = FIRE_PROOF
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/explorer/old
	name = "prototype exploration gauntlets"
	desc = "Thick-fingered, durable gloves, meant to stop all but the most brutal of stovetop-touching accidents in the field."
	icon_state = "explorerold"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 75)
	siemens_coefficient = 0.5
	permeability_coefficient = 0.05

/obj/item/clothing/suit/hooded/survivor
	name = "survivor suit"
	desc = "A ragged makeshift suit resembling the explorer suit, covered with the emblems of a failed revolution. It's been repaired so many times it's hard to tell if it's more suit or patch. The joints have been redesigned for quicker movement."
	lefthand_file = 'icons/mob/inhands/clothing_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing_righthand.dmi'
	icon_state = "survivor"
	item_state = "survivor"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = (FIRE_SUIT_MIN_TEMP_PROTECT * 2)
	cold_protection = CHEST|GROIN|LEGS|ARMS
	max_heat_protection_temperature = (FIRE_SUIT_MAX_TEMP_PROTECT / 2)
	heat_protection = CHEST|GROIN|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/survivor_hood
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 10, "bomb" = 20, "bio" = 100, "rad" = 20, "fire" = 50, "acid" = 30)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/pinpointer/mineral, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe)
	resistance_flags = FIRE_PROOF
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/head/hooded/survivor_hood
	name = "survivor hood"
	desc = "A loose-fitting hood, patched up with sealant and adhesive. Somewhat protects the head from the environment, but gets the job done."
	icon_state = "survivor"
	item_state = "survivor"
	suit = /obj/item/clothing/suit/hooded/survivor
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 10, "bomb" = 20, "bio" = 100, "rad" = 20, "fire" = 50, "acid" = 30)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/hooded/survivor/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/hooded/survivor_hood/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/hooded/survivor/brown
	icon_state = "survivorbrown"
	item_state = "survivorbrown"
	hoodtype = /obj/item/clothing/head/hooded/survivor_hood/brown


/obj/item/clothing/head/hooded/survivor_hood/brown
	icon_state = "survivorbrown"
	item_state = "survivorbrown"
	suit = /obj/item/clothing/suit/hooded/survivor/brown


/obj/item/clothing/suit/hooded/survivor/yellow
	icon_state = "survivoryellow"
	item_state = "survivoryellow"
	hoodtype = /obj/item/clothing/head/hooded/survivor_hood/yellow

/obj/item/clothing/head/hooded/survivor_hood/yellow
	icon_state = "survivoryellow"
	item_state = "survivoryellow"
	suit = /obj/item/clothing/suit/hooded/survivor/yellow

/obj/item/clothing/suit/hooded/survivor/green
	icon_state = "survivorgreen"
	item_state = "survivorgreen"
	hoodtype = /obj/item/clothing/head/hooded/survivor_hood/green

/obj/item/clothing/head/hooded/survivor_hood/green
	icon_state = "survivorgreen"
	item_state = "survivorgreen"
	suit = /obj/item/clothing/suit/hooded/survivor/green

/obj/item/clothing/suit/hooded/survivor/jermit
	icon_state = "survivorjermit"
	item_state = "survivorjermit"
	hoodtype = /obj/item/clothing/head/hooded/survivor_hood/jermit

/obj/item/clothing/head/hooded/survivor_hood/jermit
	icon_state = "survivorjermit"
	item_state = "survivorjermit"
	suit = /obj/item/clothing/suit/hooded/survivor/jermit

/obj/item/clothing/suit/armor/vest/scrap
	name = "scrap armor"
	desc = "An 'armor' vest consisting of sheet metal held together with cable. Who thought this was a good idea?"
	icon_state = "scraparmor"
	item_state = "scraparmor"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 15, "bomb" = 20, "bio" = 100, "rad" = 20, "fire" = 50, "acid" = 30)
