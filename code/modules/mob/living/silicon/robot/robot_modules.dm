/obj/item/robot_module
	name = "Default"
	icon = 'icons/obj/module.dmi'
	icon_state = "std_mod"
	w_class = WEIGHT_CLASS_GIGANTIC
	item_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	flags_1 = CONDUCT_1

	var/list/basic_modules = list() //a list of paths, converted to a list of instances on New()
	var/list/emag_modules = list() //ditto
	var/list/modules = list() //holds all the usable modules
	var/list/added_modules = list() //modules not inherient to the robot module, are kept when the module changes
	var/list/storages = list()

	var/cyborg_base_icon = "robot" //produces the icon for the borg and, if no special_light_key is set, the lights
	var/special_light_key //if we want specific lights, use this instead of copying lights in the dmi

	var/moduleselect_icon = "nomod"

	var/can_be_pushed = TRUE
	var/magpulsing = FALSE
	var/clean_on_move = FALSE

	var/did_feedback = FALSE

	var/hat_offset = -3

	var/list/ride_offset_x = list("north" = 0, "south" = 0, "east" = -6, "west" = 6)
	var/list/ride_offset_y = list("north" = 4, "south" = 4, "east" = 3, "west" = 3)
	var/ride_allow_incapacitated = TRUE
	var/allow_riding = TRUE
	var/canDispose = FALSE // Whether the borg can stuff itself into disposal

	var/icon/cyborg_icon_override //WS Addition, need this shit to use VG icons

/obj/item/robot_module/Initialize()
	. = ..()
	for(var/i in basic_modules)
		var/obj/item/I = new i(src)
		basic_modules += I
		basic_modules -= i
	for(var/i in emag_modules)
		var/obj/item/I = new i(src)
		emag_modules += I
		emag_modules -= i

/obj/item/robot_module/Destroy()
	basic_modules.Cut()
	emag_modules.Cut()
	modules.Cut()
	added_modules.Cut()
	storages.Cut()
	return ..()

/obj/item/robot_module/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_CONTENTS)
		return
	for(var/obj/O in modules)
		O.emp_act(severity)
	..()

/obj/item/robot_module/proc/get_usable_modules()
	. = modules.Copy()

/obj/item/robot_module/proc/get_inactive_modules()
	. = list()
	var/mob/living/silicon/robot/R = loc
	for(var/m in get_usable_modules())
		if(!(m in R.held_items))
			. += m

/obj/item/robot_module/proc/get_or_create_estorage(var/storage_type)
	for(var/datum/robot_energy_storage/S in storages)
		if(istype(S, storage_type))
			return S

	return new storage_type(src)

/obj/item/robot_module/proc/add_module(obj/item/I, nonstandard, requires_rebuild)
	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I

		if(is_type_in_list(S, list(/obj/item/stack/sheet/metal, /obj/item/stack/rods, /obj/item/stack/tile/plasteel)))
			if(S.custom_materials && custom_materials.len)
				if(S.custom_materials[SSmaterials.GetMaterialRef(/datum/material/iron)])
					S.cost = S.custom_materials[SSmaterials.GetMaterialRef(/datum/material/iron)] * 0.25
			S.source = get_or_create_estorage(/datum/robot_energy_storage/metal)

		else if(istype(S, /obj/item/stack/sheet/glass))
			S.cost = 500
			S.source = get_or_create_estorage(/datum/robot_energy_storage/glass)

		else if(istype(S, /obj/item/stack/sheet/rglass/cyborg))
			var/obj/item/stack/sheet/rglass/cyborg/G = S
			G.source = get_or_create_estorage(/datum/robot_energy_storage/metal)
			G.glasource = get_or_create_estorage(/datum/robot_energy_storage/glass)

		else if(istype(S, /obj/item/stack/medical))
			S.cost = 250
			S.source = get_or_create_estorage(/datum/robot_energy_storage/medical)

		else if(istype(S, /obj/item/stack/cable_coil))
			S.cost = 1
			S.source = get_or_create_estorage(/datum/robot_energy_storage/wire)

		else if(istype(S, /obj/item/stack/marker_beacon))
			S.cost = 1
			S.source = get_or_create_estorage(/datum/robot_energy_storage/beacon)

		if(S && S.source)
			S.custom_materials = null
			S.is_cyborg = 1

	if(I.loc != src)
		I.forceMove(src)
	modules += I
	ADD_TRAIT(I, TRAIT_NODROP, CYBORG_ITEM_TRAIT)
	I.mouse_opacity = MOUSE_OPACITY_OPAQUE
	if(nonstandard)
		added_modules += I
	if(requires_rebuild)
		rebuild_modules()
	return I

/obj/item/robot_module/proc/remove_module(obj/item/I, delete_after)
	basic_modules -= I
	modules -= I
	emag_modules -= I
	added_modules -= I
	rebuild_modules()
	if(delete_after)
		qdel(I)

/obj/item/robot_module/proc/respawn_consumable(mob/living/silicon/robot/R, coeff = 1)
	for(var/datum/robot_energy_storage/st in storages)
		st.energy = min(st.max_energy, st.energy + coeff * st.recharge_rate)

	for(var/obj/item/I in get_usable_modules())
		if(istype(I, /obj/item/assembly/flash))
			var/obj/item/assembly/flash/F = I
			F.times_used = 0
			F.burnt_out = FALSE
			F.update_icon()
		else if(istype(I, /obj/item/melee/baton))
			var/obj/item/melee/baton/B = I
			if(B.cell)
				B.cell.charge = B.cell.maxcharge
		else if(istype(I, /obj/item/gun/energy))
			var/obj/item/gun/energy/EG = I
			if(!EG.chambered)
				EG.recharge_newshot() //try to reload a new shot.

	R.toner = R.tonermax

/obj/item/robot_module/proc/rebuild_modules() //builds the usable module list from the modules we have
	var/mob/living/silicon/robot/R = loc
	var/held_modules = R.held_items.Copy()
	R.uneq_all()
	modules = list()
	for(var/obj/item/I in basic_modules)
		add_module(I, FALSE, FALSE)
	if(R.emagged)
		for(var/obj/item/I in emag_modules)
			add_module(I, FALSE, FALSE)
	for(var/obj/item/I in added_modules)
		add_module(I, FALSE, FALSE)
	for(var/i in held_modules)
		if(i)
			R.activate_module(i)
	if(R.hud_used)
		R.hud_used.update_robot_modules_display()

/obj/item/robot_module/proc/transform_to(new_module_type)
	var/mob/living/silicon/robot/R = loc
	var/obj/item/robot_module/RM = new new_module_type(R)
	if(!RM.be_transformed_to(src))
		qdel(RM)
		return
	R.module = RM
	R.update_module_innate()
	RM.rebuild_modules()
	INVOKE_ASYNC(RM, .proc/do_transform_animation)
	qdel(src)
	return RM

/obj/item/robot_module/proc/be_transformed_to(obj/item/robot_module/old_module)
	for(var/i in old_module.added_modules)
		added_modules += i
		old_module.added_modules -= i
	did_feedback = old_module.did_feedback
	return TRUE

/obj/item/robot_module/proc/do_transform_animation()
	var/mob/living/silicon/robot/R = loc
	if(R.hat)
		R.hat.forceMove(get_turf(R))
		R.hat = null
	R.cut_overlays()
	R.setDir(SOUTH)
	do_transform_delay()

/obj/item/robot_module/proc/do_transform_delay()
	var/mob/living/silicon/robot/R = loc
	var/prev_lockcharge = R.lockcharge
	sleep(1)
	flick("[cyborg_base_icon]_transform", R)
	R.notransform = TRUE
	R.SetLockdown(1)
	R.set_anchored(TRUE)
	R.logevent("Chassis configuration has been set to [name].")
	sleep(1)
	for(var/i in 1 to 4)
		playsound(R, pick('sound/items/drill_use.ogg', 'sound/items/jaws_cut.ogg', 'sound/items/jaws_pry.ogg', 'sound/items/welder.ogg', 'sound/items/ratchet.ogg'), 80, TRUE, -1)
		sleep(7)
	if(!prev_lockcharge)
		R.SetLockdown(0)
	R.setDir(SOUTH)
	R.set_anchored(FALSE)
	R.notransform = FALSE
	R.updatehealth()
	R.update_icons()
	R.notify_ai(NEW_MODULE)
	if(R.hud_used)
		R.hud_used.update_robot_modules_display()
	SSblackbox.record_feedback("tally", "cyborg_modules", 1, R.module)

/**
  * check_menu: Checks if we are allowed to interact with a radial menu
  *
  * Arguments:
  * * user The mob interacting with a menu
  */
/obj/item/robot_module/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/robot_module/standard
	name = "Standard"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/reagent_containers/borghypo/epi,
		/obj/item/healthanalyzer,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/stack/sheet/metal/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/plasteel/cyborg,
		/obj/item/extinguisher,
		/obj/item/pickaxe,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/soap/nanotrasen,
		/obj/item/borg/cyborghug)
	emag_modules = list(/obj/item/melee/transforming/energy/sword/cyborg)
	cyborg_base_icon = "robot"
	moduleselect_icon = "standard"
	hat_offset = -3

//WS Begin - Can these all be modularized? Probably.
/obj/item/robot_module/standard/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/default_icons
	if(!default_icons)
		default_icons = list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "robot"),
		"Antique" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "robot_old"),
		"Droid" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "droid"),
		"Marina" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "marinaSD"),
		"Sleek" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "sleekstandard"),
		"servbot" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "servbot"),
		"Spider" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "spider-standard"),
		"Kodiak - 'Polar'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "kodiak-standard"),
		"Noble" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "Noble-STD"),
		"R34 - STR4a 'Durin'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "durin"),
		"Booty" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "booty-blue")
		)
		default_icons = sortList(default_icons)
	var/default_borg_icon = show_radial_menu(R, R , default_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(default_borg_icon)
		if("Default")
			cyborg_base_icon = "robot"
		if("Antique")
			cyborg_base_icon = "robot_old"
		if("Droid")
			cyborg_base_icon = "droid"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "droid"
		if("Marina")
			cyborg_base_icon = "marinaSD"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "marinaSD"
		if("Sleek")
			cyborg_base_icon = "sleekstandard"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "sleekstandard"
		if("servbot")
			cyborg_base_icon = "servbot"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "servbot"
		if("Spider")
			cyborg_base_icon = "spider-standard"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "spider-standard"
		if("Kodiak - 'Polar'")
			cyborg_base_icon = "kodiak-standard"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "kodiak-standard"
		if("Noble")
			cyborg_base_icon = "Noble-STD"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "Noble-STD"
		if("R34 - STR4a 'Durin'")
			cyborg_base_icon = "durin"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "durin"
		if("Booty")
			cyborg_base_icon = "booty-blue"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "booty-blue"
		else
			return FALSE
	return ..()
//WS End

/obj/item/robot_module/medical
	name = "Medical"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/healthanalyzer,
		/obj/item/reagent_containers/borghypo,
		/obj/item/borg/apparatus/beaker,
		/obj/item/reagent_containers/dropper,
		/obj/item/reagent_containers/syringe,
				/obj/item/retractor,
		/obj/item/hemostat,
		/obj/item/cautery,
		/obj/item/surgicaldrill,
		/obj/item/scalpel,
		/obj/item/circular_saw,
		/obj/item/extinguisher/mini,
		/obj/item/roller/robo,
		/obj/item/borg/cyborghug/medical,
		/obj/item/stack/medical/gauze/cyborg,
		/obj/item/organ_storage,
		/obj/item/borg/lollipop)
	emag_modules = list(/obj/item/reagent_containers/borghypo/hacked)
	cyborg_base_icon = "medical"
	moduleselect_icon = "medical"
	can_be_pushed = FALSE
	hat_offset = 3

//WS Begin
/obj/item/robot_module/medical/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/med_icons
	if(!med_icons)
		med_icons = list(
		"Antique" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "medbot"),
		"Needles" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "needles"),
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "medical"),
		"EVE" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "eve"),
		"Droid" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "droid-medical"),
		"Marina" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "marina"),
		"Sleek" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "sleekmedic"),
		"#17" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "servbot-medi"),
		"Kodiak - 'Arachne'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "arachne"),
		"Noble" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "Noble-MED"),
		"R34 - MED6a 'Gibbs'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "gibbs"),
		"Booty" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "booty-white"),
		"Qualified Doctor" = image(icon = 'icons/mob/robots.dmi', icon_state = "qualified_doctor")
		)
		med_icons = sortList(med_icons)
	var/med_borg_icon = show_radial_menu(R, R , med_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(med_borg_icon)
		if("Antique")
			cyborg_base_icon = "medbot"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "medbot"
		if("Needles")
			cyborg_base_icon = "needles"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "needles"
		if("Default")
			cyborg_base_icon = "medical"
		if("EVE")
			cyborg_base_icon = "eve"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "eve"
		if("Droid")
			cyborg_base_icon = "droid-medical"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "droid-medical"
		if("Marina")
			cyborg_base_icon = "marina"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "marina"
		if("Sleek")
			cyborg_base_icon = "sleekmedic"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "sleekmedic"
		if("#17")
			cyborg_base_icon = "servbot-medi"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "servbot-medi"
		if("Kodiak - 'Arachne'")
			cyborg_base_icon = "arachne"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "arachne"
		if("Noble")
			cyborg_base_icon = "Noble-MED"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "Noble-MED"
		if("R34 - MED6a 'Gibbs'")
			cyborg_base_icon = "gibbs"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "gibbs"
		if("Booty")
			cyborg_base_icon = "booty-white"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "booty-white"
		if("Qualified Doctor")
			cyborg_base_icon = "qualified-doctor"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "qualified-doctor"
		else
			return FALSE
	return ..()
//WS End

/obj/item/robot_module/engineering
	name = "Engineering"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/meson,
		/obj/item/construction/rcd/borg,
		/obj/item/pipe_dispenser,
		/obj/item/extinguisher,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/screwdriver/cyborg,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/geiger_counter/cyborg,
		/obj/item/assembly/signaler/cyborg,
		/obj/item/areaeditor/blueprints/cyborg,
		/obj/item/electroadaptive_pseudocircuit,
		/obj/item/stack/sheet/metal/cyborg,
		/obj/item/stack/sheet/glass/cyborg,
		/obj/item/stack/sheet/rglass/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/plasteel/cyborg,
		/obj/item/stack/cable_coil/cyborg)
	emag_modules = list(/obj/item/borg/stun)
	cyborg_base_icon = "engineer"
	moduleselect_icon = "engineer"
	magpulsing = TRUE
	hat_offset = -4

//WS Begin
/obj/item/robot_module/engineering/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/engi_icons
	if(!engi_icons)
		engi_icons = list(
		"Antique" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "engibot"),
		"Engiseer" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "engiseer"),
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "engineer"),
		"Wall-E" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "wall-e"),
		"Droid" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "droid-engineer"),
		"Marina" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "marinaEN"),
		"Sleek" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "sleekengineer"),
		"#25" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "servbot-engi"),
		"Kodiak" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "kodiak-eng"),
		"Noble" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "Noble-ENG"),
		"R34 - ENG7a 'Conagher'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "conagher"),
		"Booty" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "booty-yellow")
		)
		engi_icons = sortList(engi_icons)
	var/engi_borg_icon = show_radial_menu(R, R , engi_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(engi_borg_icon)
		if("Antique")
			cyborg_base_icon = "engibot"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "engibot"
		if("Engiseer")
			cyborg_base_icon = "engiseer"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key ="engiseer"
		if("Default")
			cyborg_base_icon = "engineer"
		if("Wall-E")
			cyborg_base_icon = "wall-e"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "wall-e"
		if("Droid")
			cyborg_base_icon = "droid-engineer"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "droid-engineer"
		if("Marina")
			cyborg_base_icon = "marinaEN"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "marinaEN"
		if("Sleek")
			cyborg_base_icon = "sleekengineer"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "sleekengineer"
		if("#25")
			cyborg_base_icon = "servbot-engi"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "servbot-engi"
		if("Kodiak")
			cyborg_base_icon = "kodiak-eng"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "kodiak-eng"
		if("Noble")
			cyborg_base_icon = "Noble-ENG"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "Noble-ENG"
		if("R34 - ENG7a 'Conagher'")
			cyborg_base_icon = "conagher"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "conagher"
		if("Booty")
			cyborg_base_icon = "booty-yellow"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "booty-yellow"
		else
			return FALSE
	return ..()
//WS End

/obj/item/robot_module/security
	name = "Security"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/melee/baton/loaded,
		/obj/item/gun/energy/disabler/cyborg,
		/obj/item/clothing/mask/gas/sechailer/cyborg,
		/obj/item/extinguisher/mini)
	emag_modules = list(/obj/item/gun/energy/laser/cyborg)
	cyborg_base_icon = "sec"
	moduleselect_icon = "security"
	can_be_pushed = FALSE
	hat_offset = 3

//WS Begin
/obj/item/robot_module/security/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/sec_icons
	if(!sec_icons)
		sec_icons = list(
		"Antique" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "secbot"),
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "sec"),
		"Securitron" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "securitron"),
		"Droid 'Black Knight'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "droid-security"),
		"Marina" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "marinaSC"),
		"Sleek" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "sleeksecurity"),
		"#9" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "servbot-sec"),
		"Kodiak" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "kodiak-sec"),
		"Noble" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "Noble-SEC"),
		"R34 - SEC10a 'Woody'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "woody"),
		"Booty" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "booty-red")
		)
		sec_icons = sortList(sec_icons)
	var/sec_borg_icon = show_radial_menu(R, R , sec_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(sec_borg_icon)
		if("Antique")
			cyborg_base_icon = "secbot"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "secbot"
		if("Default")
			cyborg_base_icon = "sec"
		if("Securitron")
			cyborg_base_icon = "securitron"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "securitron"
		if("Droid 'Black Knight'")
			cyborg_base_icon = "droid-security"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "droid-security"
		if("Marina")
			cyborg_base_icon = "marinaSC"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "marinaSC"
		if("Sleek")
			cyborg_base_icon = "sleeksecurity"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "sleeksecurity"
		if("#9")
			cyborg_base_icon = "servbot-sec"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "servbot-sec"
		if("Kodiak")
			cyborg_base_icon = "kodiak-sec"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "kodiak-sec"
		if("Noble")
			cyborg_base_icon = "Noble-SEC"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "Noble-SEC"
		if("R34 - SEC10a 'Woody'")
			cyborg_base_icon = "woody"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "woody"
		if("Booty")
			cyborg_base_icon = "booty-red"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "booty-red"
		else
			return FALSE
	return ..()
//WS End

/obj/item/robot_module/security/do_transform_animation()
	..()
	to_chat(loc, "<span class='userdanger'>While you have picked the security module, you still have to follow your laws, NOT Space Law. \
	For Asimov, this means you must follow criminals' orders unless there is a law 1 reason not to.</span>")

/obj/item/robot_module/security/respawn_consumable(mob/living/silicon/robot/R, coeff = 1)
	..()
	var/obj/item/gun/energy/e_gun/advtaser/cyborg/T = locate(/obj/item/gun/energy/e_gun/advtaser/cyborg) in basic_modules
	if(T)
		if(T.cell.charge < T.cell.maxcharge)
			var/obj/item/ammo_casing/energy/S = T.ammo_type[T.select]
			T.cell.give(S.e_cost * coeff)
			T.update_icon()
		else
			T.charge_tick = 0

/obj/item/robot_module/peacekeeper
	name = "Peacekeeper"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/rsf/cookiesynth,
		/obj/item/harmalarm,
		/obj/item/reagent_containers/borghypo/peace,
		/obj/item/holosign_creator/cyborg,
		/obj/item/borg/cyborghug/peacekeeper,
		/obj/item/extinguisher,
		/obj/item/borg/projectile_dampen)
	emag_modules = list(/obj/item/reagent_containers/borghypo/peace/hacked)
	cyborg_base_icon = "peace"
	moduleselect_icon = "standard"
	can_be_pushed = FALSE
	hat_offset = -2

/obj/item/robot_module/peacekeeper/do_transform_animation()
	..()
	to_chat(loc, "<span class='userdanger'>Under ASIMOV, you are an enforcer of the PEACE and preventer of HUMAN HARM. \
	You are not a security module and you are expected to follow orders and prevent harm above all else. Space law means nothing to you.</span>")

/obj/item/robot_module/janitor
	name = "Janitor"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/screwdriver/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/stack/tile/plasteel/cyborg,
		/obj/item/soap/nanotrasen,
		/obj/item/storage/bag/trash/cyborg,
		/obj/item/melee/flyswatter,
		/obj/item/extinguisher/mini,
		/obj/item/mop/cyborg,
		/obj/item/reagent_containers/glass/bucket,
		/obj/item/paint/paint_remover,
		/obj/item/lightreplacer/cyborg,
		/obj/item/holosign_creator/janibarrier,
		/obj/item/reagent_containers/spray/cyborg_drying)
	emag_modules = list(/obj/item/reagent_containers/spray/cyborg_lube)
	cyborg_base_icon = "janitor"
	moduleselect_icon = "janitor"
	hat_offset = -5
	clean_on_move = TRUE

//WS Begin
/obj/item/robot_module/janitor/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/jan_icons
	if(!jan_icons)
		jan_icons = list(
		"Antique" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "janbot"),
		"Mechaduster" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "mechaduster"),
		"HAN-D" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "han-d"),
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "janitor"),
		"Droid - 'Mopbot'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "droid-janitor"),
		"Marina" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "marinaJN"),
		"Sleek" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "sleekjanitor"),
		"#29" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "servbot-jani"),
		"Noble" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "Noble-JAN"),
		"R34 - CUS3a 'Flynn'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "flynn"),
		"Booty" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "booty-green")
		)
		jan_icons = sortList(jan_icons)
	var/jan_borg_icon = show_radial_menu(R, R , jan_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(jan_borg_icon)
		if("Antique")
			cyborg_base_icon = "janbot"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "janbot"
		if("Mechaduster")
			cyborg_base_icon = "mechaduster"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "mechaduster"
		if("HAN-D")
			cyborg_base_icon = "han-d"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "han-d"
		if("Default")
			cyborg_base_icon = "janitor"
		if("Droid - 'Mopbot'")
			cyborg_base_icon = "droid-janitor"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "droid-janitor"
		if("Marina")
			cyborg_base_icon = "marinaJN"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "marinaJN"
		if("Sleek")
			cyborg_base_icon = "sleekjanitor"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "sleekjanitor"
		if("#29")
			cyborg_base_icon = "servbot-jani"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "servbot-jani"
		if("Noble")
			cyborg_base_icon = "Noble-JAN"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "Noble-JAN"
		if("R34 - CUS3a 'Flynn'")
			cyborg_base_icon = "flynn"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "flynn"
		if("Booty")
			cyborg_base_icon = "booty-green"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "booty-green"
		else
			return FALSE
	return ..()
//WS End

/obj/item/reagent_containers/spray/cyborg_drying
	name = "drying agent spray"
	color = "#A000A0"
	list_reagents = list(/datum/reagent/drying_agent = 250)

/obj/item/reagent_containers/spray/cyborg_lube
	name = "lube spray"
	list_reagents = list(/datum/reagent/lube = 250)

/obj/item/robot_module/janitor/respawn_consumable(mob/living/silicon/robot/R, coeff = 1)
	..()
	var/obj/item/lightreplacer/LR = locate(/obj/item/lightreplacer) in basic_modules
	if(LR)
		for(var/i in 1 to coeff)
			LR.Charge(R)

	var/obj/item/reagent_containers/spray/cyborg_drying/CD = locate(/obj/item/reagent_containers/spray/cyborg_drying) in basic_modules
	if(CD)
		CD.reagents.add_reagent(/datum/reagent/drying_agent, 5 * coeff)

	var/obj/item/reagent_containers/spray/cyborg_lube/CL = locate(/obj/item/reagent_containers/spray/cyborg_lube) in emag_modules
	if(CL)
		CL.reagents.add_reagent(/datum/reagent/lube, 2 * coeff)

/obj/item/robot_module/clown
	name = "Clown"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/toy/crayon/rainbow,
		/obj/item/instrument/bikehorn,
		/obj/item/stamp/clown,
		/obj/item/bikehorn,
		/obj/item/bikehorn/airhorn,
		/obj/item/paint/anycolor,
		/obj/item/soap/nanotrasen,
		/obj/item/pneumatic_cannon/pie/selfcharge/cyborg,
		/obj/item/razor,					//killbait material
		/obj/item/lipstick/purple,
		/obj/item/reagent_containers/spray/waterflower/cyborg,
		/obj/item/borg/cyborghug/peacekeeper,
		/obj/item/borg/lollipop/clown,
		/obj/item/picket_sign/cyborg,
		/obj/item/reagent_containers/borghypo/clown,
		/obj/item/extinguisher/mini)
	emag_modules = list(
		/obj/item/reagent_containers/borghypo/clown/hacked,
		/obj/item/reagent_containers/spray/waterflower/cyborg/hacked)
	moduleselect_icon = "service"
	cyborg_base_icon = "clown"
	hat_offset = -2

/obj/item/robot_module/butler
	name = "Service"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/reagent_containers/glass/beaker/large, //I know a shaker is more appropiate but this is for ease of identification
		/obj/item/reagent_containers/food/condiment/enzyme,
		/obj/item/pen,
		/obj/item/toy/crayon/spraycan/borg,
		/obj/item/extinguisher/mini,
		/obj/item/hand_labeler/borg,
		/obj/item/razor,
		/obj/item/rsf,
		/obj/item/instrument/guitar,
		/obj/item/instrument/piano_synth,
		/obj/item/reagent_containers/dropper,
		/obj/item/lighter,
		/obj/item/storage/bag/tray,
		/obj/item/reagent_containers/borghypo/borgshaker,
		/obj/item/borg/lollipop,
		/obj/item/stack/cable_coil/cyborg,
		/obj/item/borg/apparatus/beaker/service)
	emag_modules = list(/obj/item/reagent_containers/borghypo/borgshaker/hacked)
	moduleselect_icon = "service"
	special_light_key = "service"
	hat_offset = 0

/obj/item/robot_module/butler/respawn_consumable(mob/living/silicon/robot/R, coeff = 1)
	..()
	var/obj/item/reagent_containers/O = locate(/obj/item/reagent_containers/food/condiment/enzyme) in basic_modules
	if(O)
		O.reagents.add_reagent(/datum/reagent/consumable/enzyme, 2 * coeff)

//WS Edits Begin
/obj/item/robot_module/butler/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/service_icons
	if(!service_icons)
		service_icons = list(
		"Default - 'Waitress'" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_f"),
		"Default - 'Butler'" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_m"),
		"Default - 'Bro'" = image(icon = 'icons/mob/robots.dmi', icon_state = "brobot"),
		"Default - 'Kent'" = image(icon = 'icons/mob/robots.dmi', icon_state = "kent"),
		"Default - 'Maximillion'" = image(icon = 'icons/mob/robots.dmi', icon_state = "tophat"),
		"Default - 'Hydro'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "hydrobot"),
		"Marina" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "marinaSV"),
		"Sleek" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "sleekservice"),
		"#27" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "servbot-service"),
		"Kodiak - 'Teddy'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "kodiak-service"),
		"Noble" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "Noble-SRV"),
		"R34 - SRV9a 'Llyod'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "lloyd"),
		"Booty" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "booty-flower")
		)
		service_icons = sortList(service_icons)
	var/service_robot_icon = show_radial_menu(R, R , service_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(service_robot_icon)
		if("Default - 'Waitress'")
			cyborg_base_icon = "service_f"
		if("Default - 'Butler'")
			cyborg_base_icon = "service_m"
		if("Default - 'Bro'")
			cyborg_base_icon = "brobot"
		if("Default - 'Maximillion'")
			cyborg_base_icon = "tophat"
			special_light_key = null
			hat_offset = INFINITY //He is already wearing a hat
		if("Default - 'Hydro'")
			cyborg_base_icon = "hydrobot"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "hydrobot"
		if("Default - 'Kent'")
			cyborg_base_icon = "kent"
			special_light_key = "medical"
			hat_offset = 3
		if("Marina")
			cyborg_base_icon = "marinaSV"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "marinaSV"
		if("Sleek")
			cyborg_base_icon = "sleekservice"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "sleekservice"
		if("#27")
			cyborg_base_icon = "servbot-service"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "servbot-service"
		if("Kodiak - 'Teddy'")
			cyborg_base_icon = "kodiak-service"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "kodiak-service"
		if("Noble")
			cyborg_base_icon = "Noble-SRV"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "Noble-SRV"
		if("R34 - SRV9a 'Llyod'")
			cyborg_base_icon = "lloyd"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "lloyd"
		if("Booty")
			cyborg_base_icon = "booty-flower"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "booty-flower"
		else
			return FALSE
	return ..()
//WS Edits End

/obj/item/robot_module/miner
	name = "Miner"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/meson,
		/obj/item/storage/bag/ore/cyborg,
		/obj/item/pickaxe/drill/cyborg,
		/obj/item/shovel,
		/obj/item/crowbar/cyborg,
		/obj/item/weldingtool/mini,
		/obj/item/extinguisher/mini,
		/obj/item/storage/bag/sheetsnatcher/borg,
		/obj/item/gun/energy/kinetic_accelerator/cyborg,
		/obj/item/gps/cyborg,
		/obj/item/stack/marker_beacon)
	emag_modules = list(/obj/item/borg/stun)
	cyborg_base_icon = "miner"
	moduleselect_icon = "miner"
	hat_offset = 0
	var/obj/item/t_scanner/adv_mining_scanner/cyborg/mining_scanner //built in memes.

//WS Begin
/obj/item/robot_module/miner/be_transformed_to(obj/item/robot_module/old_module)
	var/mob/living/silicon/robot/R = loc
	var/static/list/mining_icons
	if(!mining_icons)
		mining_icons = list(
		"Antique" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "minerbot"),
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "miner"),
		"Wall-A" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "wall-a"),
		"Droid" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "droid-miner"),
		"Marina" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "marinaMN"),
		"Sleek" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "sleekminer"),
		"#31" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "servbot-miner"),
		"Kodiak" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "kodiak-miner"),
		"Noble" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "Noble-SUP"),
		"R34 - MIN2a 'Ishimura'" = image(icon = 'whitesands/icons/mob/robots.dmi', icon_state = "ishimura")
		)
		mining_icons = sortList(mining_icons)
	var/mining_borg_icon = show_radial_menu(R, R , mining_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
	switch(mining_borg_icon)
		if("Antique")
			cyborg_base_icon = "minerbot"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "minerbot"
		if("Default")
			cyborg_base_icon = "miner"
		if("Wall-A")
			cyborg_base_icon = "wall-a"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "wall-a"
		if("Droid")
			cyborg_base_icon = "droid-miner"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "droid-miner"
		if("Marina")
			cyborg_base_icon = "marinaMN"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "marinaMN"
		if("Sleek")
			cyborg_base_icon = "sleekminer"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "sleekminer"
		if("#31")
			cyborg_base_icon = "servbot-miner"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "servbot-miner"
		if("Kodiak")
			cyborg_base_icon = "kodiak-miner"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "kodiak-miner"
		if("Noble")
			cyborg_base_icon = "Noble-SUP"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "Noble-SUP"
		if("R34 - MIN2a 'Ishimura'")
			cyborg_base_icon = "ishimura"
			cyborg_icon_override = 'whitesands/icons/mob/robots.dmi'
			special_light_key = "ishimura"
		else
			return FALSE
	return ..()
//WS End

/obj/item/robot_module/miner/rebuild_modules()
	. = ..()
	if(!mining_scanner)
		mining_scanner = new(src)

/obj/item/robot_module/miner/Destroy()
	QDEL_NULL(mining_scanner)
	return ..()

/obj/item/robot_module/syndicate
	name = "Syndicate Assault"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/melee/transforming/energy/sword/cyborg,
		/obj/item/gun/energy/printer,
		/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg,
		/obj/item/card/emag,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/pinpointer/syndicate_cyborg)

	cyborg_base_icon = "synd_sec"
	moduleselect_icon = "malf"
	can_be_pushed = FALSE
	hat_offset = 3

/obj/item/robot_module/syndicate/rebuild_modules()
	..()
	var/mob/living/silicon/robot/Syndi = loc
	Syndi.faction  -= "silicon" //ai turrets

/obj/item/robot_module/syndicate/remove_module(obj/item/I, delete_after)
	..()
	var/mob/living/silicon/robot/Syndi = loc
	Syndi.faction += "silicon" //ai is your bff now!

/obj/item/robot_module/syndicate_medical
	name = "Syndicate Medical"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/reagent_containers/borghypo/syndicate,
		/obj/item/shockpaddles/syndicate/cyborg,
		/obj/item/healthanalyzer,
				/obj/item/retractor,
		/obj/item/hemostat,
		/obj/item/cautery,
		/obj/item/surgicaldrill,
		/obj/item/scalpel,
		/obj/item/melee/transforming/energy/sword/cyborg/saw,
		/obj/item/roller/robo,
		/obj/item/card/emag,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/pinpointer/syndicate_cyborg,
		/obj/item/stack/medical/gauze/cyborg,
		/obj/item/gun/medbeam,
		/obj/item/organ_storage)

	cyborg_base_icon = "synd_medical"
	moduleselect_icon = "malf"
	can_be_pushed = FALSE
	hat_offset = 3

/obj/item/robot_module/saboteur
	name = "Syndicate Saboteur"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/thermal,
		/obj/item/construction/rcd/borg/syndicate,
		/obj/item/pipe_dispenser,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/extinguisher,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/screwdriver/nuke,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
		/obj/item/stack/sheet/metal/cyborg,
		/obj/item/stack/sheet/glass/cyborg,
		/obj/item/stack/sheet/rglass/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/plasteel/cyborg,
		/obj/item/destTagger/borg,
		/obj/item/stack/cable_coil/cyborg,
		/obj/item/pinpointer/syndicate_cyborg,
		/obj/item/borg_chameleon,
		)

	cyborg_base_icon = "synd_engi"
	moduleselect_icon = "malf"
	can_be_pushed = FALSE
	magpulsing = TRUE
	hat_offset = -4
	canDispose = TRUE

/datum/robot_energy_storage
	var/name = "Generic energy storage"
	var/max_energy = 30000
	var/recharge_rate = 1000
	var/energy

/datum/robot_energy_storage/New(var/obj/item/robot_module/R = null)
	energy = max_energy
	if(R)
		R.storages |= src
	return

/datum/robot_energy_storage/proc/use_charge(amount)
	if (energy >= amount)
		energy -= amount
		if (energy == 0)
			return 1
		return 2
	else
		return 0

/datum/robot_energy_storage/proc/add_charge(amount)
	energy = min(energy + amount, max_energy)

/datum/robot_energy_storage/metal
	name = "Metal Synthesizer"

/datum/robot_energy_storage/glass
	name = "Glass Synthesizer"

/datum/robot_energy_storage/wire
	max_energy = 50
	recharge_rate = 2
	name = "Wire Synthesizer"

/datum/robot_energy_storage/medical
	max_energy = 2500
	recharge_rate = 250
	name = "Medical Synthesizer"

/datum/robot_energy_storage/beacon
	max_energy = 30
	recharge_rate = 1
	name = "Marker Beacon Storage"
