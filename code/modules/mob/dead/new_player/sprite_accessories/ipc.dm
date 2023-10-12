// IPC accessories.

// Start screens

/datum/sprite_accessory/ipc_screen
	icon = 'icons/mob/ipc_accessories.dmi'
	color_src = EYECOLOR
	key = "ipc_screen"
	generic = "Screen Display"
	recommended_species = list(SPECIES_IPC)
	relevent_layers = list(BODY_ADJ_LAYER)


/datum/sprite_accessory/ipc_screen/blank
	name = "Blank Canvas"
	icon_state = "blank"

/datum/sprite_accessory/ipc_screen/blue
	name = "Blue"
	icon_state = "blue"
	color_src = 0

/datum/sprite_accessory/ipc_screen/blush
	name = "Blush"
	icon_state = "blush"

/datum/sprite_accessory/ipc_screen/bsod
	name = "BSOD"
	icon_state = "bsod"
	color_src = 0

/datum/sprite_accessory/ipc_screen/buffering
	name = "Buffering"
	icon_state = "buffering"

/datum/sprite_accessory/ipc_screen/breakout
	name = "Breakout"
	icon_state = "breakout"

/datum/sprite_accessory/ipc_screen/console
	name = "Console"
	icon_state = "console"

/datum/sprite_accessory/ipc_screen/doom
	name = "DOOM"
	icon_state = "doom"

/datum/sprite_accessory/ipc_screen/ecgwave
	name = "ECG Wave"
	icon_state = "ecgwave"

/datum/sprite_accessory/ipc_screen/eight
	name = "Eight"
	icon_state = "eight"

/datum/sprite_accessory/ipc_screen/eyes
	name = "Eyes (Spinny)"
	icon_state = "eyes"

/datum/sprite_accessory/ipc_screen/eyes_noanim
	name = "Eyes (No Spinny)"
	icon_state = "eyes_noanim"

/datum/sprite_accessory/ipc_screen/eyes_fortuna
	name = "Eyes (Sun and Moon)"
	icon_state = "eyes_fortuna"

/datum/sprite_accessory/ipc_screen/glider
	name = "Glider"
	icon_state = "glider"

/datum/sprite_accessory/ipc_screen/goggles
	name = "Goggles"
	icon_state = "goggles"

/datum/sprite_accessory/ipc_screen/green
	name = "Green"
	icon_state = "green"

/datum/sprite_accessory/ipc_screen/heart
	name = "Heart"
	icon_state = "heart"
	color_src = 0

/datum/sprite_accessory/ipc_screen/monoeye
	name = "Mono-eye"
	icon_state = "monoeye"

/datum/sprite_accessory/ipc_screen/nyaru
	name = "Nyaru"
	icon_state = "nyaru"

/datum/sprite_accessory/ipc_screen/nature
	name = "Nature"
	icon_state = "nature"

/datum/sprite_accessory/ipc_screen/orange
	name = "Orange"
	icon_state = "orange"

/datum/sprite_accessory/ipc_screen/pink
	name = "Pink"
	icon_state = "pink"

/datum/sprite_accessory/ipc_screen/purple
	name = "Purple"
	icon_state = "purple"

/datum/sprite_accessory/ipc_screen/rainbow
	name = "Rainbow"
	icon_state = "rainbow"
	color_src = 0

/datum/sprite_accessory/ipc_screen/red
	name = "Red"
	icon_state = "red"

/datum/sprite_accessory/ipc_screen/text
	name = "Text Lines"
	icon_state = "text"

/datum/sprite_accessory/ipc_screen/rgb
	name = "RGB"
	icon_state = "rgb"

/datum/sprite_accessory/ipc_screen/scroll
	name = "Scanline"
	icon_state = "scroll"

/datum/sprite_accessory/ipc_screen/shower
	name = "Shower"
	icon_state = "shower"

/datum/sprite_accessory/ipc_screen/sinewave
	name = "Sinewave"
	icon_state = "sinewave"

/datum/sprite_accessory/ipc_screen/squarewave
	name = "Square wave"
	icon_state = "squarewave"

/datum/sprite_accessory/ipc_screen/static_screen
	name = "Static"
	icon_state = "static"

/datum/sprite_accessory/ipc_screen/yellow
	name = "Yellow"
	icon_state = "yellow"

/datum/sprite_accessory/ipc_screen/textdrop
	name = "Text drop"
	icon_state = "textdrop"

/datum/sprite_accessory/ipc_screen/stars
	name = "Stars"
	icon_state = "stars"

/datum/sprite_accessory/ipc_screen/loading
	name = "Loading"
	icon_state = "loading"

/datum/sprite_accessory/ipc_screen/windowsxp
	name = "Windows XP"
	icon_state = "windowsxp"

/datum/sprite_accessory/ipc_screen/tetris
	name = "Tetris"
	icon_state = "tetris"

/datum/sprite_accessory/ipc_screen/bubbles
	name = "Bubbles"
	icon_state = "bubbles"

/datum/sprite_accessory/ipc_screen/tv
	name = "Color Test"
	icon_state = "tv"

// Start antennas

/datum/sprite_accessory/ipc_antennas
	icon = 'icons/mob/ipc_accessories.dmi'
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_SECONDARY
	key = "ipc_antenna"
	generic = "Antenna"
	recommended_species = list(SPECIES_IPC)
	relevent_layers = list(BODY_ADJ_LAYER)

/datum/sprite_accessory/ipc_antennas/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD)
		return TRUE
	return FALSE


/datum/sprite_accessory/ipc_antennas/none
	name = "None"
	icon_state = "None"

/datum/sprite_accessory/ipc_antennas/angled
	name = "Angled"
	icon_state = "antennae"

/datum/sprite_accessory/ipc_antennas/antlers
	name = "Antlers"
	icon_state = "antlers"

/datum/sprite_accessory/ipc_antennas/crowned
	name = "Crowned"
	icon_state = "crowned"

/datum/sprite_accessory/ipc_antennas/cyberhead
	name = "Cyberhead"
	icon_state = "cyberhead"

/datum/sprite_accessory/ipc_antennas/droneeyes
	name = "Drone Eyes"
	icon_state = "droneeyes"

/datum/sprite_accessory/ipc_antennas/sidelights
	name = "Sidelights"
	icon_state = "sidelights"

/datum/sprite_accessory/ipc_antennas/tesla
	name = "Tesla"
	icon_state = "tesla"

/datum/sprite_accessory/ipc_antennas/tv
	name = "TV Antenna"
	icon_state = "tvantennae"

/datum/sprite_accessory/ipc_antennas/cross
	name = "Cross"
	icon_state = "cross"

/datum/sprite_accessory/ipc_antennas/sidepanels
	name = "Side Panels"
	icon_state = "sidepanels"

/datum/sprite_accessory/ipc_antennas/horns
	name = "Horns"
	icon_state = "horns"

/datum/sprite_accessory/ipc_antennas/langle
	name = "Left Angle"
	icon_state = "langle"

/datum/sprite_accessory/ipc_antennas/rangle
	name = "Right Angle"
	icon_state = "rangle"

// Start chassis - the worst thing ever please rework this

/datum/sprite_accessory/ipc_chassis // Used for changing limb icons, doesn't need to hold the actual icon. That's handled in ipc.dm
	icon = null
	icon_state = "who cares fuck you" // In order to pull the chassis correctly, we need AN icon_state(see line 36-39). It doesn't have to be useful, because it isn't used.
	color_src = FALSE
	key = "ipc_chassis"
	generic = "Chassis Type"
	recommended_species = list(SPECIES_IPC)

/datum/sprite_accessory/ipc_chassis/mcgreyscale
	name = "Morpheus Cyberkinetics (Custom)"
	limbs_id = "mcgipc"
	color_src = USE_ONE_COLOR
	default_color = DEFAULT_PRIMARY

/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics
	name = "Bishop Cyberkinetics"
	limbs_id = "bshipc"

/datum/sprite_accessory/ipc_chassis/bishopcyberkinetics2
	name = "Bishop Cyberkinetics 2.0"
	limbs_id = "bs2ipc"

/datum/sprite_accessory/ipc_chassis/hephaestussindustries
	name = "Hephaestus Industries"
	limbs_id = "hsiipc"

/datum/sprite_accessory/ipc_chassis/hephaestussindustries2
	name = "Hephaestus Industries 2.0"
	limbs_id = "hi2ipc"

/datum/sprite_accessory/ipc_chassis/pawsitronsunited
	name = "Pawsitrons United"
	limbs_id = "pawsitrons"

/datum/sprite_accessory/ipc_chassis/shellguardmunitions
	name = "Shellguard Munitions Standard Series"
	limbs_id = "sgmipc"

/datum/sprite_accessory/ipc_chassis/wardtakahashimanufacturing
	name = "Ward-Takahashi Manufacturing"
	limbs_id = "wtmipc"

/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup
	name = "Xion Manufacturing Group"
	limbs_id = "xmgipc"

/datum/sprite_accessory/ipc_chassis/xionmanufacturinggroup2
	name = "Xion Manufacturing Group 2.0"
	limbs_id = "xm2ipc"

/datum/sprite_accessory/ipc_chassis/zenghupharmaceuticals
	name = "Zeng-Hu Pharmaceuticals"
	limbs_id = "zhpipc"
