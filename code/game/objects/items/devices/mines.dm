
/obj/item/mine
	name = "dummy mine"
	desc = "An anti-personnel mine. This one is designed for training actions. Explodes into harmless sparks."
	icon = 'icons/obj/device.dmi'
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	icon_state = "mine"
	item_state = "assembly"//when we get custom sprites replace this. please
	base_icon_state = "mine"

	/// Is our mine live?
	var/armed = FALSE
	/// Has the mine loc been entered?
	var/clicked = FALSE
	/// Is our mine currently exploding?
	var/triggered = FALSE

	/// Sets a delay for mines going live after being planted
	var/arm_delay = 5 SECONDS
	/// Use to set a delay after activation to trigger the explosion.
	var/blast_delay = 1 SECONDS

	/// When true, mines explode instantly on being stepped upon
	var/hair_trigger = FALSE

	/// Disables the mine without disarming it. perfect for practical jokes
	var/clickblock = FALSE

	var/manufacturer = MANUFACTURER_NONE

	/// Are the wires exposed?
	var/open_panel = FALSE

	/// A surprised tool that'll help us later (handles turf slowdown manipulation)
	var/oldslow

	/// Prevents a mine from being screwdrivable (e.g. cannot be disarmed)
	var/sealed = FALSE

	/// Armed mines will become transparent by a set %. 0 is invisible, default value is fully visible
	var/stealthpwr = 204

	/// Who's got their foot on the mine's pressure plate
	/// Stepping on the mine will set this to the first mob who stepped over it
	/// The mine will not detonate via movement unless the first mob steps off of it
	var/datum/weakref/foot_on_mine

/obj/item/mine/Initialize()
	. = ..()

	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_ATOM_EXITED = PROC_REF(on_exited),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	wires = new /datum/wires/mine(src)

/obj/item/mine/examine(mob/user)
	. = ..()
	if(!armed)
		. += "<span class='information'>It appears to be inactive...</span>"
	else
		. += "<span class='information'>It looks ready to explode.</span>"

	if(manufacturer)
		. += "<span class='notice'>It has <b>[manufacturer]</b> engraved on it.</span>"

	var/atom/movable/unlucky_sod = foot_on_mine?.resolve()
	if(user == unlucky_sod)
		. += "<span class='span_bolddanger'>The pressure plate is depressed. Any movement you make will set it off now."
	else if(!isnull(unlucky_sod))
		. += "<span class='span_danger'>The pressure plate is depressed by [unlucky_sod]. Any move they make'll set it off now."

/obj/item/mine/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][triggered ? "_exploding" : null][!armed && anchored ? "_arming" : null][armed && anchored && !triggered ? "_armed" : null]"

/// Can this mine trigger on the passed movable?
/obj/item/mine/proc/can_trigger(atom/movable/on_who)
	//var/badtype = typecacheof(list(/obj/effect, /obj/item/mine))
	if(triggered || !isturf(loc) || !armed || iseffect(on_who) || istype(on_who, /obj/item/mine))
		return FALSE
	//if(on_who == badtype)//no recursive self triggering. Bad landmine
	//	return FALSE
	return TRUE

//step 1: the mistake
/obj/item/mine/proc/on_entered(datum/source, atom/movable/arrived)
	SIGNAL_HANDLER
	if(!can_trigger(arrived))
		return
	// Flying = can't step on a mine
	if(arrived.movement_type & FLYING)
		return
		// Someone already on it
	if(foot_on_mine?.resolve())
		return

	foot_on_mine = WEAKREF(arrived)

	if(ismob(arrived))
		var/mob/living/fool = arrived
		fool.do_alert_animation(fool)
		if(!hair_trigger)
			fool.Immobilize(20, TRUE)
			to_chat(fool, span_userdanger("You step on \the [src] and freeze."))

	visible_message(span_danger("[icon2html(src, viewers(src))] *click*"))
	if(clickblock == FALSE)//see wirecutting
		clicked = TRUE
	if(hair_trigger && clicked)
		triggermine(arrived)
	else
		if(isopenturf(loc))
			var/turf/open/locturf = loc
			oldslow = locturf.slowdown
			locturf.slowdown = 4
	alpha = 204
	playsound(src, 'sound/machines/click.ogg', 100, TRUE)

//step 2: the consequences
/obj/item/mine/proc/on_exited(datum/source, atom/movable/gone)
	SIGNAL_HANDLER
	if(!clicked)
		return
	if(!can_trigger(gone))
		return
	// Check that the guy who's on it is stepping off
	if(foot_on_mine && !IS_WEAKREF_OF(gone, foot_on_mine))
		return

	INVOKE_ASYNC(src, PROC_REF(triggermine), gone)
	foot_on_mine = null

//mines may be triggered by damage, but they take longer to explode
/obj/item/mine/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir)
	. = ..()
	if(prob(65))
		blast_delay = blast_delay * 3
		triggermine()

/// When something sets off a mine
/obj/item/mine/proc/triggermine(atom/movable/triggerer)
	if(triggered) //too busy detonating to detonate again
		return
	if(triggerer)
		triggerer.visible_message(span_danger("[icon2html(src, viewers(src))] [triggerer] sets off \the [src]. It's gonna blow!"), span_danger("[icon2html(src, viewers(src))] \The [src] activates."))
	else
		visible_message(span_danger("[icon2html(src, viewers(src))] \the [src] begins to flash bright red!"))
	triggered = TRUE
	update_appearance(UPDATE_ICON_STATE)
	playsound(src, 'sound/items/mine_activate.ogg', 60, FALSE, -2)
	light_color = "#FF0000"
	light_power = 3
	light_range = 2
	addtimer(CALLBACK(src, PROC_REF(blast_now), triggerer), blast_delay)

//NOW we actually blow up
/obj/item/mine/proc/blast_now(atom/movable/triggerer)
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	if(isopenturf(loc) || oldslow)
		var/turf/open/locturf = loc
		locturf.slowdown = oldslow
	if(ismob(triggerer))
		mineEffect(triggerer)
	else
		mineEffect()
	visible_message(span_danger("[icon2html(src, viewers(src))] \the [src] detonates!"))
	SEND_SIGNAL(src, COMSIG_MINE_TRIGGERED, triggerer)
	qdel(src)

//using an unarmed mine inhand deploys it.
/obj/item/mine/attack_self(mob/user)
	if(!armed)
		user.visible_message("<span class='danger'>[user] deploys the [src].</span>", "<span class='notice'>You deploy the [src].</span>")

		user.dropItemToGround(src)
		anchored = TRUE
		playsound(src, 'sound/machines/click.ogg', 60, TRUE)

		if(arm_delay)
			armed = FALSE
			update_appearance(UPDATE_ICON_STATE)
			addtimer(CALLBACK(src, PROC_REF(now_armed)), arm_delay)
		else
			armed = TRUE
			alpha = stealthpwr
		log_admin("[key_name(user)] has placed \a [src] at ([x],[y],[z]).")

//let them know the mine's done cooking
/obj/item/mine/proc/now_armed()
	armed = TRUE
	alpha = stealthpwr
	update_appearance(UPDATE_ICON_STATE)
	playsound(src, 'sound/machines/nuke/angry_beep.ogg', 40, FALSE, -2)
	visible_message("<span class='danger'>\The [src] beeps softly, indicating it is now active.<span>", vision_distance = COMBAT_MESSAGE_RANGE)

//insert your horrible fate here
/obj/item/mine/proc/mineEffect(mob/victim)
	return

//trying to pick up a live mine is probably up there when it comes to terrible ideas
/obj/item/mine/attack_hand(mob/user)
	if(armed)
		user.visible_message(span_warning("[user] extends their hand towards \the [src]!"), span_userdanger("You extend your arms to pick up \the [src], knowing that it will likely blow up when you touch it!"))
		if(do_after(user, 5 SECONDS, target = src))//SO SO generous. You can still step back from the edge.
			if(prob(10))
				user.visible_message(span_notice("[user] picks up \the [src], which miraculously doesn't explode!"), span_notice("You pick up \the [src], which miraculously doesn't explode!"))
				anchored = FALSE
				armed = FALSE
				clicked = FALSE
				if(isopenturf(loc) || oldslow)
					var/turf/open/locturf = loc
					locturf.slowdown = oldslow
				update_appearance(UPDATE_ICON_STATE)
			else
				user.visible_message(span_danger("[user] attempts to pick up \the [src] only to hear a beep as it activates in their hand!"), span_danger("You attempt to pick up \the [src] only to hear a beep as it activates in your hands!"))
				triggermine(user)
				return
		else
			user.visible_message(span_notice("[user] withdraws their hand from \the [src]."), span_notice("You decide against picking up \the [src]."))
	. =..()

//handles disarming(and failing to disarm)
/obj/item/mine/attackby(obj/item/I, mob/user)
	if(I.tool_behaviour == TOOL_SCREWDRIVER)
		if(sealed)
			to_chat(user, "<span class='notice'>You can't see any way to access \the [src]'s wiring.</span>")
			return
		open_panel = !open_panel
		update_appearance(UPDATE_ICON_STATE)
		to_chat(user, "<span class='notice'>You [open_panel ? "reveal" : "hide"] \the [src]'s wiring.</span>")
		I.play_tool_sound(src, 50)
	else if(is_wire_tool(I) && open_panel)
		wires.interact(user)
	else if(!armed)
		to_chat(user, span_notice("You hit \the [src] with [I]. Thankfully, nothing happens."))
		return
	else//please stop hitting the live mine with a rock
		if(user.a_intent != INTENT_HARM)//are you SURE you want to hit the live mine with a rock
			user.visible_message(user, span_notice("[user] gently pokes \the [src] with [I]. Nothing seems to happen."), span_notice("You gently prod \the [src] with [I]. Thankfully, nothing happens."))
		else//at this point it's just natural selection
			user.visible_message(span_danger("[user] hits \the [src] with [I], activating it!"), span_userdanger("[icon2html(src, viewers(src))]You hit \the [src] with [I]. The light goes red."))
			triggermine(user)

//
//LANDMINE TYPES
//Rylie please help me make these more immersive
//

/obj/item/mine/explosive
	name = "\improper G-80 Landmine"
	desc = "An anti-infantry explosive produced during the corporate wars. Watch your step."

	//customize explosive power
	var/range_devastation = 0
	var/range_heavy = 1
	var/range_light = 5
	var/range_flame = 1

	//using this to indicate pb
	var/range_flash = 1

	//customize shrapnel. Magnitude zero prevents them from spawning
	var/shrapnel_type = /obj/projectile/bullet/shrapnel
	var/shrapnel_magnitude = 2

	/// If TRUE, we spawn extra pellets to eviscerate the person who stepped on it, otherwise it just spawns a ring of pellets around the tile we're on (making setting it off an offensive move)
	var/shred_triggerer = TRUE

	stealthpwr = 100
	manufacturer = MANUFACTURER_SCARBOROUGH

/obj/item/mine/explosive/mineEffect(mob/victim)
	explosion(loc, range_devastation, range_heavy, range_light, range_flash, 1, 0, range_flame, 0, 1)
	if(shrapnel_magnitude > 0)
		AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_magnitude)

/obj/item/mine/explosive/rusty
	name = "\improper Rusted Landmine"
	desc = "An anti-infantry explosive, designed to go off underfoot. This one has seen better days."
	manufacturer = MANUFACTURER_NONE
	range_heavy = 0
	range_light = 3
	shrapnel_type = /obj/projectile/bullet/shrapnel/rusty

/obj/item/mine/explosive/fire
	name = "\improper G-82 Incindeary"
	desc = "An anti-infantry explosive produced during the corporate wars. Transforms into superheated slag and a ball of fire on detonation. "

	range_flame = 6
	range_light = 3
	range_flash = 3

	shrapnel_type = /obj/projectile/bullet/shrapnel/hot
	shrapnel_magnitude = 2

/obj/item/mine/explosive/fire/mineEffect(mob/victim)
	for(var/turf/T in view(4,src))
		T.IgniteTurf(15)
		new /obj/effect/hotspot(T)
	. = ..()

/obj/item/mine/explosive/heavy
	name = "\improper G-81 Anti-Tank Mine"
	desc = "An immense anti-vehicle explosive built during the corporate wars. Someone has recklessly switched out the detonator for one that activates for lighter targets."
	w_class = WEIGHT_CLASS_BULKY
	range_heavy = 6
	range_light = 9
	shrapnel_magnitude = 7
	shrapnel_type = /obj/projectile/bullet/shrapnel/mega
	blast_delay = 50//run.
	sealed = TRUE//unless we specifically give it to people disarmed, we probably don't want them stealing this

/obj/item/mine/explosive/shrapnel
	name = "\improper G-84 Fragmentation"
	desc = "An anti-infantry explosive built during the corporate wars. Metal banding inside creates additional deadly shrapnel on detonation. "

	range_heavy = 1
	range_light = 4

	shrapnel_magnitude = 4
	shred_triggerer = TRUE

/obj/item/mine/explosive/shrapnel/carbon_only
	name = "\improper G-84 Special"
	desc = "A deadly fragmentation mine. This one has a specially-calibrated weight sensor designed to prevent misfire."

/obj/item/mine/explosive/shrapnel/carbon_only/on_entered(datum/source, atom/movable/AM)
	if(!iscarbon(AM))
		return
	. = ..()

//like all real 'less' than lethal crowd control options this is, in fact, not very good at being nonlethal
/obj/item/mine/explosive/shrapnel/sting
	name = "\improper'Stinger' Crowd Management Device"
	desc = "A \"less\" than lethal crowd control weapon, designed to demoralise and scatter anti-NT protestors. The bands of ballistic gel inside strike targets and incapacitate without causing serious maiming. In Theory."

	range_heavy = 0
	range_light = 0
	range_flash = 3
	range_flame = 0

	hair_trigger = TRUE
	shrapnel_magnitude = 6
	shred_triggerer = TRUE
	shrapnel_type = /obj/projectile/bullet/pellet/stingball
	manufacturer = MANUFACTURER_NANOTRASEN_OLD

/obj/item/mine/explosive/
	name = "\improper G-85 Fission"
	desc = "An anti-infantry explosive produced during the corporate wars. This one detonates a small microfission core, creating a bloom of deadly radiation. "
	range_light = 4
	range_flame = 2
	shrapnel_magnitude = 3
	shrapnel_type = /obj/projectile/bullet/shrapnel/spicy
	var/radpower = 500

/obj/item/mine/explosive/rad/mineEffect(mob/victim)
	radiation_pulse(src, radpower, 2)
	. = ..()

/obj/item/mine/explosive/plasma
	name = "\improper Etherbor EM-3"
	desc = "An anti-infantry explosive designed by the PGF for denial of territory to enemy forces. Incinerates anything nearby with high energy plasma."
	range_light = 2
	range_flame = 3
	range_heavy = 0
	shrapnel_magnitude = 8
	shred_triggerer = FALSE //this would be ridiculous overkill
	shrapnel_type = /obj/projectile/energy/plasmabolt
	manufacturer = MANUFACTURER_PGF

/obj/item/mine/explosive/plasma/mineEffect(mob/victim)
	for(var/turf/T in view(3,src))
		T.IgniteTurf(25, "green")
	. = ..()

//WIP variants(CLEAN THIS UP BEFORE UNDRAFTING)
/obj/item/mine/spawner
//mannhacks go here :)


//
//UNUSED MINES//
//mainly remain to demonstrate possible mine effects.
//

/obj/item/mine/stun
	name = "stun mine"
	var/stun_time = 80
	hair_trigger = TRUE
	anchored = TRUE
	armed = TRUE

/obj/item/mine/stun/mineEffect(mob/living/victim)
	if(isliving(victim) && Adjacent(victim))
		victim.Paralyze(stun_time)

/obj/item/mine/gas
	name = "oxygen mine"
	var/gas_amount = 360
	var/gas_type = "o2"
	hair_trigger = TRUE
	anchored = TRUE
	armed = TRUE

/obj/item/mine/gas/mineEffect(mob/victim)
	atmos_spawn_air("[gas_type]=[gas_amount]")


/obj/item/mine/gas/plasma
	name = "plasma mine"
	gas_type = "plasma"


/obj/item/mine/gas/n2o
	name = "\improper N2O mine"
	gas_type = "n2o"


/obj/item/mine/gas/water_vapor
	name = "chilled vapor mine"
	gas_amount = 500
	gas_type = "water_vapor"


//
//GIMMICK MINES//
//pretty much exclusively for adminbus
//use these at your own risk, I haven't tested them
//

/obj/item/mine/kickmine
	name = "\improper A-00 'Adminbus'"
	desc = "An Anti-Griefer proximity expulsive. Delivers Justice."
	blast_delay = 0//funnier this way
	hair_trigger = TRUE
	anchored = TRUE
	armed = TRUE

/obj/item/mine/kickmine/mineEffect(mob/victim)
	if(isliving(victim) && victim.client && Adjacent(victim))
		to_chat(victim, "<span class='userdanger'>You have been kicked FOR NO REISIN!</span>")
		qdel(victim.client)

/obj/item/mine/sound
	name = "honkblaster 1000"
	var/sound = 'sound/items/bikehorn.ogg'
	anchored = TRUE
	armed = TRUE
	blast_delay = null
	hair_trigger = TRUE

/obj/item/mine/sound/mineEffect(mob/victim)
	playsound(loc, sound, 100, TRUE)


/obj/item/mine/sound/bwoink
	name = "bwoink mine"
	sound = 'sound/effects/adminhelp.ogg'

/obj/item/mine/pickup
	name = "pickup mine"
	desc = "does nothing"
	icon = 'icons/obj/marg.dmi'
	icon_state = "marg"
	density = FALSE
	var/duration = 0
	pixel_x = -8
	pixel_y = 1
	anchored = TRUE
	armed = TRUE
	blast_delay = null
	hair_trigger = TRUE

/obj/item/mine/pickup/Initialize()
	. = ..()
	animate(src, time = 20, loop = -1)

/obj/item/mine/pickup/triggermine(mob/victim)
	if(triggered)
		return
	triggered = TRUE
	invisibility = INVISIBILITY_ABSTRACT
	mineEffect(victim)
	qdel(src)


/obj/item/mine/pickup/bloodbath
	name = "bloody orb"
	desc = "Embrace righteous fury."
	duration = 1200 //2min
	color = "#FF0000"
	var/mob/living/doomslayer
	var/obj/item/chainsaw/doomslayer/chainsaw

/obj/item/mine/pickup/bloodbath/mineEffect(mob/living/carbon/victim)
	if(!victim.client || !istype(victim))
		return
	to_chat(victim, "<span class='reallybig redtext'>RIP AND TEAR</span>")

	INVOKE_ASYNC(src, PROC_REF(blood_delusion), victim)

	chainsaw = new(victim.loc)
	victim.log_message("entered a marg frenzy", LOG_ATTACK)

	ADD_TRAIT(chainsaw, TRAIT_NODROP, CHAINSAW_FRENZY_TRAIT)
	victim.drop_all_held_items()
	victim.put_in_hands(chainsaw, forced = TRUE)
	chainsaw.attack_self(victim)
	victim.reagents.add_reagent(/datum/reagent/medicine/adminordrazine,25)
	to_chat(victim, "<span class='warning'>KILL, KILL, KILL! YOU HAVE NO ALLIES ANYMORE, KILL THEM ALL!</span>")

	var/datum/client_colour/colour = victim.add_client_colour(/datum/client_colour/bloodlust)
	QDEL_IN(colour, 11)
	doomslayer = victim
	RegisterSignal(src, COMSIG_PARENT_QDELETING, PROC_REF(end_blood_frenzy))
	QDEL_IN(WEAKREF(src), duration)

/obj/item/mine/pickup/bloodbath/proc/end_blood_frenzy()
	if(doomslayer)
		to_chat(doomslayer, "<span class='notice'>Your bloodlust seeps back into the bog of your subconscious and you regain self control.</span>")
		doomslayer.log_message("exited a blood frenzy", LOG_ATTACK)
	if(chainsaw)
		qdel(chainsaw)

/obj/item/mine/pickup/bloodbath/proc/blood_delusion(mob/living/carbon/victim)
	new /datum/hallucination/delusion(victim, TRUE, "demon", duration, 0)

/obj/item/mine/pickup/healing
	name = "healing orb"
	desc = "Your wounds shall be undone."

/obj/item/mine/pickup/healing/mineEffect(mob/living/carbon/victim)
	if(!victim.client || !istype(victim))
		return
	to_chat(victim, "<span class='notice'>You feel great!</span>")
	victim.revive(full_heal = TRUE, admin_revive = TRUE)

/obj/item/mine/pickup/speed
	name = "quick orb"
	desc = "Quickens you."
	duration = 300

/obj/item/mine/pickup/speed/mineEffect(mob/living/carbon/victim)
	if(!victim.client || !istype(victim))
		return
	to_chat(victim, "<span class='notice'>You feel fast!</span>")
	victim.add_movespeed_modifier(/datum/movespeed_modifier/yellow_orb)
	addtimer(CALLBACK(src, PROC_REF(finish_effect), victim), duration)

/obj/item/mine/pickup/speed/proc/finish_effect(mob/living/carbon/victim)
	victim.remove_movespeed_modifier(/datum/movespeed_modifier/yellow_orb)
	to_chat(victim, "<span class='notice'>You slow down.</span>")
