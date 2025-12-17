#define CELL_DRAIN_TIME 35
#define CELL_POWER_GAIN (3    * ELZUOSE_CHARGE_SCALING_MULTIPLIER)
#define CELL_POWER_DRAIN (37.5 * ELZUOSE_CHARGE_SCALING_MULTIPLIER)

/obj/item/stock_parts/cell
	name = "power cell"
	desc = "A rechargeable electrochemical power cell."
	icon = 'icons/obj/power.dmi'
	icon_state = "cell"
	item_state = "cell"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	force = 5
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/charge = 0	// note %age conveted to actual charge in New
	var/maxcharge = 1000
	custom_materials = list(/datum/material/iron=700, /datum/material/glass=50)
	grind_results = list(/datum/reagent/lithium = 15, /datum/reagent/iron = 5, /datum/reagent/silicon = 5)
	var/rigged = FALSE	// true if rigged to
	var/show_rigged = TRUE // whether if the cell shows it's fauly on examine.
	var/chargerate = 100 //how much power is given every tick in a recharger
	var/self_recharge = 0 //does it self recharge, over time, or not?
	var/ratingdesc = TRUE
	var/grown_battery = FALSE // If it's a grown that acts as a battery, add a wire overlay to it.
	//fuck ass blinky light toggle (turn off for weapon cells)
	var/blinky_light = TRUE

/obj/item/stock_parts/cell/get_cell()
	return src

/obj/item/stock_parts/cell/Initialize(mapload, spawn_empty, override_maxcharge)
	. = ..()
	START_PROCESSING(SSobj, src)
	create_reagents(5, INJECTABLE | DRAINABLE)
	if (override_maxcharge)
		maxcharge = override_maxcharge
	charge = maxcharge
	if(spawn_empty)
		charge = 0
	if(ratingdesc)
		desc += " This one has a rating of [DisplayEnergy(maxcharge)], and you should not swallow it."
	update_appearance()

/obj/item/stock_parts/cell/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/stock_parts/cell/vv_edit_var(var_name, var_value)
	switch(var_name)
		if(NAMEOF(src, self_recharge))
			if(var_value)
				START_PROCESSING(SSobj, src)
			else
				STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/stock_parts/cell/process(seconds_per_tick)
	if(self_recharge)
		give(chargerate * 0.125 * seconds_per_tick)
	else
		return PROCESS_KILL

/obj/item/stock_parts/cell/update_overlays()
	. = ..()
	if(grown_battery)
		. += mutable_appearance('icons/obj/power.dmi', "grown_wires")
	if(blinky_light)
		if(charge < 0.01)
			return
		else if(charge/maxcharge >=0.995)
			. += "cell-o2"
		else
			. += "cell-o1"

/obj/item/stock_parts/cell/proc/percent()		// return % charge of cell
	return 100*charge/maxcharge

// use power from a cell
/obj/item/stock_parts/cell/use(amount, log = TRUE)
	if(rigged && amount > 0)
		explode()
		return 0
	if(charge < amount)
		return 0
	charge = (charge - amount)
	if(log)
		SSblackbox.record_feedback("tally", "cell_used", 1, type)
	return 1

// recharge the cell
/obj/item/stock_parts/cell/proc/give(amount)
	if(rigged && amount > 0)
		explode()
		return 0
	if(maxcharge < amount)
		amount = maxcharge
	var/power_used = min(maxcharge-charge,amount)
	charge += power_used
	return power_used

/obj/item/stock_parts/cell/examine(mob/user)
	. = ..()
	if(rigged && show_rigged)
		. += span_danger("This power cell seems to be faulty!")
	else
		. += "The charge meter reads [round(src.percent())]%."

/obj/item/stock_parts/cell/on_reagent_change(changetype)
	rigged = !isnull(reagents.has_reagent(/datum/reagent/toxin/plasma, 5)) //has_reagent returns the reagent datum
	..()


/obj/item/stock_parts/cell/proc/explode()
	var/turf/T = get_turf(src.loc)
	if (charge==0)
		return
	var/devastation_range = -1 //round(charge/11000)
	var/heavy_impact_range = round(sqrt(charge)/60)
	var/light_impact_range = round(sqrt(charge)/30)
	var/flash_range = light_impact_range
	if (light_impact_range==0)
		rigged = FALSE
		corrupt()
		return
	//explosion(T, 0, 1, 2, 2)
	explosion(T, devastation_range, heavy_impact_range, light_impact_range, flash_range)
	qdel(src)

/obj/item/stock_parts/cell/proc/corrupt()
	charge /= 2
	maxcharge = max(maxcharge/2, chargerate)
	if (prob(10))
		rigged = TRUE //broken batterys are dangerous

/obj/item/stock_parts/cell/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	charge -= 1000 / severity
	if (charge < 0)
		charge = 0

/obj/item/stock_parts/cell/ex_act(severity, target)
	..()
	if(!QDELETED(src))
		switch(severity)
			if(2)
				if(prob(50))
					corrupt()
			if(3)
				if(prob(25))
					corrupt()

/obj/item/stock_parts/cell/attack_self(mob/user)
	if(iselzuose(user))
		var/mob/living/carbon/human/H = user
		var/datum/species/elzuose/E = H.dna.species
		var/charge_limit = ELZUOSE_CHARGE_DANGEROUS - CELL_POWER_GAIN
		if(E.drain_time > world.time)
			return
		if(charge < CELL_POWER_DRAIN)
			to_chat(H, span_warning("[src] doesn't have enough power!"))
			return
		var/obj/item/organ/stomach/ethereal/stomach = H.getorganslot(ORGAN_SLOT_STOMACH)
		if(stomach.crystal_charge > charge_limit)
			to_chat(H, span_warning("Your charge is full!"))
			return
		to_chat(H, span_notice("You begin clumsily channeling power from [src] into your body."))
		E.drain_time = world.time + CELL_DRAIN_TIME
		if(do_after(user, CELL_DRAIN_TIME, target = src))
			if((charge < CELL_POWER_DRAIN) || (stomach.crystal_charge > charge_limit))
				return
			if(istype(stomach))
				to_chat(H, span_notice("You receive some charge from [src], wasting some in the process."))
				stomach.adjust_charge(CELL_POWER_GAIN)
				charge -= CELL_POWER_DRAIN //you waste way more than you receive, so that ethereals cant just steal one cell and forget about hunger
			else
				to_chat(H, span_warning("You can't receive charge from [src]!"))
		return

/obj/item/stock_parts/cell/proc/get_electrocute_damage()
	if(charge >= 1000)
		return clamp(20 + round(charge/25000), 20, 195) + rand(-5,5)
	else
		return 0

/obj/item/stock_parts/cell/get_part_rating()
	return rating * maxcharge

/* Cell variants*/
/obj/item/stock_parts/cell/empty/Initialize()
	. = ..()
	charge = 0

/obj/item/stock_parts/cell/crap
	name = "\improper Nanotrasen brand rechargeable AA battery"
	desc = "You can't top the plasma top." //TOTALLY TRADEMARK INFRINGEMENT
	maxcharge = 500
	custom_materials = list(/datum/material/glass=40)

/obj/item/stock_parts/cell/crap/empty/Initialize()
	. = ..()
	charge = 0
	update_appearance()

/obj/item/stock_parts/cell/upgraded
	name = "upgraded power cell"
	desc = "A power cell with a slightly higher capacity than normal!"
	maxcharge = 2500
	custom_materials = list(/datum/material/glass=50)
	chargerate = 1000

/obj/item/stock_parts/cell/upgraded/plus
	name = "upgraded power cell+"
	desc = "A power cell with an even higher capacity than the base model!"
	maxcharge = 5000

/obj/item/stock_parts/cell/secborg
	name = "security borg rechargeable D battery"
	maxcharge = 6000	//6000 max charge / 1000 charge per shot = six shots
	custom_materials = list(/datum/material/glass=40)

/obj/item/stock_parts/cell/secborg/empty/Initialize()
	. = ..()
	charge = 0
	update_appearance()

/obj/item/stock_parts/cell/mini_egun
	name = "miniature energy gun power cell"
	maxcharge = 600
	rating = 0 //gun batteries now incompatible with RPED WS edit

/obj/item/stock_parts/cell/hos_gun
	name = "X-01 multiphase energy gun power cell"
	maxcharge = 1200
	rating = 0 //gun batteries now incompatible with RPED WS edit

/obj/item/stock_parts/cell/pulse //200 pulse shots
	name = "pulse rifle power cell"
	maxcharge = 400000
	chargerate = 1500
	rating = 0 //gun batteries now incompatible with RPED WS edit

/obj/item/stock_parts/cell/pulse/carbine //25 pulse shots
	name = "pulse carbine power cell"
	maxcharge = 50000
	rating = 0 //gun batteries now incompatible with RPED WS edit

/obj/item/stock_parts/cell/pulse/pistol //10 pulse shots
	name = "pulse pistol power cell"
	maxcharge = 20000
	rating = 0 //gun batteries now incompatible with RPED WS edit

/obj/item/stock_parts/cell/high
	name = "high-capacity power cell"
	icon_state = "hcell"
	maxcharge = 10000
	custom_materials = list(/datum/material/glass=60)
	chargerate = 1500

/obj/item/stock_parts/cell/high/plus
	name = "high-capacity power cell+"
	desc = "Where did these come from?"
	icon_state = "h+cell"
	maxcharge = 15000
	chargerate = 2250
	rating = 2

/obj/item/stock_parts/cell/high/empty/Initialize()
	. = ..()
	charge = 0
	update_appearance()

/obj/item/stock_parts/cell/super
	name = "super-capacity power cell"
	icon_state = "scell"
	maxcharge = 20000
	custom_materials = list(/datum/material/glass=300)
	chargerate = 2000
	rating = 3

/obj/item/stock_parts/cell/super/empty/Initialize()
	. = ..()
	charge = 0
	update_appearance()

/obj/item/stock_parts/cell/hyper
	name = "hyper-capacity power cell"
	icon_state = "hpcell"
	maxcharge = 30000
	custom_materials = list(/datum/material/glass=400)
	chargerate = 3000
	rating = 4

/obj/item/stock_parts/cell/hyper/empty/Initialize()
	. = ..()
	charge = 0
	update_appearance()

/obj/item/stock_parts/cell/bluespace
	name = "bluespace power cell"
	desc = "A rechargeable transdimensional power cell."
	icon_state = "bscell"
	maxcharge = 40000
	custom_materials = list(/datum/material/glass=600)
	chargerate = 4000
	rating = 5

/obj/item/stock_parts/cell/bluespace/empty/Initialize()
	. = ..()
	charge = 0
	update_appearance()

/obj/item/stock_parts/cell/infinite
	name = "infinite-capacity power cell!"
	icon_state = "icell"
	maxcharge = 30000
	custom_materials = list(/datum/material/glass=1000)
	rating = 100
	chargerate = 30000

/obj/item/stock_parts/cell/infinite/use()
	return 1

/obj/item/stock_parts/cell/infinite/abductor
	name = "void core"
	desc = "An alien power cell that produces energy seemingly out of nowhere."
	icon = 'icons/obj/abductor.dmi'
	icon_state = "cell"
	maxcharge = 50000
	ratingdesc = FALSE

/obj/item/stock_parts/cell/infinite/abductor/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/stock_parts/cell/potato
	name = "potato battery"
	desc = "A rechargeable starch based power cell."
	icon = 'icons/obj/hydroponics/harvest.dmi'
	icon_state = "potato"
	charge = 100
	maxcharge = 300
	custom_materials = null
	grown_battery = TRUE //it has the overlays for wires

/obj/item/stock_parts/cell/emproof
	name = "\improper EMP-proof cell"
	desc = "An EMP-proof cell."
	maxcharge = 500
	rating = 3

/obj/item/stock_parts/cell/emproof/empty/Initialize()
	. = ..()
	charge = 0
	update_appearance()

/obj/item/stock_parts/cell/emproof/empty/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/empprotection, EMP_PROTECT_SELF)

/obj/item/stock_parts/cell/emproof/corrupt()
	return

/obj/item/stock_parts/cell/beam_rifle
	name = "beam rifle capacitor"
	desc = "A high powered capacitor that can provide huge amounts of energy in an instant."
	maxcharge = 50000
	chargerate = 5000	//Extremely energy intensive

/obj/item/stock_parts/cell/beam_rifle/corrupt()
	return

/obj/item/stock_parts/cell/beam_rifle/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	charge = clamp((charge-(10000/severity)),0,maxcharge)

/obj/item/stock_parts/cell/emergency_light
	name = "miniature power cell"
	desc = "A tiny power cell with a very low power capacity. Used in light fixtures to power them in the event of an outage."
	maxcharge = 120 //Emergency lights use 0.2 W per tick, meaning ~10 minutes of emergency power from a cell
	custom_materials = list(/datum/material/glass = 20)
	w_class = WEIGHT_CLASS_TINY

/obj/item/stock_parts/cell/emergency_light/Initialize()
	. = ..()
	var/area/A = get_area(src)
	if(!A.lightswitch || !A.light_power)
		charge = 0 //For naturally depowered areas, we start with no power

// gun power cell //
/obj/item/stock_parts/cell/gun
	name = "eoehoma power cell"
	desc = "A rechargeable weapon cell. While intended for Eoehoma laser weapons, these are compatable with various other manufactorer's designs, intentionally or not."
	icon = 'icons/obj/power.dmi'
	icon_state = "e-cell"
	maxcharge = 10000
	custom_materials = list(/datum/material/glass=60)
	chargerate = 1500
	rating = 0 //Makes it incompatible with RPED
	blinky_light = FALSE
	auto_scatter = FALSE
	var/start_empty = FALSE //this really wasn't a var before?

/obj/item/stock_parts/cell/gun/Initialize()
	. = ..()
	if(!start_empty)
		return
	charge = 0
	update_appearance()

/obj/item/stock_parts/cell/gun/empty
	start_empty = TRUE

/obj/item/stock_parts/cell/gun/update_overlays()
	. = ..()
	cut_overlays()
	if(charge < 0.1)
		return
	else if(charge/maxcharge >=0.995)
		. += "[initial(icon_state)]-o4"
	else if(charge/maxcharge >=0.745)
		. += "[initial(icon_state)]-o3"
	else if(charge/maxcharge >=0.495)
		. += "[initial(icon_state)]-o2"
	else if(charge/maxcharge >=0.145)
		. += "[initial(icon_state)]-o1"
	return .

/obj/item/stock_parts/cell/gun/upgraded
	name = "high-capacity eoehoma power cell"
	desc = "A high capacity weapon cell. Intended for use in heavy weapons and the odd piece of personal gear."
	icon_state = "e-class2-cell"
	maxcharge = 20000
	custom_materials = list(/datum/material/glass=300)
	chargerate = 2000

/obj/item/stock_parts/cell/gun/upgraded/empty
	start_empty = TRUE

/obj/item/stock_parts/cell/gun/mini
	name = "miniature eoehoma power cell"
	icon_state = "e_mini-cell"
	maxcharge = 5000
	custom_materials = list(/datum/material/glass=300)
	chargerate = 1000

/obj/item/stock_parts/cell/gun/mini/empty
	start_empty = TRUE

/obj/item/stock_parts/cell/gun/solgov
	name = "SolGov power cell"
	icon_state = "g-sg-cell"
	maxcharge = 15000

/obj/item/stock_parts/cell/gun/large
	name = "extra-large weapon power cell"
	icon_state = "bg-cell"
	maxcharge = 50000
	custom_materials = list(/datum/material/glass=1000)
	chargerate = 5000
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/stock_parts/cell/gun/large/empty
	start_empty = TRUE

/obj/item/stock_parts/cell/gun/kalix
	name = "Etherbor EWC-5"
	desc = "Brought to you by Etherbor Industries, proudly based within the PGF, is the EWC-5, an energy cell compatible with any Etherbor Industries energy weapons."
	icon_state = "kalix-cell"
	maxcharge = 12750 // 15 shots at 850 energy per
	chargerate = 1750

/obj/item/stock_parts/cell/gun/kalix/empty
	start_empty = TRUE

/obj/item/stock_parts/cell/gun/pgf
	name = "Etherbor EWC-6m"
	desc = "Exclusive only to the PGF military, the EWC-6m is an Etherbor energy weapon cell designed for military-grade use, including expanded capacity and output."
	icon_state = "pgf-cell"
	maxcharge = 20000 // 20 shots at 1000 energy per
	chargerate = 2000

/obj/item/stock_parts/cell/gun/pgf/empty
	start_empty = TRUE

/obj/item/stock_parts/cell/gun/sharplite
	name = "Sharplite power cell"
	desc = "A proprietary power cell primarily used by Sharplite weaponry. Nanotrasen's large market share has forced some weapon developers to include adapters for these cells"
	icon = 'icons/obj/power.dmi'
	icon_state = "nt-cell"

/obj/item/stock_parts/cell/gun/sharplite/empty
	start_empty = TRUE

/obj/item/stock_parts/cell/gun/sharplite/plus
	name = "Sharplite Plus power cell"
	desc = "An high-capacity weapon cell used exclusively by Sharplite weaponry. They are a great improvement over the stock cell, and are frequently sought after by collectors, soldiers, and operators of heavy lasers alike."
	icon_state = "nt_plus-cell"

	maxcharge = 20000
	custom_materials = list(/datum/material/glass=300)
	chargerate = 2000

/obj/item/stock_parts/cell/gun/sharplite/plus/empty
	start_empty = TRUE

/obj/item/stock_parts/cell/gun/sharplite/mini
	name = "Sharplite Compact power cell"
	desc = "A compact weapon cell used exclusively by Sharplite weaponry. It holds less charge and is intended for usage in energy handguns."
	icon_state = "nt_mini-cell"
	maxcharge = 7000
	custom_materials = list(/datum/material/glass=300)
	chargerate = 1000

/obj/item/stock_parts/cell/gun/sharplite/mini/empty
	start_empty = TRUE

#undef CELL_DRAIN_TIME
#undef CELL_POWER_GAIN
#undef CELL_POWER_DRAIN
