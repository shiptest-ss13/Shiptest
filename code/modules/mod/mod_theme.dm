/// Global proc that sets up all MOD themes as singletons in a list and returns it.
/proc/setup_mod_themes()
	. = list()
	for(var/path in typesof(/datum/mod_theme))
		var/datum/mod_theme/new_theme = new path()
		.[path] = new_theme

/// MODsuit theme, instanced once and then used by MODsuits to grab various statistics.
/datum/mod_theme
	/// Theme name for the MOD.
	var/name = "standard"
	/// Description added to the MOD.
	var/desc = "A civilian class MODsuit, it doesn't offer much. The minimalist design does however mean it's more lightweight then specialized models."
	/// Extended description on examine_more
	var/extended_desc
	/// Default skin of the MOD.
	var/default_skin = "standard"
	/// The slot this mod theme fits on
	var/slot_flags = ITEM_SLOT_BACK
	/// Armor shared across the MOD parts.
	var/armor = list("melee" = 10, "bullet" = 5, "laser" = 5, "energy" = 5, "bomb" = 0, "bio" = 100, "fire" = 25, "acid" = 25)
	/// Resistance flags shared across the MOD parts.
	var/resistance_flags = NONE
	/// Atom flags shared across the MOD parts.
	var/atom_flags = NONE
	/// Max heat protection shared across the MOD parts.
	var/max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	/// Max cold protection shared across the MOD parts.
	var/min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	/// Siemens shared across the MOD parts.
	var/siemens_coefficient = 0.5
	/// How much modules can the MOD carry without malfunctioning.
	var/complexity_max = DEFAULT_MAX_COMPLEXITY
	/// How much battery power the MOD uses by just being on
	var/charge_drain = DEFAULT_CHARGE_DRAIN
	/// Slowdown of the MOD when not active.
	var/slowdown_inactive = 0.75
	/// Slowdown of the MOD when active.
	var/slowdown_active = 0.5
	/// Theme used by the MOD TGUI.
	var/ui_theme = "ntos"
	/// List of inbuilt modules. These are different from the pre-equipped suits, you should mainly use these for unremovable modules with 0 complexity.
	var/list/inbuilt_modules = list()
	/// Modules blacklisted from the MOD.
	var/list/module_blacklist = list()
	/// Allowed items in the chestplate's suit storage.
	var/list/allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
	)
	/// List of variants and items created by them, with the flags we set.
	var/list/variants = list(
		"standard" = list(
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = NECK_LAYER,
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
		),
		"civilian" = list(
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR,
				UNSEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = HELMET_UNSEAL_MESSAGE,
				SEALED_MESSAGE = HELMET_SEAL_MESSAGE,
			),
		),
	)

/// Create parts of the suit and modify them using the theme's variables.
/datum/mod_theme/proc/set_up_parts(obj/item/mod/control/mod, skin)
	var/list/parts = list(mod)
	mod.slot_flags = slot_flags
	mod.extended_desc = extended_desc
	mod.slowdown_inactive = slowdown_inactive
	mod.slowdown_active = slowdown_active
	// mod.activation_step_time = activation_step_time todo fix?
	mod.complexity_max = complexity_max
	mod.ui_theme = ui_theme
	mod.charge_drain = charge_drain
	var/datum/mod_part/control_part_datum = new()
	control_part_datum.part_item = mod
	mod.mod_parts["[mod.slot_flags]"] = control_part_datum
	for(var/path in variants[default_skin])
		var/obj/item/mod_part = new path(mod)
		if(mod_part.slot_flags == ITEM_SLOT_OCLOTHING && isclothing(mod_part))
			var/obj/item/clothing/chestplate = mod_part
			chestplate.allowed |= allowed_suit_storage
		var/datum/mod_part/part_datum = new()
		part_datum.part_item = mod_part
		mod.mod_parts["[mod_part.slot_flags]"] = part_datum
		parts += mod_part
	for(var/obj/item/part as anything in parts)
		part.name = "[name] [part.name]"
		part.desc = "[part.desc] [desc]"
		part.armor = armor
		part.resistance_flags = resistance_flags
		part.flags_1 |= atom_flags //flags like initialization or admin spawning are here, so we cant set, have to add
		part.heat_protection = NONE
		part.cold_protection = NONE
		part.max_heat_protection_temperature = max_heat_protection_temperature
		part.min_cold_protection_temperature = min_cold_protection_temperature
		part.siemens_coefficient = siemens_coefficient
	set_skin(mod, skin || default_skin)

/datum/mod_theme/proc/set_skin(obj/item/mod/control/mod, skin)
	mod.skin = skin
	var/list/used_skin = variants[skin]
	var/list/parts = mod.get_parts()
	for(var/obj/item/clothing/part as anything in parts)
		var/list/category = used_skin[part.type]
		var/datum/mod_part/part_datum = mod.get_part_datum(part)
		part_datum.unsealed_layer = category[UNSEALED_LAYER]
		part_datum.sealed_layer = category[SEALED_LAYER]
		part_datum.unsealed_message = category[UNSEALED_MESSAGE] || "No unseal message set! Tell a coder!"
		part_datum.sealed_message = category[SEALED_MESSAGE] || "No seal message set! Tell a coder!"
		part_datum.can_overslot = category[CAN_OVERSLOT] || FALSE
		part.clothing_flags = category[UNSEALED_CLOTHING] || NONE
		part.visor_flags = category[SEALED_CLOTHING] || NONE
		part.flags_inv = category[UNSEALED_INVISIBILITY] || NONE
		part.visor_flags_inv = category[SEALED_INVISIBILITY] || NONE
		part.flags_cover = category[UNSEALED_COVER] || NONE
		part.visor_flags_cover = category[SEALED_COVER] || NONE
		if(mod.get_part_datum(part).sealed)
			part.clothing_flags |= part.visor_flags
			part.flags_inv |= part.visor_flags_inv
			part.flags_cover |= part.visor_flags_cover
			part.alternate_worn_layer = part_datum.sealed_layer
		else
			part.alternate_worn_layer = part_datum.unsealed_layer
		if(!part_datum.can_overslot && part_datum.overslotting)
			var/obj/item/overslot = part_datum.overslotting
			overslot.forceMove(mod.drop_location())
	for(var/obj/item/part as anything in parts + mod)
		part.icon = used_skin[MOD_ICON_OVERRIDE] || 'icons/obj/clothing/modsuit/mod_clothing.dmi'
		part.mob_overlay_icon = used_skin[MOD_WORN_ICON_OVERRIDE] || 'icons/mob/clothing/modsuit/mod_clothing.dmi'
		part.icon_state = "[skin]-[part.base_icon_state][mod.get_part_datum(part).sealed ? "-sealed" : ""]"
		// mod.wearer?.update_clothing(part.slot_flags) todo fix

/datum/mod_theme/heavy
	name = "corporate"
	default_skin = "corporate"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	complexity_max = 50
	siemens_coefficient = 0
	slowdown_inactive = 0.5
	slowdown_active = 0
	variants = list(
		"corporate" = list(
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH,
				SEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)


/datum/mod_theme/debug
	name = "debug"
	default_skin = "debug"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 50, "bomb" = 100, "bio" = 100, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF|ACID_PROOF
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	complexity_max = 50
	siemens_coefficient = 0
	slowdown_inactive = 0.5
	slowdown_active = 0
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/gun,
	)
	variants = list(
		"debug" = list(
			/obj/item/clothing/head/mod = list(
				UNSEALED_LAYER = null,
				UNSEALED_CLOTHING = SNUG_FIT|THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE|BLOCK_GAS_SMOKE_EFFECT,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR|HIDEEARS|HIDEHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE,
				UNSEALED_COVER = HEADCOVERSMOUTH,
				SEALED_COVER = HEADCOVERSEYES|PEPPERPROOF,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
			/obj/item/clothing/suit/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				SEALED_INVISIBILITY = HIDEJUMPSUIT,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
			/obj/item/clothing/gloves/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
			/obj/item/clothing/shoes/mod = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
				CAN_OVERSLOT = TRUE,
				UNSEALED_MESSAGE = BOOT_UNSEAL_MESSAGE,
				SEALED_MESSAGE = BOOT_SEAL_MESSAGE,
			),
		),
	)
