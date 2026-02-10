/datum/sprite_accessory/body/ipc_chassis // Used for changing limb icons, doesn't need to hold the actual icon. That's handled in ipc.dm
	icon = null
	icon_state = "who cares fuck you" // In order to pull the chassis correctly, we need AN icon_state(see line 36-39). It doesn't have to be useful, because it isn't used.
	color_src = 0
	/// Associated list of bodyparts by zone.
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc,
	)

/datum/sprite_accessory/body/ipc_chassis/morpheus
	name = "Morpheus Cyberkinetics (Custom)"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/morpheus,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/morpheus,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/morpheus,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/morpheus,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/morpheus,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/morpheus,
	)
	color_src = MUTCOLORS

/datum/sprite_accessory/body/ipc_chassis/bishop
	name = "Bishop Cyberkinetics"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/bishop,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/bishop,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/bishop,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/bishop,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/bishop,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/bishop,
	)

/datum/sprite_accessory/body/ipc_chassis/bishop_v2
	name = "Bishop Cyberkinetics 2.0"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/bishop_v2,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/bishop_v2,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/bishop_v2,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/bishop_v2,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/bishop_v2,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/bishop_v2,
	)

/datum/sprite_accessory/body/ipc_chassis/hephaestus
	name = "Hephaestus Industries"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/hephaestus,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/hephaestus,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/hephaestus,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/hephaestus,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/hephaestus,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/hephaestus,
	)

/datum/sprite_accessory/body/ipc_chassis/hephaestus_v2
	name = "Hephaestus Industries 2.0"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/hephaestus_v2,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/hephaestus_v2,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/hephaestus_v2,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/hephaestus_v2,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/hephaestus_v2,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/hephaestus_v2,
	)

/datum/sprite_accessory/body/ipc_chassis/pawsitrons
	name = "Pawsitrons United"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pawsitrons,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pawsitrons,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pawsitrons,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pawsitrons,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pawsitrons,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pawsitrons,
	)

/datum/sprite_accessory/body/ipc_chassis/shellguard
	name = "Shellguard Munitions Standard Series"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/shellguard,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/shellguard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/shellguard,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/shellguard,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/shellguard,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/shellguard,
	)

/datum/sprite_accessory/body/ipc_chassis/ward_takahashi
	name = "Ward-Takahashi Manufacturing"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/ward_takahashi,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/ward_takahashi,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/ward_takahashi,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/ward_takahashi,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/ward_takahashi,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/ward_takahashi,
	)

/datum/sprite_accessory/body/ipc_chassis/xion
	name = "Xion Manufacturing Group"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/xion,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/xion,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/xion,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/xion,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/xion,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/xion,
	)

/datum/sprite_accessory/body/ipc_chassis/xion_v2
	name = "Xion Manufacturing Group 2.0"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/xion_v2,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/xion_v2,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/xion_v2,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/xion_v2,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/xion_v2,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/xion_v2,
	)

/datum/sprite_accessory/body/ipc_chassis/zeng_hu
	name = "Zeng-Hu Pharmaceuticals"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/zeng_hu,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/zeng_hu,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/zeng_hu,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/zeng_hu,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/zeng_hu,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/zeng_hu,
	)

/datum/sprite_accessory/body/ipc_chassis/pgf
	name = "PGF Mechanics Type-P"
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgf,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pgf,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pgf,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pgf,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pgf,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pgf,
	)

/datum/sprite_accessory/body/ipc_chassis/pgf_type_d
	name = "PGF Mechanics Type-D"
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgf,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pgf,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pgf,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pgf,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pgf/type_d,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pgf/type_d,
	)

/datum/sprite_accessory/body/ipc_chassis/sprinter
	name = "Inteq Mothership 'Sprinter' Type 1"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/sprinter,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/sprinter,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/sprinter,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/sprinter,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/sprinter,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/sprinter,
	)

/datum/sprite_accessory/body/ipc_chassis/sprinter_v2
	name = "Inteq Mothership 'Sprinter' Type 2"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/sprinter/type_2,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/sprinter,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/sprinter,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/sprinter,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/sprinter,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/sprinter,
	)

/datum/sprite_accessory/body/ipc_chassis/seeker
	name = "Maxim Dynamics 'Seeker'"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/seeker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/seeker,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/seeker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/seeker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/seeker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/seeker,
	)

/datum/sprite_accessory/body/ipc_chassis/solferino
	name = "Absolution-Lux 'Solferino'"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/solferino,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/solferino,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/solferino,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/solferino,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/solferino,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/solferino,
	)

/datum/sprite_accessory/body/ipc_chassis/humaniform
	name = "Clover Corporation 'Humaniform'"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/humaniform,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/humaniform,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/humaniform,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/humaniform,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/humaniform,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/humaniform,
	)

/datum/sprite_accessory/body/ipc_chassis/cybersun
	name = "Cybersun Biodynamics S Series 'Ghost'"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/ghost,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/ghost,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/ghost,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/ghost,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/ghost,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/ghost,
	)
