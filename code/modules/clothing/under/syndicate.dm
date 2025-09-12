/obj/item/clothing/under/syndicate
	name = "tactical turtleneck"
	desc = "A non-descript and slightly suspicious looking turtleneck with digital camouflage cargo pants."
	icon_state = "syndicate"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	roll_sleeves = TRUE
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/syndicate.dmi'
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/under/syndicate/skirt
	name = "tactical skirtleneck"
	desc = "A non-descript and slightly suspicious looking skirtleneck."
	icon_state = "syndicate_skirt"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	roll_sleeves = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/syndicate/bloodred
	name = "blood-red sneaksuit"
	desc = "It still counts as stealth if there are no witnesses."
	icon_state = "bloodred_pajamas"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 10, "laser" = 10,"energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 50, "acid" = 40)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	roll_sleeves = FALSE
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/bloodred/sleepytime
	name = "blood-red pajamas"
	desc = "Do operatives dream of nuclear sheep?"
	icon_state = "bloodred_pajamas"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/tacticool
	name = "tacticool turtleneck"
	desc = "Just looking at it makes you want to buy an SKS, go into the woods, and -operate-."
	icon_state = "tactifool"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/under/syndicate/tacticool/skirt
	name = "tacticool skirtleneck"
	desc = "Just looking at it makes you want to buy an SKS, go into the woods, and -operate-."
	icon_state = "tactifool_skirt"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	roll_sleeves = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/sniper
	name = "Tactical turtleneck suit"
	desc = "A double seamed tactical turtleneck disguised as a civilian grade silk suit. Intended for the most formal operator. The collar is really sharp."
	icon = 'icons/obj/clothing/under/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/suits.dmi'
	icon_state = "really_black_suit"
	item_state = "bl_suit"
	roll_sleeves = FALSE

/obj/item/clothing/under/syndicate/camo
	name = "camouflage fatigues"
	desc = "A green military camouflage uniform."
	icon_state = "camogreen"
	item_state = "g_suit"
	roll_sleeves = FALSE

/obj/item/clothing/under/syndicate/combat
	name = "combat uniform"
	desc = "With a suit lined with this many pockets, you are ready to operate."
	icon_state = "syndicate_combat"
	roll_sleeves = FALSE
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/rus_army
	name = "advanced military tracksuit"
	desc = "Military grade tracksuits for frontline squatting."
	icon_state = "rus_under"
	roll_sleeves = FALSE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = NONE

/obj/item/clothing/under/syndicate/intern
	name = "red polo and khaki pants"
	desc = "A non-descript and slightly suspicious looking polo paired with a respectable yet also suspicious pair of khaki pants."
	icon_state = "jake"
	roll_sleeves = FALSE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)

/obj/item/clothing/under/syndicate/gorlex
	name = "Gorlex Marauder uniform"
	desc = "Originally worn by the miners of the Gorlex VII colony, it is now donned by veteran Gorlex Marauders."
	icon_state = "gorlex"
	roll_sleeves = FALSE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/cybersun
	name = "cybersun jumpsuit"
	desc = "The standard jumpsuit used by the agents employed by Cybersun, in its distinctive half-black-half-white aesthetic."
	icon_state = "cybersun_agent"
	roll_sleeves = FALSE

/obj/item/clothing/under/syndicate/cybersun/research
	name = "Cybersun coveralls"
	desc = "Nomex coveralls worn by workers and research personnel employed by Cybersun industries."
	icon_state = "cybersun"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 100)
	roll_sleeves = TRUE
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/cybersun/officer
	name = "cybersun officer's suit"
	desc = "A crimson-red suit used by the officers employed by Cybersun."
	icon_state = "cybersun_officer"
	roll_sleeves = TRUE
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/medic
	name = "Cybersun medical jumpsuit"
	desc = "Sterile coveralls worn by Cybersun Industries field medics for protection against biological hazards."
	icon_state = "cybersun_med"
	permeability_coefficient = 0.5
	roll_down = TRUE
	roll_sleeves = FALSE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/under/syndicate/medic/skirt
	name = "Cybersun medical jumpskirt"
	desc = "A sterile jumpskirt worn by Cybersun Industries field medics for protection against biological hazards."
	icon_state = "cybersun_med_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	roll_down = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION

/obj/item/clothing/under/syndicate/donk
	name = "Donk! Co. employee uniform"
	desc = "The standard employee uniform of Donk Co. Smells like minimum wage."
	icon_state = "donk_cargo"
	roll_sleeves = FALSE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/donk/qm
	name = "Donk! Co. manager uniform"
	desc = "The standard uniform of Donk Co. managers. Direct all complaints here."
	icon_state = "donk_qm"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations = DIGITIGRADE_VARIATION

/obj/item/clothing/suit/hazardvest/donk
	name = "Donk! Co. employee vest"
	desc = "A vest used to easily identify employees. It has a name tag attached. It reads: 'Hello! My name is..' It's not filled in."
	icon_state = "donk_cargo_vest"

/obj/item/clothing/suit/hazardvest/donk/qm
	name = "Donk! Co. manager vest"
	desc = "A vest used to easily identify managers. It has a name tag attached. It reads: 'Hello! My name is... THE BOSS'"
	icon_state = "donk_qm_vest"

/obj/item/clothing/under/syndicate/gec
	name = "GEC engineer jumpsuit"
	desc = "A jumpsuit worn by GEC engineers. This one is worn by low ranking engineers."
	icon_state = "gec_engineer"
	roll_sleeves = FALSE
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 60, "acid" = 20)
	resistance_flags = NONE

/obj/item/clothing/under/syndicate/gec/atmos_tech
	name = "GEC atmospheric technician jumpsuit"
	desc = "A jumpsuit worn by GEC engineers. This one is worn by atmospheric technicians."
	icon_state = "gec_atmos"

/obj/item/clothing/under/syndicate/gec/chief_engineer
	name = "GEC chief engineer jumpsuit"
	desc = "A jumpsuit worn by GEC engineers. This one is worn by high ranking chiefengineers."
	icon_state = "gec_ce"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 80, "acid" = 40)

/datum/outfit/syndicate/intern
	name = "Syndicate Operative - Intern"

	uniform = /obj/item/clothing/under/syndicate/intern
	suit = /obj/item/clothing/suit/space/syndicate/surplus
	suit_store = /obj/item/tank/internals/emergency_oxygen/engi
	head = /obj/item/clothing/head/helmet/space/syndicate/surplus
	mask = /obj/item/clothing/mask/breath
	shoes = /obj/item/clothing/shoes/laceup
	r_hand = /obj/item/gun/ballistic/automatic/assault/hydra/dmr
	gloves =  null
	l_pocket = /obj/item/pinpointer/nuke/syndicate
	r_pocket = /obj/item/ammo_box/magazine/m556_42_hydra/small
	belt = null
	back = /obj/item/tank/jetpack/oxygen/harness
	backpack_contents = null
	internals_slot = ITEM_SLOT_SUITSTORE

	tc = 10
	uplink_type = /obj/item/uplink/nuclear
	uplink_slot = ITEM_SLOT_BELT
