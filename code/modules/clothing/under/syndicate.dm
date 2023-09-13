/obj/item/clothing/under/syndicate
	name = "tactical turtleneck"
	desc = "A non-descript and slightly suspicious looking turtleneck with digital camouflage cargo pants."
	icon_state = "syndicate"
	item_state = "bl_suit"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/syndicate.dmi'
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/skirt
	name = "tactical skirtleneck"
	desc = "A non-descript and slightly suspicious looking skirtleneck."
	icon_state = "syndicate_skirt"
	item_state = "bl_suit"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/bloodred
	name = "blood-red sneaksuit"
	desc = "It still counts as stealth if there are no witnesses."
	icon_state = "bloodred_pajamas"
	item_state = "bl_suit"
	armor = list("melee" = 10, "bullet" = 10, "laser" = 10,"energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 10, "fire" = 50, "acid" = 40)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/bloodred/sleepytime
	name = "blood-red pajamas"
	desc = "Do operatives dream of nuclear sheep?"
	icon_state = "bloodred_pajamas"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	supports_variations = DIGITIGRADE_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/tacticool
	name = "tacticool turtleneck"
	desc = "Just looking at it makes you want to buy an SKS, go into the woods, and -operate-."
	icon_state = "tactifool"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/tacticool/skirt
	name = "tacticool skirtleneck"
	desc = "Just looking at it makes you want to buy an SKS, go into the woods, and -operate-."
	icon_state = "tactifool_skirt"
	item_state = "bl_suit"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/sniper
	name = "Tactical turtleneck suit"
	desc = "A double seamed tactical turtleneck disguised as a civilian grade silk suit. Intended for the most formal operator. The collar is really sharp."
	icon = 'icons/obj/clothing/under/suits.dmi'
	icon_state = "really_black_suit"
	item_state = "bl_suit"
	mob_overlay_icon = 'icons/mob/clothing/under/suits.dmi'
	can_adjust = FALSE

/obj/item/clothing/under/syndicate/camo
	name = "camouflage fatigues"
	desc = "A green military camouflage uniform."
	icon_state = "camogreen"
	item_state = "g_suit"
	can_adjust = FALSE

/obj/item/clothing/under/syndicate/soviet
	name = "Ratnik 5 tracksuit"
	desc = "Badly translated labels tell you to clean this in Vodka. Great for squatting in."
	icon_state = "trackpants"
	can_adjust = FALSE
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = NONE

/obj/item/clothing/under/syndicate/combat
	name = "combat uniform"
	desc = "With a suit lined with this many pockets, you are ready to operate."
	icon_state = "syndicate_combat"
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/rus_army
	name = "advanced military tracksuit"
	desc = "Military grade tracksuits for frontline squatting."
	icon_state = "rus_under"
	can_adjust = FALSE
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	resistance_flags = NONE

/obj/item/clothing/under/syndicate/intern
	name = "red polo and khaki pants"
	desc = "A non-descript and slightly suspicious looking polo paired with a respectable yet also suspicious pair of khaki pants."
	icon_state = "jake"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE

/obj/item/clothing/under/syndicate/aclf
	name = "2nd Battlegroup uniform"
	desc = "A black uniform worn by the officers of the Gorlex Marauders 2nd Battlegroup."
	icon_state = "aclf"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE

/obj/item/clothing/under/syndicate/aclfgrunt
	name = "ACLF uniform"
	desc = "A button-up in a tasteful shade of gray with red pants, used as the uniform of the Anti-Corporate Liberation front on the rim."
	icon_state = "aclfgrunt"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE

/obj/item/clothing/under/syndicate/gorlex
	name = "Gorlex Marauder uniform"
	desc = "Originally worn by the miners of the Gorlex VII colony, it is now donned by veteran Gorlex Marauders."
	icon_state = "gorlex"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	alt_covers_chest = TRUE
	supports_variations = DIGITIGRADE_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/cybersun
	name = "Cybersun coveralls"
	desc = "Nomex coveralls worn by workers and research personnel employed by Cybersun industries."
	icon_state = "cybersun"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 100)
	alt_covers_chest = TRUE
	supports_variations = DIGITIGRADE_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/medic
	name = "Cybersun medical jumpsuit"
	desc = "Sterile coveralls worn by Cybersun Industries field medics for protection against biological hazards."
	icon_state = "cybersun_med"
	permeability_coefficient = 0.5
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/under/syndicate/medic/skirt
	name = "Cybersun medical jumpskirt"
	desc = "A sterile jumpskirt worn by Cybersun Industries field medics for protection against biological hazards."
	icon_state = "cybersun_med_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/donk
	name = "Donk! Co. employee uniform"
	desc = "The standard employee uniform of Donk Co. Smells like minimum wage."
	icon_state = "donk_cargo"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	body_parts_covered = CHEST|GROIN|ARMS
	alt_covers_chest = TRUE
	supports_variations = DIGITIGRADE_VARIATION | KEPORI_VARIATION

/obj/item/clothing/under/syndicate/donk/qm
	name = "Donk! Co. manager uniform"
	desc = "The standard uniform of Donk Co. managers. Direct all complaints here."
	icon_state = "donk_qm"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	supports_variations = DIGITIGRADE_VARIATION | KEPORI_VARIATION

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

/obj/item/clothing/under/syndicate/skirt/maid
	name = "tactical maid outfit"
	desc = "A 'tactical' turtleneck fashioned to the likeness of a maid outfit. Why the Syndicate has these, you'll never know."
	icon_state = "syndimaid"
	item_state = "syndimaid"

/obj/item/clothing/under/syndicate/skirt/maid/Initialize()
	. = ..()
	var/obj/item/clothing/accessory/maidapron/syndicate/A = new (src)
	attach_accessory(A)

/datum/outfit/syndicate/intern
	name = "Syndicate Operative - Intern"

	uniform = /obj/item/clothing/under/syndicate/intern
	suit = /obj/item/clothing/suit/space/syndicate/surplus
	suit_store = /obj/item/tank/internals/emergency_oxygen/engi
	head = /obj/item/clothing/head/helmet/space/syndicate/surplus
	mask = /obj/item/clothing/mask/breath
	shoes = /obj/item/clothing/shoes/laceup
	r_hand = /obj/item/gun/ballistic/automatic/ebr
	gloves =  null
	l_pocket = /obj/item/pinpointer/nuke/syndicate
	r_pocket = /obj/item/ammo_box/magazine/ebr
	belt = null
	back = /obj/item/tank/jetpack/oxygen/harness
	backpack_contents = null
	internals_slot = ITEM_SLOT_SUITSTORE

	tc = 10
	uplink_type = /obj/item/uplink/nuclear
	uplink_slot = ITEM_SLOT_BELT

//INTEQ
//maybe split it into it's own file?

/obj/item/clothing/under/syndicate/inteq
	name = "inteq turtleneck"
	desc = "A rich brown turtleneck with black pants, it has a small 'IRMG' embroidered onto the shoulder."
	icon_state = "inteq"
	item_state = "bl_suit"
	has_sensor = HAS_SENSORS
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION
	alt_covers_chest = TRUE
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	mob_overlay_icon = 'icons/mob/clothing/under/syndicate.dmi'

/obj/item/clothing/under/syndicate/inteq/skirt
	name = "inteq skirtleneck"
	desc = "A rich brown turtleneck with a free flowing black skirt, it has a small 'IRMG' embroidered onto the shoulder."
	icon_state = "inteq_skirt"
	item_state = "bl_suit"
	has_sensor = HAS_SENSORS
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 40)
	body_parts_covered = CHEST|GROIN|ARMS
	supports_variations = DIGITIGRADE_VARIATION_NO_NEW_ICON | VOX_VARIATION | KEPORI_VARIATION
	alt_covers_chest = TRUE

/obj/item/clothing/under/syndicate/inteq/artificer
	name = "inteq artificer overalls"
	desc = "A black set of overalls atop a standard issue turtleneck, for the IRMG's support division Artificers."
	icon_state = "inteqeng"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/inteq/skirt/artificer
	name = "inteq artificer overall skirt"
	desc = "A black set of overalls in the likeness of a skirt atop a standard issue turtleneck, for the IRMG's support division Artificers."
	icon_state = "inteqeng_skirt"
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/inteq/corpsman
	name = "inteq corpsman turtleneck"
	desc = "A sterile white turtleneck with tactical cargo pants, it is emblazoned with the lettering 'IRMG' on the shoulder. For the IRMG's support division Corpsmen."
	icon_state = "inteqmed"
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION

/obj/item/clothing/under/syndicate/inteq/skirt/corpsman
	name = "inteq corpsman skirtleneck"
	desc = "A sterile white turtleneck with a free flowing black skirt, it is emblazoned with the lettering 'IRMG' on the shoulder. For the IRMG's support division Corpsmen."
	icon_state = "inteqmed_skirt"
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/inteq/skirt/maid
	name = "inteq tactical maid outfit"
	desc = "A 'tactical' turtleneck fashioned to the likeness of a maid outfit. This one is lovingly knitted in the colors of the IRMG."
	icon_state = "inteqmaid"
	item_state = "inteqmaid"
	can_adjust = FALSE
	supports_variations = KEPORI_VARIATION | VOX_VARIATION | DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/syndicate/inteq/skirt/maid/Initialize()
	. = ..()
	var/obj/item/clothing/accessory/maidapron/inteq/A = new (src)
	attach_accessory(A)

/obj/item/clothing/under/syndicate/inteq/honorable
	name = "honorable vanguard turtleneck"
	desc = "a midnight black turtleneck worn by honorable Vanguards of the IRMG."
	icon_state = "inteq_honorable"
	item_state = "inteq_honorable"
	supports_variations = KEPORI_VARIATION | DIGITIGRADE_VARIATION
