/obj/structure/cabinet/fireaxe
	name = "\improper fire axe cabinet"
	desc = "There is a small label that reads \"For Emergency use only\" along with details for safe use of the axe. As if."
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "fireaxe"
	stored_sprite = "axe"
	allowed_type = /obj/item/melee/axe/fire
	req_one_access_txt = "24"

/obj/structure/cabinet/oneshot
	name = "\improper rocket launcher cabinet"
	desc = "There is a small label that reads \"For Emergency use only\" along with a small drawing of how to operate the launcher."
	icon_state = "rpg"
	stored_sprite = "launcher"
	allowed_type = /obj/item/gun/ballistic/rocketlauncher/oneshot
	req_one_access_txt = "3"

/obj/structure/cabinet/scout
	name = "\improper rifle display"
	desc = "A wooden board used to proudly display your favourite rifles. This one is made specifically to fit an HP Scout."
	icon_state = "scoutcase"
	stored_sprite = "scout"
	allowed_type = /obj/item/gun/ballistic/rifle/scout
	locked = TRUE
	open = TRUE
