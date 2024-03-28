/obj/effect/ambience //these will basically never get used because we don't have the sound channels for it. i'm adding them just in case we ever do.
	name = "ambient sound"
	icon = 'icons/effects/mapping_helpers.dmi'
	icon_state = "ambient"
	invisibility = INVISIBILITY_ABSTRACT
	ambience = null

/obj/effect/ambience/hum
	name = "ambient hum"
	ambience = AMBIENCE_HUM
