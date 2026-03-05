#define COLOR_CYBERSUN_OUTPOST_LIGHTING "#ffab56"

#define CYBERSUN_OUTPOST_TURF_HELPER(turf_type)			\
	/turf/open/floor/##turf_type/cybersun_outpost {		\
		initial_gas_mix = OPENTURF_DEFAULT_ATMOS;		\
		planetary_atmos = TRUE;							\
		light_color = COLOR_CYBERSUN_OUTPOST_LIGHTING;	\
		light_power = 1;								\
		light_range = 2;								\
	}

/turf/open/cybersun_outpost_exterior
	name = "gas giant"
	desc = "The gravitic bubble that protects 1000 Eyes Perch from the winds of Orucati's Rest has the side-effect of compressing down the gas giant's atmosphere into something <i>almost</i> walkable. If you're a moron with a death-wish."
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE
	icon = 'icons/turf/floors.dmi'
	color = COLOR_CYBERSUN_OUTPOST_LIGHTING
	icon_state = "reebemap"
	light_color = COLOR_CYBERSUN_OUTPOST_LIGHTING
	light_power = 0.4
	light_range = 2
	slowdown = 2

	plane = PLANE_SPACE
	layer = SPACE_LAYER
	light_power = 0.25
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED

	var/cleaning = FALSE

/turf/open/cybersun_outpost_exterior/Initialize(mapload, inherited_virtual_z)
	. = ..()
	RegisterSignals(src, list(COMSIG_ATOM_ENTERED), PROC_REF(object_enter))

/turf/open/cybersun_outpost_exterior/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_ATOM_ENTERED)

/turf/open/cybersun_outpost_exterior/proc/object_enter(datum/source, atom/movable/mover)
	if(HAS_TRAIT(src, TRAIT_CHASM_STOPPED))
		return FALSE
	if(cleaning)
		return FALSE
	if(mover.movement_type & (FLYING | FLOATING))
		return FALSE
	if(iseffect(mover) || isprojectile(mover))
		return FALSE
	if(isliving(mover))
		new /obj/effect/particle_effect/shield_blip(src)
		if(prob(10))
			var/mob/living/idiot = mover
			idiot.visible_message(span_warning("[idiot] loses their footing as the shield focuses around their steps!"), span_warning("The shield under you shifts and buckles!"))
			idiot.AdjustKnockdown(20)
			new /obj/effect/particle_effect/sparks/quantum(src)
	cleaning = TRUE
	addtimer(CALLBACK(src, PROC_REF(clean_tile)), 30 SECONDS)
	return TRUE

/turf/open/cybersun_outpost_exterior/proc/clean_tile()
	if(HAS_TRAIT(src, TRAIT_CHASM_STOPPED))
		return FALSE
	if(!length(contents))
		return FALSE
	new /obj/effect/particle_effect/sparks/quantum(src)
	//heavily truncated chasm fall for items. STOP THROWING YOUR GARBAGE IN. I SEE YOU. ALL THOUSAND EYES SEE YOU.
	for(var/obj/item/subway_trash in contents)
		subway_trash.visible_message(span_boldwarning("[subway_trash] falls into the gas giant below!"))
		animate(subway_trash, transform = matrix() - matrix(), alpha = 0, color = rgb(0, 0, 0), time = 10, pixel_y = subway_trash.pixel_y-10)
		QDEL_IN(subway_trash,10)
	for(var/mob/living/idiot in contents)
		idiot.visible_message(span_boldwarning("[idiot] loses their footing as the shield struggles to hold them!"), span_boldwarning("The shield under you buckles, get somewhere solid before you fall in!!"))
		idiot.AdjustKnockdown(40)
		idiot.Paralyze(20)
		new /obj/effect/particle_effect/shield_blip(loc)

/obj/effect/particle_effect/shield_blip
	name = "shield_blip"
	icon_state = "blip"
	anchored = TRUE
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.5
	light_color = LIGHT_COLOR_CYAN

/obj/effect/particle_effect/shield_blip/Initialize()
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/effect/particle_effect/shield_blip/LateInitialize()
	flick(icon_state, src)
	playsound(src, 'sound/effects/space_wind_big.ogg', 40, TRUE, SHORT_RANGE_SOUND_EXTRARANGE)
	QDEL_IN(src, 12)


/obj/structure/elevator_platform/tile/brushed
	icon = 'icons/turf/floors/tiles.dmi'
	icon_state = "kafel_full"
	base_icon_state = "kafel_full"
	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null

/obj/structure/elevator_platform/tile/bamboo_hatch
	icon = 'icons/turf/floors/suns.dmi'
	icon_state = "lighthatched"
	base_icon_state = "lighthatched"
	color = WOOD_COLOR_PALE2
	smoothing_flags = null
	smoothing_groups = null
	canSmoothWith = null

/obj/structure/fluff/power_conduit
	name = "High Voltage Conduit"
	desc = "Insulated conduit carrying high voltages of electricity. Ideal for transferring energy between areas."
	icon = 'icons/obj/power_cond/power_cond_heavy.dmi'
	icon_state = "node"
	deconstructible = FALSE
	density = FALSE
	plane = FLOOR_PLANE
	layer = 2.19

/obj/structure/fluff/power_conduit/over_floor
	name = "High Voltage Conduit"
	desc = "Insulated conduit carrying high voltages of electricity. Ideal for transferring energy between areas."
	icon = 'icons/obj/power_cond/power_cond_heavy.dmi'
	icon_state = "node"
	deconstructible = FALSE
	density = FALSE
	layer = 3

/obj/structure/fake_titanium_wall
	name = "wall"
	desc = "A light-weight titanium wall used in shuttles."
	icon = 'icons/turf/walls/shuttle_wall.dmi'
	icon_state = "shuttle_wall-0"
	base_icon_state = "shuttle_wall"
	explosion_block = 3
	density = TRUE
	opacity = TRUE
	anchored = TRUE
	layer = CLOSED_TURF_LAYER
	resistance_flags = INDESTRUCTIBLE
	flags_ricochet = RICOCHET_SHINY | RICOCHET_HARD
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_WALLS, SMOOTH_GROUP_TITANIUM_WALLS)
	canSmoothWith = list(SMOOTH_GROUP_TITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS)
	hitsound_type = PROJECTILE_HITSOUND_NON_LIVING

/area/outpost/crew/bar/cybersun_outpost
	name = "Her Eyes"
	lighting_colour_tube = "#634d36"
	lighting_colour_bulb = "#8f6c49"
	lighting_brightness_tube = 20
	lighting_brightness_bulb = 12

/area/outpost/exterior/csoutpost
	name = "Scaffolding"
	sound_environment = SOUND_ENVIRONMENT_UNDERWATER
	ambience_index = AMBIENCE_MAINT

CYBERSUN_OUTPOST_TURF_HELPER(plasteel/mono)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/mono/white)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/mono/dark)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/patterned/brushed)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/patterned/grid/dark)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/tech/techmaint)
CYBERSUN_OUTPOST_TURF_HELPER(suns/hatch/bamboo)
CYBERSUN_OUTPOST_TURF_HELPER(plasteel/tech)
CYBERSUN_OUTPOST_TURF_HELPER(hangar)
CYBERSUN_OUTPOST_TURF_HELPER(engine/hull/reinforced)

/turf/open/water/csoutpost //all the water is indoors so we can't use the helper
	name = "freshwater"
	desc = "Lovingly warm water likely circulated by unseen mechanisms."
	layer = TURF_LAYER
	baseturfs = /turf/open/water/csoutpost
	planetary_atmos = FALSE
	color = "#8ac7e6"
