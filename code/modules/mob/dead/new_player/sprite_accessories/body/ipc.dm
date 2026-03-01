
//desc comments are meant for the pr body when its more finished, ignore them
/*
	The blurbs in the PR you shouldn't take these as offical lore for your IPC, these should instead serve as jumping-off points for your
	character's lore, after all, these are just skins at the end of the day.
	They exist mostly to document the 'story' that was in mind when spriting, and have nearly no bearing on gameplay or roleplay.
*/

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
/*
	A highly unconventional frame produced by Pawsitrons United. Both the N1 and company were formed for a crowdfunder on a solarian gene-modder's forum,
	it's suprise popularity ensured that it's production continued long after the crowdfunding's end. It's awkward build along with paws for hands and
	feet make it extremely disorienting to use for non-fans
*/

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
/*
	Makosso-Warra's standard consumer frame, built on top of the MW-HIAU base. A popular choice for prosthetics, as well as a full postrionic frame.
	The visor unit contains a wide camera for imaging, much cheaper than robotic eyes, but allegedly is not that much of a tradeoff for cost.
*/

/datum/sprite_accessory/body/ipc_chassis/mwpmu
	name = "Makosso-Warra MW-PMU"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/mwpmu,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/mwpmu,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/mwpmu,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/mwpmu,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/mwpmu,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/mwpmu,
	)

//Makosso-Warra MW-HIACU
/*
	A more durable and eaier to manufacture frame, based on the MW-PMU. A large number of Tricorp employees during the ICW have had HIACU as a chassis or
	prosthetic. Made for all the Tricorp companies, production has paused as MW has too many stockpiled, but intends to continue once demand catches up.
*/

/datum/sprite_accessory/body/ipc_chassis/mwhiacu
	name = "Makosso-Warra MW-HIACU (MW)"
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
/*
	Atua Synkinetics's standard IPC frame. Originally designed by a lonely solarian student who lived in the African Canton, the design is  has reamained
	identical to as it was centuries ago, besides spec-upgrades. It is considered a classic, and appears in numerous pieces of solarian media.
*/

/datum/sprite_accessory/body/ipc_chassis/atua
	name = "Atua Synkinetics Parça"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/atua,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/atua,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/atua,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/atua,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/atua,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/atua,
	)

//Scarborgh Arms IPC-73
/*
	Scarborgh Arms's old line of frames, based on licened Atua Synkinetics's Parça frames. Atua attempted to revoke the licence during the ICW to
	avoid conflict, but by then it was too late; Scarborgh Arms now could produce the IPC-80 at an unprecedented scale at that point. However the IPC-73
	ceased production to avoid legal troubles with Atua.
*/

/datum/sprite_accessory/body/ipc_chassis/saipc
	name = "Scarborgh Arms IPC-73"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/saipc,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/saipc,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/saipc,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/saipc,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/saipc,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/saipc,
	)

//Scarborgh Arms IPC-80 Mk.2
/*
	Scarborgh Arms's new line of frames. It's an improved and more well built version of the IPC-80. While produced for indvidual sale, a large amount
	is produced on contract for the NGR in NGR territory, as a way to grow domestic production capablity. The NGR offers veterans with old IPC-73 or IPC-80
	parts to replace them with the Mk.2
*/

/datum/sprite_accessory/body/ipc_chassis/saipc2
	name = "Scarborgh Arms IPC-80 MK.2"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/saipc2,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/saipc2,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/saipc2,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/saipc2,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/saipc2,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/saipc2,
	)

//Lanchester Mechanics 'HEAVY DUTY FRAME'
/*
	Lanchester Mechanics's industrial frame. Often loaned to employees then returned once they change jobs, however secondhand or privately owned users
	are	not unheard of. Often bought by Tricorp before inhouse frame production capablity was established.
*/

/datum/sprite_accessory/body/ipc_chassis/lanchesterheavy
	name = "Lanchester Mechanics 'HEAVY DUTY FRAME'"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/lanchesterheavy,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/lanchesterheavy,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/lanchesterheavy,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/lanchesterheavy,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/lanchesterheavy,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/lanchesterheavy,
	)

//HARDLINE 'Longshore'
/*
	HARDLINE's only frame. It's based on a Lanchester Mechanics frame with custom plating, intended to help with internal shipbuilding. However, it's
	specializiation has made it popular outside the company's production lines, and is commonly sold in volume as a side-buisness for HARDLINE.
*/

/datum/sprite_accessory/body/ipc_chassis/lanchesterworker
	name = "HARDLINE 'Longshore'"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/lanchesterworker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/lanchesterworker,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/lanchesterworker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/lanchesterworker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/lanchesterworker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/lanchesterworker,
	)

//Custom Lanchester Unplated
/*
	A Lanchester frame with no plating. It is not sold like this, and the lack of protection makes it more vulnerable to damage.
*/

/datum/sprite_accessory/body/ipc_chassis/lanchesterunplated
	name = "Custom 'Unplated'"
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/lanchesterunplated,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/lanchesterunplated,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/lanchesterunplated,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/lanchesterunplated,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/lanchesterunplated,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/lanchesterunplated,
	)

//PGF Mechanics MK.III
/*
	A very old frame of PGF Mechanics. It's low cost vs newer models is seen as why it has never stopped production. Intended as both a simple postrionic
	frame and as prosthetics for Elzuose, it's mass adoptation outside the military has resulted in its very long lifespan, despite it's replacement.
	It comes in two variations, Suhols-Ro and Wusha. The differences are mostly cosmetic, with almost no difference in specs.
*/

/datum/sprite_accessory/body/ipc_chassis/pgfmk3_suhols
	name = "PGF Mechanics MK.III Type 'Suhols-Ro'"
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgfmk3_suhols,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pgfmk3_suhols,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pgfmk3,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pgfmk3,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pgfmk3,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pgfmk3,
	)


/datum/sprite_accessory/body/ipc_chassis/pgfmk3_wusha
	name = "PGF Mechanics MK.III Type 'Wusha'"
	color_src = MUTCOLORS
	replacement_bodyparts = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/ipc/pgfmk3_wusha,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/ipc/pgfmk3_wusha,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/ipc/pgfmk3,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/ipc/pgfmk3,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/ipc/pgfmk3,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/ipc/pgfmk3,
	)


//PGF Mechanics MK.V
/*
	Widely considered to be the most advanced postrionic frame ever created, the MK.V is a masterwork of technology, only held back by it's masterwork of
	a price. It's wide adoption in the PGFN is considered by many a show of force for the PGF's technological superiority.
*/

/datum/sprite_accessory/body/ipc_chassis/pgf
	name = "PGF Mechanics MK.V Type-P"
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
/*
	The flagship of Besoro, an up and coming tech startup. Intended for medical purposes, it has gained a niche following for its clean and sleek look.
	The company isn't sure how to deal with it however, and only sells it for internal or as prosthetics
*/

/datum/sprite_accessory/body/ipc_chassis/bishop
	name = "Besoro Bishop"
//	color_src = MUTCOLORS
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
