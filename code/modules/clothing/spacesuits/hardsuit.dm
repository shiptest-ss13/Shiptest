	//Baseline hardsuits
/obj/item/clothing/head/helmet/space/hardsuit
	name = "hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low-pressure environment. Has radiation shielding."
	icon_state = "hardsuit0-engineering"
	item_state = "eng_helm"
	max_integrity = 300
	armor = list("melee" = 10, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 50, "acid" = 75, "wound" = 20)
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 1
	light_on = FALSE
	var/basestate = "hardsuit"
	var/on = FALSE
	var/obj/item/clothing/suit/space/hardsuit/suit
	var/hardsuit_type = "engineering" //Determines used sprites: hardsuit[on]-[type]
	actions_types = list(/datum/action/item_action/toggle_helmet)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH	| PEPPERPROOF
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF | SEALS_EYES
	var/current_tick_amount = 0
	var/radiation_count = 0
	var/grace = RAD_GEIGER_GRACE_PERIOD
	var/datum/looping_sound/geiger/soundloop

	//fuck you 15 year old hardsuit code
	equip_delay_self = null
	equip_delay_other = null
	strip_delay = null

/obj/item/clothing/head/helmet/space/hardsuit/Initialize()
	. = ..()
	soundloop = new(list(), FALSE, TRUE)
	soundloop.volume = 5
	START_PROCESSING(SSobj, src)

/obj/item/clothing/head/helmet/space/hardsuit/Destroy()
	. = ..()
	if(!QDELETED(suit))
		qdel(suit)
	suit = null
	QDEL_NULL(soundloop)
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/head/helmet/space/hardsuit/attack_self(mob/user)
	on = !on
	icon_state = "[basestate][on]-[hardsuit_type]"
	user.update_inv_head()	//so our mob-overlays update

	set_light_on(on)

	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/head/helmet/space/hardsuit/dropped(mob/user)
	..()
	if(suit)
		suit.RemoveHelmet()
		soundloop.stop(user)

/obj/item/clothing/head/helmet/space/hardsuit/item_action_slot_check(slot)
	if(slot == ITEM_SLOT_HEAD)
		return 1

/obj/item/clothing/head/helmet/space/hardsuit/equipped(mob/user, slot)
	..()
	if(slot != ITEM_SLOT_HEAD)
		if(suit)
			suit.RemoveHelmet()
			soundloop.stop(user)
		else
			qdel(src)
	else
		soundloop.start(user)

/obj/item/clothing/head/helmet/space/hardsuit/proc/display_visor_message(msg)
	var/mob/wearer = loc
	if(msg && ishuman(wearer))
		wearer.show_message("[icon2html(src, wearer)]<b>[span_robot("[msg]")]</b>", MSG_VISUAL)

/obj/item/clothing/head/helmet/space/hardsuit/rad_act(amount)
	. = ..()
	if(amount <= RAD_BACKGROUND_RADIATION)
		return
	current_tick_amount += amount

/obj/item/clothing/head/helmet/space/hardsuit/process(seconds_per_tick)
	radiation_count = LPFILTER(radiation_count, current_tick_amount, seconds_per_tick, RAD_GEIGER_RC)

	if(current_tick_amount)
		grace = RAD_GEIGER_GRACE_PERIOD
	else
		grace -= seconds_per_tick
		if(grace <= 0)
			radiation_count = 0

	current_tick_amount = 0

	soundloop.last_radiation = radiation_count

/obj/item/clothing/head/helmet/space/hardsuit/emp_act(severity)
	. = ..()
	display_visor_message("[severity > 1 ? "Light" : "Strong"] electromagnetic pulse detected!")

/obj/item/clothing/suit/space/hardsuit
	name = "hardsuit"
	desc = "A special suit that protects against hazardous, low pressure environments. Has radiation shielding."
	icon_state = "hardsuit-engineering"
	item_state = "eng_hardsuit"
	max_integrity = 300
	armor = list("melee" = 10, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 50, "acid" = 75, "wound" = 20)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/t_scanner, /obj/item/construction/rcd, /obj/item/pipe_dispenser)
	siemens_coefficient = 0.5
	var/obj/item/clothing/head/helmet/space/hardsuit/helmet
	actions_types = list(/datum/action/item_action/toggle_helmet)
	var/helmettype = /obj/item/clothing/head/helmet/space/hardsuit
	var/obj/item/tank/jetpack/suit/jetpack = null
	var/hardsuit_type
	pocket_storage_component_path = FALSE
	greyscale_colors = list(list(11, 19), list(22, 12), list(16, 9))
	greyscale_icon_state = "hardsuit"

/obj/item/clothing/suit/space/hardsuit/Initialize()
	if(jetpack && ispath(jetpack))
		jetpack = new jetpack(src)
	. = ..()

/obj/item/clothing/suit/space/hardsuit/attack_self(mob/user)
	user.changeNext_move(CLICK_CD_MELEE)
	..()

/obj/item/clothing/suit/space/hardsuit/examine(mob/user)
	. = ..()
	if(!helmet && helmettype)
		. += span_notice(" The helmet on [src] seems to be malfunctioning. It's light bulb needs to be replaced.")

/obj/item/clothing/suit/space/hardsuit/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/tank/jetpack/suit))
		if(jetpack)
			to_chat(user, span_warning("[src] already has a jetpack installed."))
			return
		if(src == user.get_item_by_slot(ITEM_SLOT_OCLOTHING)) //Make sure the player is not wearing the suit before applying the upgrade.
			to_chat(user, span_warning("You cannot install the upgrade to [src] while wearing it."))
			return

		if(user.transferItemToLoc(I, src))
			jetpack = I
			to_chat(user, span_notice("You successfully install the jetpack into [src]."))
			return
	else if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(!jetpack)
			to_chat(user, span_warning("[src] has no jetpack installed."))
			return
		if(src == user.get_item_by_slot(ITEM_SLOT_OCLOTHING))
			to_chat(user, span_warning("You cannot remove the jetpack from [src] while wearing it."))
			return

		jetpack.turn_off(user)
		jetpack.forceMove(drop_location())
		jetpack = null
		to_chat(user, span_notice("You successfully remove the jetpack from [src]."))
		return
	else if(istype(I, /obj/item/light) && helmettype)
		if(src == user.get_item_by_slot(ITEM_SLOT_OCLOTHING))
			to_chat(user, span_warning("You cannot replace the bulb in the helmet of [src] while wearing it."))
			return
		if(helmet)
			to_chat(user, span_warning("The helmet of [src] does not require a new bulb."))
			return
		var/obj/item/light/L = I
		if(L.status)
			to_chat(user, span_warning("This bulb is too damaged to use as a replacement!"))
			return
		if(do_after(user, 50, src))
			qdel(I)
			helmet = new helmettype(src)
			to_chat(user, span_notice("You have successfully repaired [src]'s helmet."))
			new /obj/item/light/bulb/broken(drop_location())
	return ..()

/obj/item/clothing/suit/space/hardsuit/equipped(mob/user, slot)
	..()
	if(jetpack)
		if(slot == ITEM_SLOT_OCLOTHING)
			for(var/X in jetpack.actions)
				var/datum/action/A = X
				A.Grant(user)

/obj/item/clothing/suit/space/hardsuit/dropped(mob/user)
	..()
	if(jetpack)
		for(var/X in jetpack.actions)
			var/datum/action/A = X
			A.Remove(user)

/obj/item/clothing/suit/space/hardsuit/item_action_slot_check(slot)
	if(slot == ITEM_SLOT_OCLOTHING) //we only give the mob the ability to toggle the helmet if he's wearing the hardsuit.
		return 1

	//Engineering
/obj/item/clothing/head/helmet/space/hardsuit/engine
	name = "engineering hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low-pressure environment. Has radiation shielding."
	icon_state = "hardsuit0-engineering"
	item_state = "eng_helm"
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75, "wound" = 20)
	hardsuit_type = "engineering"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/space/hardsuit/engine
	name = "engineering hardsuit"
	desc = "A special suit that protects against hazardous, low pressure environments. Has radiation shielding."
	icon_state = "hardsuit-engineering"
	item_state = "eng_hardsuit"
	siemens_coefficient = 0
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 75, "fire" = 100, "acid" = 75, "wound" = 20)
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/engine
	resistance_flags = FIRE_PROOF

	//Atmospherics
/obj/item/clothing/head/helmet/space/hardsuit/engine/atmos
	name = "atmospherics hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low-pressure environment. Has thermal shielding."
	icon_state = "hardsuit0-atmospherics"
	item_state = "atmo_helm"
	hardsuit_type = "atmospherics"
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 25, "fire" = 100, "acid" = 75, "wound" = 20)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT

/obj/item/clothing/suit/space/hardsuit/engine/atmos
	name = "atmospherics hardsuit"
	desc = "A special suit that protects against hazardous, low pressure environments. Has thermal shielding."
	icon_state = "hardsuit-atmospherics"
	item_state = "atmo_hardsuit"
	armor = list("melee" = 30, "bullet" = 10, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 25, "fire" = 100, "acid" = 75, "wound" = 20)
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/engine/atmos


	//Chief Engineer's hardsuit
/obj/item/clothing/head/helmet/space/hardsuit/engine/elite
	name = "advanced hardsuit helmet"
	desc = "An advanced helmet designed for work in a hazardous, low pressure environment. Shines with a high polish."
	icon_state = "hardsuit0-white"
	item_state = "ce_helm"
	hardsuit_type = "white"
	armor = list("melee" = 40, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 90, "wound" = 20)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT

/obj/item/clothing/suit/space/hardsuit/engine/elite
	icon_state = "hardsuit-white"
	name = "advanced hardsuit"
	desc = "An advanced suit that protects against hazardous, low pressure environments. Shines with a high polish."
	item_state = "ce_hardsuit"
	armor = list("melee" = 40, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 90, "wound" = 20)
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/engine/elite
	jetpack = /obj/item/tank/jetpack/suit

	//Mining hardsuit
/obj/item/clothing/head/helmet/space/hardsuit/mining
	name = "frontier hardsuit helmet"
	desc = "A mass-produced, brandless helmet designed for work in hazardous, low pressure environments. Carries limited protection against a number of threats and dual floodlights."
	icon_state = "hardsuit0-mining"
	item_state = "mining_helm"
	hardsuit_type = "mining"
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	heat_protection = HEAD
	armor = list("melee" = 50, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 65, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 100, "wound" = 20)
	light_range = 7
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator)

/obj/item/clothing/suit/space/hardsuit/mining
	name = "frontier hardsuit"
	desc = "A widely-produced suit design, possessing limited shielding against a robust variety of threats, and patch points for further reinforcement."
	icon_state = "hardsuit-mining"
	item_state = "mining_hardsuit"
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 50, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 65, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 100, "wound" = 20)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/storage/bag/ore, /obj/item/pickaxe)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/mining
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	custom_price = 2000
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

	//Heavy Mining Hardsuit, bought from Cargo.
/obj/item/clothing/suit/space/hardsuit/mining/heavy
	name = "heavy mining hardsuit"
	desc = "A heavy frontier operations hardsuit, generally carried by purpose-built mining vessels travelling to highly dangerous locales. Possesses enhanced chemical and enviromental resistance, thick armor plating, and attach points for field reinforcement."
	icon_state = "hardsuit-hvymining"
	item_state = "hvymining_hardsuit"
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 65, "bullet" = 30, "laser" = 25, "energy" = 30, "bomb" = 70, "bio" = 100, "rad" = 85, "fire" = 100, "acid" = 100, "wound" = 30)
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/storage/bag/ore, /obj/item/pickaxe)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/mining/heavy
	custom_price = 4500

/obj/item/clothing/head/helmet/space/hardsuit/mining/heavy
	name = "heavy mining helmet"
	desc = "The helmet for a heavy frontier operations hardsuit. Though somewhat cramped, it offers advanced braincase protection against a variety of dangers common to far frontier orebreaking work."
	icon_state = "hardsuit0-hvymining"
	item_state = "hvymining_helm"
	hardsuit_type = "hvymining"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 65, "bullet" = 30, "laser" = 25, "energy" = 30, "bomb" = 70, "bio" = 100, "rad" = 85, "fire" = 100, "acid" = 100, "wound" = 30)
	light_range = 10

	//NS hardsuit
/obj/item/clothing/suit/space/hardsuit/mining/heavy/ns
	name = "N+S mining hardsuit"
	desc = "An N+S brand heavy hardsuit. The armor is slightly cumbersome, with a tag inside the suit rating it for major impacts, atmospheric hazards, and various acids."
	icon_state = "ns-hardsuit-mining"
	item_state = "ns-hardsuit-mining"
	slowdown = 0.7
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/mining/heavy/ns
	hardsuit_type = "nsmining"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 65, "bullet" = 30, "laser" = 25, "energy" = 30, "bomb" = 70, "bio" = 100, "rad" = 85, "fire" = 100, "acid" = 100)
	supports_variations = KEPORI_VARIATION

/obj/item/clothing/head/helmet/space/hardsuit/mining/heavy/ns
	name = "N+S mining hardsuit helmet"
	desc = "An N+S brand heavy hardsuit. The helmet itself is spacious and thick, rated for major impacts, atmospheric hazards, and various acids."
	icon_state = "hardsuit0-nsmining"
	item_state = "hardsuit0-nsmining"
	hardsuit_type = "nsmining"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 65, "bullet" = 30, "laser" = 25, "energy" = 30, "bomb" = 70, "bio" = 100, "rad" = 85, "fire" = 100, "acid" = 100)
	supports_variations = KEPORI_VARIATION

	//Syndicate hardsuit
/obj/item/clothing/head/helmet/space/hardsuit/syndi
	name = "blood-red hardsuit helmet"
	desc = "A dual-mode advanced hardsuit designed for special combat operations. It is in EVA mode. Produced by the Gorlex Marauders."
	alt_desc = "A dual-mode advanced hardsuit designed for special combat operations. It is in travel mode. Produced by the Gorlex Marauders."
	icon_state = "hardsuit1-syndi"
	item_state = "syndie_helm"
	hardsuit_type = "syndi"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 90, "wound" = 30)
	on = FALSE
	var/obj/item/clothing/suit/space/hardsuit/syndi/linkedsuit = null
	actions_types = list(/datum/action/item_action/toggle_helmet_mode,/datum/action/item_action/toggle_helmet_light)
	visor_flags_inv = HIDEMASK|HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDEEARS
	visor_flags = STOPSPRESSUREDAMAGE
	var/full_retraction = FALSE //whether or not our full face is revealed or not during combat mode
	var/eva_mode = TRUE

	kepori_override_icon = 'icons/mob/clothing/head/spacesuits_kepori.dmi'
	supports_variations = KEPORI_VARIATION | VOX_VARIATION

/obj/item/clothing/head/helmet/space/hardsuit/syndi/update_icon_state()
	icon_state = "hardsuit[eva_mode]-[hardsuit_type]"
	return ..()

/obj/item/clothing/head/helmet/space/hardsuit/syndi/Initialize()
	. = ..()
	if(istype(loc, /obj/item/clothing/suit/space/hardsuit/syndi))
		linkedsuit = loc

/obj/item/clothing/head/helmet/space/hardsuit/syndi/attack_self(mob/user)
	on = !on
	set_light_on(on)

/obj/item/clothing/head/helmet/space/hardsuit/syndi/proc/toggle_mode(mob/user) //Toggle Helmet
	if(!isturf(user.loc))
		to_chat(user, span_notice("You cannot toggle your helmet while in this [user.loc]!"))
		return
	eva_mode = !eva_mode
	if(eva_mode || force)
		to_chat(user, span_notice("You switch your hardsuit to EVA mode, sealing your visor and protecting you from space."))
		name = initial(name)
		desc = initial(desc)
		clothing_flags |= visor_flags
		cold_protection |= HEAD
		if(full_retraction)
			flags_cover |= HEADCOVERSEYES | HEADCOVERSMOUTH
		else
			flags_cover |= HEADCOVERSMOUTH
		flags_inv |= visor_flags_inv
	else
		to_chat(user, span_notice("You switch your hardsuit to travel mode, opening your visor and exposing you to environmental conditions."))
		name += " (travel)"
		desc = alt_desc
		clothing_flags &= ~visor_flags
		cold_protection &= ~HEAD
		if(full_retraction)
			flags_cover &= ~(HEADCOVERSEYES | HEADCOVERSMOUTH)
		else
			flags_cover &= ~(HEADCOVERSMOUTH)
		flags_inv &= ~visor_flags_inv
	update_appearance()
	playsound(src.loc, 'sound/mecha/mechmove03.ogg', 50, TRUE)
	toggle_hardsuit_mode(user)
	user.update_inv_head()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.head_update(src, forced = 1)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/head/helmet/space/hardsuit/syndi/proc/toggle_hardsuit_mode(mob/user) //Helmet Toggles Suit Mode
	if(linkedsuit)
		if(eva_mode)
			linkedsuit.name = initial(linkedsuit.name)
			linkedsuit.desc = initial(linkedsuit.desc)
			linkedsuit.clothing_flags |= STOPSPRESSUREDAMAGE
			linkedsuit.cold_protection |= CHEST | GROIN | LEGS | FEET | ARMS | HANDS
		else
			linkedsuit.name += " (travel)"
			linkedsuit.desc = linkedsuit.alt_desc
			linkedsuit.clothing_flags &= ~STOPSPRESSUREDAMAGE
			linkedsuit.cold_protection &= ~(CHEST | GROIN | LEGS | FEET | ARMS | HANDS)
			if(linkedsuit.lightweight)
				linkedsuit.flags_inv &= ~(HIDEGLOVES | HIDESHOES | HIDEJUMPSUIT)

		linkedsuit.icon_state = "hardsuit[eva_mode]-[hardsuit_type]"
		linkedsuit.update_appearance()
		user.update_inv_wear_suit()
		user.update_inv_w_uniform()
		user.update_equipment_speed_mods()


/obj/item/clothing/suit/space/hardsuit/syndi
	name = "blood-red hardsuit"
	desc = "A dual-mode advanced hardsuit designed for special combat operations. It is in EVA mode. Produced by the Gorlex Marauders."
	alt_desc = "A dual-mode advanced hardsuit designed for special combat operations. It is in travel mode. Produced by the Gorlex Marauders."
	icon_state = "hardsuit1-syndi"
	item_state = "syndie_hardsuit"
	hardsuit_type = "syndi"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 50, "acid" = 90, "wound" = 30)
	allowed = list(/obj/item/gun, /obj/item/ammo_box,/obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi
	jetpack = /obj/item/tank/jetpack/suit
	slowdown = 0.5
	var/lightweight = 0 //used for flags when toggling

	kepori_override_icon = 'icons/mob/clothing/suits/spacesuits_kepori.dmi'
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION | KEPORI_VARIATION

//Mayor's Suit

/obj/item/clothing/suit/space/hardsuit/syndi/old
	name = "worn blood-red hardsuit"
	desc = "A dual-mode, once advanced hardsuit designed for special combat operations. So severely damaged, it is no longer spaceproof. It is in 'EVA' mode. Produced by the Gorlex Marauders."
	alt_desc = "A dual-mode, once advanced hardsuit designed for special combat operations. So severely damaged, it is no longer spaceproof. It is in travel mode. Produced by the Gorlex Marauders."
	icon_state = "hardsuit1-old"
	item_state = "old_syndie_hardsuit"
	hardsuit_type = "old"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/old
	armor = list("melee" = 35, "bullet" = 40, "laser" = 20,"energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	slowdown = 1
	jetpack = null
	supports_variations = KEPORI_VARIATION

/obj/item/clothing/head/helmet/space/hardsuit/syndi/old
	name = "worn blood-red hardsuit helmet"
	desc = "A dual-mode, once advanced hardsuit helmet designed for special combat operations. So severely damaged, it is no longer spaceproof. It is in 'EVA' mode. Produced by the Gorlex Marauders."
	alt_desc = "A dual-mode, once advanced hardsuit helmet designed for special combat operations. So severely damaged, it is no longer spaceproof. It is in travel mode. Produced by the Gorlex Marauders."
	icon_state = "hardsuit1-old"
	item_state = "old_syndie_helm"
	hardsuit_type = "old"
	supports_variations = KEPORI_VARIATION

//Elite Syndie suit
/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite
	name = "elite syndicate hardsuit helmet"
	desc = "An elite version of the syndicate helmet, with improved armour and fireproofing. It is in EVA mode. Property of Gorlex Marauders."
	alt_desc = "An elite version of the syndicate helmet, with improved armour and fireproofing. It is in travel mode. Property of Gorlex Marauders."
	icon_state = "hardsuit0-syndielite"
	hardsuit_type = "syndielite"
	armor = list("melee" = 60, "bullet" = 60, "laser" = 50, "energy" = 60, "bomb" = 55, "bio" = 100, "rad" = 70, "fire" = 100, "acid" = 100, "wound" = 50)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	full_retraction = TRUE

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/debug

/obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/debug/Initialize()
	. = ..()
	soundloop.volume = 0

/obj/item/clothing/suit/space/hardsuit/syndi/elite
	name = "elite syndicate hardsuit"
	desc = "An elite version of the syndicate hardsuit, with improved armour and fireproofing. It is in EVA mode."
	alt_desc = "An elite version of the syndicate hardsuit, with improved armour and fireproofing. It is in travel mode."
	icon_state = "hardsuit0-syndielite"
	item_state = "elitesyndie_hardsuit"
	hardsuit_type = "syndielite"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite
	armor = list("melee" = 60, "bullet" = 60, "laser" = 50, "energy" = 60, "bomb" = 55, "bio" = 100, "rad" = 70, "fire" = 100, "acid" = 100, "wound" = 50)
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/suit/space/hardsuit/syndi/elite/debug
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/elite/debug
	slowdown = 0

//Cybersun Hardsuit
/obj/item/clothing/suit/space/hardsuit/syndi/cybersun
	name = "neutron-star combat hardsuit"
	desc = "Designed with fighting Nanotrasen weapons in mind, the Cybersun combat hardsuit trades ballistic and blunt protection for top grade laser protection. It is in EVA mode. Produced by Cybersun Industries."
	alt_desc = "Designed with fighting Nanotrasen weapons in mind, the Cybersun combat hardsuit trades ballistic and blunt protection for top grade laser protection. It is in travel mode. Produced by Cybersun Industries."
	icon_state = "hardsuit1-cybersun"
	hardsuit_type = "cybersun"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 50, "energy" = 50, "bomb" = 25, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 60, "wound" = 30)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/cybersun
	supports_variations = VOX_VARIATION | KEPORI_VARIATION

/obj/item/clothing/head/helmet/space/hardsuit/syndi/cybersun
	name = "neutron-star combat hardsuit helmet"
	desc = "Designed with fighting Nanotrasen weapons in mind, the Cybersun combat hardsuit trades ballistic and blunt protection for top grade laser protection. It is in EVA mode. Produced by Cybersun Industries."
	alt_desc = "Designed with fighting Nanotrasen weapons in mind, the Cybersun combat hardsuit trades ballistic and blunt protection for top grade laser protection. It is in travel mode. Produced by Cybersun Industries."
	icon_state = "hardsuit1-cybersun"
	hardsuit_type = "cybersun"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 50, "energy" = 50, "bomb" = 25, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 60, "wound" = 30)

//Cybersun Medical Techinician Hardsuit
/obj/item/clothing/suit/space/hardsuit/syndi/cybersun/paramed
	name = "cybersun medical technician hardsuit"
	desc = "A stripped down version of the neutron-star hardsuit for use by medical technicians. It is in EVA mode. Produced by Cybersun Industries."
	alt_desc = "A stripped down version of the neutron-star hardsuit for use by medical technicians. It is in travel mode. Produced by Cybersun Industries."
	icon_state = "hardsuit1-cyberparamed"
	hardsuit_type = "cyberparamed"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 35, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 65, "fire" = 75, "acid" = 40, "wound" = 20)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/syndi/cybersun/paramed
	jetpack = null

/obj/item/clothing/head/helmet/space/hardsuit/syndi/cybersun/paramed
	name = "cybersun medical technician hardsuit helmet"
	desc = "A stripped down version of the neutron-star hardsuit for use by medical technicians. It is in EVA mode. Produced by Cybersun Industries."
	alt_desc = "A stripped down version of the neutron-star hardsuit for use by medical technicians. It is in travel mode. Produced by Cybersun Industries"
	icon_state = "hardsuit1-cyberparamed"
	hardsuit_type = "cyberparamed"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 35, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 65, "fire" = 75, "acid" = 40, "wound" = 20)

	//Medical hardsuit
/obj/item/clothing/head/helmet/space/hardsuit/medical
	name = "medical hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low pressure environment. Built with lightweight materials for extra comfort, but does not protect the eyes from intense light."
	icon_state = "hardsuit0-medical"
	item_state = "medical_helm"
	hardsuit_type = "medical"
	flash_protect = FLASH_PROTECTION_NONE
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75, "wound" = 20)
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SCAN_REAGENTS | SNUG_FIT | BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS //WS Port - Cit Internals

/obj/item/clothing/suit/space/hardsuit/medical
	name = "medical hardsuit"
	desc = "A special suit that protects against hazardous, low pressure environments. Built with lightweight materials for easier movement."
	icon_state = "hardsuit-medical"
	item_state = "medical_hardsuit"
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/storage/firstaid, /obj/item/healthanalyzer, /obj/item/stack/medical)
	armor = list("melee" = 30, "bullet" = 5, "laser" = 10, "energy" = 20, "bomb" = 10, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 75, "wound" = 20)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/medical
	slowdown = 0.3
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/head/helmet/space/hardsuit/medical/cmo
	name = "chief medical officer's hardsuit helmet"
	desc = "A special helmet designed for work in a hazardous, low pressure environment. Built with lightweight materials for extra comfort and protects the eyes from intense light."
	flash_protect = 2

/obj/item/clothing/suit/space/hardsuit/medical/cmo
	name = "chief medical officer's hardsuit"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/medical/cmo

	//Research Director hardsuit
/obj/item/clothing/head/helmet/space/hardsuit/bomb
	name = "EOD hardsuit helmet"
	desc = "A bulky helmet designed for hazardous, low pressure environments. Fitted with extensive plating for handling of explosives and shrapnel. The difference between a closed and open-casket."
	icon_state = "hardsuit0-eod"
	hardsuit_type = "eod"
	resistance_flags = ACID_PROOF | FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	armor = list("melee" = 30, "bullet" = 40, "laser" = 10, "energy" = 20, "bomb" = 100, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 80, "wound" = 40)
	var/explosion_detection_dist = 21
	clothing_flags = STOPSPRESSUREDAMAGE | THICKMATERIAL | SCAN_REAGENTS | SNUG_FIT | BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS //WS Port - Cit Internals
	actions_types = list(/datum/action/item_action/toggle_helmet_light, /datum/action/item_action/toggle_research_scanner)

/obj/item/clothing/head/helmet/space/hardsuit/bomb/Initialize()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_EXPLOSION, PROC_REF(sense_explosion))

/obj/item/clothing/head/helmet/space/hardsuit/bomb/equipped(mob/living/carbon/human/user, slot)
	..()
	if (slot == ITEM_SLOT_HEAD)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_DIAGNOSTIC_BASIC]
		DHUD.add_hud_to(user)

/obj/item/clothing/head/helmet/space/hardsuit/bomb/dropped(mob/living/carbon/human/user)
	..()
	if (user.head == src)
		var/datum/atom_hud/DHUD = GLOB.huds[DATA_HUD_DIAGNOSTIC_BASIC]
		DHUD.remove_hud_from(user)

/obj/item/clothing/head/helmet/space/hardsuit/bomb/proc/sense_explosion(datum/source, turf/epicenter, devastation_range, heavy_impact_range,
		light_impact_range, took, orig_dev_range, orig_heavy_range, orig_light_range)
	var/turf/T = get_turf(src)
	if(T.z != epicenter.z)
		return
	if(get_dist(epicenter, T) > explosion_detection_dist)
		return
	display_visor_message("Explosion detected! Epicenter: [devastation_range], Outer: [heavy_impact_range], Shock: [light_impact_range]")

/obj/item/clothing/suit/space/hardsuit/bomb
	name = "EOD hardsuit"
	desc = "A bulky suit that protects against hazardous, low pressure environments. Fitted with extensive plating for handling of explosives and shrapnel. The difference between a closed and open-casket."
	icon_state = "hardsuit-eod"
	item_state = "hardsuit-eod"
	resistance_flags = ACID_PROOF | FIRE_PROOF
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT //Same as an emergency firesuit. Not ideal for extended exposure.
	slowdown = 1
	armor = list("melee" = 30, "bullet" = 40, "laser" = 10, "energy" = 20, "bomb" = 100, "bio" = 100, "rad" = 60, "fire" = 60, "acid" = 80, "wound" = 40)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/bomb
	supports_variations = VOX_VARIATION

/obj/item/clothing/suit/space/hardsuit/bomb/Initialize()
	. = ..()
	allowed = GLOB.security_hardsuit_allowed

//Security hardsuit
/obj/item/clothing/head/helmet/space/hardsuit/security
	name = "\improper Vigilitas Guardian hardsuit helmet"
	desc = "A helmet with a wide visor commonly seen with Vigilitas Interstellar security contractors."
	icon_state = "hardsuit0-sec"
	item_state = "sec_helm"
	hardsuit_type = "sec"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	supports_variations = SNOUTED_VARIATION

/obj/item/clothing/suit/space/hardsuit/security
	icon_state = "hardsuit-sec"
	name = "\improper Vigilitas Guardian hardsuit"
	desc = "A hardsuit commonly employed in security operations by Vigilitas Interstellar, often used for basic patrol duty and light engagements."
	item_state = "sec_hardsuit"
	armor = list("melee" = 35, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security
	slowdown = 0.5
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

/obj/item/clothing/suit/space/hardsuit/security/Initialize()
	. = ..()
	allowed = GLOB.security_hardsuit_allowed

//Head of Security hardsuit
/obj/item/clothing/head/helmet/space/hardsuit/security/hos
	name = "\improper Vigilitas Sentinel hardsuit helmet"
	desc = "An especially armored helmet with a narrow visor and armored facemask, commonly seen with high ranking Vigilitas Interstellar security contractors."
	icon_state = "hardsuit0-hos"
	hardsuit_type = "hos"
	armor = list("melee" = 50, "bullet" = 45, "laser" = 40, "energy" = 40, "bomb" = 25, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 95, "wound" = 30)
	supports_variations = SNOUTED_VARIATION

/obj/item/clothing/suit/space/hardsuit/security/hos
	icon_state = "hardsuit-hos"
	name = "\improper Vigilitas Sentinel hardsuit"
	desc = "A modified heavy hardsuit commonly employed by higher ranking members of Vigilitas Interstellar during security operations."
	armor = list("melee" = 50, "bullet" = 45, "laser" = 40, "energy" = 40, "bomb" = 25, "bio" = 100, "rad" = 50, "fire" = 95, "acid" = 95, "wound" = 30)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/hos
	jetpack = /obj/item/tank/jetpack/suit
	slowdown = 0.7
	supports_variations = DIGITIGRADE_VARIATION | VOX_VARIATION

	//SWAT MKII
/obj/item/clothing/head/helmet/space/hardsuit/swat
	name = "\improper MK.II SWAT Helmet"
	icon_state = "swat2helm"
	item_state = "swat2helm"
	desc = "A tactical SWAT helmet MK.II."
	armor = list("melee" = 40, "bullet" = 50, "laser" = 50, "energy" = 60, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR //we want to see the mask //this makes the hardsuit not fireproof you genius
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	actions_types = list()

/obj/item/clothing/head/helmet/space/hardsuit/swat/attack_self()

/obj/item/clothing/suit/space/hardsuit/swat
	name = "\improper MK.II SWAT Suit"
	desc = "A MK.II SWAT suit with streamlined joints and armor made out of superior materials, insulated against intense heat if worn with the complementary gas mask. The most advanced tactical armor available."
	icon_state = "swat2"
	item_state = "swat2"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 50, "energy" = 60, "bomb" = 50, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT //this needed to be added a long fucking time ago
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/swat

/obj/item/clothing/suit/space/hardsuit/swat/Initialize()
	. = ..()
	allowed = GLOB.security_hardsuit_allowed

	//Captain
/obj/item/clothing/head/helmet/space/hardsuit/swat/captain
	name = "captain's SWAT helmet"
	icon_state = "capspace"
	item_state = "capspacehelmet"
	desc = "A tactical MK.II SWAT helmet boasting better protection and a reasonable fashion sense."

/obj/item/clothing/suit/space/hardsuit/swat/captain
	name = "captain's SWAT suit"
	desc = "A MK.II SWAT suit with streamlined joints and armor made out of superior materials, insulated against intense heat with the complementary gas mask. The most advanced tactical armor available. Usually reserved for heavy hitter corporate security, this one has a regal finish in Nanotrasen company colors. Better not let the assistants get a hold of it."
	icon_state = "caparmor"
	item_state = "capspacesuit"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/swat/captain

	//Old Prototype
/obj/item/clothing/head/helmet/space/hardsuit/ancient
	name = "prototype RIG hardsuit helmet"
	desc = "Early prototype RIG hardsuit helmet, designed to quickly shift over a user's head. Design constraints of the helmet mean it has no inbuilt cameras, thus it restricts the users visability."
	icon_state = "hardsuit0-ancient"
	item_state = "anc_helm"
	armor = list("melee" = 30, "bullet" = 5, "laser" = 5, "energy" = 15, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 75, "wound" = 15)
	hardsuit_type = "ancient"
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/space/hardsuit/ancient
	name = "prototype RIG hardsuit"
	desc = "Prototype powered RIG hardsuit. Provides excellent protection from the elements of space while being comfortable to move around in, thanks to the powered locomotives. Remains very bulky however."
	icon_state = "hardsuit-ancient"
	item_state = "anc_hardsuit"
	armor = list("melee" = 30, "bullet" = 5, "laser" = 5, "energy" = 15, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 75, "wound" = 15)
	slowdown = 3
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ancient
	resistance_flags = FIRE_PROOF
	var/footstep = 1
	var/mob/listeningTo

/obj/item/clothing/suit/space/hardsuit/ancient/proc/on_mob_move()
	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.wear_suit != src)
		return
	if(footstep > 1)
		playsound(src, 'sound/effects/servostep.ogg', 100, TRUE)
		footstep = 0
	else
		footstep++

/obj/item/clothing/suit/space/hardsuit/ancient/equipped(mob/user, slot)
	. = ..()
	if(slot != ITEM_SLOT_OCLOTHING)
		if(listeningTo)
			UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
		return
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(on_mob_move))
	listeningTo = user

/obj/item/clothing/suit/space/hardsuit/ancient/dropped()
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)

/obj/item/clothing/suit/space/hardsuit/ancient/Destroy()
	listeningTo = null
	return ..()

/////////////SHIELDED//////////////////////////////////

/obj/item/clothing/suit/space/hardsuit/shielded
	name = "shielded hardsuit"
	desc = "A hardsuit with built in energy shielding. Will rapidly recharge when not under fire."
	icon_state = "hardsuit-hos"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/hos
	allowed = null
	armor = list("melee" = 30, "bullet" = 15, "laser" = 30, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	var/current_charges = 3
	var/max_charges = 3 //How many charges total the shielding has
	var/recharge_delay = 200 //How long after we've been shot before we can start recharging. 20 seconds here
	var/recharge_cooldown = 0 //Time since we've last been shot
	var/recharge_rate = 1 //How quickly the shield recharges once it starts charging
	var/shield_state = "shield-old"
	var/shield_on = "shield-old"

/obj/item/clothing/suit/space/hardsuit/shielded/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.advanced_hardsuit_allowed

/obj/item/clothing/suit/space/hardsuit/shielded/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	recharge_cooldown = world.time + recharge_delay
	if(current_charges > 0)
		var/datum/effect_system/spark_spread/s = new
		s.set_up(2, 1, src)
		s.start()
		owner.visible_message(span_danger("[owner]'s shields deflect [attack_text] in a shower of sparks!"))
		current_charges--
		if(recharge_rate)
			START_PROCESSING(SSobj, src)
		if(current_charges <= 0)
			owner.visible_message(span_warning("[owner]'s shield overloads!"))
			shield_state = "broken"
			owner.update_inv_wear_suit()
		return 1
	return 0


/obj/item/clothing/suit/space/hardsuit/shielded/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/suit/space/hardsuit/shielded/process(seconds_per_tick)
	if(world.time > recharge_cooldown && current_charges < max_charges)
		current_charges = clamp((current_charges + recharge_rate), 0, max_charges)
		playsound(loc, 'sound/magic/charge.ogg', 50, TRUE)
		if(current_charges == max_charges)
			playsound(loc, 'sound/machines/ding.ogg', 50, TRUE)
			STOP_PROCESSING(SSobj, src)
		shield_state = "[shield_on]"
		if(ishuman(loc))
			var/mob/living/carbon/human/C = loc
			C.update_inv_wear_suit()

/obj/item/clothing/suit/space/hardsuit/shielded/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		. += mutable_appearance('icons/effects/effects.dmi', shield_state, MOB_LAYER + 0.01)

/obj/item/clothing/head/helmet/space/hardsuit/shielded
	resistance_flags = FIRE_PROOF | ACID_PROOF

///////////////Capture the Flag////////////////////

/obj/item/clothing/suit/space/hardsuit/shielded/ctf
	name = "white shielded hardsuit"
	desc = "Standard issue hardsuit for playing capture the flag."
	icon_state = "ert_medical"
	item_state = "ert_medical"
	hardsuit_type = "ert_medical"
	// Adding TRAIT_NODROP is done when the CTF spawner equips people
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/shielded/ctf
	armor = list("melee" = 0, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 95)
	slowdown = 0
	max_charges = 5

/obj/item/clothing/suit/space/hardsuit/shielded/ctf/red
	name = "red shielded hardsuit"
	icon_state = "ert_security"
	item_state = "ert_security"
	hardsuit_type = "ert_security"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/shielded/ctf/red
	shield_state = "shield-red"
	shield_on = "shield-red"

/obj/item/clothing/suit/space/hardsuit/shielded/ctf/blue
	name = "blue shielded hardsuit"
	desc = "Standard issue hardsuit for playing capture the flag."
	icon_state = "ert_command"
	item_state = "ert_command"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/shielded/ctf/blue



/obj/item/clothing/head/helmet/space/hardsuit/shielded/ctf
	name = "shielded hardsuit helmet"
	desc = "Standard issue hardsuit helmet for playing capture the flag."
	icon_state = "hardsuit0-ert_medical"
	item_state = "hardsuit0-ert_medical"
	hardsuit_type = "ert_medical"
	armor = list("melee" = 0, "bullet" = 30, "laser" = 30, "energy" = 40, "bomb" = 50, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 95)


/obj/item/clothing/head/helmet/space/hardsuit/shielded/ctf/red
	icon_state = "hardsuit0-ert_security"
	item_state = "hardsuit0-ert_security"
	hardsuit_type = "ert_security"

/obj/item/clothing/head/helmet/space/hardsuit/shielded/ctf/blue
	name = "shielded hardsuit helmet"
	desc = "Standard issue hardsuit helmet for playing capture the flag."
	icon_state = "hardsuit0-ert_commander"
	item_state = "hardsuit0-ert_commander"
	hardsuit_type = "ert_commander"





//////Syndicate Version

/obj/item/clothing/suit/space/hardsuit/shielded/syndi
	name = "blood-red hardsuit"
	desc = "An advanced hardsuit with built in energy shielding."
	icon_state = "hardsuit1-syndi"
	item_state = "syndie_hardsuit"
	hardsuit_type = "syndi"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/melee/energy/sword/saber, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/shielded/syndi
	slowdown = 0.5
	shield_state = "shield-red"
	shield_on = "shield-red"
	jetpack = /obj/item/tank/jetpack/suit

/obj/item/clothing/suit/space/hardsuit/shielded/syndi/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(shield_state == "broken")
		to_chat(user, span_warning("You can't interface with the hardsuit's software if the shield's broken!"))
		return

	if(shield_state == "shield-red")
		shield_state = "shield-old"
		shield_on = "shield-old"
		to_chat(user, span_warning("You roll back the hardsuit's software, changing the shield's color!"))

	else
		shield_state = "shield-red"
		shield_on = "shield-red"
		to_chat(user, span_warning("You update the hardsuit's hardware, changing back the shield's color to red."))
	user.update_inv_wear_suit()

/obj/item/clothing/head/helmet/space/hardsuit/shielded/syndi
	name = "blood-red hardsuit helmet"
	desc = "An advanced hardsuit helmet with built in energy shielding."
	icon_state = "hardsuit1-syndi"
	item_state = "syndie_helm"
	hardsuit_type = "syndi"
	armor = list("melee" = 40, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 35, "bio" = 100, "rad" = 50, "fire" = 100, "acid" = 100)

///SWAT version
/obj/item/clothing/suit/space/hardsuit/shielded/swat
	name = "death commando spacesuit"
	desc = "An advanced hardsuit favored by commandos for use in special operations."
	icon_state = "deathsquad"
	item_state = "swat_suit"
	hardsuit_type = "syndi"
	max_charges = 4
	current_charges = 4
	recharge_delay = 15
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 60, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/shielded/swat
	dog_fashion = /datum/dog_fashion/back/deathsquad

/obj/item/clothing/head/helmet/space/hardsuit/shielded/swat
	name = "death commando helmet"
	desc = "A tactical helmet with built in energy shielding."
	icon_state = "deathsquad"
	item_state = "deathsquad"
	hardsuit_type = "syndi"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 50, "energy" = 60, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	strip_delay = 130
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	actions_types = list()

///////////////Shiptest Additions////////////////////

//this 'shiptest' server really needs to just add new files

//Softsuit helmet light framework
/obj/item/clothing/head/helmet/space/light
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	var/on = FALSE
	light_color = "#FFCC66"
	light_power = 0.8
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 4
	light_power = 1
	light_on = FALSE
	on = FALSE

/obj/item/clothing/head/helmet/space/light/attack_self(mob/living/user)
	toggle_helmet_light(user)

/obj/item/clothing/head/helmet/space/light/proc/toggle_helmet_light(mob/living/user)
	on = !on
	if(on)
		turn_on(user)
	else
		turn_off(user)
	update_appearance()

/obj/item/clothing/head/helmet/space/light/update_icon_state()
	if(on)
		icon_state = "[initial(icon_state)]-on"
		item_state = "[initial(icon_state)]-on"
	else
		icon_state = "[initial(icon_state)]"
		item_state = "[initial(icon_state)]"
	return ..()

/obj/item/clothing/head/helmet/space/light/proc/turn_on(mob/user)
	set_light_on(TRUE)

/obj/item/clothing/head/helmet/space/light/proc/turn_off(mob/user)
	set_light_on(FALSE)

////Independents

	//Security
/obj/item/clothing/head/helmet/space/hardsuit/security/independent
	name = "security hardsuit helmet"
	desc = "An obsolete, surplus helmet designed for work in hazardous, low pressure environments. Well-armored, if somewhat claustrophobic."
	icon_state = "hardsuit0-independent-sec"
	item_state = "independent_sec_helm"
	hardsuit_type = "independent-sec"
	armor = list("melee" = 35, "bullet" = 25, "laser" = 20,"energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	supports_variations = VOX_VARIATION | SNOUTED_VARIATION

/obj/item/clothing/suit/space/hardsuit/security/independent
	icon_state = "hardsuit-independent-sec"
	name = "security hardsuit"
	desc = "An obsolete, surplus suit that protects against hazardous, low pressure environments. Though bulky, it has significant armor protection for its age. <br> Dating from well before the war, old surplus suits such as this can be found in the service of various local police and private security organizations across known space."
	icon_state = "hardsuit-independent-sec"
	item_state = "independent_sec_hardsuit"
	hardsuit_type = "independent-sec"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/security/independent
	armor = list("melee" = 35, "bullet" = 25, "laser" = 20, "energy" = 40, "bomb" = 10, "bio" = 100, "rad" = 50, "fire" = 75, "acid" = 75, "wound" = 20)
	supports_variations = VOX_VARIATION | DIGITIGRADE_VARIATION

//Mining
/obj/item/clothing/head/helmet/space/hardsuit/mining/independent
	name = "mining hardsuit helmet"
	desc = "An inexpensive helmet designed for work in hazardous, low pressure environments. Its open cage design provides excellent visibility."
	icon_state = "hardsuit0-independent-mining"
	item_state = "independent_mining_helm"
	hardsuit_type = "independent-mining"
	armor = list("melee" = 50, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 65, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 100, "wound" = 20)

/obj/item/clothing/suit/space/hardsuit/mining/independent
	name = "mining hardsuit"
	desc = "An inexpensive, widespread suit designed for work in hazardous, low pressure environments. Equipped with extra plating against blunt impacts and other common threats as well as a powerful shoulder-mounted floodlight. <br> Suits like this are a common sight among miners on the frontier, frequently equipped with additional improvised plating."
	icon_state = "hardsuit0-independent-mining"
	item_state = "independent_mining_hardsuit"
	hardsuit_type = "independent-mining"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/mining/independent
	armor = list("melee" = 50, "bullet" = 20, "laser" = 20, "energy" = 30, "bomb" = 65, "bio" = 100, "rad" = 50, "fire" = 80, "acid" = 100, "wound" = 20)
