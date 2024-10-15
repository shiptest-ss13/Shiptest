
#define GIBTONITE_QUALITY_HIGH 3
#define GIBTONITE_QUALITY_MEDIUM 2
#define GIBTONITE_QUALITY_LOW 1

#define ORESTACK_OVERLAYS_MAX 10

/**********************Mineral ores**************************/

/obj/item/stack/ore
	name = "rock"
	icon = 'icons/obj/materials/ores.dmi'
	icon_state = "ore"
	item_state = "ore"
	full_w_class = WEIGHT_CLASS_BULKY
	singular_name = "ore chunk"
	var/points = 0 //How many points this ore gets you from the ore redemption machine
	var/refined_type = null //What this ore defaults to being refined into
	var/mine_experience = 5 //How much experience do you get for mining this ore?
	novariants = TRUE // Ore stacks handle their icon updates themselves to keep the illusion that there's more going
	var/list/stack_overlays
	var/scan_state = "" //Used by mineral turfs for their scan overlay.
	var/spreadChance = 0 //Also used by mineral turfs for spreading veins

/obj/item/stack/ore/update_overlays()
	. = ..()
	var/difference = min(ORESTACK_OVERLAYS_MAX, amount) - (LAZYLEN(stack_overlays)+1)
	if(difference == 0)
		return
	else if(difference < 0 && LAZYLEN(stack_overlays))			//amount < stack_overlays, remove excess.
		if (LAZYLEN(stack_overlays)-difference <= 0)
			stack_overlays = null
		else
			stack_overlays.len += difference
	else if(difference > 0)			//amount > stack_overlays, add some.
		for(var/i in 1 to difference)
			var/mutable_appearance/newore = mutable_appearance(icon, icon_state)
			newore.pixel_x = rand(-8,8)
			newore.pixel_y = rand(-8,8)
			LAZYADD(stack_overlays, newore)
	if (stack_overlays)
		. += stack_overlays

/obj/item/stack/ore/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if(isnull(refined_type))
		return
	else
		var/probability = (rand(0,100))/100
		var/burn_value = probability*amount
		var/amountrefined = round(burn_value, 1)
		if(amountrefined < 1)
			qdel(src)
		else
			new refined_type(drop_location(),amountrefined)
			qdel(src)

/obj/item/stack/ore/hematite
	name = "hematite"
	icon_state = "hematite"
	item_state = "hematite"

	custom_materials = list(/datum/material/iron=500)
	refined_type = /obj/item/stack/ore/slag
	mine_experience = 1
	scan_state = "hematite"
	spreadChance = 45

/obj/item/stack/ore/magnetite
	name = "magnetite"
	icon_state = "magnetite"
	item_state = "magnetite"

	custom_materials = list(/datum/material/iron=ORE_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/metal
	mine_experience = 1
	scan_state = "magnetite"
	spreadChance = 20

/obj/item/stack/ore/malachite
	name = "malachite"
	icon_state = "malachite"
	item_state = "malachite"
	custom_materials = list(/datum/material/copper=ORE_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/copper
	scan_state = "malachite"
	spreadChance = 30

/obj/item/stack/ore/galena
	name = "galena"
	icon_state = "galena"
	item_state = "galena"
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/lead=9480,/datum/material/sulfur=500,/datum/material/silver=20)
	refined_type = /obj/item/stack/sheet/mineral/lead
	scan_state = "galena"
	spreadChance = 20

/obj/item/stack/ore/proustite
	name = "proustite"
	icon_state = "proustite"
	item_state = "proustite"
	custom_materials = list(/datum/material/silver=ORE_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/silver
	scan_state = "proustite"
	spreadChance = 10

/obj/item/stack/ore/autunite
	name = "autunite"
	icon_state = "autunite"
	item_state = "autunite"
	points = 30
	//material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/uranium=500)
	refined_type = /obj/item/stack/ore/slag
	mine_experience = 6
	scan_state = "autunite"
	spreadChance = 10

/obj/item/stack/ore/gold
	name = "gold ore"
	icon_state = "goldore"
	item_state = "goldore"
	custom_materials = list(/datum/material/gold=ORE_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/gold
	scan_state = "goldore"
	spreadChance = 10

/obj/item/stack/ore/plasma
	name = "phoron"
	icon_state = "phoron"
	item_state = "phoron"

	points = 15
	custom_materials = list(/datum/material/plasma=1650, /datum/material/sulfur=50, /datum/material/carbon=100, /datum/material/quartz=200)
	refined_type = /obj/item/stack/ore/slag
	mine_experience = 5
	scan_state = "phoron"
	spreadChance = 15

/obj/item/stack/ore/plasma/attackby(obj/item/W as obj, mob/user as mob, params)
	if(W.get_temperature() > 300)//If the temperature of the object is over 300, then ignite
		var/turf/T = get_turf(src)
		message_admins("Plasma ore ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(T)]")
		log_game("Plasma ore ignited by [key_name(user)] in [AREACOORD(T)]")
		fire_act(W.get_temperature())
	else
		return ..()

/obj/item/stack/ore/plasma/fire_act(exposed_temperature, exposed_volume)
	atmos_spawn_air("plasma=[amount*5];TEMP=[exposed_temperature]")
	qdel(src)

/obj/item/stack/ore/sulfur
	name = "sulfur dust"
	icon_state = "sulfur"
	item_state = "sulfur"
	grind_results = list(/datum/reagent/sulfur = 10)
	points = 1
	scan_state = "sulfur"
	custom_materials = list(/datum/material/sulfur=ORE_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/ore/slag
	w_class = WEIGHT_CLASS_TINY

/obj/item/stack/ore/sulfur/pyrite
	name = "pyrite"
	icon_state = "pyrite"
	item_state = "pyrite"
	grind_results = list(/datum/reagent/sulfur = 5,/datum/reagent/iron = 5)
	points = 1
	scan_state = "pyrite"
	material_flags = MATERIAL_NO_EFFECTS
	custom_materials = list(/datum/material/sulfur=495,/datum/material/iron=495,/datum/material/gold=10)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/stack/ore/sulfur/attackby(obj/item/weapon as obj, mob/user as mob, params)
	if(weapon.get_temperature() > 300)//If the temperature of the object is over 300, then ignite
		var/turf/current_turf = get_turf(src)
		message_admins("Sulfur ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(current_turf)]")
		log_game("Sulfur ignited by [key_name(user)] in [AREACOORD(current_turf)]")
		fire_act(weapon.get_temperature())
	else
		return ..()

/obj/item/stack/ore/sulfur/ex_act(severity, target)
	. = ..()
	fire_act()

/obj/item/stack/ore/sulfur/fire_act(exposed_temperature, exposed_volume)
	var/turf/current_turf = get_turf(src)
	if(isopenturf(current_turf))
		current_turf.IgniteTurf(1*amount, "blue")
	qdel(src)


/obj/item/stack/ore/diamond
	name = "diamond ore"
	icon_state = "diamondore"
	item_state = "diamondore"

	points = 50
	custom_materials = list(/datum/material/diamond=ORE_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/ore/slag
	mine_experience = 10
	scan_state = "diamondore"


/obj/item/stack/ore/rutile
	name = "rutile"
	icon_state = "rutile"
	item_state = "rutile"
	points = 50
	custom_materials = list(/datum/material/titanium=900, /datum/material/iron=100)
	refined_type = /obj/item/stack/sheet/mineral/titanium
	mine_experience = 3
	scan_state = "rutile"
	spreadChance = 10

/obj/item/stack/ore/graphite
	name = "graphite"
	icon_state = "graphite"
	item_state = "graphite"

	custom_materials = list(/datum/material/carbon=ORE_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/ore/slag
	mine_experience = 1
	scan_state = "graphite"
	spreadChance = 25

//alt version for jungle planets
/obj/item/stack/ore/graphite/coal
	name = "coal"

	custom_materials = list(/datum/material/carbon=200)
	refined_type = /obj/item/stack/ore/slag
	mine_experience = 1
	scan_state = "graphite"
	spreadChance = 85

/obj/item/stack/ore/graphite/coal/attackby(obj/item/W, mob/user, params)
	if(W.get_temperature() > 300)//If the temperature of the object is over 300, then ignite
		var/turf/T = get_turf(src)
		message_admins("Coal ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(T)]")
		log_game("Coal ignited by [key_name(user)] in [AREACOORD(T)]")
		fire_act(W.get_temperature())
		T.IgniteTurf((W.get_temperature()/20))
		return TRUE
	else
		return ..()

/obj/item/stack/ore/graphite/coal/fire_act(exposed_temperature, exposed_volume)
	atmos_spawn_air("co2=[amount*10];TEMP=[exposed_temperature]")
	qdel(src)

/obj/item/stack/ore/quartzite
	name = "quartzite"
	icon_state = "quartzite"
	item_state = "quartzite"

	custom_materials = list(/datum/material/quartz=ORE_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/ore/slag
	mine_experience = 1
	scan_state = "quartzite"
	spreadChance = 45

/obj/item/stack/ore/glass
	name = "rocky sand"
	icon_state = "rocky_sand"
	item_state = "rocky_sand"
	singular_name = "sand pile"
	grind_results = list(/datum/reagent/quartz = 10)
	points = 1
	custom_materials = list(/datum/material/quartz = 500)
	refined_type = /obj/item/stack/sheet/glass
	w_class = WEIGHT_CLASS_TINY
	mine_experience = 0 //its sand

/obj/item/stack/ore/glass/basalt
	name = "volcanic ash"
	icon_state = "volcanic_sand"
	item_state = "volcanic_sand"
	singular_name = "volcanic ash pile"
	grind_results = list(/datum/reagent/toxin/lava_microbe = 1, /datum/reagent/ash = 8.5, /datum/reagent/quartz = 5)
	custom_materials = list(/datum/material/quartz = 250, /datum/material/silicon = 50, /datum/material/carbon = 100, /datum/material/sulfur = 10)

/obj/item/stack/ore/glass/whitesands
	name = "white sand pile"
	icon_state = "whitesands"
	item_state = "whitesands"
	singular_name = "white sand pile"
	grind_results = list(/datum/reagent/consumable/sodiumchloride = 10, /datum/reagent/quartz = 10)
	custom_materials = list(/datum/material/quartz = 500)

/obj/item/stack/ore/glass/rockplanet
	name = "oxidized sand pile"
	icon_state = "rockplanet_sand"
	item_state = "rockplanet_sand"
	singular_name = "iron sand pile"
	grind_results = list(/datum/reagent/quartz = 10, /datum/reagent/iron = 2)
	custom_materials = list(/datum/material/quartz = 500, /datum/material/quartz = 50)

/obj/item/stack/ore/glass/wasteplanet
	name = "oily dust"
	icon_state = "wasteplanet_sand"
	item_state = "wasteplanet_sand"
	singular_name = "rocky dust"
	grind_results = list(/datum/reagent/quartz = 5, /datum/reagent/lithium = 2, /datum/reagent/uranium/radium = 1, /datum/reagent/chlorine = 1, /datum/reagent/aluminium = 1)//may be unsafe for human consumption
	custom_materials = list(/datum/material/quartz = 250)

/obj/item/stack/ore/glass/beach
	name = "beige sand pile"
	icon_state = "beach_sand"
	item_state = "beach_sand"
	singular_name = "beige sand pile"
	grind_results = list(/datum/reagent/quartz = 10)
	custom_materials = list(/datum/material/quartz = 500)

GLOBAL_LIST_INIT(sand_recipes, list(\
		new /datum/stack_recipe("sandstone", /obj/item/stack/sheet/mineral/sandstone, 1, 1, 50),\
		new /datum/stack_recipe("aesthetic volcanic floor tile", /obj/item/stack/tile/basalt, 2, 1, 50)\
))

/obj/item/stack/ore/glass/get_main_recipes()
	. = ..()
	. += GLOB.sand_recipes

/obj/item/stack/ore/glass/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(..() || !ishuman(hit_atom))
		return
	var/mob/living/carbon/human/C = hit_atom
	if(C.is_eyes_covered())
		C.visible_message("<span class='danger'>[C]'s eye protection blocks the sand!</span>", "<span class='warning'>Your eye protection blocks the sand!</span>")
		return
	C.adjust_blurriness(6)
	C.adjustStaminaLoss(15)//the pain from your eyes burning does stamina damage
	C.confused += 5
	to_chat(C, "<span class='userdanger'>\The [src] gets into your eyes! The pain, it burns!</span>")
	qdel(src)

/obj/item/stack/ore/glass/ex_act(severity, target)
	if (severity == EXPLODE_NONE)
		return
	qdel(src)

/obj/item/stack/ore/hellstone
	name = "hellstone ore"
	icon_state = "hellstone-ore"
	item_state = "hellstone-ore"
	singular_name = "hellstone ore chunk"
	resistance_flags = LAVA_PROOF
	points = 50
	custom_materials = list(/datum/material/hellstone=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/hidden/hellstone

/obj/item/stack/ore/slag
	name = "slag"
	desc = "Completely useless."
	icon_state = "slag"
	item_state = "slag"
	singular_name = "slag chunk"

/obj/item/stack/ore/ice
	name = "ice crystals"
	desc = "Used in an electrolyzer to produce hydrogen and oxygen."
	icon_state = "ice"
	item_state = "ice"
	scan_state = "ice"
	mine_experience = 2
	grind_results = list(/datum/reagent/consumable/ice = 10)
	spreadChance = 10

/obj/item/gibtonite
	name = "gibtonite ore"
	desc = "Extremely explosive if struck with mining equipment, Gibtonite is often used by miners to speed up their work by using it as a mining charge. This material is illegal to possess by unauthorized personnel under space law."
	icon = 'icons/obj/materials/ores.dmi'
	icon_state = "Gibtonite ore"
	item_state = "Gibtonite ore"
	w_class = WEIGHT_CLASS_BULKY
	throw_range = 0
	var/primed = FALSE
	var/det_time = 100
	var/quality = GIBTONITE_QUALITY_LOW //How pure this gibtonite is, determines the explosion produced by it and is derived from the det_time of the rock wall it was taken from, higher value = better
	var/attacher = "UNKNOWN"
	var/det_timer

/obj/item/gibtonite/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/obj/item/gibtonite/Destroy()
	qdel(wires)
	wires = null
	return ..()

/obj/item/gibtonite/attackby(obj/item/I, mob/user, params)
	if(!wires && istype(I, /obj/item/assembly/igniter))
		user.visible_message("<span class='notice'>[user] attaches [I] to [src].</span>", "<span class='notice'>You attach [I] to [src].</span>")
		wires = new /datum/wires/explosive/gibtonite(src)
		attacher = key_name(user)
		qdel(I)
		add_overlay("Gibtonite_igniter")
		return

	if(wires && !primed)
		if(is_wire_tool(I))
			wires.interact(user)
			return

	if(I.tool_behaviour == TOOL_MINING || istype(I, /obj/item/resonator) || I.force >= 10)
		GibtoniteReaction(user)
		return
	if(primed)
		if(istype(I, /obj/item/mining_scanner) || istype(I, /obj/item/t_scanner/adv_mining_scanner) || I.tool_behaviour == TOOL_MULTITOOL)
			primed = FALSE
			if(det_timer)
				deltimer(det_timer)
			user.visible_message("<span class='notice'>The chain reaction stopped! ...The ore's quality looks diminished.</span>", "<span class='notice'>You stopped the chain reaction. ...The ore's quality looks diminished.</span>")
			icon_state = "Gibtonite ore"
			quality = GIBTONITE_QUALITY_LOW
			return
	..()

/obj/item/gibtonite/attack_self(user)
	if(wires)
		wires.interact(user)
	else
		..()

/obj/item/gibtonite/bullet_act(obj/projectile/P)
	GibtoniteReaction(P.firer)
	. = ..()

/obj/item/gibtonite/ex_act()
	GibtoniteReaction(null, 1)

/obj/item/gibtonite/proc/GibtoniteReaction(mob/user, triggered_by = 0)
	if(!primed)
		primed = TRUE
		playsound(src,'sound/effects/hit_on_shattered_glass.ogg',50,TRUE)
		icon_state = "Gibtonite active"
		var/notify_admins = FALSE
		if(z != 5)//Only annoy the admins ingame if we're triggered off the mining zlevel
			notify_admins = TRUE

		if(triggered_by == 1)
			log_bomber(null, "An explosion has primed a", src, "for detonation", notify_admins)
		else if(triggered_by == 2)
			var/turf/bombturf = get_turf(src)
			if(notify_admins)
				message_admins("A signal has triggered a [name] to detonate at [ADMIN_VERBOSEJMP(bombturf)]. Igniter attacher: [ADMIN_LOOKUPFLW(attacher)]")
			var/bomb_message = "A signal has primed a [name] for detonation at [AREACOORD(bombturf)]. Igniter attacher: [key_name(attacher)]."
			log_game(bomb_message)
			GLOB.bombers += bomb_message
		else
			user.visible_message("<span class='warning'>[user] strikes \the [src], causing a chain reaction!</span>", "<span class='danger'>You strike \the [src], causing a chain reaction.</span>")
			log_bomber(user, "has primed a", src, "for detonation", notify_admins)
		det_timer = addtimer(CALLBACK(src, PROC_REF(detonate), notify_admins), det_time, TIMER_STOPPABLE)

/obj/item/gibtonite/proc/detonate(notify_admins)
	if(primed)
		switch(quality)
			if(GIBTONITE_QUALITY_HIGH)
				explosion(src,2,4,9,adminlog = notify_admins)
			if(GIBTONITE_QUALITY_MEDIUM)
				explosion(src,1,2,5,adminlog = notify_admins)
			if(GIBTONITE_QUALITY_LOW)
				explosion(src,0,1,3,adminlog = notify_admins)
		qdel(src)

/obj/item/stack/ore/Initialize()
	. = ..()
	pixel_x = base_pixel_x +  rand(0,16) - 8
	pixel_y = base_pixel_y + rand(0,8) - 8

/obj/item/stack/ore/ex_act(severity, target)
	if (!severity || severity >= 2)
		return
	qdel(src)


/*****************************Coin********************************/

// The coin's value is a value of it's materials.
// Yes, the gold standard makes a come-back!
// This is the only way to make coins that are possible to produce on station actually worth anything.
/obj/item/coin
	icon = 'icons/obj/economy.dmi'
	name = "coin"
	icon_state = "coin"
	flags_1 = CONDUCT_1
	force = 1
	throwforce = 2
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = 400)
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	var/string_attached
	var/list/sideslist = list("heads","tails")
	var/cooldown = 0
	var/value
	var/coinflip
	item_flags = NO_MAT_REDEMPTION //You know, it's kind of a problem that money is worth more extrinsicly than intrinsically in this universe.
	drop_sound = 'sound/items/handling/coin_drop.ogg'
	pickup_sound =  'sound/items/handling/coin_pickup.ogg'
/obj/item/coin/Initialize()
	. = ..()
	coinflip = pick(sideslist)
	icon_state = "coin_[coinflip]"
	pixel_x = base_pixel_x + rand(0,16) - 8
	pixel_y = base_pixel_y + rand(0,8) - 8

/obj/item/coin/set_custom_materials(list/materials, multiplier = 1)
	. = ..()
	value = 0
	for(var/i in custom_materials)
		var/datum/material/M = i
		value += M.value_per_unit * custom_materials[M]

/obj/item/coin/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stack/cable_coil))
		var/obj/item/stack/cable_coil/CC = W
		if(string_attached)
			to_chat(user, "<span class='warning'>There already is a string attached to this coin!</span>")
			return

		if (CC.use(1))
			add_overlay("coin_string_overlay")
			string_attached = 1
			to_chat(user, "<span class='notice'>You attach a string to the coin.</span>")
		else
			to_chat(user, "<span class='warning'>You need one length of cable to attach a string to the coin!</span>")
			return
	else
		..()

/obj/item/coin/wirecutter_act(mob/living/user, obj/item/I)
	..()
	if(!string_attached)
		return TRUE

	new /obj/item/stack/cable_coil(drop_location(), 1)
	overlays = list()
	string_attached = null
	to_chat(user, "<span class='notice'>You detach the string from the coin.</span>")
	return TRUE

/obj/item/coin/attack_self(mob/user)
	if(cooldown < world.time)
		if(string_attached) //does the coin have a wire attached
			to_chat(user, "<span class='warning'>The coin won't flip very well with something attached!</span>" )
			return FALSE//do not flip the coin
		cooldown = world.time + 15
		flick("coin_[coinflip]_flip", src)
		coinflip = pick(sideslist)
		icon_state = "coin_[coinflip]"
		playsound(user.loc, 'sound/items/coinflip.ogg', 50, TRUE)
		var/oldloc = loc
		sleep(15)
		if(loc == oldloc && user && !user.incapacitated())
			user.visible_message(
				"<span class='notice'>[user] flips [src]. It lands on [coinflip].</span>", \
				"<span class='notice'>You flip [src]. It lands on [coinflip].</span>", \
				"<span class='hear'>You hear the clattering of loose change.</span>")
	return TRUE//did the coin flip?

/obj/item/coin/gold
	custom_materials = list(/datum/material/gold = 400)

/obj/item/coin/silver
	custom_materials = list(/datum/material/silver = 400)

/obj/item/coin/diamond
	custom_materials = list(/datum/material/diamond = 400)

/obj/item/coin/plasma
	custom_materials = list(/datum/material/plasma = 400)

/obj/item/coin/uranium
	custom_materials = list(/datum/material/uranium = 400)

/obj/item/coin/titanium
	custom_materials = list(/datum/material/titanium = 400)

/obj/item/coin/plastic
	custom_materials = list(/datum/material/plastic = 400)

/obj/item/coin/hellstone
	custom_materials = list(/datum/material/hellstone = 400)

/obj/item/coin/twoheaded
	desc = "Hey, this coin's the same on both sides!"
	sideslist = list("heads")

/obj/item/coin/antagtoken
	name = "antag token"
	desc = "A novelty coin that helps the heart know what hard evidence cannot prove."
	icon_state = "coin_valid"
	custom_materials = list(/datum/material/plastic = 400)
	sideslist = list("valid", "salad")
	material_flags = NONE

/obj/item/coin/iron

#undef ORESTACK_OVERLAYS_MAX
