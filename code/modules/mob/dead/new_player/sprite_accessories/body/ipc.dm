

#define GENERIC_3D_PRINTED_DESC "Modern day autolathes are able to create a wide assortment of things at relatively low cost, IPC parts included. As such, 3D Printed parts are\
	\nincreasingly popular with bodymoders and fashionable postrionics alike."

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

//Pawsitrons United N1

/datum/sprite_accessory/body/ipc_chassis/pawsitrons
	name = "Pawsitrons United N1"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pawsitrons,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pawsitrons,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pawsitrons,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pawsitrons,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pawsitrons,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pawsitrons,
	)

//Makosso-Warra MW-PMU

/datum/sprite_accessory/body/ipc_chassis/mwpmu
	name = "Makosso-Warra MW-PMU"
	desc = "Makosso-Warra's standard consumer frame, built on top of the MW-HIAU base. A popular choice for prosthetics, as well as a full postrionic frame.\
	\nThe visor unit contains a wide camera for imaging, much cheaper than robotic eyes, but allegedly is not that much of a tradeoff for the lower cost."
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/mwpmu,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/mwpmu,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/mwpmu,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/mwpmu,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/mwpmu,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/mwpmu,
	)
//Makosso-Warra MW-PMU (Custom Visor Color)

/datum/sprite_accessory/body/mwpmu
	name = "Makosso-Warra MW-PMU (Custom Visor Color)"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/mwpmu_visor_color,
	)

//Makosso-Warra MW-HIACU

/datum/sprite_accessory/body/ipc_chassis/mwhiacu
	name = "Makosso-Warra MW-HIACU (MW)"
	desc = "A more durable and eaier to manufacture frame, based on the MW-PMU. A large number of Tricorp employees during the ICW have had HIACU as a chassis or\
	\nprosthetic. Made for all the Tricorp companies, production has paused as MW has too many stockpiled, but intends to continue once demand catches up."
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/mwhiacu,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/mwhiacu,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/mwhiacu,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/mwhiacu,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/mwhiacu,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/mwhiacu,
	)

//Makosso-Warra MW-HIACU (VI)

/datum/sprite_accessory/body/ipc_chassis/mwhiacu_vi
	name = "Makosso-Warra MW-HIACU (VI)"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/mwhiacu_vi,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/mwhiacu_vi,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/mwhiacu_vi,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/mwhiacu_vi,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/mwhiacu_vi,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/mwhiacu_vi,
	)

//Atua Synkinetics Parça

/datum/sprite_accessory/body/ipc_chassis/atua
	name = "Atua Synkinetics Parça"
	desc = "Atua Synkinetics's standard IPC frame. Originally designed by a lonely solarian student who lived in the African Canton, the design is has remained\
	\nidentical to as it was centuries ago, besides spec-upgrades. It is considered a classic, and appears in numerous pieces of solarian media."
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/atua,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/atua,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/atua,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/atua,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/atua,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/atua,
	)

//Scarborgh Arms IPC-73

/datum/sprite_accessory/body/ipc_chassis/saipc
	name = "Scarborgh Arms IPC-73"
	desc = "Scarborgh Arms's old line of frames, based on licened Atua Synkinetics's Parça frames. Atua attempted to revoke the licence during the ICW to\
	\navoid conflict, but by then it was too late; Scarborgh Arms now could produce the IPC-80 at an unprecedented scale at that point. However the IPC-73\
	\nceased production to avoid legal troubles with Atua."
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/saipc,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/saipc,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/saipc,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/saipc,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/saipc,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/saipc,
	)

/datum/sprite_accessory/body/saipc
	name = "Scarborgh Arms IPC-73 Type-2 boxhead"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/saipc_boxhead,
	)

//Scarborgh Arms IPC-80 Mk.2

/datum/sprite_accessory/body/ipc_chassis/saipc2
	name = "Scarborgh Arms IPC-80 MK.2"
	desc = "Scarborgh Arms's new line of frames. It's an improved and more well built version of the IPC-80. While produced for indvidual sale, a large amount\
	is produced on contract for the NGR in their territory, as a way to grow domestic production capablity. The NGR offers veterans with old IPC-73 or IPC-80\
	parts to replace them with the MK.2"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/saipc2,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/saipc2,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/saipc2,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/saipc2,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/saipc2,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/saipc2,
	)

//Lanchester Mechanics 'HEAVY DUTY FRAME'

/datum/sprite_accessory/body/ipc_chassis/lanchesterheavy
	name = "Lanchester Mechanics 'HEAVY DUTY FRAME'"
	desc = "Lanchester Mechanics's industrial frame. Often loaned to employees then returned once they change jobs, however secondhand or privately owned users\
	\nare not unheard of. Was commonly bought by Tricorp before inhouse frame production capablity was established."
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/lanchesterheavy,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/lanchesterheavy,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/lanchesterheavy,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/lanchesterheavy,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/lanchesterheavy,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/lanchesterheavy,
	)

/datum/sprite_accessory/body/lanchesterheavy_boxhead
	name = "Lanchester Mechanics 'HEAVY DUTY FRAME' 'PLUS' boxhead"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/lanchesterheavy_boxhead,
	)

//HARDLINE 'Longshore'

/datum/sprite_accessory/body/ipc_chassis/lanchesterworker
	name = "HARDLINE 'Longshore'"
	desc = "HARDLINE's only frame. It's based on a Lanchester Mechanics frame with custom plating, intended to help with internal shipbuilding. However, it's\
	specializiation has made it popular outside the company's production lines, and is commonly sold in volume as a side-buisness for HARDLINE."
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/lanchesterworker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/lanchesterworker,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/lanchesterworker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/lanchesterworker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/lanchesterworker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/lanchesterworker,
	)

//Custom Lanchester Unplated

/datum/sprite_accessory/body/ipc_chassis/lanchesterunplated
	name = "Custom Unplated"
	desc = "A Lanchester frame with no plating. It is not intended to be used or sold like this, and the lack of protection makes critical components vulnerable."
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/lanchesterunplated,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/lanchesterunplated,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/lanchesterunplated,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/lanchesterunplated,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/lanchesterunplated,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/lanchesterunplated,
	)

//PGF Mechanics MK.III

/datum/sprite_accessory/body/ipc_chassis/pgfmk3_suhols
	name = "PGF Mechanics MK.III Type 'Suhols-Ro'"
	desc = "A very old frame of PGF Mechanics. It's low cost vs newer models is seen as why it has never stopped production. Intended as both a simple postrionic\
	\nframe and as prosthetics for Elzuose, it's mass adoptation outside the military has resulted in its very long lifespan, despite it's replacements.\
	\nIt comes in two variations, Suhols-Ro and Wusha. The differences are mostly cosmetic, with almost no difference in specs."
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgfmk3_suhols,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pgfmk3_suhols,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pgfmk3,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pgfmk3,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pgfmk3,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pgfmk3,
	)

/datum/sprite_accessory/body/pgfmk3_suhols_boxhead
	name = "PGF Mechanics MK.III Type 'Suhols-Ro' aftermarket boxhead"
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgfmk3_suhols_boxhead,
	)

/datum/sprite_accessory/body/ipc_chassis/pgfmk3_wusha
	name = "PGF Mechanics MK.III Type 'Wusha'"
	desc = "A very old frame of PGF Mechanics. It's low cost vs newer models is seen as why it has never stopped production. Intended as both a simple postrionic\
	\nframe and as prosthetics for Elzuose, it's mass adoptation outside the military has resulted in its very long lifespan, despite it's replacements.\
	\nIt comes in two variations, Suhols-Ro and Wusha. The differences are mostly cosmetic, with almost no difference in specs."
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgfmk3_wusha,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pgfmk3_wusha,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pgfmk3,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pgfmk3,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pgfmk3,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pgfmk3,
	)

/datum/sprite_accessory/body/pgfmk3_wusha_boxhead
	name = "PGF Mechanics MK.III Type 'Wusha' aftermarket boxhead"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgfmk3_wusha_boxhead,
	)

//PGF Mechanics MK.V

/datum/sprite_accessory/body/ipc_chassis/pgf
	name = "PGF Mechanics MK.V Type-P"
	desc = "Widely considered to be the most advanced postrionic frame ever created, the MK.V is a masterwork of technology, only held back by it's masterwork of\
	\na price. The visor is holographic, meant for depth for the eyes, but is able to be manipulated for emotions or even used as a monochrome screen. The jaw also \
	moves with speech, but unable to truly eat. It's wide adoption in the PGFN is considered by many a show of force for the PGF's technological might."
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
	name = "PGF Mechanics MK.V Type-D"
	desc = "Widely considered to be the most advanced postrionic frame ever created, the MK.V is a masterwork of technology, only held back by it's masterwork of\
	\na price. The visor is holographic, meant for depth for the eyes, but is able to be manipulated for emotions or even used as a monochrome screen. The jaw also \
	moves with speech, but unable to truly eat. It's wide adoption in the PGFN is considered by many a show of force for the PGF's technological might."
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgf,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pgf,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pgf,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pgf,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pgf/type_d,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pgf/type_d,
	)

//Besoro Bishop

/datum/sprite_accessory/body/ipc_chassis/bishop
	name = "Besoro Bishop"
	desc = "The flagship of Besoro, an up and coming tech startup. Intended for medical purposes, it has gained a niche following for its clean and sleek look.\
	The company isn't sure how to deal with it however, and still only sells it for internal-use or as prosthetics to customers. But many have gotten their hands\
	on it anyways, in no small part due to it's following happily paying for the markup when sold seperately as prosthetics."
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/bishop,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/bishop,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/bishop,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/bishop,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/bishop,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/bishop,
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


//Custom 3D Printed

/datum/sprite_accessory/body/lanchesterunplated
	name = "Custom 3D Printed Boxhead"
	desc = GENERIC_3D_PRINTED_DESC
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/custom_boxhead,
	)
	color_src = MUTCOLORS

/datum/sprite_accessory/body/custom_monoeye
	name = "Custom 3D Printed monoeye head"
	desc = GENERIC_3D_PRINTED_DESC
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/custom_monoeye,
	)
	color_src = MUTCOLORS

/datum/sprite_accessory/body/ipc_chassis/custompgfmk3_suhols
	name = "Custom 3D Printed MK.III Type 'Suhols-Ro'"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/custompgf3_suhols,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/custompgf3_suhols,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/custompgf3,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/custompgf3,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/custompgf3,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/custompgf3,
	)

/datum/sprite_accessory/body/ipc_chassis/custompgf3_wusha
	name = "Custom 3D Printed MK.III Type 'Wusha'"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/custompgf3_wusha,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/custompgf3_wusha,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/custompgf3,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/custompgf3,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/custompgf3,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/custompgf3,
	)

/datum/sprite_accessory/body/ipc_chassis/customatua
	name = "Custom 3D Printed Atua"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/customatua,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/customatua,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/customatua,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/customatua,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/customatua,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/customatua,
	)

/datum/sprite_accessory/body/ipc_chassis/customlanchesterheavy
	name = "Custom 3D Printed Lanchester"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/customlanchesterheavy,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/customlanchesterheavy,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/customlanchesterheavy,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/customlanchesterheavy,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/customlanchesterheavy,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/customlanchesterheavy,
	)

/datum/sprite_accessory/body/ipc_chassis/customlanchesterworker
	name = "Custom 3D Printed Longshore"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/customlanchesterworker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/customlanchesterworker,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/customlanchesterworker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/customlanchesterworker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/customlanchesterworker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/customlanchesterworker,
	)

/datum/sprite_accessory/body/ipc_chassis/custombishop
	name = "Custom 3D Printed Bishop"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/custombishop,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/custombishop,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/custombishop,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/custombishop,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/custombishop,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/custombishop,
	)

/datum/sprite_accessory/body/ipc_chassis/customhiacu
	name = "Custom 3D Printed HIACU"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/customhiacu,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/customhiacu,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/customhiacu,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/customhiacu,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/customhiacu,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/customhiacu,
	)

/datum/sprite_accessory/body/customatua_monoc
	name = "Custom 3D Printed Atua (Monocolor)"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/customatua_monoc,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/customatua_monoc,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/customatua_monoc,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/customatua_monoc,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/customatua_monoc,
	)

/datum/sprite_accessory/body/ipc_chassis/customseeker
	name = "Custom 3D Printed Seeker"
	desc = GENERIC_3D_PRINTED_DESC
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/customseeker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/customseeker,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/customseeker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/customseeker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/customseeker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/customseeker,
	)

/datum/sprite_accessory/body/saipc2
	name = "Custom 3D Printed IPC-80"
	desc = GENERIC_3D_PRINTED_DESC
	replacement_bodyparts = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/custom_saipc2,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/custom_saipc2,
	)

/datum/sprite_accessory/body/pgf_monocolor
	name = "PGF Mechanics MK.V Type-P (Monocolor)"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgf_monocolor,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pgf_monocolor,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pgf_monocolor,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pgf_monocolor,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pgf_monocolor,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pgf_monocolor,
	)

/datum/sprite_accessory/body/pgf_monocolor_type_d
	name = "PGF Mechanics MK.V Type-D (Monocolor)"
	desc = GENERIC_3D_PRINTED_DESC
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgf_monocolor,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pgf_monocolor,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pgf_monocolor,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pgf_monocolor,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pgf_monocolor/type_d,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pgf_monocolor/type_d,
	)

#undef GENERIC_3D_PRINTED_DESC
