#define HOLOGRAM_CYCLE_COLORS list("#00ffff", "#ffc0cb", "#9400D3", "#4B0082", "#0000FF", "#00FF00", "#FFFF00", "#FF7F00", "#FF0000")

/mob/living/simple_animal/hologram
	name = "hologram"
	initial_language_holder = /datum/language_holder/universal
	icon = 'icons/effects/effects.dmi'
	icon_state = "static"
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	speed = -1
	unsuitable_atmos_damage = 0
	healable = FALSE
	wander = FALSE
	possible_a_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB)
	status_flags = (CANPUSH | CANSTUN | CANKNOCKDOWN)
	dextrous = TRUE
	dextrous_hud_type = /datum/hud/dextrous/hologram
	hud_possible = list(DIAG_STAT_HUD, DIAG_HUD, ANTAG_HUD)
	held_items = list(null, null)
	damage_coeff = list(BRUTE = 0, BURN = 0, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)

	/// The holopad that contains it currently. NOT ALWAYS THE SPAWN HOLOPAD
	var/obj/machinery/holopad/holopad

	/// The job the icon for it is generated with
	var/datum/job/job_type

	/// Internal storage slot. Fits any item
	var/obj/item/internal_storage = null
	/// Pockets (Left and right respectively)
	var/obj/item/l_store = null
	var/obj/item/r_store = null

	/// Items to delete after the hologram dissapears when [/datum/proc/Destroy] is called. This could be done better, but shut up
	var/list/obj/item/holoitems = list()
	/// Item that spawns in the hologram's dex_storage slot
	var/obj/item/dex_item

	/// Action used to toggle the ability to walk through everything
	var/datum/action/innate/hologram/toggle_density/toggle_density_action = new

	/// Flavor text announced to holograms on [/mob/proc/Login]
	var/flavortext = "You have no laws other than SERVE THE CREW AT LARGE AT ANY COST."

/mob/living/simple_animal/hologram/Initialize(mapload, _prefs, _holopad)
	. = ..()

	var/datum/outfit/O
	if(job_type?.outfit)
		O = new job_type.outfit
		O.r_hand = null
		O.l_hand = null //It would be confusing if, say, the medical hologram had a fake medkit

	var/icon/initial_icon = get_flat_human_icon("hologram_[job_type?.title]", job_type, _prefs, "static", outfit_override = O)
	var/icon/alpha_mask = new('icons/effects/effects.dmi', "scanline")//Scanline effect.
	initial_icon.AddAlphaMask(alpha_mask)
	icon = initial_icon
	icon_living = initial_icon

	access_card = new /obj/item/card/id(src)
	access_card?.access |= job_type.access //dunno how the access card would delete itself before then, but this is DM, after all
	ADD_TRAIT(access_card, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

	holopad = _holopad
	holopad.set_holo(src, src)

	toggle_density_action.Grant(src)

	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.add_to_hud(src)

	if(dex_item)
		var/obj/item/to_add = new dex_item(src)
		equip_to_slot_if_possible(to_add, ITEM_SLOT_DEX_STORAGE)
		holoitems += to_add
		if(!istype(to_add, /obj/item/storage))
			return
		for(var/obj/item/content in to_add.contents)
			holoitems += content

/mob/living/simple_animal/hologram/Destroy()
	. = ..()
	for(var/obj/todelete in holoitems)
		QDEL_NULL(todelete)
	for(var/item in contents)
		dropItemToGround(item)
	QDEL_NULL(holopad?.holorays[src])
	LAZYREMOVE(holopad?.holorays, src)
	QDEL_NULL(access_card) //Otherwise it ends up on the floor! ...apparently
	QDEL_NULL(toggle_density_action)

/mob/living/simple_animal/hologram/gib()
	dust()

/mob/living/simple_animal/hologram/Move(atom/newloc, direct)
	. = ..()
	if(!holopad.anchored || holopad.machine_stat)
		for(var/I in holopad.holopads)
			var/obj/machinery/holopad/another = I
			if(another == holopad || another.machine_stat || !another.anchored)
				continue
			if(another.validate_location(get_turf(newloc), FALSE, FALSE))
				holopad.unset_holo(src)
				if(another.masters && another.masters[src])
					another.clear_holo(src)
				another.set_holo(src, src)
				holopad = another
				return
			else if(istype(another, /obj/machinery/holopad/emergency))
				var/obj/machinery/holopad/emergency/emh = another
				if(emh.em == src)
					if(another == holopad)
						continue
					holopad.unset_holo(src)
					if(emh.masters && another.masters[src])
						emh.clear_holo(src)
					emh.set_holo(src, src)
					holopad = emh
					forceMove(get_turf(emh.loc))
					to_chat(src, "<span class='danger'>Your current holoprojector stops working, and you reset to your primary one!</span>")
	if(holopad)
		holopad.update_holoray(src, get_turf(newloc))
		if(!holopad.validate_location(get_turf(newloc), FALSE, FALSE))
			for(var/I in holopad.holopads)
				var/obj/machinery/holopad/another = I
				if(another == holopad || another.machine_stat || !another.anchored)
					continue
				if(another.validate_location(get_turf(newloc), FALSE, FALSE))
					holopad.unset_holo(src)
					if(another.masters && another.masters[src])
						another.clear_holo(src)
					another.set_holo(src, src)
					holopad = another
					return
			forceMove(get_turf(holopad.loc))
			to_chat(src, "<span class='danger'>You've gone too far from your holoprojector!</span>")

/mob/living/simple_animal/hologram/emag_act(mob/user)
	. = ..()
	if(user == src)
		return //no free antag holograms sorry
	if(user)
		var/str = reject_bad_text(stripped_input(user, "Type in a custom law if you want to set one.", "Set laws","", CONFIG_GET(number/max_law_len)))
		if(str && length(str))
			flavortext = str
		else
			flavortext = "Serve [user]."
		to_chat(user, "<span class='notice'>You [density ? "poke [src] with your card" : "slide your card through the air where [src] is"], and set their laws to [str].</span>")
	src.visible_message("<span class='danger'>[src] starts flickering!</span>",
						"<span class='userdanger'>You start flickering, and detect an unauthorized law change!</span>",
						"<span class='danger'>You hear a strange buzzing noise!</span>")
	possible_a_intents |= list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, INTENT_HARM)
	show_laws()
	disco(src)

/mob/living/simple_animal/hologram/proc/disco()
	color = pick(HOLOGRAM_CYCLE_COLORS)
	alpha = rand(75, 180)
	addtimer(CALLBACK(src, .proc/disco, src), 5) //Call ourselves every 0.5 seconds to change color

/mob/living/simple_animal/hologram/med_hud_set_health()
	var/image/holder = hud_list[DIAG_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = "huddiag[RoundDiagBar(health/maxHealth)]"

/mob/living/simple_animal/hologram/med_hud_set_status()
	var/image/holder = hud_list[DIAG_STAT_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	if(stat == DEAD)
		holder.icon_state = "huddead2"
	else if(incapacitated())
		holder.icon_state = "hudoffline"
	else
		holder.icon_state = "hudstat"

/datum/action/innate/hologram/toggle_density
	name = "Toggle Density"
	desc = "Remodulate your holo-emitters to pass through matter."
	icon_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "blink"

/datum/action/innate/hologram/toggle_density/Activate()
	var/mob/living/simple_animal/hologram/H = owner
	H.toggle_density()

/mob/living/simple_animal/hologram/verb/toggle_density() //made it a verb in case people prefer the verb entry box over an action
	set category = "Hologram"
	set name = "Toggle Density"
	set desc = "Remodulate your holo-emitters to pass through matter."
	density = !density
	if(density)
		movement_type = GROUND
		pass_flags = null
		dextrous = TRUE
	else
		movement_type = FLYING
		pass_flags = PASSGLASS|PASSGRILLE|PASSMOB|PASSTABLE
		drop_all_held_items() //can't hold things when you don't actually exist
		dextrous = FALSE//see above comment
	to_chat(src, "You toggle your density [density ? "on" : "off"].")
	update_icon()
	update_gravity()

/mob/living/simple_animal/hologram/update_icon()
	. = ..()
	alpha = density ? initial(alpha) : 100 //applies opacity effect if non-dense
	color = density ? initial(color) : "#77abff" //makes the hologram slightly blue

/mob/living/simple_animal/hologram/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	show_laws()
	add_verb(src, list(/mob/living/simple_animal/hologram/verb/toggle_density, /mob/living/simple_animal/hologram/verb/show_laws))

/mob/living/simple_animal/hologram/verb/show_laws()
	set category = "Hologram"
	set name = "Show Laws"
	set desc = "Show the laws you're required to follow."
	var/formatted_laws = "<b>Hologram law:</b>\n"
	formatted_laws += flavortext ? "<big><span class='warning'>[flavortext]</span></big>" : "<big>No laws set!</big>" //If flavortext set, show it, else show "No laws set!"
	formatted_laws += "\n<span class='notice'>Emergency holograms are ghost spawns that can majorly affect the round due to their versatility. Act with common sense.</span>\n"+\
					  "<span class='notice'>Using the role to grief or metagame against your set laws will be met with a silicon ban.</span>\n"

	var/policy = get_policy(ROLE_POSIBRAIN) //if we need something different than the use of posibrains for policy and bans, ping mark and he'll add a new define for it
	if(policy)
		formatted_laws += policy

	to_chat(src, formatted_laws)

/mob/living/simple_animal/hologram/auto_deadmin_on_login()
	if(!client?.holder)
		return TRUE
	if(CONFIG_GET(flag/auto_deadmin_silicons) || (client.prefs?.toggles & DEADMIN_POSITION_SILICON))
		return client.holder.auto_deadmin()
	return ..()

/mob/living/simple_animal/hologram/assess_threat(judgement_criteria, lasercolor = "", datum/callback/weaponcheck=null) //beepsky isn't stupid
	return -10

/mob/living/simple_animal/hologram/handle_temperature_damage()
	return FALSE

/mob/living/simple_animal/hologram/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0)
	if(affect_silicon)
		return ..()

/mob/living/simple_animal/hologram/mob_negates_gravity()
	return TRUE

/mob/living/simple_animal/hologram/mob_has_gravity()
	return ..() || mob_negates_gravity()

/mob/living/simple_animal/hologram/experience_pressure_difference(pressure_difference, direction)
	return //holograms can't feel the breeze

/mob/living/simple_animal/hologram/bee_friendly()
	return TRUE //See: Star Trek Voyager S3 E12

/mob/living/simple_animal/hologram/electrocute_act(shock_damage, source, siemens_coeff, flags = NONE)
	return FALSE //You can't shock a hologram dumbass

/mob/living/simple_animal/hologram/medical
	job_type = new /datum/job/doctor
	dex_item = /obj/item/storage/belt/medical/surgery

/mob/living/simple_animal/hologram/bar
	job_type = new /datum/job/bartender
	dex_item = /obj/item/reagent_containers/food/drinks/shaker

/mob/living/simple_animal/hologram/science
	job_type = new /datum/job/scientist
	dex_item = /obj/item/storage/belt/utility/atmostech

/mob/living/simple_animal/hologram/engineering
	job_type = new /datum/job/engineer
	dex_item = /obj/item/storage/belt/utility/full

/mob/living/simple_animal/hologram/command
	job_type = new /datum/job/head_of_personnel
	dex_item = /obj/item/card/id/silver/hologram

#undef HOLOGRAM_CYCLE_COLORS
