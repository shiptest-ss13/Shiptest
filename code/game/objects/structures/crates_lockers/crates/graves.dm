/obj/structure/closet/crate/grave
	name = "burial mound"
	desc = "A marked patch of soil, adorned with a wooden cross"
	icon_state = "grave"
	dense_when_open = TRUE
	material_drop = /obj/item/stack/ore/glass/basalt
	material_drop_amount = 5
	opened = TRUE
	anchorable = FALSE
	anchored = TRUE
	locked = TRUE
	breakout_time = 900
	cutting_tool = TOOL_SHOVEL

/obj/structure/closet/crate/grave/attackby(obj/item/W, mob/user, params)
	.=..()
	if(istype(W, /obj/item/screwdriver))
		if(!user.is_literate())
			to_chat(user, span_notice("You scratch illegibly on [src]!"))
			return
		var/t = stripped_input(user, "What would you like the inscription to be?", name, null, 53)
		if(user.get_active_held_item() != W)
			return
		if(!user.canUseTopic(src, BE_CLOSE))
			return
		if(t)
			desc = "[t]"
		return

/obj/structure/closet/crate/grave/open(mob/living/user, obj/item/S, force = FALSE)
	if(!opened)
		to_chat(user, span_notice("The ground here is too hard to dig up with your bare hands. You'll need a shovel."))
	else
		to_chat(user, span_notice("The grave has already been dug up."))

/obj/structure/closet/crate/grave/shovel_act(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(!opened) //checks to attempt to dig the grave
		if(tool.tool_behaviour == cutting_tool)
			to_chat(user, span_notice("You start start to dig open \the [src]  with \the [tool]..."))
			if(tool.use_tool(src, user, 3 SECONDS))
				opened = TRUE
				locked = TRUE
				dump_contents()
				update_appearance()
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "graverobbing", /datum/mood_event/graverobbing)
		else
			to_chat(user, span_notice("You can't dig up a grave with \the [tool.name]."))
	else if(LAZYACCESS(modifiers, RIGHT_CLICK)) //checks to attempt to remove the grave entirely.
		if(tool.tool_behaviour == cutting_tool)
			to_chat(user, span_notice("You start to remove \the [src]  with \the [tool]."))
			if(tool.use_tool(src, user, 2 SECONDS))
				to_chat(user, span_notice("You remove \the [src]  completely."))
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "graverobbing", /datum/mood_event/graverobbing)
				deconstruct(TRUE)
	else
		to_chat(user, span_notice("The grave has already been dug up."))
	return TRUE

/obj/structure/closet/crate/grave/bust_open()
	..()
	opened = TRUE
	update_appearance()
	dump_contents()
	return

/obj/structure/closet/crate/grave/stone
	name = "burial mound"
	desc = "A marked patch of soil, adorned with a sandstone slab"
	icon_state = "grave_lead"

/obj/structure/closet/crate/grave/loot
	name = "burial mound"
	desc = "A marked patch of soil, showing signs of a burial long ago. You wouldn't disturb a grave... right?"
	opened = FALSE

/obj/structure/closet/crate/grave/loot/PopulateContents()  //GRAVEROBBING IS NOW A FEATURE
	..()
	new /obj/effect/decal/remains/human/grave(src)
	switch(rand(1,7))
		if(1)
			new /obj/item/spacecash/bundle/smallrand(src)
			new /obj/item/card/id
			new /obj/item/storage/wallet(src)
		if(2)
			new /obj/item/clothing/head/papersack/smiley(src)
		if(3)
			new /obj/item/clothing/under/nanotrasen(src)
			new /obj/item/clothing/head/nanotrasen(src)
		if(4)
			new /obj/item/storage/book/bible/booze(src)
		if(5)
			new /obj/item/clothing/neck/stethoscope(src)
			new	/obj/item/scalpel(src)
			new /obj/item/hemostat(src)

		if(6)
			new /obj/item/reagent_containers/glass/beaker/large/napalm(src)
			new /obj/item/clothing/under/frontiersmen(src)
		if(7)
			new /obj/item/clothing/glasses/sunglasses(src)
			new /obj/item/clothing/mask/cigarette/rollie(src)
			new /obj/item/lighter(src)

/obj/effect/decal/remains/human/grave
	turf_loc_check = FALSE
