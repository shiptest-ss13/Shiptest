//hypovials used with the MkII hypospray.
/obj/item/reagent_containers/glass/bottle/vial
	name = "broken hypovial"
	desc = "A hypovial compatible with most hyposprays."
	icon = 'icons/obj/chemical/hypovial.dmi'
	icon_state = "hypovial"
	spillable = FALSE
	var/comes_with = list() //Easy way of doing this.
	volume = 10
	possible_transfer_amounts = list(1,2,5,10)
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"hypovial" = "hypovial",
		"red hypovial" = "hypovial-b",
		"blue hypovial" = "hypovial-d",
		"green hypovial" = "hypovial-a",
		"orange hypovial" = "hypovial-k",
		"purple hypovial" = "hypovial-p",
		"black hypovial" = "hypovial-t",
		"pink hypovial" = "hypovial-pink"
	)
	unique_reskin_changes_name = TRUE
	can_have_cap = FALSE
	cap_icon_state = null
	cap_on = FALSE

/obj/item/reagent_containers/glass/bottle/vial/Initialize()
	. = ..()
	if(!icon_state)
		icon_state = "hypovial"
	for(var/R in comes_with)
		reagents.add_reagent(R,comes_with[R])
	update_appearance()


/obj/item/reagent_containers/glass/bottle/vial/on_reagent_change()
	update_appearance()

/obj/item/reagent_containers/glass/bottle/vial/update_appearance()
	cut_overlays()
	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "hypovial10")

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 9)
				filling.icon_state = "hypovial10"
			if(10 to 29)
				filling.icon_state = "hypovial25"
			if(30 to 49)
				filling.icon_state = "hypovial50"
			if(50 to 85)
				filling.icon_state = "hypovial75"
			if(86 to INFINITY)
				filling.icon_state = "hypovial100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		add_overlay(filling)
	return ..()

/obj/item/reagent_containers/glass/bottle/vial/tiny
	name = "small hypovial"
	//Shouldn't be possible to get this without adminbuse

/obj/item/reagent_containers/glass/bottle/vial/small
	name = "hypovial"
	volume = 60
	possible_transfer_amounts = list(5,10)

/obj/item/reagent_containers/glass/bottle/vial/small/bluespace
	volume = 120
	possible_transfer_amounts = list(5,10)
	name = "bluespace hypovial"
	icon_state = "hypovialbs"
	unique_reskin = null

/obj/item/reagent_containers/glass/bottle/vial/large
	name = "large hypovial"
	desc = "A large hypovial, for deluxe hypospray models."
	icon_state = "hypoviallarge"
	volume = 120
	possible_transfer_amounts = list(5,10,15,20)
	unique_reskin = list(
		"large hypovial" = "hypoviallarge",
		"large red hypovial" = "hypoviallarge-b",
		"large blue hypovial" = "hypoviallarge-d",
		"large green hypovial" = "hypoviallarge-a",
		"large orange hypovial" = "hypoviallarge-k",
		"large purple hypovial" = "hypoviallarge-p",
		"large black hypovial" = "hypoviallarge-t"
	)
	unique_reskin_changes_name = TRUE

/obj/item/reagent_containers/glass/bottle/vial/large/update_appearance()
	cut_overlays()
	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('icons/obj/reagentfillings.dmi', "hypoviallarge10")

		var/percent = round((reagents.total_volume / volume) * 100)
		switch(percent)
			if(0 to 9)
				filling.icon_state = "hypoviallarge10"
			if(10 to 29)
				filling.icon_state = "hypoviallarge25"
			if(30 to 49)
				filling.icon_state = "hypoviallarge50"
			if(50 to 85)
				filling.icon_state = "hypoviallarge75"
			if(86 to INFINITY)
				filling.icon_state = "hypoviallarge100"

		filling.color = mix_color_from_reagents(reagents.reagent_list)
		add_overlay(filling)
	return ..()

/obj/item/reagent_containers/glass/bottle/vial/large/bluespace
	possible_transfer_amounts = list(5,10,15,20)
	name = "bluespace large hypovial"
	volume = 240
	icon_state = "hypoviallargebs"
	unique_reskin = null


/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/indomide
	name = "red hypovial (indomide)"
	icon_state = "hypovial-b"
	comes_with = list(/datum/reagent/medicine/indomide = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/pancrazine
	name = "green hypovial (pancrazine)"
	icon_state = "hypovial-a"
	comes_with = list(/datum/reagent/medicine/pancrazine = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/alvitane
	name = "orange hypovial (alvitane)"
	icon_state = "hypovial-k"
	comes_with = list(/datum/reagent/medicine/alvitane = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/dexalin
	name = "blue hypovial (dexalin)"
	icon_state = "hypovial-d"
	comes_with = list(/datum/reagent/medicine/dexalin = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/cureall
	name = "hypovial (cureall)"
	icon_state = "hypovial"
	comes_with = list(/datum/reagent/medicine/cureall = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/morphine
	name = "hypovial (morphine)"
	icon_state = "hypovial-pink"
	comes_with = list(/datum/reagent/medicine/morphine = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/atropine
	name = "hypovial (atropine)"
	icon_state = "hypovial-t"
	comes_with = list(/datum/reagent/medicine/atropine = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/erp //its not what it looks like i swear
	name = "hypovial (radiation purgant)"
	icon_state = "hypovial-k"
	comes_with = list(/datum/reagent/medicine/anti_rad = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/salclu
	name = "hypovial (SalGlu Solution)"
	icon_state = "hypovial"
	comes_with = list(/datum/reagent/medicine/salglu_solution = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/chitosan
	name = "hypovial (chitosan)"
	icon_state = "hypovial-b"
	amount_per_transfer_from_this = 5
	comes_with = list(/datum/reagent/medicine/chitosan = 60)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/combat_drug
	name = "hypovial (shoal juice)"
	icon_state = "hypovial-b"
	amount_per_transfer_from_this = 10
	comes_with = list(/datum/reagent/drug/combat_drug = 20, /datum/reagent/medicine/silfrine = 20, /datum/reagent/medicine/ysiltane = 20)

/obj/item/reagent_containers/glass/bottle/vial/small/preloaded/stasis
	name = "hypovial (stasis)"
	icon_state = "hypovial-b"
	amount_per_transfer_from_this = 5
	comes_with = list(/datum/reagent/medicine/stasis = 60)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/CMO
	name = "deluxe hypovial"
	icon_state = "hypoviallarge-cmos"
	comes_with = list(/datum/reagent/medicine/panacea = 40, /datum/reagent/medicine/leporazine = 40, /datum/reagent/medicine/atropine = 40)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/silfrine
	name = "large red hypovial (silfrine)"
	icon_state = "hypoviallarge-b"
	comes_with = list(/datum/reagent/medicine/silfrine = 120)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/gjalrazine
	name = "large green hypovial (gjalrazine)"
	icon_state = "hypoviallarge-a"
	comes_with = list(/datum/reagent/medicine/gjalrazine = 120)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/ysiltane
	name = "large orange hypovial (ysiltane)"
	icon_state = "hypoviallarge-k"
	comes_with = list(/datum/reagent/medicine/ysiltane = 120)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/salbutamol
	name = "large blue hypovial (salbutamol)"
	icon_state = "hypoviallarge-d"
	comes_with = list(/datum/reagent/medicine/salbutamol = 120)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/charcoal
	name = "large black hypovial (charcoal)"
	icon_state = "hypoviallarge-t"
	comes_with = list(/datum/reagent/medicine/charcoal = 120)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/cureall
	name = "large hypovial (cureall)"
	icon_state = "hypoviallarge"
	comes_with = list(/datum/reagent/medicine/cureall = 120)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/salglu
	name = "large green hypovial (salglu)"
	icon_state = "hypoviallarge-a"
	comes_with = list(/datum/reagent/medicine/salglu_solution = 120)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/synthflesh
	name = "large orange hypovial (synthflesh)"
	icon_state = "hypoviallarge-k"
	comes_with = list(/datum/reagent/medicine/synthflesh = 120)

/obj/item/reagent_containers/glass/bottle/vial/large/preloaded/combat
	name = "combat hypovial"
	icon_state = "hypoviallarge-t"
	comes_with = list(/datum/reagent/drug/combat_drug = 40, /datum/reagent/medicine/silfrine = 20, /datum/reagent/medicine/ysiltane = 20, /datum/reagent/medicine/synaptizine = 40)
