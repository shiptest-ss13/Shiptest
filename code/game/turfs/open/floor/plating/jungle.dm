/turf/open/floor/plating/dirt/jungle
	name = "mud"
	desc = "Upon closer examination, it's still dirt, just more wet than usual."
	slowdown = 0.5
	baseturfs = /turf/open/floor/plating/dirt/jungle
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	footstep = FOOTSTEP_MUD
	barefootstep = FOOTSTEP_MUD
	clawfootstep = FOOTSTEP_MUD

/turf/open/floor/plating/dirt/jungle/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/lit
	light_range = 2
	light_power = 1
	light_color = COLOR_VERY_LIGHT_GRAY

/turf/open/floor/plating/dirt/jungle/dark
	icon_state = "greenerdirt"
	baseturfs = /turf/open/floor/plating/dirt/jungle/dark

/turf/open/floor/plating/dirt/jungle/dark/lit
	light_range = 2
	light_power = 1

/turf/open/floor/plating/dirt/jungle/wasteland //Like a more fun version of living in Arizona.
	name = "cracked earth"
	desc = "Looks a bit dry."
	icon = 'icons/turf/planetary/jungle.dmi'
	icon_state = "wasteland"
	slowdown = 1
	baseturfs = /turf/open/floor/plating/dirt/jungle/wasteland
	var/floor_variance = 15

/turf/open/floor/plating/dirt/jungle/wasteland/lit
	baseturfs = /turf/open/floor/plating/dirt/jungle/wasteland/lit
	light_range = 2
	light_power = 1


/turf/open/floor/plating/dirt/jungle/wasteland/Initialize(mapload, inherited_virtual_z)
	.=..()
	if(prob(floor_variance))
		icon_state = "[initial(icon_state)][rand(0,12)]"

/turf/open/floor/plating/asteroid/dirt
	gender = PLURAL
	name = "dirt"
	desc = "It's quite dirty."
	icon = 'icons/turf/floors.dmi'
	base_icon_state = "dirt"
	icon_state = "dirt"
	planetary_atmos = FALSE
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/dirt
	floor_variance = 0
	var/update_lighting_on_init = TRUE
	var/has_grass = FALSE

/turf/open/floor/plating/asteroid/dirt/examine(mob/user)
	. = ..()
	if(has_grass)
		return
	if(ismob(user, /datum/species/pod))
		. += "<span class='notice'>While this plot of land is now farmable and fertile, theres nothing growing on it. Perhaps you could add <i>grass?</i></span>"

/turf/open/floor/plating/asteroid/dirt/Initialize(mapload, inherited_virtual_z)
	. = ..()
	if(smoothing_flags)
		var/matrix/translation = new
		translation.Translate(-9, -9)
		transform = translation
	if(!update_lighting_on_init)
		return
	var/area/selected_area = get_area(src)
	if(istype(selected_area, /area/overmap_encounter) && !istype(selected_area, /area/overmap_encounter/planetoid/cave)) //cheap trick, but i dont want to automate this shit
		light_range = 2
		light_power = 0.80
		update_light()

/turf/open/floor/plating/asteroid/dirt/attackby(obj/item/item_attacked_by, mob/user, params)
	. = ..()
	if(has_grass)
		return
	if(!istype(item_attacked_by, /obj/item/reagent_containers/food/snacks/grown/grass))
		return FALSE
	var/grass_to_plant = /turf/open/floor/plating/asteroid/dirt/grass

	if(istype(item_attacked_by, /obj/item/reagent_containers/food/snacks/grown/grass/fairy))
		grass_to_plant = /turf/open/floor/plating/asteroid/dirt/grass/fairy

	visible_message("<span class='notice'>You plant the [item_attacked_by], and the dirt accepts it. It should be breathable now.</span>")
	qdel(item_attacked_by)
	ChangeTurf(grass_to_plant, flags = CHANGETURF_IGNORE_AIR)


/turf/open/floor/plating/asteroid/dirt/getDug()
	. = ..()
	ScrapeAway()

/turf/open/floor/plating/asteroid/dirt/burn_tile()
	ScrapeAway()
	return TRUE

/turf/open/floor/plating/asteroid/dirt/ex_act(severity, target)
	. = ..()
	ScrapeAway()

/turf/open/floor/plating/asteroid/dirt/grass
	name = "grass"
	desc = "A patch of grass."
	icon_state = "grass0"
	base_icon_state = "grass"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_GRASS)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_GRASS)
	layer = HIGH_TURF_LAYER
	icon = 'icons/turf/floors/grass.dmi'
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/dirt
	floor_variance = 100
	max_icon_states = 3
	tiled_dirt = FALSE
	update_lighting_on_init = TRUE
	has_grass = TRUE

/turf/open/floor/plating/asteroid/dirt/grass/fairy
	light_range = 2
	light_power = 0.80
	light_color = COLOR_BLUE_LIGHT
	update_lighting_on_init = FALSE

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/basin
	name = "dried basin"
	desc = "Dried up basin."
	icon_state = "dried_up"
	icon_plating = "dried_up"
	base_icon_state = "dried_up"
	digResult = /obj/item/stack/ore/glass/basalt
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface/basin
	var/update_lighting_on_init = TRUE
	var/current_water = 0 //yeah

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/basin/examine(mob/user)
	. = ..()
	if(ismob(user, /datum/species/pod))
		. += "<span class='notice'>It could hold water, maybe 50 units per meter could do the trick. Currently, it has <i>[current_water]</i> units.</span>"

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/basin/Initialize(mapload, inherited_virtual_z) //inheritance moment
	. = ..()
	if(!update_lighting_on_init)
		return
	var/area/selected_area = get_area(src)
	if(istype(selected_area, /area/overmap_encounter) && !istype(selected_area, /area/overmap_encounter/planetoid/cave)) //cheap trick, but i dont want to automate this shit
		light_range = 2
		light_power = 0.80
		update_light()

/turf/open/floor/plating/asteroid/whitesands/dried
	var/current_water = 0 //yeah

/turf/open/floor/plating/asteroid/whitesands/dried/examine(mob/user)
	. = ..()
	if(ismob(user, /datum/species/pod))
		. += "<span class='notice'>It could hold water, maybe 50 units per meter could do the trick. Currently, it has <i>[current_water]</i> units.</span>"

/turf/open/floor/plating/asteroid/sand/terraform
	light_color = LIGHT_COLOR_TUNGSTEN
	var/update_lighting_on_init = TRUE

/turf/open/floor/plating/asteroid/sand/terraform/Initialize(mapload, inherited_virtual_z) //inheritance moment
	. = ..()
	if(!update_lighting_on_init)
		return
	var/area/selected_area = get_area(src)
	if(istype(selected_area, /area/overmap_encounter) && !istype(selected_area, /area/overmap_encounter/planetoid/cave)) //cheap trick, but i dont want to automate this shit
		light_range = 2
		light_power = 0.80
		update_light()

/turf/closed/mineral/random/volcanic/terraformed
	turf_type = /turf/open/floor/plating/asteroid/dirt
	baseturfs = /turf/open/floor/plating/asteroid/dirt

/datum/reagent/water/expose_turf(turf/exposed_turf, reac_volume)
	if(!isopenturf(exposed_turf))
		return ..()
	var/turf/open/floor/plating/asteroid/basalt/lava_land_surface/basin/terraform_target = exposed_turf

	if(istype(terraform_target,  /turf/open/floor/plating/asteroid/basalt/lava_land_surface/basin) || istype(terraform_target, /turf/open/floor/plating/asteroid/whitesands/dried)) //if basin, replace with water
		terraform_target.current_water += reac_volume
		if(terraform_target.current_water >= 50)
			terraform_target.ChangeTurf(/turf/open/water/beach, flags = CHANGETURF_INHERIT_AIR)
			terraform_target.visible_message("<span class='notice'>The [terraform_target.name] fills up with water!</span>")
			return ..()
		else
			terraform_target.visible_message("<span class='notice'>The [terraform_target.name] is filled up with [terraform_target.current_water] units of water.</span>")
			return ..()

/datum/reagent/water/expose_obj(obj/exposed_object, reac_volume)
	. = ..()
	if(istype(exposed_object, /obj/structure/flora/rock/lava) || istype(exposed_object, /obj/structure/flora/rock/pile/lava))
		exposed_object.icon = 'icons/obj/flora/rocks.dmi'
		exposed_object.visible_message("<span class='notice'>[src]cools down.</span>")

/obj/structure/flora/rock/lava/examine(mob/user)
	. = ..()
	if(ismob(user, /datum/species/pod))
		. += "<span class='notice'>If I pour some <i>water</i> onto it, maybe it can cool down?</span>"


/obj/structure/flora/rock/pile/lava/examine(mob/user)
	. = ..()
	if(ismob(user, /datum/species/pod))
		. += "<span class='notice'>If I pour some <i>water</i> onto it, maybe it can cool down?</span>"
