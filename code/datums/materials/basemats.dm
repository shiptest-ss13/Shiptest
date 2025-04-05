///Has no special properties.
/datum/material/iron
	name = "iron"
	id = "iron"
	desc = "Common iron ore often found in sedimentary and igneous layers of the crust."
	color = "#878687"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	sheet_type = /obj/item/stack/sheet/metal
	value_per_unit = 0.0025

///Breaks extremely easily but is transparent.
/datum/material/glass
	name = "glass"
	id = "glass"
	desc = "Glass forged by melting sand."
	color = "#88cdf1"
	alpha = 150
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	integrity_modifier = 0.1
	sheet_type = /obj/item/stack/sheet/glass
	value_per_unit = 0.0025
	beauty_modifier = 0.05
	armor_modifiers = list("melee" = 0.2, "bullet" = 0.2, "laser" = 0, "energy" = 1, "bomb" = 0, "bio" = 0.2, "rad" = 0.2, "fire" = 1, "acid" = 0.2)

/*
Color matrices are like regular colors but unlike with normal colors, you can go over 255 on a channel.
Unless you know what you're doing, only use the first three numbers. They're in RGB order.
*/

///Has no special properties. Could be good against vampires in the future perhaps.
/datum/material/silver
	name = "silver"
	id = "silver"
	desc = "Silver"
	color = "#ffffff"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/silver
	value_per_unit = 0.025
	beauty_modifier = 0.075

///Slight force increase
/datum/material/gold
	name = "gold"
	id = "gold"
	desc = "Gold"
	color = "#fff032" //gold is shiny, but not as bright as bananium
	strength_modifier = 1.2
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/gold
	value_per_unit = 0.0625
	beauty_modifier = 0.15
	armor_modifiers = list("melee" = 1.1, "bullet" = 1.1, "laser" = 1.15, "energy" = 1.15, "bomb" = 1, "bio" = 1, "rad" = 1, "fire" = 0.7, "acid" = 1.1)

/datum/material/carbon
	name = "carbon"
	id = "carbon"
	desc = "Carbon is an essential component of life, but also used as a primitive source of energy by virutally every sapient species in history."
	color = "#665b5b"
	categories = list(MAT_CATEGORY_ORE = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/coal
	value_per_unit = 1

/datum/material/carbon/on_applied_obj(obj/source, amount, material_flags)
	. = ..()
	if(material_flags & MATERIAL_AFFECT_STATISTICS)
		var/obj/carbon = source
		carbon.resistance_flags |= FLAMMABLE

/datum/material/carbon/on_removed_obj(obj/source, material_flags)
	. = ..()
	if(material_flags & MATERIAL_AFFECT_STATISTICS)
		var/obj/carbon = source
		carbon.resistance_flags &= ~FLAMMABLE

///Has no special properties
/datum/material/diamond
	name = "diamond"
	id = "diamond"
	desc = "Highly pressurized carbon"
	color = "#30ffff"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/diamond
	alpha = 132
	value_per_unit = 0.25
	beauty_modifier = 0.3
	armor_modifiers = list("melee" = 1.3, "bullet" = 1.3, "laser" = 0.6, "energy" = 1, "bomb" = 1.2, "bio" = 1, "rad" = 1, "fire" = 1, "acid" = 1)

///Is slightly radioactive
/datum/material/uranium
	name = "uranium"
	id = "uranium"
	desc = "Uranium"
	color = "#30ed1a"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/uranium
	value_per_unit = 0.05
	beauty_modifier = 0.3 //It shines so beautiful
	armor_modifiers = list("melee" = 1.5, "bullet" = 1.4, "laser" = 0.5, "energy" = 0.5, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 1, "acid" = 1)

/datum/material/uranium/on_applied(atom/source, amount, material_flags)
	. = ..()
	source.AddComponent(/datum/component/radioactive, amount / 20, source, 0) //half-life of 0 because we keep on going.

/datum/material/uranium/on_removed(atom/source, amount, material_flags)
	. = ..()
	qdel(source.GetComponent(/datum/component/radioactive))

///Adds firestacks on hit (Still needs support to turn into gas on destruction)
/datum/material/plasma
	name = "plasma"
	id = "plasma"
	desc = "Isn't plasma a state of matter? Oh whatever."
	color = "#ff2eff"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/plasma
	value_per_unit = 0.1
	beauty_modifier = 0.15
	armor_modifiers = list("melee" = 1.4, "bullet" = 0.7, "laser" = 0, "energy" = 1.2, "bomb" = 0, "bio" = 1.2, "rad" = 1, "fire" = 0, "acid" = 0.5)

/datum/material/plasma/on_applied(atom/source, amount, material_flags)
	. = ..()
	if(ismovable(source))
		source.AddElement(/datum/element/firestacker, amount=1)
		source.AddComponent(/datum/component/explodable, 0, 0, amount / 2500, amount / 1250)

/datum/material/plasma/on_removed(atom/source, amount, material_flags)
	. = ..()
	source.RemoveElement(/datum/element/firestacker, amount=1)
	qdel(source.GetComponent(/datum/component/explodable))

///Can cause bluespace effects on use. (Teleportation) (Not yet implemented)
/datum/material/bluespace
	name = "bluespace crystal"
	id = "bluespace_crystal"
	desc = "Crystals with bluespace properties"
	color = "#4086e2"
	alpha = 200
	categories = list(MAT_CATEGORY_ORE = TRUE)
	beauty_modifier = 0.5
	sheet_type = /obj/item/stack/sheet/bluespace_crystal
	value_per_unit = 0.15


///Mediocre force increase
/datum/material/titanium
	name = "titanium"
	id = "titanium"
	desc = "Titanium"
	color = "#b3c0c7"
	strength_modifier = 1.3
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/titanium
	value_per_unit = 0.0625
	beauty_modifier = 0.05
	armor_modifiers = list("melee" = 1.35, "bullet" = 1.3, "laser" = 1.3, "energy" = 1.25, "bomb" = 1.25, "bio" = 1, "rad" = 1, "fire" = 0.7, "acid" = 1)

///Force decrease
/datum/material/plastic
	name = "plastic"
	id = "plastic"
	desc = "Plastic"
	color = "#caccd9"
	strength_modifier = 0.85
	sheet_type = /obj/item/stack/sheet/plastic
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	value_per_unit = 0.0125
	beauty_modifier = -0.01
	armor_modifiers = list("melee" = 1.5, "bullet" = 1.1, "laser" = 0.3, "energy" = 0.5, "bomb" = 1, "bio" = 1, "rad" = 1, "fire" = 1.1, "acid" = 1)

/datum/material/copper
	name = "copper"
	id = "copper"
	desc = "Copper is a soft, malleable, and ductile metal with very high thermal and electrical conductivity."
	color = "#c47a3d"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/copper
	value_per_unit = 0.0025

/datum/material/lead
	name = "lead"
	id = "lead"
	desc = "Lead is a soft, malleable, and heavy metal found in sedimentary and igneous layers of the crust."
	color = "#60706b"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/lead
	value_per_unit = 0.0025

/datum/material/sulfur
	name = "sulfur"
	id = "sulfur"
	desc = "Also known as brimstone, Sulfur is a flammable substance, but is also a core component of life."
	color = "#ede218"
	categories = list(MAT_CATEGORY_ORE = TRUE)
	sheet_type = /obj/item/stack/ore/sulfur
	value_per_unit = 1

/datum/material/sulfur/on_applied(atom/source, amount, material_flags)
	. = ..()
	if(ismovable(source))
		source.AddComponent(/datum/component/explodable, 0, 0, amount / 3000, amount / 1000)

/datum/material/sulfur/on_removed(atom/source, material_flags)
	. = ..()
	qdel(source.GetComponent(/datum/component/explodable))

/datum/material/quartz
	name = "quartz"
	id = "quartz"
	desc = "Quartz is a common crytsal created from compacted sandstone, commonly used in glass production."
	color = "#fcedff"
	categories = list(MAT_CATEGORY_ORE = TRUE, MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/quartz
	value_per_unit = 0.0025

/datum/material/silicon
	name = "silicon"
	id = "silicon"
	desc = "Silicon is a material best known for it's use in electronics."
	color = "#4d4754"
	categories = list(MAT_CATEGORY_ORE = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/silicon
	value_per_unit = 1

///Force decrease and mushy sound effect. (Not yet implemented)
/datum/material/biomass
	name = "biomass"
	id = "biomass"
	desc = "Organic matter"
	color = "#735b4d"
	strength_modifier = 0.8
	value_per_unit = 0.025

/datum/material/wood
	name = "wood"
	id = "wood"
	desc = "Flexible, durable, but flamable. Hard to come across in space."
	color = "#bb8e53"
	strength_modifier = 0.5
	sheet_type = /obj/item/stack/sheet/mineral/wood
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	value_per_unit = 0.01
	beauty_modifier = 0.1
	armor_modifiers = list("melee" = 1.1, "bullet" = 1.1, "laser" = 0.4, "energy" = 0.4, "bomb" = 1, "bio" = 0.2, "rad" = 0, "fire" = 0, "acid" = 0.3)

/datum/material/wood/on_applied_obj(obj/source, amount, material_flags)
	. = ..()
	if(material_flags & MATERIAL_AFFECT_STATISTICS)
		var/obj/wooden = source
		wooden.resistance_flags |= FLAMMABLE

/datum/material/wood/on_removed_obj(obj/source, material_flags)
	. = ..()
	if(material_flags & MATERIAL_AFFECT_STATISTICS)
		var/obj/wooden = source
		wooden.resistance_flags &= ~FLAMMABLE

//Remember when the theme used to be "Eerie" before 1.3? Good times.
/datum/material/hellstone
	name = "hellstone"
	id = "hellstone"
	desc = "A colloquialism given to millenia-old slag, heat-treated through the eons in deep magma."
	color = "#ffaf5e"
	strength_modifier = 1.5
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/hidden/hellstone
	value_per_unit = 0.25
	beauty_modifier = 0.4
	armor_modifiers = list("melee" = 1.5, "bullet" = 1.5, "laser" = 1.3, "energy" = 1.3, "bomb" = 1, "bio" = 1, "rad" = 1, "fire" = 2.5, "acid" = 1)

//formed when freon react with o2, emits a lot of plasma when heated
/datum/material/hot_ice
	name = "hot ice"
	id = "hot ice"
	desc = "A weird kind of ice, feels warm to the touch"
	color = "#88cdf1"
	alpha = 150
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/hot_ice
	value_per_unit = 0.2
	beauty_modifier = 0.2

/datum/material/hot_ice/on_applied(atom/source, amount, material_flags)
	. = ..()
	source.AddComponent(/datum/component/hot_ice, "plasma", amount*150, amount*20+300)

/datum/material/hot_ice/on_removed(atom/source, amount, material_flags)
	qdel(source.GetComponent(/datum/component/hot_ice, "plasma", amount*150, amount*20+300))
	return ..()

//I don't like sand. It's coarse, and rough, and irritating, and it gets everywhere.
/datum/material/sand
	name = "sand"
	id = "sand"
	desc = "You know, it's amazing just how structurally sound sand can be."
	color = "#EDC9AF"
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/sandblock
	value_per_unit = 0.001
	strength_modifier = 0.5
	integrity_modifier = 0.1
	armor_modifiers = list("melee" = 0.25, "bullet" = 0.25, "laser" = 1.25, "energy" = 0.25, "bomb" = 0.25, "bio" = 0.25, "rad" = 1.5, "fire" = 1.5, "acid" = 1.5)
	beauty_modifier = 0.25
	turf_sound_override = FOOTSTEP_ASTEROID
	texture_layer_icon_state = "sand"

//And now for our lavaland dwelling friends, sand, but in stone form! Truly revolutionary.
/datum/material/sandstone
	name = "sandstone"
	id = "sandstone"
	desc = "Bialtaakid 'ant taerif ma hdha."
	color = "#B77D31"
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/sandstone
	value_per_unit = 0.0025
	armor_modifiers = list("melee" = 0.5, "bullet" = 0.5, "laser" = 1.25, "energy" = 0.5, "bomb" = 0.5, "bio" = 0.25, "rad" = 1.5, "fire" = 1.5, "acid" = 1.5)
	beauty_modifier = 0.3
	turf_sound_override = FOOTSTEP_WOOD
	texture_layer_icon_state = "brick"

/datum/material/snow
	name = "snow"
	id = "snow"
	desc = "There's no business like snow business."
	color = "#FFFFFF"
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/snow
	value_per_unit = 0.0025
	armor_modifiers = list("melee" = 0.25, "bullet" = 0.25, "laser" = 0.25, "energy" = 0.25, "bomb" = 0.25, "bio" = 0.25, "rad" = 1.5, "fire" = 0.25, "acid" = 1.5)
	beauty_modifier = 0.3
	turf_sound_override = FOOTSTEP_ASTEROID
	texture_layer_icon_state = "sand"

/datum/material/bronze
	name = "bronze"
	id = "bronze"
	desc = "Clock Cult? Never heard of it."
	color = "#92661A"
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/tile/bronze
	value_per_unit = 0.025
	armor_modifiers = list("melee" = 1, "bullet" = 1, "laser" = 1, "energy" = 1, "bomb" = 1, "bio" = 1, "rad" = 1.5, "fire" = 1.5, "acid" = 1.5)
	beauty_modifier = 0.2

/datum/material/paper
	name = "paper"
	id = "paper"
	desc = "Ten thousand folds of pure starchy power."
	color = "#E5DCD5"
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/paperframes
	value_per_unit = 0.0025
	armor_modifiers = list("melee" = 0.1, "bullet" = 0.1, "laser" = 0.1, "energy" = 0.1, "bomb" = 0.1, "bio" = 0.1, "rad" = 1.5, "fire" = 0, "acid" = 1.5)
	beauty_modifier = 0.3
	turf_sound_override = FOOTSTEP_ASTEROID
	texture_layer_icon_state = "paper"

/datum/material/paper/on_applied_obj(obj/source, amount, material_flags)
	. = ..()
	if(material_flags & MATERIAL_AFFECT_STATISTICS)
		var/obj/paper = source
		paper.resistance_flags |= FLAMMABLE
		paper.obj_flags |= UNIQUE_RENAME

/datum/material/paper/on_removed_obj(obj/source, material_flags)
	if(material_flags & MATERIAL_AFFECT_STATISTICS)
		var/obj/paper = source
		paper.resistance_flags &= ~FLAMMABLE
	return ..()

/datum/material/cardboard
	name = "cardboard"
	id = "cardboard"
	desc = "They say cardboard is used by hobos to make incredible things."
	color = "#5F625C"
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/cardboard
	value_per_unit = 0.003
	armor_modifiers = list("melee" = 0.25, "bullet" = 0.25, "laser" = 0.25, "energy" = 0.25, "bomb" = 0.25, "bio" = 0.25, "rad" = 1.5, "fire" = 0, "acid" = 1.5)
	beauty_modifier = -0.1

/datum/material/cardboard/on_applied_obj(obj/source, amount, material_flags)
	. = ..()
	if(material_flags & MATERIAL_AFFECT_STATISTICS)
		var/obj/cardboard = source
		cardboard.resistance_flags |= FLAMMABLE
		cardboard.obj_flags |= UNIQUE_RENAME

/datum/material/cardboard/on_removed_obj(obj/source, material_flags)
	if(material_flags & MATERIAL_AFFECT_STATISTICS)
		var/obj/cardboard = source
		cardboard.resistance_flags &= ~FLAMMABLE
	return ..()

/datum/material/bone
	name = "bone"
	id = "bone"
	desc = "Man, building with this will make you the coolest caveman on the block."
	color = "#e3dac9"
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/bone
	value_per_unit = 0.05
	armor_modifiers = list("melee" = 1.2, "bullet" = 0.75, "laser" = 0.75, "energy" = 1.2, "bomb" = 1, "bio" = 1, "rad" = 1.5, "fire" = 1.5, "acid" = 1.5)
	beauty_modifier = -0.2

/datum/material/bamboo
	name = "bamboo"
	id = "bamboo"
	desc = "If it's good enough for pandas, it's good enough for you."
	color = "#339933"
	categories = list(MAT_CATEGORY_RIGID = TRUE)
	sheet_type = /obj/item/stack/sheet/mineral/bamboo
	value_per_unit = 0.0025
	armor_modifiers = list("melee" = 0.5, "bullet" = 0.5, "laser" = 0.5, "energy" = 0.5, "bomb" = 0.5, "bio" = 0.51, "rad" = 1.5, "fire" = 0.5, "acid" = 1.5)
	beauty_modifier = 0.2
	turf_sound_override = FOOTSTEP_WOOD
	texture_layer_icon_state = "bamboo"
