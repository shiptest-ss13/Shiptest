
/obj/item/clothing/gloves/fingerless
	name = "fingerless gloves"
	desc = "Plain black gloves without fingertips for the hard working."
	icon_state = "fingerless"
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	custom_price = 75
	undyeable = TRUE
	clothamnt = 1

/obj/item/clothing/gloves/armwarmer
	name = "arm warmers"
	desc = "Fingerless arm warmers that reach past your elbows."
	icon_state = "armwarmer"
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS|ARMS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	custom_price = 75
	undyeable = TRUE

/obj/item/clothing/gloves/armwarmer/striped
	name = "striped arm warmers"
	icon_state = "stripedwarmer"

/obj/item/clothing/gloves/botanic_leather
	name = "botanist's leather gloves"
	desc = "These leather gloves protect against thorns, barbs, prickles, spikes and other harmful objects of floral origin.  They're also quite warm."
	icon_state = "leather"
	item_state = "ggloves"
	permeability_coefficient = 0.9
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	clothing_traits = list(TRAIT_PLANT_SAFE)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 30)

/obj/item/clothing/gloves/combat
	name = "combat gloves"
	desc = "These tactical gloves are extra-durable, offering some fire and acid protection."
	icon_state = "combat"
	siemens_coefficient = 0.5
	permeability_coefficient = 0.05
	strip_delay = 80
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 50)
	//supports_variations = KEPORI_VARIATION

/obj/item/clothing/gloves/combat/insul
	name = "insulated combat gloves"
	desc = "Durable insulated combat gloves providing both protection from electrical shocks and industrial hazards like fire and acid."
	siemens_coefficient = 0

/obj/item/clothing/gloves/bracer
	name = "bone bracers"
	desc = "Looks like they'd provide some measure of arm protection, but they're too flimsy to offer anything beside their \"stylish\" looks."
	icon_state = "bracers"
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	body_parts_covered = ARMS
	cold_protection = ARMS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/rapid
	name = "Gloves of the North Star"
	desc = "Just looking at these fills you with an urge to beat the shit out of people."
	icon_state = "rapid"
	transfer_prints = TRUE
	cuttable = FALSE

/obj/item/clothing/gloves/rapid/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/punchcooldown)


/obj/item/clothing/gloves/color/plasmaman
	desc = "Covers up those scandalous boney hands."
	name = "plasma envirogloves"
	icon_state = "plasmaman"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	permeability_coefficient = 0.05
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 95, "acid" = 95)

/obj/item/clothing/gloves/color/plasmaman/black
	name = "black envirogloves"
	icon_state = "blackplasma"

/obj/item/clothing/gloves/color/plasmaman/white
	name = "white envirogloves"
	icon_state = "whiteplasma"
	item_state = "lgloves"

/obj/item/clothing/gloves/color/plasmaman/robot
	name = "roboticist envirogloves"
	icon_state = "robotplasma"

/obj/item/clothing/gloves/color/plasmaman/janny
	name = "janitor envirogloves"
	icon_state = "jannyplasma"

/obj/item/clothing/gloves/color/plasmaman/cargo
	name = "cargo envirogloves"
	icon_state = "cargoplasma"

/obj/item/clothing/gloves/color/plasmaman/engineer
	name = "engineering envirogloves"
	icon_state = "engieplasma"
	item_state = "ygloves"
	siemens_coefficient = 0

/obj/item/clothing/gloves/color/plasmaman/atmos
	name = "atmos envirogloves"
	icon_state = "atmosplasma"
	item_state = "ygloves"
	siemens_coefficient = 0

/obj/item/clothing/gloves/color/plasmaman/explorer
	name = "explorer envirogloves"
	icon_state = "explorerplasma"

/obj/item/clothing/gloves/botanic_leather/plasmaman
	name = "botany envirogloves"
	desc = "Covers up those scandalous boney hands."
	icon_state = "botanyplasma"
	permeability_coefficient = 0.05
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 95, "acid" = 95)

/obj/item/clothing/gloves/color/plasmaman/prototype
	name = "prototype envirogloves"
	icon_state = "protoplasma"

/obj/item/clothing/gloves/combat/wizard
	name = "enchanted gloves"
	desc = "These gloves have been enchanted with a spell that makes them fireproof and acid-resistant."
	icon_state = "wizard"
