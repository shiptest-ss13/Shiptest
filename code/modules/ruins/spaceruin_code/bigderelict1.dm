///////////	bigderelict1 items

/obj/item/paper/crumpled/ruins/bigderelict1/manifest
	default_raw_text = "<i>A crumpled piece of manifest paper, out of the barely legible pen writing, you can see something about a warning involving whatever was originally in the crate.</i>"

/obj/item/paper/crumpled/ruins/bigderelict1/coward
	icon_state = "scrap_bloodied"
	default_raw_text = "If anyone finds this, please, don't let my kids know I died a coward.."

/obj/item/disk/design_disk/ammo_1911
	name = "design disk - 1911 magazine"
	desc = "A design disk containing the pattern for the classic 1911's seven round .45ACP magazine."
	illustration = "ammo"

/obj/item/disk/design_disk/ammo_1911/Initialize()
	. = ..()
	var/datum/design/colt_1911_magazine/M = new
	blueprints[1] = M
