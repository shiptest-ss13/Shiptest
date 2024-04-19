// Base type - DO NOT USE!
/obj/structure/chair/comfy
	name = "comfy chair"
	desc = "It looks comfy."
	icon_state = null
	icon = 'icons/obj/structures/chairs/comfychair.dmi'
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstackamount = 2
	item_chair = null

	///Armrest sprite to overlay over mobs
	var/mutable_appearance/armrest

/obj/structure/chair/comfy/Initialize()
	armrest = get_armrest()
	armrest.layer = ABOVE_MOB_LAYER
	return ..()

/obj/structure/chair/comfy/proc/get_armrest()
	return mutable_appearance(icon, "overlay_[icon_state]")

/obj/structure/chair/comfy/Destroy()
	QDEL_NULL(armrest)
	return ..()

/obj/structure/chair/comfy/post_buckle_mob(mob/living/M)
	. = ..()
	update_armrest()

/obj/structure/chair/comfy/proc/update_armrest()
	if(has_buckled_mobs())
		add_overlay(armrest)
	else
		cut_overlay(armrest)

/obj/structure/chair/comfy/post_unbuckle_mob()
	. = ..()
	update_armrest()

// Update this along with brass chair
/obj/structure/chair/comfy/shuttle
	name = "shuttle seat"
	desc = "A comfortable, secure seat. It has a more sturdy looking buckling system, for smoother flights."
	icon_state = "shuttle_chair"
	icon = 'icons/obj/chairs.dmi'
	buildstacktype = /obj/item/stack/sheet/mineral/titanium

/obj/structure/chair/comfy/shuttle/get_armrest()
	return mutable_appearance('icons/obj/chairs.dmi', "shuttle_chair_armrest")

/obj/structure/chair/comfy/shuttle/bronze
	name = "brass chair"
	desc = "A spinny chair made of bronze. It has little cogs for wheels!"
	anchored = FALSE
	icon_state = "brass_chair"
	buildstacktype = /obj/item/stack/tile/bronze
	buildstackamount = 1
	item_chair = null
	var/turns = 0

/obj/structure/chair/comfy/shuttle/bronze/get_armrest()
	return mutable_appearance('icons/obj/chairs.dmi', "brass_chair_armrest")

/obj/structure/chair/comfy/shuttle/bronze/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	. = ..()

/obj/structure/chair/comfy/shuttle/bronze/process()
	setDir(turn(dir,-90))
	playsound(src, 'sound/effects/servostep.ogg', 50, FALSE)
	turns++
	if(turns >= 8)
		STOP_PROCESSING(SSfastprocess, src)

/obj/structure/chair/comfy/shuttle/bronze/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/machines/clockcult/integration_cog_install.ogg', 50, TRUE)

/obj/structure/chair/comfy/shuttle/bronze/AltClick(mob/living/user)
	turns = 0
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(!(datum_flags & DF_ISPROCESSING))
		user.visible_message("<span class='notice'>[user] spins [src] around, and the last vestiges of Ratvarian technology keeps it spinning FOREVER.</span>", \
		"<span class='notice'>Automated spinny chairs. The pinnacle of ancient Ratvarian technology.</span>")
		START_PROCESSING(SSfastprocess, src)
	else
		user.visible_message("<span class='notice'>[user] stops [src]'s uncontrollable spinning.</span>", \
		"<span class='notice'>You grab [src] and stop its wild spinning.</span>")
		STOP_PROCESSING(SSfastprocess, src)

// Purple
/obj/structure/chair/comfy/purple
	icon_state = "imaginos_purple"

/obj/structure/chair/comfy/purple/old
	icon_state = "old_purple"

/obj/structure/chair/comfy/purple/old/alt
	icon_state = "old_purple_alt"

/obj/structure/chair/comfy/purple/corpo
	icon_state = "corp_purple"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/purple, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/purple/old, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/purple/old/alt, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/purple/corpo, 0)

// Beige
/obj/structure/chair/comfy/beige
	icon_state = "imaginos_beige"

/obj/structure/chair/comfy/beige/old
	icon_state = "old_beige"

/obj/structure/chair/comfy/beige/old/alt
	icon_state = "old_beige_alt"

/obj/structure/chair/comfy/beige/corpo
	icon_state = "corp_beige"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/beige, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/beige/old, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/beige/old/alt, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/beige/corpo, 0)

// Grey
/obj/structure/chair/comfy/grey
	icon_state = "imaginos_grey"

/obj/structure/chair/comfy/grey/old
	icon_state = "old_grey"

/obj/structure/chair/comfy/grey/old/alt
	icon_state = "old_grey_alt"

/obj/structure/chair/comfy/grey/corpo
	icon_state = "corp_grey"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/grey, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/grey/old, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/grey/old/alt, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/grey/corpo, 0)

// Orange

/obj/structure/chair/comfy/orange
	icon_state = "imaginos_orange"

/obj/structure/chair/comfy/orange/old
	icon_state = "old_orange"

/obj/structure/chair/comfy/orange/old/alt
	icon_state = "old_orange_alt"

/obj/structure/chair/comfy/orange/corpo
	icon_state = "corp_orange"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/orange, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/orange/old, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/orange/old/alt, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/orange/corpo, 0)

// Blue

/obj/structure/chair/comfy/blue
	icon_state = "imaginos_blue"

/obj/structure/chair/comfy/blue/old
	icon_state = "old_blue"

/obj/structure/chair/comfy/blue/old/alt
	icon_state = "old_blue_alt"

/obj/structure/chair/comfy/blue/corpo
	icon_state = "corp_blue"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/blue, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/blue/old, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/blue/old/alt, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/blue/corpo, 0)

// Red

/obj/structure/chair/comfy/red
	icon_state = "imaginos_red"

/obj/structure/chair/comfy/red/old
	icon_state = "old_red"

/obj/structure/chair/comfy/red/old/alt
	icon_state = "old_red_alt"

/obj/structure/chair/comfy/red/corpo
	icon_state = "corp_red"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/red, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/red/old, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/red/old/alt, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/red/corpo, 0)

// Olive

/obj/structure/chair/comfy/olive
	icon_state = "imaginos_olive"

/obj/structure/chair/comfy/olive/old
	icon_state = "old_olive"

/obj/structure/chair/comfy/olive/old/alt
	icon_state = "old_olive_alt"

/obj/structure/chair/comfy/olive/corpo
	icon_state = "corp_olive"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/olive, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/olive/old, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/olive/old/alt, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/comfy/olive/corpo, 0)

// Benches - No armrests

// Base type - DO NOT USE!
/obj/structure/chair/bench
	name = "comfy bench"
	desc = "It looks comfy."
	icon_state = null
	icon = 'icons/obj/structures/chairs/comfychair.dmi'
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstackamount = 2
	item_chair = null

/obj/structure/chair/bench/purple
	icon_state = "bench_purple"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/bench/purple, 0)

/obj/structure/chair/bench/beige
	icon_state = "bench_beige"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/bench/beige, 0)

/obj/structure/chair/bench/grey
	icon_state = "bench_grey"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/bench/grey, 0)

/obj/structure/chair/bench/orange
	icon_state = "bench_orange"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/bench/orange, 0)

/obj/structure/chair/bench/blue
	icon_state = "bench_blue"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/bench/blue, 0)

/obj/structure/chair/bench/red
	icon_state = "bench_red"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/bench/red, 0)

/obj/structure/chair/bench/olive
	icon_state = "bench_olive"

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/chair/bench/olive, 0)
