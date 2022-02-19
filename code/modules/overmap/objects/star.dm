/datum/overmap/star //TODO: refactor literally all of this this is painful
	name = "Star"
	token_icon_state = "star1"
	token_type = /obj/overmap/star

/datum/overmap/star/Initialize(mapload)
	. = ..()
	Rename("[pick(GLOB.star_names)] [pick(GLOB.greek_letters)]")

/datum/overmap/star/medium
	token_icon_state = "star2"
	token_type = /obj/overmap/star/medium

/datum/overmap/star/big
	token_icon_state = "star3"
	token_type = /obj/overmap/star/big

/datum/overmap/star/binary
	token_icon_state = "binaryswoosh"
	token_type = /obj/overmap/star/big/binary

/obj/overmap/star
	name = "Star"
	desc = "A star."
	icon = 'whitesands/icons/effects/overmap.dmi'
	icon_state = "star1"
	var/star_classes = list(\
		STARK,
		STARM,
		STARL,
		START,
		STARY,
		STARD
	)

/obj/overmap/star/Initialize(mapload, new_parent)
	. = ..()
	var/c = "#ffffff"
	switch(pick(star_classes))
		if(STARO)
			c = "#75ffff"
			desc = "A blue giant."
		if(STARB)
			c = "#c0ffff"
		if(STARG)
			c = "#ffff00"
		if(STARK)
			c = "#ff7f00"
		if(STARM)
			c = "#d50000"
		if(STARL) //Take the L
			c = "#a31300"
		if(START)
			c = "#a60347"
			desc = "A brown dwarf"
		if(STARY)
			c = "#4a3059"
			desc = "A brown dwarf."
		if(STARD)
			c = pick("#75ffff", "#c0ffff", "#ffffff")
			desc = "A white dwarf."
	add_atom_colour(c, FIXED_COLOUR_PRIORITY)

/obj/overmap/star/medium
	icon = 'whitesands/icons/effects/overmap_large.dmi'
	bound_height = 64
	bound_width = 64
	pixel_x = -16
	pixel_y = -16
	icon_state = "star2"
	star_classes = list(\
		STARB,
		STARA,
		STARF,
		STARG,
		STARK
	)

/obj/overmap/star/big
	icon = 'whitesands/icons/effects/overmap_larger.dmi'
	icon_state = "star3"
	bound_height = 96
	bound_width = 96
	pixel_z = -32
	pixel_w = -32
	star_classes = list(\
		STARO,
		STARB,
		STARG,
		STARM
	)

/obj/overmap/star/big/binary
	icon_state = "binaryswoosh"
	var/class
	star_classes = list(\
		STARK,
		STARM,
		STARL,
		START,
		STARY,
		STARD
	)

/obj/overmap/star/big/binary/Initialize(mapload)
	. = ..()
	name = "[pick(GLOB.greek_letters)] [pick(GLOB.star_names)] AB"
	class = pick(star_classes)
	color = "#ffffff"
	add_star_overlay()

/obj/overmap/star/big/binary/proc/add_star_overlay()
	cut_overlays()
	var/mutable_appearance/s1 = mutable_appearance(icon_state = "binary1")
	var/mutable_appearance/s2 = mutable_appearance(icon_state = "binary2")
	switch(class)
		if(STARK)
			s1.color = "#ff7f00"
			s2.color = "#ffff00"
		if(STARM)
			s1.color = "#d50000"
			s2.color = "#a31300"
		if(STARL)
			s1.color = "#a31300"
			s2.color = "#ff7f00"
		if(START)
			s1.color = "#a60347"
			s2.color = pick("#75ffff", "#c0ffff", "#ffffff")
		if(STARY)
			s1.color = "#4a3059"
			s2.color = pick("#75ffff", "#c0ffff", "#ffffff")
		if(STARD)
			s1.color = pick("#75ffff", "#c0ffff", "#ffffff")
			s2.color = pick("#4a3059", "#a60347", "#a31300")
	add_overlay(s1)
	add_overlay(s2)
