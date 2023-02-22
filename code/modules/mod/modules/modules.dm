/obj/item/mod/module/anti_magic/on_suit_activation()
	ADD_TRAIT(mod.wearer, TRAIT_ANTIMAGIC, MOD_TRAIT)
	ADD_TRAIT(mod.wearer, TRAIT_HOLY, MOD_TRAIT)

/obj/item/mod/module/anti_magic/on_suit_deactivation()
	REMOVE_TRAIT(mod.wearer, TRAIT_ANTIMAGIC, MOD_TRAIT)
	REMOVE_TRAIT(mod.wearer, TRAIT_HOLY, MOD_TRAIT)

/obj/item/mod/module/anti_magic/wizard
	name = "MOD magic neutralizer module"
	desc = "The caster wielding this spell gains an invisible barrier around them, channeling arcane power through \
		specialized runes engraved onto the surface of the suit to generate anti-magic field. \
		The field will neutralize all magic that comes into contact with the user. \
		It will not protect the caster from social ridicule."
	icon_state = "magic_neutralizer"

/obj/item/mod/module/anti_magic/wizard/on_suit_activation()
	ADD_TRAIT(mod.wearer, TRAIT_ANTIMAGIC_NO_SELFBLOCK, MOD_TRAIT)

/obj/item/mod/module/anti_magic/wizard/on_suit_deactivation()
	REMOVE_TRAIT(mod.wearer, TRAIT_ANTIMAGIC_NO_SELFBLOCK, MOD_TRAIT)

/obj/item/mod/module/kinesis //TODO POST-MERGE MAKE NOT SUCK ASS, MAKE BALLER AS FUCK
	name = "MOD kinesis module"
	desc = "A modular plug-in to the forearm, this module was presumed lost for many years, \
		despite the suits it used to be mounted on still seeing some circulation. \
		This piece of technology allows the user to generate precise anti-gravity fields, \
		letting them move objects as small as a titanium rod to as large as industrial machinery. \
		Oddly enough, it doesn't seem to work on living creatures."
	icon_state = "kinesis"
//	module_type = MODULE_ACTIVE
	module_type = MODULE_TOGGLE
//	complexity = 3
	complexity = 0
	active_power_cost = DEFAULT_CHARGE_DRAIN*0.75
//	use_power_cost = DEFAULT_CHARGE_DRAIN*3
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/kinesis)
	cooldown_time = 0.5 SECONDS
	var/has_tk = FALSE

/obj/item/mod/module/kinesis/on_activation()
	. = ..()
	if(!.)
		return
	if(mod.wearer.dna.check_mutation(TK))
		has_tk = TRUE
	else
		mod.wearer.dna.add_mutation(TK)

/obj/item/mod/module/kinesis/on_deactivation()
	. = ..()
	if(!.)
		return
	if(has_tk)
		has_tk = FALSE
		return
	mod.wearer.dna.remove_mutation(TK)

/obj/item/mod/module/insignia
	name = "MOD insignia module"
	desc = "Despite the existence of IFF systems, radio communique, and modern methods of deductive reasoning involving \
		the wearer's own eyes, colorful paint jobs remain a popular way for different factions in the galaxy to display who \
		they are. This system utilizes a series of tiny moving paint sprayers to both apply and remove different \
		color patterns to and from the suit."
	icon_state = "insignia"
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/insignia)
	overlay_state_inactive = "insignia"

/obj/item/mod/module/insignia/generate_worn_overlay()
	overlay_state_inactive = "[initial(overlay_state_inactive)]-[mod.skin]"
	. = ..()
	for(var/mutable_appearance/appearance as anything in .)
		appearance.color = color

/obj/item/mod/module/insignia/commander
	color = "#4980a5"

/obj/item/mod/module/insignia/security
	color = "#b30d1e"

/obj/item/mod/module/insignia/engineer
	color = "#e9c80e"

/obj/item/mod/module/insignia/medic
	color = "#ebebf5"

/obj/item/mod/module/insignia/janitor
	color = "#7925c7"

/obj/item/mod/module/insignia/clown
	color = "#ff1fc7"

/obj/item/mod/module/insignia/chaplain
	color = "#f0a00c"
