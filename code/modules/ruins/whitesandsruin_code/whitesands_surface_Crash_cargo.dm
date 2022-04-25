
/obj/item/disk/design_disk/disposable_gun
	name = "design disk - disposable gun"
	desc = "A design disk containing designs for a cheap and disposable gun."
	illustration = "gun"

/obj/item/disk/design_disk/disposable_gun/Initialize()
	. = ..()
	var/datum/design/disposable_gun/G = new
	var/datum/design/pizza_disposable_gun/P = new
	blueprints[1] = G
	blueprints[2] = P
