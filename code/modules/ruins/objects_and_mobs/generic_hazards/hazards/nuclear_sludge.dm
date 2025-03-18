/obj/structure/hazard/slowdown/nuclear_sludge
	name = "radioactive sludge" //not actually radioactive, its more a setpiece than anything tbh
	desc = "A thick layer of nuclear waste that has leaked onto the floor and become a thick sludge, clinging to the bottom of your footwear every step."
	icon = 'icons/effects/effects.dmi'
	icon_state = "greenglow"
	density = FALSE
	//sticky like spiderwebs, very annoying.
	var/sticky = true
	//chance you get stuck instead of walking into the hazard
	var/stick_chance = 50
	slowdown = 2
