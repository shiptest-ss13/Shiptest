/datum/component/storage/concrete/pockets
	max_items = 2
	max_w_class = WEIGHT_CLASS_SMALL
	max_combined_w_class = 50
	alt_click_open = FALSE // alt-click has special interactions on a lot of clothing items and shouldn't be canceled by opening storage instead
	use_sound = null

/datum/component/storage/concrete/pockets/handle_item_insertion(obj/item/I, prevent_warning, mob/user)
	. = ..()
	if(. && silent && !prevent_warning)
		if(quickdraw)
			to_chat(user, span_notice("You discreetly slip [I] into [parent]. Right-click [parent] to remove it."))
		else
			to_chat(user, span_notice("You discreetly slip [I] into [parent]."))

/datum/component/storage/concrete/pockets/small
	max_items = 1
	max_w_class = WEIGHT_CLASS_SMALL
	attack_hand_interact = FALSE

/datum/component/storage/concrete/pockets/tiny
	max_items = 1
	max_w_class = WEIGHT_CLASS_TINY
	attack_hand_interact = FALSE

/datum/component/storage/concrete/pockets/exo
	max_items = 2
	max_w_class = WEIGHT_CLASS_SMALL
	attack_hand_interact = FALSE
	quickdraw = FALSE
	silent = FALSE

/datum/component/storage/concrete/pockets/exo/large
	max_items = 3

/datum/component/storage/concrete/pockets/small/fedora/Initialize()
	. = ..()
	var/static/list/exception_cache = typecacheof(list(
		/obj/item/toy/katana, /obj/item/melee/sword/katana,
		/obj/item/melee/sword/energy_katana, /obj/item/gun/ballistic/automatic/smg/firestorm/pan
		))
	exception_hold = exception_cache

/datum/component/storage/concrete/pockets/small/fedora/detective
	attack_hand_interact = TRUE // so the detectives would discover pockets in their hats

/datum/component/storage/concrete/pockets/shoes
	max_items = 2
	attack_hand_interact = FALSE
	max_w_class = WEIGHT_CLASS_SMALL
	quickdraw = FALSE
	silent = TRUE

/datum/component/storage/concrete/pockets/shoes/Initialize()
	. = ..()

/datum/component/storage/concrete/pockets/pocketprotector
	max_items = 3
	max_w_class = WEIGHT_CLASS_TINY
	var/atom/original_parent

/datum/component/storage/concrete/pockets/pocketprotector/Initialize()
	original_parent = parent
	. = ..()
	set_holdable(list( //Same items as a PDA
		/obj/item/pen,
		/obj/item/toy/crayon,
		/obj/item/lipstick,
		/obj/item/flashlight/pen,
		/obj/item/clothing/mask/cigarette)
		)

/datum/component/storage/concrete/pockets/pocketprotector/real_location()
	// if the component is reparented to a jumpsuit, the items still go in the protector
	return original_parent

/datum/component/storage/concrete/pockets/helmet
	quickdraw = TRUE
	max_combined_w_class = 6

/datum/component/storage/concrete/pockets/helmet/Initialize()
	. = ..()
	set_holdable(list(
		/obj/item/clothing/glasses/cold,
		/obj/item/clothing/glasses/heat,
		/obj/item/clothing/glasses/safety,
		/obj/item/clothing/glasses/welding,
		/obj/item/clothing/glasses/meson,
		/obj/item/clothing/glasses/thermal,
		/obj/item/clothing/glasses/night,
		/obj/item/clothing/glasses/hud/health/night,
		/obj/item/clothing/glasses/hud/security/night,
		/obj/item/clothing/glasses/hud/security/sunglasses/inteq,
		/obj/item/clothing/glasses/sunglasses/ballistic,
		/obj/item/clothing/glasses/sunglasses/pgf,
		/obj/item/clothing/glasses/hud/security/sunglasses/ngr,
		/obj/item/clothing/glasses/hud/security/sunglasses/hardliners,
		/obj/item/clothing/glasses/hud/security/sunglasses/ramzi,
		/obj/item/ammo_casing,
		/obj/item/ammo_box/magazine/illestren_a850r,
		/obj/item/bodycamera,
	))

/datum/component/storage/concrete/pockets/holster
	max_items = 3
	max_w_class = WEIGHT_CLASS_NORMAL
	var/atom/original_parent

/datum/component/storage/concrete/pockets/holster/Initialize()
	original_parent = parent
	. = ..()
	can_hold = typecacheof(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/laser,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/sharplite/x26,
		/obj/item/gun/energy/kalix/pistol,
		/obj/item/stock_parts/cell/gun,
		/obj/item/ammo_box)) // this doesnt let you put hades into holsters trust me
	can_hold_max_of_items = typecacheof(list(
		/obj/item/gun = 1,
	))

/datum/component/storage/concrete/pockets/holster/real_location()
	// if the component is reparented to a jumpsuit, the items still go in the protector
	return original_parent

/datum/component/storage/concrete/pockets/holster/detective/Initialize()
	original_parent = parent
	. = ..()
	can_hold = typecacheof(list(
		/obj/item/gun/ballistic/revolver/detective,
		/obj/item/ammo_box/c38))

/datum/component/storage/concrete/pockets/holster/nukie
	max_items = 2
	max_w_class = WEIGHT_CLASS_BULKY

/datum/component/storage/concrete/pockets/holster/nukie/Initialize()
	original_parent = parent
	. = ..()
	can_hold = typecacheof(list(
		/obj/item/gun/ballistic/automatic,
		/obj/item/gun/ballistic/revolver,
		/obj/item/gun/energy/sharplite/x26,
		/obj/item/gun/energy/disabler,
		/obj/item/gun/energy/pulse/carbine,
		/obj/item/gun/energy/dueling,
		/obj/item/gun/ballistic/shotgun,
		/obj/item/gun/ballistic/rocketlauncher))
