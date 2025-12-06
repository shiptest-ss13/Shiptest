/datum/export/material
	cost = 5 // Cost per MINERAL_MATERIAL_AMOUNT, which is 2000cm3 as of now. when you are reading this. yes. now.
	desc = "The value for one sheet (or equivalent) of this material."

	elasticity_coeff = 0.002
	recovery_ds = 0.02 MINUTES
	var/material_id = null
	export_types = list(
		/obj/item/stack/sheet,
		/obj/item/stack/tile,
		/obj/item/stack/ore,
		/obj/item/coin
	)

// Yes, it's a base type containing export_types.
// But it has no material_id, so any applies_to check will return false, and these types reduce amount of copypasta a lot

/datum/export/material/get_amount(obj/O)
	if(!material_id)
		return 0
	if(!isitem(O))
		return 0
	var/obj/item/I = O
	if(!(SSmaterials.GetMaterialRef(material_id) in I.custom_materials))
		return 0

	var/amount = I.custom_materials[SSmaterials.GetMaterialRef(material_id)]

	if(istype(I, /obj/item/stack/ore))
		amount *= 0.8 // Station's ore redemption equipment is really goddamn good.

	return round(amount/MINERAL_MATERIAL_AMOUNT)

/datum/export/material/applies_to(obj/O, apply_elastic = TRUE)
	. = ..()
	if(!isitem(O))
		return FALSE
	var/obj/item/I = O
	if(length(I.custom_materials) > 1)
		return FALSE

// - Material exports.
// Prices have been heavily nerfed from the original values; mining is boring, so it shouldn't be a good way to make money.

/datum/export/material/diamond
	cost = 125
	unit_name = "cm3 of diamond"
	///my gay ass does not need industrial quantities of diamonds extracted with the blood of hungry kepori.
	elasticity_coeff = 0.004
	material_id = /datum/material/diamond

/datum/export/material/plasma
	cost = 25
	unit_name = "cm3 of plasma"
	sell_floor = 15
	material_id = /datum/material/plasma

/datum/export/material/uranium
	cost = 50
	unit_name = "cm3 of uranium"
	sell_floor = 40
	material_id = /datum/material/uranium

/datum/export/material/gold
	cost = 35
	unit_name = "cm3 of gold"
	sell_floor = 15
	material_id = /datum/material/gold

/datum/export/material/silver
	cost = 20
	unit_name = "cm3 of silver"
	sell_floor = 10
	material_id = /datum/material/silver

/datum/export/material/titanium
	cost = 35
	unit_name = "cm3 of titanium"
	sell_floor = 15
	material_id = /datum/material/titanium

/datum/export/material/bscrystal
	unit_name = "bluespace crystals"
	cost = 75
	sell_floor = 50
	material_id = /datum/material/bluespace

/datum/export/material/plastic
	unit_name = "sheet of plastic"
	cost = 2
	sell_floor = 1
	material_id = /datum/material/plastic
	valid_event_target = FALSE

/datum/export/material/metal
	unit_name = "sheet of metal"
	cost = 2
	sell_floor = 1
	material_id = /datum/material/iron
	export_types = list(
		/obj/item/stack/sheet/metal,
		/obj/item/stack/rods,
		/obj/item/stack/ore,
		/obj/item/coin
	)
	valid_event_target = FALSE

/datum/export/material/glass
	unit_name = "sheet of glass"
	cost = 1
	material_id = /datum/material/glass
	export_types = list(
		/obj/item/stack/sheet/glass,
		/obj/item/stack/ore,
		/obj/item/shard
	)
	valid_event_target = FALSE
