/obj/item/desk_flag
	name = "flag"
	desc = "Show your patriotism with WaffleCo. brand desk flags!"
	icon = 'whitesands/icons/obj/flags.dmi'
	icon_state = "flag"
	force = 3
	throwforce = 2
	throw_speed = 3
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("waved", "patriotized")

/obj/item/desk_flag/Initialize()
	. = ..()
	if(prob(5))
		name = "vampire flag"
		desc = "The blue, cyan, and white flag of the transylvanian society of vampires."
		icon_state = "trans"

/obj/item/desk_flag/solgov
	name = "solgov flag"
	desc = "The blue and gold flag of the Sol Government."
	icon_state = "solgov"

/obj/item/desk_flag/trans
	name = "vampire flag"
	desc = "The blue, cyan, and white flag of the transylvanian society of vampires."
	icon_state = "trans"
