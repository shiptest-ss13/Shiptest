GLOBAL_LIST_INIT(rod_recipes, list ( \
	new/datum/stack_recipe("grille", /obj/structure/grille, 2, time = 10, one_per_turf = TRUE, on_floor = FALSE), \
	new/datum/stack_recipe("table frame", /obj/structure/table_frame, 2, time = 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("scooter frame", /obj/item/scooter_frame, 10, time = 25, one_per_turf = 0), \
	new/datum/stack_recipe("linen bin", /obj/structure/bedsheetbin/empty, 2, time = 5, one_per_turf = 0), \
	new/datum/stack_recipe("railing", /obj/structure/railing, 3, time = 18, window_checks = TRUE), \
	new/datum/stack_recipe("railing corner", /obj/structure/railing/corner, 1, time = 10, window_checks = TRUE), \
	new/datum/stack_recipe("modern railing", /obj/structure/railing/modern, 3, time = 18, window_checks = TRUE), \
	new/datum/stack_recipe("modern railing corner", /obj/structure/railing/modern/corner, 1, time = 10, window_checks = TRUE), \
	new/datum/stack_recipe("modern railing end", /obj/structure/railing/modern/end, 3, time = 18, window_checks = TRUE), \
	new/datum/stack_recipe("thin railing", /obj/structure/railing/thin, 3, time = 18, window_checks = TRUE), \
	new/datum/stack_recipe("thin railing corner", /obj/structure/railing/thin/corner, 1, time = 10, window_checks = TRUE), \
	new/datum/stack_recipe("thick railing", /obj/structure/railing/thick, 3, time = 18, window_checks = TRUE), \
	new/datum/stack_recipe("thick railing corner", /obj/structure/railing/thick/corner, 1, time = 10, window_checks = TRUE), \
	new/datum/stack_recipe("ladder", /obj/structure/ladder/crafted, 15, time = 150, one_per_turf = TRUE, on_floor = FALSE), \
	new/datum/stack_recipe("handrail", /obj/structure/chair/handrail, 4, time = 15, one_per_turf = TRUE), \
	))

/obj/item/stack/rods
	name = "metal rod"
	desc = "Some rods. Can be used for building or something."
	singular_name = "metal rod"
	icon_state = "rods"
	item_state = "rods"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	force = 9
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=1000)
	max_amount = 50
	attack_verb = list("hit", "bludgeoned", "whacked")
	hitsound = 'sound/weapons/gun/general/grenade_launch.ogg'
	embedding = list()
	novariants = TRUE

/obj/item/stack/rods/Initialize(mapload, new_amount, merge = TRUE)
	. = ..()
	update_appearance()

/obj/item/stack/rods/get_main_recipes()
	. = ..()
	. += GLOB.rod_recipes

/obj/item/stack/rods/update_icon_state()
	. = ..()
	var/amount = get_amount()
	if(amount <= 5)
		icon_state = "rods-[amount]"
	else
		icon_state = "rods"

/obj/item/stack/rods/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WELDER)
		if(get_amount() < 2)
			to_chat(user, span_warning("You need at least two rods to do this!"))
			return

		if(W.use_tool(src, user, 0, volume=40))
			var/obj/item/stack/sheet/metal/new_item = new(usr.loc)
			user.visible_message(
				span_notice("[user.name] shaped [src] into metal with [W]."), \
				span_notice("You shape [src] into metal with [W]."), \
				span_hear("You hear welding."))
			var/obj/item/stack/rods/R = src
			src = null
			var/replace = (user.get_inactive_held_item()==R)
			R.use(2)
			if (!R && replace)
				user.put_in_hands(new_item)
	else
		return ..()

/obj/item/stack/rods/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250

/obj/item/stack/rods/cyborg/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/stack/rods/ten
	amount = 10

/obj/item/stack/rods/twentyfive
	amount = 25

/obj/item/stack/rods/fifty
	amount = 50
