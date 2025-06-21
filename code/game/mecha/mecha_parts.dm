/////////////////////////
////// Mecha Parts //////
/////////////////////////

/obj/item/mecha_parts
	name = "exosuit part"
	icon = 'icons/mecha/mech_construct.dmi'
	icon_state = "blank"
	w_class = WEIGHT_CLASS_GIGANTIC
	flags_1 = CONDUCT_1

/obj/item/mecha_parts/proc/try_attach_part(mob/user, obj/mecha/M) //For attaching parts to a finished mech
	if(!user.transferItemToLoc(src, M))
		to_chat(user, span_warning("\The [src] is stuck to your hand, you cannot put it in \the [M]!"))
		return FALSE
	user.visible_message(span_notice("[user] attaches [src] to [M]."), span_notice("You attach [src] to [M]."))
	return TRUE

/obj/item/mecha_parts/part/try_attach_part(mob/user, obj/mecha/M)
	return

/obj/item/mecha_parts/chassis
	name = "Exosuit Chassis"
	icon_state = "backbone"
	interaction_flags_item = NONE			//Don't pick us up!!
	var/construct_type

/obj/item/mecha_parts/chassis/Initialize()
	. = ..()
	if(construct_type)
		AddComponent(construct_type)

/////////// Ripley

/obj/item/mecha_parts/chassis/ripley
	name = "\improper Ripley chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/ripley

/obj/item/mecha_parts/part/ripley_torso
	name = "\improper Ripley torso"
	desc = "A torso part of Ripley APLU. Contains power unit, processing core and life support systems."
	icon_state = "ripley_harness"

/obj/item/mecha_parts/part/ripley_left_arm
	name = "\improper Ripley left arm"
	desc = "A Ripley APLU left arm. Data and power sockets are compatible with most exosuit tools."
	icon_state = "ripley_l_arm"

/obj/item/mecha_parts/part/ripley_right_arm
	name = "\improper Ripley right arm"
	desc = "A Ripley APLU right arm. Data and power sockets are compatible with most exosuit tools."
	icon_state = "ripley_r_arm"

/obj/item/mecha_parts/part/ripley_left_leg
	name = "\improper Ripley left leg"
	desc = "A Ripley APLU left leg. Contains somewhat complex servodrives and balance maintaining systems."
	icon_state = "ripley_l_leg"

/obj/item/mecha_parts/part/ripley_right_leg
	name = "\improper Ripley right leg"
	desc = "A Ripley APLU right leg. Contains somewhat complex servodrives and balance maintaining systems."
	icon_state = "ripley_r_leg"

///////// Odysseus

/obj/item/mecha_parts/chassis/odysseus
	name = "\improper 200 Series chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/odysseus

/obj/item/mecha_parts/part/odysseus_head
	name = "\improper 200 Series head"
	desc = "A 200 Series head. Contains an integrated medical HUD scanner."
	icon_state = "odysseus_head"

/obj/item/mecha_parts/part/odysseus_torso
	name = "\improper 200 Series torso"
	desc="The torso of a 200 Series exosuit. Contains power unit, processing core and life support systems along with an attachment port for a mounted sleeper."
	icon_state = "odysseus_torso"

/obj/item/mecha_parts/part/odysseus_left_arm
	name = "\improper 200 Series left arm"
	desc = "A 200 Series left arm. Data and power sockets are compatible with specialized medical equipment."
	icon_state = "odysseus_l_arm"

/obj/item/mecha_parts/part/odysseus_right_arm
	name = "\improper 200 Series right arm"
	desc = "A 200 Series right arm. Data and power sockets are compatible with specialized medical equipment."
	icon_state = "odysseus_r_arm"

/obj/item/mecha_parts/part/odysseus_left_leg
	name = "\improper 200 Series left leg"
	desc = "A 200 Series left leg. Contains complex servodrives and balance maintaining systems to maintain stability for critical patients."
	icon_state = "odysseus_l_leg"

/obj/item/mecha_parts/part/odysseus_right_leg
	name = "\improper 200 Series right leg"
	desc = "A 200 Series right leg. Contains complex servodrives and balance maintaining systems to maintain stability for critical patients."
	icon_state = "odysseus_r_leg"

///////// Gygax

/obj/item/mecha_parts/chassis/gygax
	name = "\improper 500 Series chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/gygax

/obj/item/mecha_parts/part/gygax_torso
	name = "\improper 500 Series torso"
	desc = "The torso of a 500 Series exosuit. Contains power unit, processing core and life support systems."
	icon_state = "gygax_harness"

/obj/item/mecha_parts/part/gygax_head
	name = "\improper 500 Series head"
	desc = "A 500 Series head. Houses advanced surveillance and targeting sensors."
	icon_state = "gygax_head"

/obj/item/mecha_parts/part/gygax_left_arm
	name = "\improper 500 Series left arm"
	desc = "A 500 Series left arm. Data and power sockets are compatible with most exosuit tools and weapons."
	icon_state = "gygax_l_arm"

/obj/item/mecha_parts/part/gygax_right_arm
	name = "\improper 500 Series right arm"
	desc = "A 500 Series right arm. Data and power sockets are compatible with most exosuit tools and weapons."
	icon_state = "gygax_r_arm"

/obj/item/mecha_parts/part/gygax_left_leg
	name = "\improper 500 Series left leg"
	desc = "A 500 Series left leg. Constructed with advanced servomechanisms and actuators to enable faster speed."
	icon_state = "gygax_l_leg"

/obj/item/mecha_parts/part/gygax_right_leg
	name = "\improper 500 Series right leg"
	desc = "A 500 Series right leg. Constructed with advanced servomechanisms and actuators to enable faster speed."
	icon_state = "gygax_r_leg"

/obj/item/mecha_parts/part/gygax_armor
	gender = PLURAL
	name = "\improper 500 Series armor plates"
	desc = "A set of armor plates designed for the 500 Series. Designed to effectively deflect damage with a lightweight construction."
	icon_state = "gygax_armor"

/obj/item/mecha_parts/chassis/mp_gygax
	name = "\improper MP-Gygax chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/mpgygax

/obj/item/mecha_parts/part/mpgygax_armor
	gender = PLURAL
	name = "\improper MP-Gygax armor plates"
	desc = "A set of stripped down armor plates designed for the MP-Gygax. Designed to moderately deflect damage with a lightweight construction."
	icon_state = "mpgygax_armor"


//////////// Durand

/obj/item/mecha_parts/chassis/durand
	name = "\improper Durand chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/durand

/obj/item/mecha_parts/part/durand_torso
	name = "\improper Durand torso"
	desc = "A torso part of Durand. Contains power unit, processing core and life support systems within a robust protective frame."
	icon_state = "durand_harness"

/obj/item/mecha_parts/part/durand_head
	name = "\improper Durand head"
	desc = "A Durand head. Houses advanced surveillance and targeting sensors."
	icon_state = "durand_head"

/obj/item/mecha_parts/part/durand_left_arm
	name = "\improper Durand left arm"
	desc = "A Durand left arm. Data and power sockets are compatible with most exosuit tools and weapons. Packs a really mean punch as well."
	icon_state = "durand_l_arm"

/obj/item/mecha_parts/part/durand_right_arm
	name = "\improper Durand right arm"
	desc = "A Durand right arm. Data and power sockets are compatible with most exosuit tools and weapons. Packs a really mean punch as well."
	icon_state = "durand_r_arm"

/obj/item/mecha_parts/part/durand_left_leg
	name = "\improper Durand left leg"
	desc = "A Durand left leg. Built particularly sturdy to support the Durand's heavy weight and defensive needs."
	icon_state = "durand_l_leg"

/obj/item/mecha_parts/part/durand_right_leg
	name = "\improper Durand right leg"
	desc = "A Durand right leg. Built particularly sturdy to support the Durand's heavy weight and defensive needs."
	icon_state = "durand_r_leg"

/obj/item/mecha_parts/part/durand_armor
	gender = PLURAL
	name = "\improper Durand armor plates"
	desc = "A set of armor plates for the Durand. Built heavy to resist an incredible amount of brute force."
	icon_state = "durand_armor"

////////// Firefighter

/obj/item/mecha_parts/chassis/firefighter
	name = "\improper Firefighter chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/firefighter

////////// Phazon

/obj/item/mecha_parts/chassis/phazon
	name = "\improper Phazon chassis"
	construct_type = /datum/component/construction/unordered/mecha_chassis/phazon

/obj/item/mecha_parts/part/phazon_torso
	name="\improper Phazon torso"
	desc="A Phazon torso part. The socket for the anomaly core that powers the exosuit's unique phase drives is located in the middle."
	icon_state = "phazon_harness"

/obj/item/mecha_parts/part/phazon_head
	name="\improper Phazon head"
	desc="A Phazon head. Its sensors are carefully calibrated to provide vision and data even when the exosuit is phasing."
	icon_state = "phazon_head"

/obj/item/mecha_parts/part/phazon_left_arm
	name="\improper Phazon left arm"
	desc="A Phazon left arm. Several microtool arrays are located under the armor plating, which can be adjusted to the situation at hand."
	icon_state = "phazon_l_arm"

/obj/item/mecha_parts/part/phazon_right_arm
	name="\improper Phazon right arm"
	desc="A Phazon right arm. Several microtool arrays are located under the armor plating, which can be adjusted to the situation at hand."
	icon_state = "phazon_r_arm"

/obj/item/mecha_parts/part/phazon_left_leg
	name="\improper Phazon left leg"
	desc="A Phazon left leg. It contains the unique phase drives that allow the exosuit to phase through solid matter when engaged."
	icon_state = "phazon_l_leg"

/obj/item/mecha_parts/part/phazon_right_leg
	name="\improper Phazon right leg"
	desc="A Phazon right leg. It contains the unique phase drives that allow the exosuit to phase through solid matter when engaged."
	icon_state = "phazon_r_leg"

/obj/item/mecha_parts/part/phazon_armor
	name="Phazon armor"
	desc="Phazon armor plates. They are layered with plasma to protect the pilot from the stress of phasing and have unusual properties."
	icon_state = "phazon_armor"


///////// Circuitboards

/obj/item/circuitboard/mecha
	name = "exosuit circuit board"
	icon = 'icons/obj/module.dmi'
	icon_state = "std_mod"
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 5
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 3
	throw_range = 7

/obj/item/circuitboard/mecha/ripley/peripherals
	name = "Ripley Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/ripley/main
	name = "Ripley Central Control module (Exosuit Board)"
	icon_state = "mainboard"


/obj/item/circuitboard/mecha/gygax/peripherals
	name = "500 Series Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/gygax/targeting
	name = "500 Series Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/gygax/main
	name = "500 Series Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/durand/peripherals
	name = "Durand Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/durand/targeting
	name = "Durand Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/durand/main
	name = "Durand Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/odysseus/peripherals
	name = "200 Series Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/odysseus/main
	name = "200 Series Central Control module (Exosuit Board)"
	icon_state = "mainboard"

/obj/item/circuitboard/mecha/phazon/peripherals
	name = "Phazon Peripherals Control module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/phazon/targeting
	name = "Phazon Weapon Control and Targeting module (Exosuit Board)"
	icon_state = "mcontroller"

/obj/item/circuitboard/mecha/phazon/main
	name = "Phazon Central Control module (Exosuit Board)"
