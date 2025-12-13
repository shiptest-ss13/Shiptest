/obj/item/storage/belt
	name = "belt"
	desc = "Can hold various things."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utility"
	item_state = "utility"
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	attack_verb = list("whipped", "lashed", "disciplined")
	max_integrity = 300
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	var/content_overlays = FALSE //If this is true, the belt will gain overlays based on what it's holding
	supports_variations = VOX_VARIATION
	greyscale_icon_state = "belt"
	greyscale_colors = list(list(16, 12), list(15, 11), list(13, 12))

	equipping_sound = EQUIP_SOUND_VFAST_GENERIC
	unequipping_sound = UNEQUIP_SOUND_VFAST_GENERIC
	equip_delay_self = EQUIP_DELAY_BELT
	equip_delay_other = EQUIP_DELAY_BELT * 1.5
	strip_delay = EQUIP_DELAY_BELT * 1.5
	equip_self_flags = EQUIP_ALLOW_MOVEMENT

/obj/item/storage/belt/update_overlays()
	. = ..()
	if(!content_overlays)
		return
	for(var/obj/item/I in contents)
		. += I.get_belt_overlay()


/obj/item/storage/belt/Initialize()
	. = ..()
	update_appearance()

/obj/item/storage/belt/utility
	name = "toolbelt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Holds tools."
	icon_state = "utility"
	item_state = "utility"
	content_overlays = TRUE
	custom_price = 350
	custom_premium_price = 300
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound =  'sound/items/handling/toolbelt_pickup.ogg'

/obj/item/storage/belt/utility/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 21
	STR.set_holdable(list(
		/obj/item/crowbar,
		/obj/item/screwdriver,
		/obj/item/weldingtool,
		/obj/item/wirecutters,
		/obj/item/wrench,
		/obj/item/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/geiger_counter,
		/obj/item/extinguisher/mini,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/holosign_creator/atmos,
		/obj/item/holosign_creator/engineering,
		/obj/item/forcefield_projector,
		/obj/item/assembly/signaler,
		/obj/item/lightreplacer,
		/obj/item/construction/rcd,
		/obj/item/pipe_dispenser,
		/obj/item/inducer,
		/obj/item/plunger,
		/obj/item/airlock_painter,
		/obj/item/decal_painter,
		/obj/item/floor_painter,
		/obj/item/chisel,
		/obj/item/clothing/glasses/welding, //WS edit: ok mald sure I'll add the welding stuff to the. ok.
		/obj/item/clothing/mask/gas/welding,
		/obj/item/clothing/head/welding, //WS end
		/obj/item/gun/energy/plasmacutter,
		/obj/item/bodycamera,
		/obj/item/stack/tape/industrial,
		/obj/item/trench_tool,
		))

/obj/item/storage/belt/utility/chief
	name = "\improper Chief Engineer's toolbelt" //"the Chief Engineer's toolbelt", because "Chief Engineer's toolbelt" is not a proper noun
	desc = "Holds tools, looks snazzy."
	icon_state = "utility_ce"
	item_state = "utility_ce"

/obj/item/storage/belt/utility/chief/full/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/electric(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src,MAXCOIL,pick("red","yellow","orange"))
	new /obj/item/extinguisher/mini(src)
	new /obj/item/analyzer(src)

/obj/item/storage/belt/utility/full/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src,MAXCOIL,pick("red","yellow","orange"))

/obj/item/storage/belt/utility/full/engi/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src,MAXCOIL,pick("red","yellow","orange"))


/obj/item/storage/belt/utility/atmostech/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/t_scanner(src)
	new /obj/item/extinguisher/mini(src)

/obj/item/storage/belt/utility/atmostech/hologram/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/t_scanner(src)
	new /obj/item/pipe_dispenser(src)

/obj/item/storage/belt/utility/syndicate/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/wrench/combat(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/crowbar/syndie(src)
	new /obj/item/wirecutters/syndie(src)
	new /obj/item/multitool/syndie(src)
	new /obj/item/inducer/syndicate(src)

/obj/item/storage/belt/utility/full/ert/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/electric(src)
	new /obj/item/multitool(src)
	new /obj/item/construction/rcd/combat(src)
	new /obj/item/extinguisher/mini(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/medical
	name = "medical belt"
	desc = "Can hold various medical equipment."
	icon_state = "medical"
	item_state = "medical"
	supports_variations = VOX_VARIATION

/obj/item/storage/belt/medical/webbing
	name = "medical webbing"
	desc = "Versatile chest rig, valued by field medics of all stripes for its ease of use. Can hold various medical equipment."
	icon_state = "medicwebbing"
	item_state = "medicwebbing"
	custom_premium_price = 900
	supports_variations = KEPORI_VARIATION | VOX_VARIATION

/obj/item/storage/belt/medical/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 21
	STR.set_holdable(list(
		/obj/item/healthanalyzer,
		/obj/item/dnainjector,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/pill,
		/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/medigel,
		/obj/item/lighter,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/medical,
		/obj/item/flashlight/pen,
		/obj/item/extinguisher/mini,
		/obj/item/reagent_containers/hypospray,
		/obj/item/hypospray,
		/obj/item/sensor_device,
		/obj/item/radio,
		/obj/item/clothing/gloves/,
		/obj/item/lazarus_injector,
		/obj/item/bikehorn/rubberducky,
		/obj/item/clothing/mask/surgical,
		/obj/item/clothing/mask/breath,
		/obj/item/clothing/mask/breath/medical,
		/obj/item/scalpel,
		/obj/item/circular_saw,
		/obj/item/surgicaldrill,
		/obj/item/retractor,
		/obj/item/cautery,
		/obj/item/hemostat,
		/obj/item/geiger_counter,
		/obj/item/clothing/neck/stethoscope,
		/obj/item/stamp,
		/obj/item/clothing/glasses,
		/obj/item/wrench/medical,
		/obj/item/clothing/mask/muzzle,
		/obj/item/storage/bag/chemistry,
		/obj/item/storage/bag/bio,
		/obj/item/reagent_containers/blood,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/gun/syringe/syndicate,
		/obj/item/implantcase,
		/obj/item/implant,
		/obj/item/implanter,
		/obj/item/pinpointer/crew,
		/obj/item/holosign_creator/medical,
		/obj/item/construction/plumbing,
		/obj/item/plunger,
		/obj/item/reagent_containers/spray,
		/obj/item/shears,
		/obj/item/bodycamera,
		/obj/item/bonesetter,
		/obj/item/stack/sticky_tape/surgical
		))

/obj/item/storage/belt/medical/paramedic/PopulateContents()
	new /obj/item/sensor_device(src)
	new /obj/item/pinpointer/crew/prox(src)
	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/glass/bottle/epinephrine(src)
	new /obj/item/reagent_containers/glass/bottle/formaldehyde(src)
	update_appearance()

/obj/item/storage/belt/medical/webbing/paramedic/PopulateContents()
	new /obj/item/sensor_device(src)
	new /obj/item/pinpointer/crew/prox(src)
	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/reagent_containers/glass/bottle/epinephrine(src)
	new /obj/item/reagent_containers/glass/bottle/formaldehyde(src)
	update_appearance()

/obj/item/storage/belt/medical/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/circular_saw(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/retractor(src)
	new /obj/item/cautery(src)
	new /obj/item/hemostat(src)
	new /obj/item/hypospray/mkii(src)
	update_appearance()

/obj/item/storage/belt/medical/webbing/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/circular_saw(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/retractor(src)
	new /obj/item/cautery(src)
	new /obj/item/hemostat(src)
	new /obj/item/hypospray/mkii(src)
	update_appearance()

/obj/item/storage/belt/medical/webbing/combat/PopulateContents()
	. = ..()
	new /obj/item/reagent_containers/hypospray/medipen/stimpack(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpack(src)
	new /obj/item/reagent_containers/medigel/hadrakine(src)
	new /obj/item/reagent_containers/medigel/quardexane(src)
	new /obj/item/stack/medical/gauze/twelve(src)
	new /obj/item/stack/medical/splint(src)

/obj/item/storage/belt/security
	name = "security belt"
	desc = "Can hold security gear like handcuffs and flashes."
	icon_state = "security"
	item_state = "security"//Could likely use a better one.
	content_overlays = TRUE
	supports_variations = VOX_VARIATION

/obj/item/storage/belt/security/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(
		/obj/item/melee/baton,
		/obj/item/melee/classic_baton,
		/obj/item/melee/knife,
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/binoculars,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box/magazine,
		/obj/item/ammo_box/c38, //speed loaders don't have a common path like magazines. pain.
		/obj/item/ammo_box/a357, //some day we should refactor these into an ammo_box/speedloader type
		/obj/item/ammo_box/a858, //oh boy stripper clips too
		/obj/item/ammo_box/vickland_a8_50r,
		/obj/item/ammo_box/a300,
		/obj/item/ammo_box/a762_stripper,
		/obj/item/ammo_box/amagpellet_claris, //that's the last of the clips
		/obj/item/food/donut,
		/obj/item/melee/knife/combat,
		/obj/item/flashlight/seclite,
		/obj/item/melee/classic_baton/telescopic,
		/obj/item/radio,
		/obj/item/attachment,
		/obj/item/extinguisher/mini,
		/obj/item/clothing/gloves,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/holosign_creator/security,
		/obj/item/stock_parts/cell/gun,
		/obj/item/ammo_box/magazine/ammo_stack, //handfuls of bullets
		/obj/item/bodycamera,
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/laser,
		/obj/item/gun/energy/sharplite/x26,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/kalix/pistol,
		))
	STR.can_hold_max_of_items = typecacheof(list(
		/obj/item/gun = 1,
	))

/obj/item/storage/belt/security/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/loaded(src)
	update_appearance()

/obj/item/storage/belt/security/webbing
	name = "security webbing"
	desc = "Unique and versatile chest rig, can hold security gear."
	icon_state = "securitywebbing"
	item_state = "securitywebbing"
	content_overlays = FALSE
	custom_premium_price = 900

/obj/item/storage/belt/security/webbing/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6

/obj/item/storage/belt/security/webbing/bulldog_mixed/PopulateContents()
	. = ..()
	new /obj/item/ammo_box/magazine/m12g_bulldog/drum/bioterror(src) // you only get ONE this one is nasty
	new /obj/item/ammo_box/magazine/m12g_bulldog/drum/slug(src)
	new /obj/item/ammo_box/magazine/m12g_bulldog/drum/slug(src)
	new /obj/item/ammo_box/magazine/m12g_bulldog/drum(src)

/obj/item/storage/belt/mining
	name = "explorer's webbing"
	desc = "A versatile chest rig, cherished by miners and hunters alike."
	icon_state = "explorer1"
	item_state = "explorer1"
	w_class = WEIGHT_CLASS_BULKY
	custom_price = 400
	supports_variations = VOX_VARIATION

/obj/item/storage/belt/mining/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 20
	STR.set_holdable(list(
		/obj/item/crowbar,
		/obj/item/screwdriver,
		/obj/item/weldingtool,
		/obj/item/wirecutters,
		/obj/item/wrench,
		/obj/item/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/analyzer,
		/obj/item/extinguisher/mini,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/resonator,
		/obj/item/mining_scanner,
		/obj/item/pinpointer/mineral,
		/obj/item/pickaxe,
		/obj/item/shovel,
		/obj/item/stack/sheet/animalhide,
		/obj/item/stack/sheet/sinew,
		/obj/item/stack/sheet/bone,
		/obj/item/lighter,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/reagent_containers/food/drinks/bottle,
		/obj/item/stack/medical,
		/obj/item/melee/knife,
		/obj/item/reagent_containers/hypospray,
		/obj/item/gps,
		/obj/item/storage/bag/ore,
		/obj/item/survivalcapsule,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/reagent_containers/pill,
		/obj/item/storage/pill_bottle,
		/obj/item/stack/ore,
		/obj/item/reagent_containers/food/drinks,
		/obj/item/organ/regenerative_core,
		/obj/item/wormhole_jaunter,
		/obj/item/storage/bag/plants,
		/obj/item/stack/marker_beacon,
		/obj/item/restraints/legcuffs/bola/watcher,
		/obj/item/melee/sword/bone,
		/obj/item/bodycamera,
		/obj/item/binoculars,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/trench_tool,
		))


/obj/item/storage/belt/mining/vendor
	contents = newlist(/obj/item/survivalcapsule)

/obj/item/storage/belt/mining/alt
	icon_state = "explorer2"
	item_state = "explorer2"

/obj/item/storage/belt/mining/primitive
	name = "hunter's belt"
	desc = "A versatile belt, woven from sinew."
	icon_state = "ebelt"
	item_state = "ebelt"

/obj/item/storage/belt/mining/primitive/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5

/obj/item/storage/belt/champion
	name = "championship belt"
	desc = "Proves to the world that you are the strongest!"
	icon_state = "champion"
	item_state = "champion"
	custom_materials = list(/datum/material/gold=400)
	supports_variations = VOX_VARIATION

/obj/item/storage/belt/champion/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.set_holdable(list(
		/obj/item/clothing/mask/luchador
		))

/obj/item/storage/belt/military
	name = "chest rig"
	desc = "A set of tactical webbing worn by military cosplayers and actual militaries alike."
	icon_state = "militarywebbing"
	item_state = "militarywebbing"
	resistance_flags = FIRE_PROOF
	supports_variations = KEPORI_VARIATION | VOX_VARIATION

	unique_reskin = list(
		"None" = "militarywebbing",
		"Desert" = "militarywebbing_desert",
		"Woodland" = "militarywebbing_woodland",
		"Snow" = "militarywebbing_snow",
		"Urban" = "militarywebbing_urban",
		)

/obj/item/storage/belt/military/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/static/list/exception_cache = typecacheof(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/laser,
		/obj/item/gun/energy/sharplite/x26,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/kalix/pistol,
		))
	STR.exception_hold = exception_cache
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.can_hold_max_of_items = typecacheof(list(
		/obj/item/gun = 1,
	))

/obj/item/storage/belt/military/cobra/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/m45_cobra(src)

/obj/item/storage/belt/military/hydra/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/m556_42_hydra(src)

/obj/item/storage/belt/military/boomslang/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/boomslang(src)

/obj/item/storage/belt/military/mako/PopulateContents()
	. = ..()
	new /obj/item/ammo_casing/caseless/rocket/a70mm(src)
	new /obj/item/ammo_casing/caseless/rocket/a70mm(src)
	new /obj/item/ammo_casing/caseless/rocket/a70mm(src)
	new /obj/item/ammo_casing/caseless/rocket/a70mm(src)
	new /obj/item/ammo_casing/caseless/rocket/a70mm(src)
	new /obj/item/ammo_casing/caseless/rocket/a70mm(src)

/obj/item/storage/belt/military/snack
	name = "tactical snack rig"

/obj/item/storage/belt/military/snack/Initialize()
	. = ..()
	var/sponsor = pick("Donk! Co.", "CyberSun")
	desc = "A set of snack-tical webbing worn by athletes of the [sponsor] VR sports division."

/obj/item/storage/belt/military/snack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.set_holdable(list(
		/obj/item/food,
		/obj/item/reagent_containers/food/drinks
		))

	var/amount = 5
	var/rig_snacks
	while(contents.len <= amount)
		rig_snacks = pick(list(
		/obj/item/food/candy,
		/obj/item/reagent_containers/food/drinks/dry_ramen,
		/obj/item/food/chips,
		/obj/item/food/sosjerky,
		/obj/item/food/syndicake,
		/obj/item/food/spacetwinkie,
		/obj/item/food/cheesiehonkers,
		/obj/item/food/nachos,
		/obj/item/food/cheesynachos,
		/obj/item/food/cubannachos,
		/obj/item/food/nugget,
		/obj/item/food/spaghetti/pastatomato,
		/obj/item/food/rofflewaffles,
		/obj/item/food/donkpocket,
		/obj/item/reagent_containers/food/drinks/soda_cans/cola,
		/obj/item/reagent_containers/food/drinks/soda_cans/comet_trail,
		/obj/item/reagent_containers/food/drinks/soda_cans/tadrixx,
		/obj/item/reagent_containers/food/drinks/soda_cans/lunapunch,
		/obj/item/reagent_containers/food/drinks/soda_cans/space_up,
		/obj/item/reagent_containers/food/drinks/soda_cans/pacfuel,
		/obj/item/reagent_containers/food/drinks/soda_cans/orange_soda
		))
		new rig_snacks(src)

/obj/item/storage/belt/military/abductor
	name = "agent belt"
	desc = "A belt used by abductor agents."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "belt"
	item_state = "grenadebeltnew"
	unique_reskin = null

/obj/item/storage/belt/military/abductor/full/PopulateContents()
	new /obj/item/screwdriver/abductor(src)
	new /obj/item/wrench/abductor(src)
	new /obj/item/weldingtool/abductor(src)
	new /obj/item/crowbar/abductor(src)
	new /obj/item/wirecutters/abductor(src)
	new /obj/item/multitool/abductor(src)
	new /obj/item/stack/cable_coil(src,MAXCOIL,"white")

/obj/item/storage/belt/military/army
	name = "army belt"
	desc = "A belt used by military forces."
	icon_state = "grenadebeltold"
	item_state = "grenadebeltol"
	unique_reskin = null

/obj/item/storage/belt/military/assault
	name = "assault belt"
	desc = "A tactical assault belt."
	icon_state = "assault"
	item_state = "assault"
	supports_variations = VOX_VARIATION
	unique_reskin = null

/obj/item/storage/belt/military/assault/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6

/obj/item/storage/belt/military/assault/hydra/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/m556_42_hydra(src)

/obj/item/storage/belt/military/assault/sniper/PopulateContents()
	. = ..()
	new /obj/item/ammo_box/magazine/sniper_rounds(src)
	new /obj/item/ammo_box/magazine/sniper_rounds(src)
	new /obj/item/ammo_box/magazine/sniper_rounds/penetrator(src)

/obj/item/storage/belt/military/assault/commander/PopulateContents()
	. = ..()
	for(var/i in 1 to 4)
		new /obj/item/ammo_box/magazine/co9mm(src)

/obj/item/storage/belt/grenade
	name = "grenadier belt"
	desc = "A belt for holding grenades."
	icon_state = "grenadebeltnew"
	item_state = "grenadebeltnew"

/obj/item/storage/belt/grenade/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 30
	STR.display_numerical_stacking = TRUE
	STR.max_combined_w_class = 60
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/grenade,
		/obj/item/screwdriver,
		/obj/item/lighter,
		/obj/item/multitool,
		/obj/item/reagent_containers/food/drinks/molotov,
		/obj/item/grenade/c4,
		/obj/item/food/grown/firelemon,
		))

/obj/item/storage/belt/grenade/full/PopulateContents()
	var/static/items_inside = list(
		/obj/item/grenade/flashbang = 1,
		/obj/item/grenade/smokebomb = 4,
		/obj/item/grenade/empgrenade = 1,
		/obj/item/grenade/empgrenade = 1,
		/obj/item/grenade/frag = 10,
		/obj/item/grenade/gluon = 4,
		/obj/item/grenade/chem_grenade/incendiary = 2,
		/obj/item/grenade/chem_grenade/facid = 1,
		/obj/item/grenade/syndieminibomb = 2,
		/obj/item/screwdriver = 1,
		/obj/item/multitool = 1)
	generate_items_inside(items_inside,src)

/obj/item/storage/belt/janitor
	name = "janibelt"
	desc = "A belt used to hold most janitorial supplies."
	icon_state = "jani"
	item_state = "jani"
	supports_variations = VOX_VARIATION

/obj/item/storage/belt/janitor/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.max_w_class = WEIGHT_CLASS_BULKY // Set to this so the  light replacer can fit.
	STR.set_holdable(list(
		/obj/item/grenade/chem_grenade,
		/obj/item/lightreplacer,
		/obj/item/flashlight,
		/obj/item/reagent_containers/spray,
		/obj/item/soap,
		/obj/item/holosign_creator,
		/obj/item/clothing/suit/caution,
		/obj/item/forcefield_projector,
		/obj/item/key/janitor,
		/obj/item/clothing/gloves,
		/obj/item/melee/flyswatter,
		/obj/item/assembly/mousetrap,
		/obj/item/paint/paint_remover,
		/obj/item/pushbroom
		))

/obj/item/storage/belt/janitor/full/PopulateContents()
	new /obj/item/lightreplacer(src)
	new /obj/item/reagent_containers/spray/cleaner(src)
	new /obj/item/soap/nanotrasen(src)
	new /obj/item/holosign_creator(src)
	new /obj/item/melee/flyswatter(src)

/obj/item/storage/belt/plant
	name = "botanical belt"
	desc = "A belt used to hold most hydroponics supplies. Suprisingly, not green."
	icon_state = "plant"
	item_state = "plant"
	content_overlays = TRUE

/obj/item/storage/belt/plant/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.can_hold = typecacheof(list(
		/obj/item/reagent_containers/spray/plantbgone,
		/obj/item/plant_analyzer,
		/obj/item/seeds,
		/obj/item/reagent_containers/glass/bottle,
		/obj/item/reagent_containers/glass/beaker,
		/obj/item/cultivator,
		/obj/item/reagent_containers/spray/pestspray,
		/obj/item/hatchet,
		/obj/item/shovel/spade,
		/obj/item/gun/energy/floragun
	))

/obj/item/storage/belt/plant/full/PopulateContents()
	new /obj/item/plant_analyzer(src)
	new /obj/item/cultivator(src)
	new /obj/item/hatchet(src)
	new /obj/item/shovel/spade(src)
	new /obj/item/reagent_containers/spray/pestspray(src)
	new /obj/item/reagent_containers/spray/plantbgone(src)

/obj/item/storage/belt/bandolier
	name = "bandolier"
	desc = "A bandolier for holding ammunition. Does not hold magazines."
	icon_state = "bandolier"
	item_state = "bandolier"

/obj/item/storage/belt/bandolier/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 40
	STR.max_combined_w_class = 40
	STR.display_numerical_stacking = TRUE
	STR.set_holdable(list(
		/obj/item/ammo_casing
		))

/obj/item/storage/belt/bandolier/examine(mob/user)
	. = ..()
	. += span_notice("The bandolier can be directly loaded by clicking on it with an ammo box.")

/obj/item/storage/belt/fannypack
	name = "fannypack"
	desc = "A dorky fannypack for keeping small items in."
	icon_state = "fannypack_leather"
	item_state = "fannypack_leather"
	dying_key = DYE_REGISTRY_FANNYPACK
	custom_price = 100

/obj/item/storage/belt/fannypack/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 3
	STR.max_w_class = WEIGHT_CLASS_SMALL

/obj/item/storage/belt/fannypack/black
	name = "black fannypack"
	icon_state = "fannypack_black"
	item_state = "fannypack_black"

/obj/item/storage/belt/fannypack/red
	name = "red fannypack"
	icon_state = "fannypack_red"
	item_state = "fannypack_red"

/obj/item/storage/belt/fannypack/purple
	name = "purple fannypack"
	icon_state = "fannypack_purple"
	item_state = "fannypack_purple"

/obj/item/storage/belt/fannypack/blue
	name = "blue fannypack"
	icon_state = "fannypack_blue"
	item_state = "fannypack_blue"

/obj/item/storage/belt/fannypack/orange
	name = "orange fannypack"
	icon_state = "fannypack_orange"
	item_state = "fannypack_orange"

/obj/item/storage/belt/fannypack/white
	name = "white fannypack"
	icon_state = "fannypack_white"
	item_state = "fannypack_white"

/obj/item/storage/belt/fannypack/green
	name = "green fannypack"
	icon_state = "fannypack_green"
	item_state = "fannypack_green"

/obj/item/storage/belt/fannypack/pink
	name = "pink fannypack"
	icon_state = "fannypack_pink"
	item_state = "fannypack_pink"

/obj/item/storage/belt/fannypack/cyan
	name = "cyan fannypack"
	icon_state = "fannypack_cyan"
	item_state = "fannypack_cyan"

/obj/item/storage/belt/fannypack/yellow
	name = "yellow fannypack"
	icon_state = "fannypack_yellow"
	item_state = "fannypack_yellow"

/obj/item/storage/belt/fannypack/bustin
	name = "exterminator's belt"
	desc = " "
	icon_state = "bustinbelt"
	item_state = "bustinbelt"

/obj/item/storage/belt/sabre
	name = "sabre sheath"
	desc = "An ornate sheath designed to hold an officer's blade."
	icon_state = "sheath"
	item_state = "sheath"
	base_icon_state = "sheath"
	w_class = WEIGHT_CLASS_BULKY
	var/sabre_type = /obj/item/melee/sword/sabre

/obj/item/storage/belt/sabre/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.use_sound = null //if youre wondering why this is null, its so you can look in your sheath to prepare to draw, without letting anyone know youre preparing to draw it
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.quickdraw = TRUE
	STR.set_holdable(list(
		sabre_type
		))

/obj/item/storage/belt/sabre/examine(mob/user)
	. = ..()
	if(length(contents))
		. += span_notice("Right-click it to quickly draw the blade.")

/obj/item/storage/belt/sabre/attack_hand_secondary(mob/user, list/modifiers)
	if(length(contents))
		var/obj/item/I = contents[1]
		user.visible_message(span_notice("[user] takes [I] out of [src]."), span_notice("You take [I] out of [src]."))
		user.put_in_hands(I)
		update_appearance()
	else
		to_chat(user, span_warning("[src] is empty!"))
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/storage/belt/sabre/update_icon_state()
	icon_state = "[base_icon_state]"
	item_state = "[base_icon_state]"
	if(contents.len)
		icon_state += "-sabre"
		item_state += "-sabre"
	return ..()

/obj/item/storage/belt/sabre/PopulateContents()
	new sabre_type(src)
	update_appearance()

/obj/item/storage/belt/sabre/solgov
	name = "solarian sabre sheath"
	desc = "An ornate sheath designed to hold an officer's blade."
	base_icon_state = "sheath-solgov"
	icon_state = "sheath-solgov"
	item_state = "sheath-solgov"
	w_class = WEIGHT_CLASS_BULKY
	sabre_type = /obj/item/melee/sword/sabre/solgov

/obj/item/storage/belt/sabre/suns
	name = "SUNS sabre sheath"
	desc = "A leather sheath designed to hold a blade."

	icon = 'icons/obj/clothing/faction/suns/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/belt.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

	base_icon_state = "suns-sheath"
	icon_state = "suns-sheath"
	item_state = "suns-sheath"
	w_class = WEIGHT_CLASS_BULKY
	sabre_type = /obj/item/melee/sword/sabre/suns

/obj/item/storage/belt/sabre/suns/captain
	name = "SUNS captain's sabre sheath"
	desc = "An elegant and impressively made leather sheath designed to hold a captain's blade."

	base_icon_state = "suns-capsheath"
	icon_state = "suns-capsheath"
	item_state = "suns-capsheath"
	w_class = WEIGHT_CLASS_BULKY
	sabre_type = /obj/item/melee/sword/sabre/suns/captain

/obj/item/storage/belt/sabre/suns/cmo
	name = "SUNS cane sheath"
	desc = "A walking cane modified to hold a thin stick sabre. It does not fit on belts, contrary to popular belief."
	slot_flags = null

	icon = 'icons/obj/clothing/faction/suns/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/suns/belt.dmi'
	lefthand_file = 'icons/mob/inhands/faction/suns/suns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/faction/suns/suns_righthand.dmi'

	base_icon_state = "suns-cane"
	icon_state = "suns-cane"
	item_state = "suns-cane"
	w_class = WEIGHT_CLASS_BULKY
	sabre_type = /obj/item/melee/sword/sabre/suns/cmo

/obj/item/storage/belt/sabre/pgf
	name = "cutlass scabbard"
	desc = "A mass produced thermoplastic-leather scabbard made to hold a boarding cutlass."
	icon = 'icons/obj/clothing/faction/gezena/belt.dmi'
	mob_overlay_icon = 'icons/mob/clothing/faction/gezena/belt.dmi'
	base_icon_state = "pgf-scabbard"
	icon_state = "pgf-scabbard"
	item_state = "pgf-scabbard"
	sabre_type = /obj/item/melee/sword/sabre/pgf

/obj/item/storage/belt/sabre/kukri
	name = "kukri sheath"
	desc = "A piece of solid, treated leather. Don't pull the kukri out unless you're itching for a fight."
	base_icon_state = "sheath_kukri"
	icon_state = "sheath_kukri"
	item_state = "sheath_kukri"
	sabre_type = /obj/item/melee/sword/kukri
