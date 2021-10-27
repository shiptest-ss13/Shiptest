//WS begin: spritercode
/obj/item/toy/plush/hornet
	name = "strange bug plushie"
	desc = "A cute, soft plush of a long-horned bug."
	icon = 'whitesands/icons/obj/plushes.dmi'
	icon_state = "plushie_hornet"
	attack_verb = list("poked", "shaws")
	squeak_override = list('whitesands/sound/hornetnoises/hornet_gitgud.ogg'=1, 'whitesands/sound/hornetnoises/hornet_SHAW.ogg'=10) //i have no clue how this works, the intended effect is that "git gud" will play 1 out of 11 times
	gender = FEMALE

/obj/item/toy/plush/hornet/gay
	name = "gay bug plushie"
	desc = "A cute, soft plush of a long-horned bug. Her cloak is in the colors of the lesbian pride flag."
	icon_state = "plushie_gayhornet"

/obj/item/toy/plush/knight
	name = "odd bug plushie"
	desc = "A cute, soft plush of a little bug. It sounds like this one didn't come with a voice box."
	icon = 'whitesands/icons/obj/plushes.dmi'
	icon_state = "plushie_knight"
	attack_verb = list("poked")
	should_squeak = FALSE
//WS end

/obj/item/toy/plush/among //Shiptest begin, with our debut plushy
	name = "amoung pequeño"
	desc = "A little pill shaped guy, with a price tag of 3€."
	icon = 'whitesands/icons/obj/plushes.dmi'
	icon_state = "plushie_among"
	attack_verb = list("killed","stabbed","shot","slapped","stung", "ejected")
	squeak_override = list('whitesands/sound/hornetnoises/agoguskill.ogg')
	var/random_among = TRUE //if the (among) uses random coloring
	var/rare_among = 1 //chance for rare color variant


	var/static/list/among_colors = list(\
		"red" = "#c51111",
		"blue" = "#123ed1",
		"green" = "#117f2d",
		"pink" = "#ed54ba",
		"orange" = "#ef7d0d",
		"yellow" = "#f5f557",
		"black" = "#3f474e",
		"white" = "#d6e0f0",
		"purple" = "#6b2fbb",
		"brown" = "#71491e",
		"cyan" = "#39FEDD",
		"lime" = "#4EEF38",
	)
	var/static/list/among_colors_rare = list(\
		"puce" = "#CC8899",
	)

/obj/item/toy/plush/among/Initialize(mapload)
	. = ..()
	among_randomify(rare_among)

/obj/item/toy/plush/among/proc/among_randomify(rare_among)
	if(random_among)
		var/among_color
		if(prob(rare_among))
			among_color = pick(among_colors_rare)
			add_atom_colour(among_colors_rare[among_color], FIXED_COLOUR_PRIORITY)
		else
			among_color = pick(among_colors)
			add_atom_colour(among_colors[among_color], FIXED_COLOUR_PRIORITY)
		add_among_overlay()

/obj/item/toy/plush/among/proc/add_among_overlay()
	if(!random_among)
		return
	cut_overlays()
	var/mutable_appearance/base_overlay_among = mutable_appearance(icon, "plushie_among_visor")
	base_overlay_among.appearance_flags = RESET_COLOR
	add_overlay(base_overlay_among)
