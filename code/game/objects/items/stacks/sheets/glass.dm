/* Glass stack types
 * Contains:
 *		Glass sheets
 *		Reinforced glass sheets
 *		Glass shards - TODO: Move this into code/game/object/item/weapons
 */

/*
 * Glass sheets
 */
GLOBAL_LIST_INIT(glass_recipes, list ( \
	new/datum/stack_recipe("directional window", /obj/structure/window/unanchored, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("fulltile window", /obj/structure/window/fulltile/unanchored, 2, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("glass floor tile", /obj/item/stack/tile/glass, 1, 4, 20), \
	new/datum/stack_recipe("glass shard", /obj/item/shard, 1) \
))

/obj/item/stack/sheet/glass
	name = "glass"
	desc = "HOLY SHEET! That is a lot of glass."
	singular_name = "glass sheet"
	icon_state = "sheet-glass"
	item_state = "sheet-glass"
	custom_materials = list(/datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 100)
	resistance_flags = ACID_PROOF
	merge_type = /obj/item/stack/sheet/glass
	grind_results = list(/datum/reagent/silicon = 20)
	material_type = /datum/material/glass
	point_value = 1
	tableVariant = /obj/structure/table/glass

/obj/item/stack/sheet/glass/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 500

/obj/item/stack/sheet/glass/two
	amount = 2

/obj/item/stack/sheet/glass/five
	amount = 5

/obj/item/stack/sheet/glass/twenty
	amount = 20

/obj/item/stack/sheet/glass/fifty
	amount = 50

/obj/item/stack/sheet/glass/get_main_recipes()
	. = ..()
	. += GLOB.glass_recipes

/obj/item/stack/sheet/glass/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	if(istype(W, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/CC = W
		if (get_amount() < 1 || CC.get_amount() < 5)
			to_chat(user, "<span class='warning>You need five lengths of coil and one sheet of glass to make wired glass!</span>")
			return
		CC.use(5)
		use(1)
		to_chat(user, span_notice("You attach wire to the [name]."))
		var/obj/item/stack/light_w/new_tile = new(user.loc)
		new_tile.add_fingerprint(user)
	else if(istype(W, /obj/item/stack/rods))
		var/obj/item/stack/rods/V = W
		if (V.get_amount() >= 1 && get_amount() >= 1)
			var/obj/item/stack/sheet/rglass/reinforced = new(get_turf(user)) || locate(/obj/item/stack/sheet/rglass) in get_turf(user) // Get the stack it's merged into if it is
			reinforced.add_fingerprint(user)
			var/replace = user.get_inactive_held_item()==src
			V.use(1)
			use(1)
			if(QDELETED(src) && replace)
				user.put_in_hands(reinforced)
		else
			to_chat(user, span_warning("You need one rod and one sheet of glass to make reinforced glass!"))
			return
	else
		return ..()



GLOBAL_LIST_INIT(pglass_recipes, list ( \
	new/datum/stack_recipe("directional window", /obj/structure/window/plasma/unanchored, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("fulltile window", /obj/structure/window/plasma/fulltile/unanchored, 2, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("plasma glass shard", /obj/item/shard/plasma, 1) \
))

/obj/item/stack/sheet/plasmaglass
	name = "plasma glass"
	desc = "A glass sheet made out of a plasma-silicate alloy. It looks extremely tough and heavily fire resistant."
	singular_name = "plasma glass sheet"
	icon_state = "sheet-pglass"
	item_state = "sheet-pglass"
	custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 100)
	resistance_flags = ACID_PROOF
	merge_type = /obj/item/stack/sheet/plasmaglass
	grind_results = list(/datum/reagent/silicon = 20, /datum/reagent/toxin/plasma = 10)
	material_flags = MATERIAL_NO_EFFECTS

/obj/item/stack/sheet/plasmaglass/five
	amount = 5

/obj/item/stack/sheet/plasmaglass/twenty
	amount = 20

/obj/item/stack/sheet/plasmaglass/fifty
	amount = 50

/obj/item/stack/sheet/plasmaglass/get_main_recipes()
	. = ..()
	. += GLOB.pglass_recipes

/obj/item/stack/sheet/plasmaglass/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)

	if(istype(W, /obj/item/stack/rods))
		var/obj/item/stack/rods/V = W
		if (V.get_amount() >= 1 && get_amount() >= 1)
			var/obj/item/stack/sheet/plasmarglass/reinforced = new(get_turf(user)) || locate(/obj/item/stack/sheet/plasmarglass) in get_turf(user) // Get the stack it's merged into if it is
			reinforced.add_fingerprint(user)
			var/replace = user.get_inactive_held_item() == src
			V.use(1)
			use(1)
			if(QDELETED(src) && replace)
				user.put_in_hands(reinforced)
		else
			to_chat(user, span_warning("You need one rod and one sheet of plasma glass to make reinforced plasma glass!"))
			return
	else
		return ..()



/*
 * Reinforced glass sheets
 */
GLOBAL_LIST_INIT(reinforced_glass_recipes, list ( \
	new/datum/stack_recipe("windoor frame", /obj/structure/windoor_assembly, 5, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("window firelock frame", /obj/structure/firelock_frame/window, 3, time = 50, one_per_turf = TRUE, on_floor = TRUE),
	null, \
	new/datum/stack_recipe("directional reinforced window", /obj/structure/window/reinforced/unanchored, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("fulltile reinforced window", /obj/structure/window/reinforced/fulltile/unanchored, 2, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("reinforced glass tile", /obj/item/stack/tile/glass/reinforced, 1, 4, 20), \
	new/datum/stack_recipe("glass shard", /obj/item/shard, 1) \
))


/obj/item/stack/sheet/rglass
	name = "reinforced glass"
	desc = "Glass which seems to have rods or something stuck in them."
	singular_name = "reinforced glass sheet"
	icon_state = "sheet-rglass"
	item_state = "sheet-rglass"
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 100)
	resistance_flags = ACID_PROOF
	merge_type = /obj/item/stack/sheet/rglass
	grind_results = list(/datum/reagent/silicon = 20, /datum/reagent/iron = 10)
	point_value = 4

/obj/item/stack/sheet/rglass/attackby(obj/item/W, mob/user, params)
	add_fingerprint(user)
	..()

/obj/item/stack/sheet/rglass/cyborg
	custom_materials = null
	var/datum/robot_energy_storage/glasource
	var/metcost = 250
	var/glacost = 500

/obj/item/stack/sheet/rglass/cyborg/get_amount()
	return min(round(source.energy / metcost), round(glasource.energy / glacost))

/obj/item/stack/sheet/rglass/cyborg/use(used, transfer = FALSE, check = TRUE) // Requires special checks, because it uses two storages
	if(get_amount(used)) //ensure we still have enough energy if called in a do_after chain
		source.use_charge(used * metcost)
		glasource.use_charge(used * glacost)
		return TRUE

/obj/item/stack/sheet/rglass/cyborg/add(amount)
	source.add_charge(amount * metcost)
	glasource.add_charge(amount * glacost)

/obj/item/stack/sheet/rglass/get_main_recipes()
	. = ..()
	. += GLOB.reinforced_glass_recipes

GLOBAL_LIST_INIT(prglass_recipes, list ( \
	new/datum/stack_recipe("directional reinforced window", /obj/structure/window/plasma/reinforced/unanchored, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("fulltile reinforced window", /obj/structure/window/plasma/reinforced/fulltile/unanchored, 2, time = 0, on_floor = TRUE, window_checks = TRUE), \
	new/datum/stack_recipe("plasma glass shard", /obj/item/shard/plasma, 1) \
))

/obj/item/stack/sheet/plasmarglass
	name = "reinforced plasma glass"
	desc = "A glass sheet made out of a plasma-silicate alloy and a rod matrix. It looks hopelessly tough and nearly fire-proof!"
	singular_name = "reinforced plasma glass sheet"
	icon_state = "sheet-prglass"
	item_state = "sheet-prglass"
	custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT, /datum/material/iron = MINERAL_MATERIAL_AMOUNT * 0.5)
	armor = list("melee" = 20, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 100)
	resistance_flags = ACID_PROOF
	material_flags = MATERIAL_NO_EFFECTS
	merge_type = /obj/item/stack/sheet/plasmarglass
	grind_results = list(/datum/reagent/silicon = 20, /datum/reagent/toxin/plasma = 10, /datum/reagent/iron = 10)
	point_value = 23

/obj/item/stack/sheet/plasmarglass/five
	amount = 5

/obj/item/stack/sheet/plasmarglass/twenty
	amount = 20

/obj/item/stack/sheet/plasmarglass/fifty
	amount = 50

/obj/item/stack/sheet/plasmarglass/get_main_recipes()
	. = ..()
	. += GLOB.prglass_recipes

GLOBAL_LIST_INIT(titaniumglass_recipes, list(
	new/datum/stack_recipe("shuttle window", /obj/structure/window/reinforced/fulltile/shuttle/unanchored, 2, time = 0, on_floor = TRUE, window_checks = TRUE)
	))

/obj/item/stack/sheet/titaniumglass
	name = "titanium glass"
	desc = "A glass sheet made out of a titanium-silicate alloy."
	singular_name = "titanium glass sheet"
	icon_state = "sheet-titaniumglass"
	item_state = "sheet-titaniumglass"
	custom_materials = list(/datum/material/titanium=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 100)
	resistance_flags = ACID_PROOF
	merge_type = /obj/item/stack/sheet/titaniumglass

/obj/item/stack/sheet/titaniumglass/get_main_recipes()
	. = ..()
	. += GLOB.titaniumglass_recipes

GLOBAL_LIST_INIT(plastitaniumglass_recipes, list(
	new/datum/stack_recipe("plastitanium window", /obj/structure/window/plasma/reinforced/plastitanium/unanchored, 2, time = 0, on_floor = TRUE, window_checks = TRUE)
	))

/obj/item/stack/sheet/plastitaniumglass
	name = "plastitanium glass"
	desc = "A glass sheet made out of a plasma-titanium-silicate alloy."
	singular_name = "plastitanium glass sheet"
	icon_state = "sheet-plastitaniumglass"
	item_state = "sheet-plastitaniumglass"
	custom_materials = list(/datum/material/titanium=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/plasma=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 100)
	material_flags = MATERIAL_NO_EFFECTS
	resistance_flags = ACID_PROOF
	merge_type = /obj/item/stack/sheet/plastitaniumglass

/obj/item/stack/sheet/plastitaniumglass/get_main_recipes()
	. = ..()
	. += GLOB.plastitaniumglass_recipes

/obj/item/shard
	name = "shard"
	desc = "A nasty looking shard of glass."
	icon = 'icons/obj/shards.dmi'
	icon_state = "large"
	w_class = WEIGHT_CLASS_TINY
	force = 5
	throwforce = 10
	item_state = "shard-glass"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	custom_materials = list(/datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	attack_verb = list("stabbed", "slashed", "sliced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	resistance_flags = ACID_PROOF
	armor = list("melee" = 100, "bullet" = 0, "laser" = 0, "energy" = 100, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 100)
	max_integrity = 40
	sharpness = SHARP_EDGED
	var/icon_prefix
	var/obj/item/stack/sheet/weld_material = /obj/item/stack/sheet/glass
	embedding = list("embed_chance" = 65)

/obj/item/shard/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, force)
	AddComponent(/datum/component/butchering, 150, 65)
	icon_state = pick("large", "medium", "small")
	switch(icon_state)
		if("small")
			pixel_x = rand(-12, 12)
			pixel_y = rand(-12, 12)
		if("medium")
			pixel_x = rand(-8, 8)
			pixel_y = rand(-8, 8)
		if("large")
			pixel_x = rand(-5, 5)
			pixel_y = rand(-5, 5)
	if (icon_prefix)
		icon_state = "[icon_prefix][icon_state]"

	if(!mapload)
		SSblackbox.record_feedback("tally", "station_mess_created", 1, name)

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/shard/afterattack(atom/A as mob|obj, mob/user, proximity)
	. = ..()
	if(!proximity || !(src in user))
		return
	if(isturf(A))
		return
	if(istype(A, /obj/item/storage))
		return
	var/hit_hand = ((user.active_hand_index % 2 == 0) ? "r_" : "l_") + "arm"
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!H.gloves && !HAS_TRAIT(H, TRAIT_PIERCEIMMUNE))
			to_chat(H, span_warning("[src] cuts into your hand!"))
			H.apply_damage(force*0.5, BRUTE, hit_hand)
	else if(ismonkey(user))
		var/mob/living/carbon/monkey/M = user
		if(!HAS_TRAIT(M, TRAIT_PIERCEIMMUNE))
			to_chat(M, span_warning("[src] cuts into your hand!"))
			M.apply_damage(force*0.5, BRUTE, hit_hand)

/obj/item/shard/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/lightreplacer))
		var/obj/item/lightreplacer/L = I
		L.attackby(src, user)
	else if(istype(I, /obj/item/stack/sheet/cotton/cloth))
		var/obj/item/stack/sheet/cotton/cloth/C = I
		to_chat(user, span_notice("You begin to wrap the [C] around the [src]..."))
		if(do_after(user, 35, target = src))
			var/obj/item/melee/knife/shiv/S = new /obj/item/melee/knife/shiv
			C.use(1)
			to_chat(user, span_notice("You wrap the [C] around the [src] forming a makeshift weapon."))
			remove_item_from_storage(src)
			qdel(src)
			user.put_in_hands(S)

	else
		return ..()

/obj/item/shard/welder_act(mob/living/user, obj/item/I)
	..()
	if(I.use_tool(src, user, 0, volume=50))
		var/obj/item/stack/sheet/NG = new weld_material(user.loc)
		for(var/obj/item/stack/sheet/G in user.loc)
			if(G == NG)
				continue
			if(G.amount >= G.max_amount)
				continue
			G.attackby(NG, user)
		to_chat(user, span_notice("You add the newly-formed [NG.name] to the stack. It now contains [NG.amount] sheet\s."))
		qdel(src)
	return TRUE

/obj/item/shard/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(isliving(AM))
		var/mob/living/L = AM
		if(!(L.movement_type & (FLYING|FLOATING)) || L.buckled)
			playsound(src, 'sound/effects/glass_step.ogg', HAS_TRAIT(L, TRAIT_LIGHT_STEP) ? 30 : 50, TRUE)

/obj/item/shard/plasma
	name = "plasmaglass shard"
	desc = "A nasty looking shard of plasma glass."
	force = 6
	throwforce = 11
	icon_state = "plasmalarge"
	custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	icon_prefix = "plasma"
	weld_material = /obj/item/stack/sheet/plasmaglass

/obj/item/shard/plastitanium
	name = "plastitanium glass shard"
	desc = "A nasty looking shard of plastitanium glass."
	force = 6
	throwforce = 11
	icon_state = "plastitaniumlarge"
	custom_materials = list(/datum/material/titanium=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/plasma=MINERAL_MATERIAL_AMOUNT * 0.5, /datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	icon_prefix = "plastitanium"
	weld_material = /obj/item/stack/sheet/plastitaniumglass
