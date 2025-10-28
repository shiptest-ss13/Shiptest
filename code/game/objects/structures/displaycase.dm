/obj/structure/displaycase
	name = "display case"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "glassbox0"
	desc = "A display case for prized possessions."
	density = TRUE
	anchored = TRUE
	resistance_flags = ACID_PROOF
	armor = list("melee" = 30, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 70, "acid" = 100)
	max_integrity = 200
	integrity_failure = 0.25
	var/obj/item/showpiece = null
	var/obj/item/showpiece_type = null //This allows for showpieces that can only hold items if they're the same istype as this.
	var/alert = TRUE
	var/open = FALSE
	var/openable = TRUE
	var/obj/item/electronics/airlock/electronics
	var/start_showpiece_type = null //add type for items on display
	var/list/start_showpieces = list() //Takes sublists in the form of list("type" = /obj/item/bikehorn, "trophy_message" = "henk")
	var/trophy_message = ""
	var/glass_fix = TRUE

/obj/structure/displaycase/Initialize()
	. = ..()
	if(start_showpieces.len && !start_showpiece_type)
		var/list/showpiece_entry = pick(start_showpieces)
		if (showpiece_entry && showpiece_entry["type"])
			start_showpiece_type = showpiece_entry["type"]
			if (showpiece_entry["trophy_message"])
				trophy_message = showpiece_entry["trophy_message"]
	if(start_showpiece_type)
		showpiece = new start_showpiece_type (src)
	update_appearance()

/obj/structure/displaycase/Destroy()
	if(electronics)
		QDEL_NULL(electronics)
	if(showpiece)
		QDEL_NULL(showpiece)
	return ..()

/obj/structure/displaycase/examine(mob/user)
	. = ..()
	if(alert)
		. += span_notice("Hooked up with an anti-theft system.")
	if(showpiece)
		. += span_notice("There's [showpiece] inside.")
	if(trophy_message)
		. += "The plaque reads:\n [trophy_message]"


/obj/structure/displaycase/proc/dump()
	if (showpiece)
		showpiece.forceMove(loc)
		showpiece = null

/obj/structure/displaycase/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(src.loc, 'sound/effects/glasshit.ogg', 75, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/displaycase/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		dump()
		if(!disassembled)
			new /obj/item/shard(src.loc)
			trigger_alarm()
	qdel(src)

/obj/structure/displaycase/atom_break(damage_flag)
	if(!broken && !(flags_1 & NODECONSTRUCT_1))
		density = FALSE
		broken = 1
		new /obj/item/shard(src.loc)
		playsound(src, "shatter", 70, TRUE)
		update_appearance()
		trigger_alarm()
	. = ..()

/obj/structure/displaycase/proc/trigger_alarm()
	//Activate Anti-theft
	if(alert)
		var/area/alarmed = get_area(src)
		alarmed.burglaralert(src)
		playsound(src, 'sound/effects/alert.ogg', 50, TRUE)

/obj/structure/displaycase/update_appearance()
	var/icon/I
	if(open)
		I = icon('icons/obj/stationobjs.dmi',"glassbox_open")
	else
		I = icon('icons/obj/stationobjs.dmi',"glassbox0")
	if(broken)
		I = icon('icons/obj/stationobjs.dmi',"glassboxb0")
	if(showpiece)
		var/icon/S = getFlatIcon(showpiece)
		S.Scale(17,17)
		I.Blend(S,ICON_UNDERLAY,8,8)
	src.icon = I
	return ..()

/obj/structure/displaycase/attackby(obj/item/W, mob/user, params)
	if(W.GetID() && !broken && openable)
		if(allowed(user))
			to_chat(user,  span_notice("You [open ? "close":"open"] [src]."))
			toggle_lock(user)
		else
			to_chat(user,  span_alert("Access denied."))
	else if(W.tool_behaviour == TOOL_WELDER && user.a_intent == INTENT_HELP && !broken)
		if(atom_integrity < max_integrity)
			if(!W.tool_start_check(user, src, amount=5))
				return

			to_chat(user, span_notice("You begin repairing [src]..."))
			if(W.use_tool(src, user, 40, amount=5, volume=50))
				atom_integrity = max_integrity
				update_appearance()
				to_chat(user, span_notice("You repair [src]."))
		else
			to_chat(user, span_warning("[src] is already in good condition!"))
		return
	else if(!alert && W.tool_behaviour == TOOL_CROWBAR && openable) //Only applies to the lab cage and player made display cases
		if(broken)
			if(showpiece)
				to_chat(user, span_warning("Remove the displayed object first!"))
			else
				to_chat(user, span_notice("You remove the destroyed case."))
				qdel(src)
		else
			to_chat(user, span_notice("You start to [open ? "close":"open"] [src]..."))
			if(W.use_tool(src, user, 20))
				to_chat(user,  span_notice("You [open ? "close":"open"] [src]."))
				toggle_lock(user)
	else if(open && !showpiece)
		if(showpiece_type && !istype(W, showpiece_type))
			to_chat(user, span_notice("This doesn't belong in this kind of display."))
			return TRUE
		if(user.transferItemToLoc(W, src))
			showpiece = W
			to_chat(user, span_notice("You put [W] on display."))
			update_appearance()
	else if(glass_fix && broken && istype(W, /obj/item/stack/sheet/glass))
		var/obj/item/stack/sheet/glass/G = W
		if(G.get_amount() < 2)
			to_chat(user, span_warning("You need two glass sheets to fix the case!"))
			return
		to_chat(user, span_notice("You start fixing [src]..."))
		if(do_after(user, 20, target = src))
			G.use(2)
			broken = 0
			atom_integrity = max_integrity
			update_appearance()
	else
		return ..()

/obj/structure/displaycase/proc/toggle_lock(mob/user)
	open = !open
	update_appearance()

/obj/structure/displaycase/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/displaycase/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if (showpiece && (broken || open))
		to_chat(user, span_notice("You deactivate the hover field built into the case."))
		log_combat(user, src, "deactivates the hover field of")
		dump()
		src.add_fingerprint(user)
		update_appearance()
		return
	else
		//prevents remote "kicks" with TK
		if (!Adjacent(user))
			return
		if (user.a_intent == INTENT_HELP)
			user.examinate(src)
			return
		user.visible_message(span_danger("[user] kicks the display case."), null, null, COMBAT_MESSAGE_RANGE)
		log_combat(user, src, "kicks")
		user.do_attack_animation(src, ATTACK_EFFECT_KICK)
		take_damage(2)

/obj/structure/displaycase/broken
	name = "broken display case"
	desc = "A display case for prized possessions. Or at least it was, until someone smashed it open."
	broken = 1

/obj/structure/displaycase_chassis
	anchored = TRUE
	density = FALSE
	name = "display case chassis"
	desc = "The wooden base of a display case."
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "glassbox_chassis"
	var/obj/item/electronics/airlock/electronics


/obj/structure/displaycase_chassis/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WRENCH) //The player can only deconstruct the wooden frame
		to_chat(user, span_notice("You start disassembling [src]..."))
		I.play_tool_sound(src)
		if(I.use_tool(src, user, 30))
			playsound(src.loc, 'sound/items/deconstruct.ogg', 50, TRUE)
			new /obj/item/stack/sheet/mineral/wood(get_turf(src), 5)
			qdel(src)

	else if(istype(I, /obj/item/electronics/airlock))
		to_chat(user, span_notice("You start installing the electronics into [src]..."))
		I.play_tool_sound(src)
		if(do_after(user, 30, target = src) && user.transferItemToLoc(I,src))
			electronics = I
			to_chat(user, span_notice("You install the airlock electronics."))

	else if(istype(I, /obj/item/stock_parts/card_reader))
		var/obj/item/stock_parts/card_reader/C = I
		to_chat(user, span_notice("You start adding [C] to [src]..."))
		if(do_after(user, 20, target = src))
			var/obj/structure/displaycase/forsale/sale = new(src.loc)
			if(electronics)
				electronics.forceMove(sale)
				sale.electronics = electronics
				if(electronics.one_access)
					sale.req_one_access = electronics.accesses
				else
					sale.req_access = electronics.accesses
			qdel(src)
			qdel(C)

	else if(istype(I, /obj/item/stack/sheet/glass))
		var/obj/item/stack/sheet/glass/G = I
		if(G.get_amount() < 10)
			to_chat(user, span_warning("You need ten glass sheets to do this!"))
			return
		to_chat(user, span_notice("You start adding [G] to [src]..."))
		if(do_after(user, 20, target = src))
			G.use(10)
			var/obj/structure/displaycase/noalert/display = new(src.loc)
			if(electronics)
				electronics.forceMove(display)
				display.electronics = electronics
				if(electronics.one_access)
					display.req_one_access = electronics.accesses
				else
					display.req_access = electronics.accesses
			qdel(src)
	else
		return ..()

//The lab cage and captain's display case do not spawn with electronics, which is why req_access is needed.
/obj/structure/displaycase/captain
	start_showpiece_type = /obj/item/gun/energy/laser/captain
	req_access = list(ACCESS_CENT_SPECOPS) //this was intentional, presumably to make it slightly harder for caps to grab their gun roundstart

/obj/structure/displaycase/labcage
	name = "lab cage"
	desc = "A glass lab container for storing interesting creatures."
	start_showpiece_type = /obj/item/clothing/mask/facehugger_item/lamarr
	req_access = list(ACCESS_RD)

/obj/structure/displaycase/noalert
	alert = FALSE

/obj/structure/displaycase/trophy
	name = "trophy display case"
	desc = "Store your trophies of accomplishment in here, and they will stay forever."
	var/placer_key = ""
	var/added_roundstart = TRUE
	var/is_locked = TRUE
	integrity_failure = 0
	openable = FALSE

/obj/structure/displaycase/trophy/Initialize()
	. = ..()
	GLOB.trophy_cases += src

/obj/structure/displaycase/trophy/Destroy()
	GLOB.trophy_cases -= src
	return ..()

/obj/structure/displaycase/trophy/attackby(obj/item/W, mob/user, params)

	if(!user.Adjacent(src)) //no TK museology
		return
	if(user.a_intent == INTENT_HARM)
		return ..()

	if(user.is_holding_item_of_type(/obj/item/key/displaycase))
		if(added_roundstart)
			is_locked = !is_locked
			to_chat(user, span_notice("You [!is_locked ? "un" : ""]lock the case."))
		else
			to_chat(user, span_warning("The lock is stuck shut!"))
		return

	if(is_locked)
		to_chat(user, span_warning("The case is shut tight with an old-fashioned physical lock. Maybe you should ask the curator for the key?"))
		return

	if(!added_roundstart)
		to_chat(user, span_warning("You've already put something new in this case!"))
		return

	if(is_type_in_typecache(W, GLOB.blacklisted_cargo_types))
		to_chat(user, span_warning("The case rejects the [W]!"))
		return

	for(var/a in W.GetAllContents())
		if(is_type_in_typecache(a, GLOB.blacklisted_cargo_types))
			to_chat(user, span_warning("The case rejects the [W]!"))
			return

	if(user.transferItemToLoc(W, src))

		if(showpiece)
			to_chat(user, span_notice("You press a button, and [showpiece] descends into the floor of the case."))
			QDEL_NULL(showpiece)

		to_chat(user, span_notice("You insert [W] into the case."))
		showpiece = W
		added_roundstart = FALSE
		update_appearance()

		placer_key = user.ckey

		trophy_message = W.desc //default value

		var/chosen_plaque = stripped_input(user, "What would you like the plaque to say? Default value is item's description.", "Trophy Plaque")
		if(chosen_plaque)
			if(user.Adjacent(src))
				trophy_message = chosen_plaque
				to_chat(user, span_notice("You set the plaque's text."))
			else
				to_chat(user, span_warning("You are too far to set the plaque's text!"))

		SSpersistence.SaveTrophy(src)
		return TRUE

	else
		to_chat(user, span_warning("\The [W] is stuck to your hand, you can't put it in the [src.name]!"))

	return

/obj/structure/displaycase/trophy/dump()
	if (showpiece)
		if(added_roundstart)
			visible_message(span_danger("The [showpiece] crumbles to dust!"))
			new /obj/effect/decal/cleanable/ash(loc)
			QDEL_NULL(showpiece)
		else
			..()

/obj/item/key/displaycase
	name = "display case key"
	desc = "The key to the curator's display cases."

/obj/item/showpiece_dummy
	name = "Cheap replica"

/obj/item/showpiece_dummy/Initialize(mapload, path)
	. = ..()
	var/obj/item/I = path
	name = initial(I.name)
	icon = initial(I.icon)
	icon_state = initial(I.icon_state)

/obj/structure/displaycase/forsale
	name = "vend-a-tray"
	icon = 'icons/obj/stationobjs.dmi'
	icon_state = "laserbox0"
	desc = "A display case with an ID-card swiper. Use your ID to purchase the contents."
	density = FALSE
	max_integrity = 100
	req_access = null
	showpiece_type = /obj/item/reagent_containers/food
	alert = FALSE //No, we're not calling the fire department because someone stole your cookie.
	glass_fix = FALSE //Fixable with tools instead.
	///The price of the item being sold. Altered by grab intent ID use.
	var/sale_price = 20
	///The Account which will receive payment for purchases. Set by the first ID to swipe the tray.
	var/datum/bank_account/payments_acc = null

/obj/structure/displaycase/forsale/update_appearance()	//remind me to fix my shitcode later
	var/icon/I
	if(open)
		I = icon('icons/obj/stationobjs.dmi',"laserboxb0")
	else
		I = icon('icons/obj/stationobjs.dmi',"laserbox0")
	if(!showpiece && !open)
		I = icon('icons/obj/stationobjs.dmi',"laserbox_open")
	if(broken)
		I = icon('icons/obj/stationobjs.dmi',"laserbox_broken")
	if(showpiece)
		var/icon/S = getFlatIcon(showpiece)
		S.Scale(17,17)
		I.Blend(S,ICON_UNDERLAY,8,12)
	src.icon = I
	return ..()

/obj/structure/displaycase/forsale/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Vendatray", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/structure/displaycase/forsale/ui_data(mob/user)
	var/list/data = list()
	var/register = FALSE
	if(payments_acc)
		register = TRUE
		data["owner_name"] = payments_acc.account_holder
	if(showpiece)
		data["product_name"] = capitalize(showpiece.name)
		var/base64 = icon2base64(icon(showpiece.icon, showpiece.icon_state))
		data["product_icon"] = base64
	data["registered"] = register
	data["product_cost"] = sale_price
	data["tray_open"] = open
	return data

/obj/structure/displaycase/forsale/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/obj/item/card/bank/potential_acc = usr.get_bankcard()
	switch(action)
		if("Buy")
			if(!showpiece)
				to_chat(usr, span_notice("There's nothing for sale."))
				return TRUE
			if(broken)
				to_chat(usr, span_notice("[src] appears to be broken."))
				return TRUE
			if(!payments_acc)
				to_chat(usr, span_notice("[src] hasn't been registered yet."))
				return TRUE
			if(!usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
				return TRUE
			if(!potential_acc)
				to_chat(usr, span_notice("No ID card detected."))
				return
			var/datum/bank_account/account = potential_acc.registered_account
			if(!account)
				to_chat(usr, span_notice("[potential_acc] has no account registered!"))
				return
			if(!account.has_money(sale_price))
				to_chat(usr, span_notice("You do not possess the funds to purchase this."))
				return TRUE
			else
				payments_acc.transfer_money(account, sale_price)
				usr.put_in_hands(showpiece)
				to_chat(usr, span_notice("You purchase [showpiece] for [sale_price] credits."))
				playsound(src, 'sound/effects/cashregister.ogg', 40, TRUE)
				icon = 'icons/obj/stationobjs.dmi'
				flick("laserbox_vend", src)
				showpiece = null
				update_appearance()
				SStgui.update_uis(src)
				return TRUE
		if("Open")
			if(!payments_acc)
				to_chat(usr, span_notice("[src] hasn't been registered yet."))
				return TRUE
			if(!potential_acc || !potential_acc.registered_account)
				return
			if(!check_access(potential_acc))
				playsound(src, 'sound/machines/buzz-sigh.ogg', 50, TRUE)
				return
			toggle_lock()
			SStgui.update_uis(src)
		if("Register")
			if(payments_acc)
				return
			if(!potential_acc || !potential_acc.registered_account)
				return
			if(!check_access(potential_acc))
				playsound(src, 'sound/machines/buzz-sigh.ogg', 50, TRUE)
				return
			payments_acc = potential_acc.registered_account
			playsound(src, 'sound/machines/click.ogg', 20, TRUE)
		if("Adjust")
			if(!check_access(potential_acc) || potential_acc.registered_account != payments_acc)
				playsound(src, 'sound/machines/buzz-sigh.ogg', 50, TRUE)
				return

			var/new_price_input = input(usr,"Set the sale price for this vend-a-tray.","new price",0) as num|null
			if(isnull(new_price_input) || (payments_acc != potential_acc.registered_account))
				to_chat(usr, span_warning("[src] rejects your new price."))
				return
			if(!usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
				to_chat(usr, span_warning("You need to get closer!"))
				return
			new_price_input = clamp(round(new_price_input, 1), 10, 1000)
			sale_price = new_price_input
			to_chat(usr, span_notice("The cost is now set to [sale_price]."))
			SStgui.update_uis(src)
			return TRUE
	. = TRUE
/obj/structure/displaycase/forsale/attackby(obj/item/I, mob/living/user, params)
	if(isbankcard(I))
		//Card Registration
		var/obj/item/card/bank/potential_acc = I
		if(!potential_acc.registered_account)
			to_chat(user, span_warning("This ID card has no account registered!"))
			return
		if(payments_acc == potential_acc.registered_account)
			playsound(src, 'sound/machines/click.ogg', 20, TRUE)
			toggle_lock()
			return
	if(istype(I, /obj/item/pda))
		return TRUE
	SStgui.update_uis(src)
	. = ..()


/obj/structure/displaycase/forsale/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(atom_integrity <= (integrity_failure *  max_integrity))
		to_chat(user, span_notice("You start recalibrating [src]'s hover field..."))
		if(do_after(user, 20, target = src))
			broken = 0
			atom_integrity = max_integrity
			update_appearance()
		return TRUE

/obj/structure/displaycase/forsale/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	if(open && user.a_intent == INTENT_HELP)
		if(anchored)
			to_chat(user, span_notice("You start unsecuring [src]..."))
		else
			to_chat(user, span_notice("You start securing [src]..."))
		if(I.use_tool(src, user, 16, volume=50))
			if(QDELETED(I))
				return
			if(anchored)
				to_chat(user, span_notice("You unsecure [src]."))
			else
				to_chat(user, span_notice("You secure [src]."))
			set_anchored(!anchored)
			return
	else if(!open && user.a_intent == INTENT_HELP)
		to_chat(user, span_notice("[src] must be open to move it."))
		return

/obj/structure/displaycase/forsale/emag_act(mob/user)
	. = ..()
	payments_acc = null
	req_access = list()
	to_chat(user, span_warning("[src]'s card reader fizzles and smokes, and the account owner is reset."))

/obj/structure/displaycase/forsale/examine(mob/user)
	. = ..()
	if(showpiece && !open)
		. += span_notice("[showpiece] is for sale for [sale_price] credits.")
	if(broken)
		. += span_notice("[src] is sparking and the hover field generator seems to be overloaded. Use a multitool to fix it.")

/obj/structure/displaycase/forsale/atom_break(damage_flag)
	if(!broken && !(flags_1 & NODECONSTRUCT_1))
		broken = TRUE
		playsound(src, "shatter", 70, TRUE)
		update_appearance()
		trigger_alarm() //In case it's given an alarm anyway.
	. = ..()

/obj/structure/displaycase/forsale/kitchen
	desc = "A display case with an ID-card swiper. Use your ID to purchase the contents. Meant for the bartender and chef."
	req_access = list(ACCESS_KITCHEN)
