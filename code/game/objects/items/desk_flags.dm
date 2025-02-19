/obj/item/desk_flag
	name = "blank desk flag"
	desc = "Show your patriotism with desk flags!"
	icon = 'icons/obj/deskflags.dmi'
	icon_state = "flag"
	force = 3
	throwforce = 2
	throw_speed = 3
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("waved", "patriotized")

/obj/item/desk_flag/Initialize()
	. = ..()
	if(prob(3))
		name = "vampire flag"
		desc = "The blue, cyan, and white flag of the transylvanian society of vampires."
		icon_state = "trans"

/obj/item/desk_flag/solgov
	name = "solgov desk flag"
	desc = "The blue and gold flag of the Sol Government."
	icon_state = "solgov"

/obj/item/desk_flag/trans
	name = "vampire desk flag"
	desc = "The blue, cyan, and white flag of the transylvanian society of vampires."
	icon_state = "trans"

/obj/item/desk_flag/gezena
	name = "gezenan desk flag"
	desc = "A small banner on a pole depicting the sigil of the Pan-Gezenan Federation."
	icon_state = "gezena"

/obj/item/desk_flag/suns
	name = "SUNS desk flag"
	desc = "A little desk decoration in the gold and purple color palette of SUNS."
	icon_state = "suns"

/obj/item/desk_flag/ngr
	name = "new gorlexian desk flag"
	desc = "The crimson, black, and tan flag of the New Gorlex Republic."
	icon_state = "ngr"
